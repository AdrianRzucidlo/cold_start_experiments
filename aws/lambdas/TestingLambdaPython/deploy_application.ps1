aws s3 cp TestingLambdaPython.zip s3://cold-start-lambdas

Write-Host "TestingLambdaPython uploaded to S3"

Remove-Item TestingLambdaPython.zip

Write-Host "TestingLambdaPython files cleaned"