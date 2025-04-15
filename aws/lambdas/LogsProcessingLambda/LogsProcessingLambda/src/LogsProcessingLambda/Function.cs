using Amazon.CloudWatchLogs;
using Amazon.CloudWatchLogs.Model;
using Amazon.Lambda.Core;
using Amazon.Lambda.SQSEvents;
using Amazon.S3;
using Amazon.S3.Model;
using System.Text;
using System.Text.RegularExpressions;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace LogsProcessingLambda;

public class Function
{
    private const string LogsBucketName = "testing-lambdas-logs";

    private static AmazonS3Client _s3Client;
    private static AmazonCloudWatchLogsClient _cloudwatchClient;

    public Function()
    {
        _s3Client = new AmazonS3Client();
        _cloudwatchClient = new AmazonCloudWatchLogsClient();
    }

    public async Task FunctionHandler(SQSEvent evnt, ILambdaContext context)
    {
        foreach (var message in evnt.Records)
        {
            await ProcessMessageAsync(message, context);
        }
    }

    private async Task ProcessMessageAsync(SQSEvent.SQSMessage message, ILambdaContext context)
    {
        context.Logger.LogInformation($"Started processing logs");

        var logGroups = new List<LogGroup>();

        string? nextToken = null;

        do
        {
            var request = new DescribeLogGroupsRequest
            {
                NextToken = nextToken
            };

            var response = await _cloudwatchClient.DescribeLogGroupsAsync(request);
            logGroups.AddRange(response.LogGroups);

            nextToken = response.NextToken;
        } while (!string.IsNullOrEmpty(nextToken));

        foreach (var group in logGroups.Where(lg => lg.LogGroupName.Contains("Testing")))
        {
            await ProcessLogGroupAsync(group.LogGroupName);
        }
    }

    private static async Task ProcessLogGroupAsync(string logGroupName)
    {
        var logStreamsResponse = await _cloudwatchClient.DescribeLogStreamsAsync(new DescribeLogStreamsRequest
        {
            LogGroupName = logGroupName,
            OrderBy = "LastEventTime",
            Descending = true,
            Limit = 3
        });

        var startTime = DateTime.UtcNow.AddMinutes(-10);
        var endTime = DateTime.UtcNow;

        foreach (var stream in logStreamsResponse.LogStreams)
        {
            var eventsResponse = await _cloudwatchClient.GetLogEventsAsync(new GetLogEventsRequest
            {
                LogGroupName = logGroupName,
                LogStreamName = stream.LogStreamName,
                StartTime = startTime,
                EndTime = endTime,
                Limit = 1000
            });

            foreach (var log in eventsResponse.Events)
            {
                await ProcessLogAsync(log.Message.ToString(), logGroupName);
            }
        }
    }

    private static async Task ProcessLogAsync(string logMessage, string logGroupName)
    {
        var match = Regex.Match(logMessage, @"Init Duration: ([\d.]+) ms");

        if (!match.Success)
        {
            return;
        }

        var fileName = logGroupName.Split('/').Last() + ".csv";

        string existingContent = "";

        try
        {
            var s3Response = await _s3Client.GetObjectAsync(LogsBucketName, fileName);

            using (var reader = new StreamReader(s3Response.ResponseStream))
            {
                existingContent = await reader.ReadToEndAsync();
            }
        }
        catch (AmazonS3Exception ex) when (ex.StatusCode == System.Net.HttpStatusCode.NotFound)
        {
            existingContent += "Timestamp;ColdStartValue;" + Environment.NewLine;
        }

        var coldStartValue = match.Groups[1].Value;

        var updatedContent = new StringBuilder(existingContent)
            .AppendLine(DateTime.Now.ToString() + ';' + coldStartValue + ';');

        var putReq = new PutObjectRequest
        {
            BucketName = LogsBucketName,
            Key = fileName,
            ContentBody = updatedContent.ToString()
        };

        await _s3Client.PutObjectAsync(putReq);
    }
}