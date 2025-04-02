using Amazon.Lambda.Core;
using Amazon.SimpleNotificationService;
using Amazon.Lambda.CloudWatchEvents;
using Amazon.SQS;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace SNSPublisherLambda;

public sealed class Function
{
    private readonly AmazonSimpleNotificationServiceClient _snsClient;
    private readonly AmazonSQSClient _sqsClient;

    private const string SnsTopicArnVariableName = "SNSTopicArn";
    private const string SqsQueueUrlVariableName = "SQSQueueUrl";

    public Function()
    {
        _snsClient = new AmazonSimpleNotificationServiceClient();
        _sqsClient = new AmazonSQSClient();
    }

    public async Task FunctionHandler(CloudWatchEvent<object> eventBridgeEvent, ILambdaContext context)
    {
        context.Logger.LogInformation("Event received");

        await _snsClient.PublishAsync(Environment.GetEnvironmentVariable(SnsTopicArnVariableName), "Start testing");
        context.Logger.LogInformation("Published a message to SNS topic");

        await _sqsClient.SendMessageAsync(Environment.GetEnvironmentVariable(SqsQueueUrlVariableName), "Process logs");
        context.Logger.LogInformation("Sent a message to SQS queue");

        context.Logger.LogInformation("Processing finished");
    }
}