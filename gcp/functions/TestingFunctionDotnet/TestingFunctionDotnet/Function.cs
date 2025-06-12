using Google.Cloud.Functions.Framework;
using Google.Cloud.Storage.V1;
using Microsoft.AspNetCore.Http;
using System;
using System.Threading.Tasks;

namespace TestingFunctionDotnet;

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        Console.WriteLine("Request received");

        try
        {
            var storage = StorageClient.Create();
            var buckets = storage.ListBuckets("fake");
        }
        catch (Exception)
        {
        }

        await context.Response.WriteAsync("Done");
    }
}