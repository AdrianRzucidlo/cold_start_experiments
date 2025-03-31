aws s3 cp TestingLambdaDotnet.zip s3://cold-start-lambdas

Write-Host "TestingLambdaDotnet uploaded to S3"

Remove-Item TestingLambdaDotnet.zip

Remove-Item -Path ./publish -Recurse

Write-Host "TestingLambdaDotnet files cleaned"