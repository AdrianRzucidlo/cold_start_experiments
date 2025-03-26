using Amazon.Lambda.Core;
using Amazon.SimpleNotificationService;
using Amazon.Lambda.CloudWatchEvents;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace SNSPublisherLambda;

public sealed class Function
{
    private readonly AmazonSimpleNotificationServiceClient _snsClient;

    public Function()
    {
        _snsClient = new AmazonSimpleNotificationServiceClient();
    }

    public async Task FunctionHandler(CloudWatchEvent<object> eventBridgeEvent, ILambdaContext context)
    {
        context.Logger.LogInformation("Event received");

        //await _snsClient.PublishAsync(Environment.GetEnvironmentVariable("sns_topic"), "");
    }
}