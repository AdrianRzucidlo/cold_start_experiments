using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using System;
using System.Threading.Tasks;

namespace TestingFunctionDotnet;

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        Console.WriteLine("Request received");

        await context.Response.WriteAsync("Done");
    }
}