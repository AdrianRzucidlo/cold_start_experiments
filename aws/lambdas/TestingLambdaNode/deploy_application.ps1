aws s3 cp TestingLambdaNode.zip s3://cold-start-lambdas

Write-Host "TestingLambdaNode uploaded to S3"

Remove-Item TestingLambdaNode.zip

Remove-Item TestingLambdaNode/fake.bin

Write-Host "TestingLambdaNode files cleaned"