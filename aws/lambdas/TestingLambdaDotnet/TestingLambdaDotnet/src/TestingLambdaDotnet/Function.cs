using Amazon.Lambda.Core;
using Amazon.Lambda.SNSEvents;
using Google.Cloud.Storage.V1;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace TestingLambdaDotnet;

public class Function
{
    public Function()
    {
    }

    public async Task FunctionHandler(SNSEvent evnt, ILambdaContext context)
    {
        foreach (var record in evnt.Records)
        {
            await ProcessRecordAsync(record, context);
        }
    }

    private async Task ProcessRecordAsync(SNSEvent.SNSRecord record, ILambdaContext context)
    {
        context.Logger.LogInformation($"Processed record {record.Sns.Message}");

        try
        {
            var storage = StorageClient.Create();
            var buckets = storage.ListBuckets("fake");
        }
        catch (Exception)
        {
        }

        await Task.CompletedTask;
    }
}