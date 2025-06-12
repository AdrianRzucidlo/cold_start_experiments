gsutil cp TestingFunctionDotnet.zip "gs://cold-start-experiments-functions/TestingFunctionDotnet.zip"

Write-Host "TestingFunctionDotnet uploaded to cloud storage"

Remove-Item TestingFunctionDotnet.zip
#Remove-Item TestingFunctionDotnet/fake.bin


Write-Host "TestingFunctionDotnet files cleaned"