aws s3 cp LogsProcessingLambda.zip s3://cold-start-lambdas

Write-Host "LogsProcessingLambda uploaded to S3"

Remove-Item LogsProcessingLambda.zip

Remove-Item -Path ./publish -Recurse

Write-Host "LogsProcessingLambda files cleaned"