using Amazon.Lambda.Core;
using Amazon.SimpleNotificationService;
using Amazon.Lambda.CloudWatchEvents;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace SNSPublisherLambda;

public sealed class Function
{
    private readonly AmazonSimpleNotificationServiceClient _snsClient;
    private const string SnsTopicArnVariableName = "SNSTopicArn";

    public Function()
    {
        _snsClient = new AmazonSimpleNotificationServiceClient();
    }

    public async Task FunctionHandler(CloudWatchEvent<object> eventBridgeEvent, ILambdaContext context)
    {
        context.Logger.LogInformation("Event received");

        await _snsClient.PublishAsync(Environment.GetEnvironmentVariable(SnsTopicArnVariableName), "Start testing");

        context.Logger.LogInformation("Published a message to SNS topic");
        context.Logger.LogInformation("Processing finished");
    }
}