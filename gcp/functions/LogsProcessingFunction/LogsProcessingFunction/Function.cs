using Google.Cloud.Functions.Framework;
using Google.Cloud.Logging.V2;
using Google.Cloud.Storage.V1;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace LogsProcessingFunction;

public class Function : IHttpFunction
{
    private readonly List<string> _services = new()
    {
        "TestingFunctionDotnet","TestingFunctionJava", "TestingFunctionRuby", "TestingFunctionNode", "TestingFunctionPython"
    };
    private readonly string _bucketName = "cold-start-logs";
    private readonly string _projectId = Environment.GetEnvironmentVariable("GCP_PROJECT") ?? "cold-start-experiments";

    private readonly LoggingServiceV2Client _loggingClient = LoggingServiceV2Client.Create();
    private readonly StorageClient _storageClient = StorageClient.Create();

    public async Task HandleAsync(HttpContext context)
    {
        foreach (var service in _services)
        {
            var coldStartTuple = await GetColdStartTupleAsync(service);

            var initialContent = string.Empty;
            try
            {
                var obj = _storageClient.GetObject(_bucketName, service);

                using var memoryStream = new MemoryStream();
                _storageClient.DownloadObject(_bucketName, service, memoryStream);
                memoryStream.Position = 0;

                initialContent = new StreamReader(memoryStream).ReadToEnd();
            }
            catch (Google.GoogleApiException ex) when (ex.Error.Code == 404)
            {
                initialContent = "Timestamp;ColdStartValue;" + Environment.NewLine;
            }

            var content = new StringBuilder(initialContent);
            content.AppendLine(coldStartTuple.Item1 + ";" + coldStartTuple.Item2 + ";");
            var contentBytes = Encoding.UTF8.GetBytes(content.ToString());

            using var uploadStream = new MemoryStream(contentBytes);
            _storageClient.UploadObject(_bucketName, service, "text/csv", uploadStream);
        }

        context.Response.ContentType = "text/plain";
        await context.Response.WriteAsync("Done");
    }

    private async Task<(DateTime, string)> GetColdStartTupleAsync(string service)
    {
        var filter = $"resource.type=\"cloud_function\"\r\n" +
                $"resource.labels.function_name=\"{service}\"\r\n" +
                $"resource.labels.region=\"europe-central2\"\r\n" +
                $"timestamp > \"{DateTime.UtcNow.AddMinutes(-15):yyyy-MM-ddTHH:mm:ss}\"";

        var request = new ListLogEntriesRequest
        {
            ResourceNames = { $"projects/{_projectId}" },
            Filter = filter
        };

        int? firstStartValue = null;

        await foreach (var entry in _loggingClient.ListLogEntriesAsync(request))
        {
            var match = Regex.Match(entry.TextPayload, @"Function execution took (\d+)\s*ms");
            if (match.Success)
            {
                var timeValue = int.Parse(match.Groups[1].Value);

                if (firstStartValue is null)
                {
                    firstStartValue = timeValue;
                }
                else
                {
                    var coldStartValue = Math.Abs(firstStartValue.GetValueOrDefault() - timeValue);
                    return (entry.Timestamp.ToDateTime(), coldStartValue.ToString());
                }
            }
        }

        return (default, default);
    }
}