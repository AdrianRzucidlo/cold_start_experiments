dotnet publish ".\TestingLambdaDotnet\src\TestingLambdaDotnet\TestingLambdaDotnet.csproj" `
-c Release `
-o publish `
-r linux-x64 `
--self-contained false `

Write-Host "TestingLambdaDotnet built"

#fsutil file createnew publish/fake.bin 209715200

Compress-Archive -Path publish/* -DestinationPath TestingLambdaDotnet.zip -Force

Write-Host "TestingLambdaDotnet compressed to zip file"
