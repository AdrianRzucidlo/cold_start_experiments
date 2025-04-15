aws s3 cp TestingLambdaNode.zip s3://cold-start-lambdas

Write-Host "TestingLambdaNode uploaded to S3"

Remove-Item TestingLambdaNode.zip

Write-Host "TestingLambdaNode files cleaned"