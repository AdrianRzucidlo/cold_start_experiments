aws s3 cp SNSPublisherLambda.zip s3://cold-start-lambdas

Write-Host "SNSPublisherLambda uploaded to S3"

Remove-Item SNSPublisherLambda.zip

Remove-Item -Path ./publish -Recurse

Write-Host "SNSPublisherLambda files cleaned"