#fsutil file createnew TestingFunctionDotnet/fake.bin 209715200

Compress-Archive -Path TestingFunctionDotnet/* -DestinationPath TestingFunctionDotnet.zip -Force

Write-Host "TestingFunctionDotnet compressed to zip file"