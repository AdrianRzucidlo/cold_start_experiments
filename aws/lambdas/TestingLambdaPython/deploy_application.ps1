aws s3 cp TestingLambdaPython.zip s3://cold-start-lambdas

Write-Host "TestingLambdaPython uploaded to S3"

Remove-Item TestingLambdaPython.zip

Remove-Item TestingLambdaPython/fake.bin

Write-Host "TestingLambdaPython files cleaned"