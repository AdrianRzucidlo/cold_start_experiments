dotnet publish ".\SNSPublisherLambda\src\SNSPublisherLambda\SNSPublisherLambda.csproj" `
-c Release `
-o publish `
-r linux-x64 `
--self-contained false `

Write-Host "SNSPublisherLambda built"

Compress-Archive -Path publish/* -DestinationPath SNSPublisherLambda.zip -Force

Write-Host "SNSPublisherLambda compressed to zip file"
