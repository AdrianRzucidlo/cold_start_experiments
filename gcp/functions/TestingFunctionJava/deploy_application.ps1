gsutil cp TestingFunctionJava.zip "gs://cold-start-experiments-functions/TestingFunctionJava.zip"

Write-Host "TestingFunctionJava uploaded to cloud storage"

Remove-Item TestingFunctionJava.zip

Remove-Item -Path ./TestingFunctionJava/target -Recurse
#Remove-Item -Path ./TestingFunctionJava/build -Recurse

Write-Host "TestingFunctionJava files cleaned"