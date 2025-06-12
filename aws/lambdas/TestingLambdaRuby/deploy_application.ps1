aws s3 cp TestingLambdaRuby.zip s3://cold-start-lambdas

Write-Host "TestingLambdaRuby uploaded to S3"

Remove-Item TestingLambdaRuby.zip

#Remove-Item TestingLambdaRuby/fake.bin

Write-Host "TestingLambdaRuby files cleaned"