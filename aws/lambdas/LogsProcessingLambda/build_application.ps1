dotnet publish ".\LogsProcessingLambda\src\LogsProcessingLambda\LogsProcessingLambda.csproj" `
-c Release `
-o publish `
-r linux-x64 `
--self-contained false `

Write-Host "LogsProcessingLambda built"

Compress-Archive -Path publish/* -DestinationPath LogsProcessingLambda.zip -Force

Write-Host "LogsProcessingLambda compressed to zip file"
