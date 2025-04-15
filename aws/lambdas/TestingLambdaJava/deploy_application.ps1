aws s3 cp TestingLambdaJava.zip s3://cold-start-lambdas

Write-Host "TestingLambdaJava uploaded to S3"

Remove-Item TestingLambdaJava.zip

Remove-Item -Path ./TestingLambdaJava/target -Recurse
Remove-Item -Path ./TestingLambdaJava/1 -Recurse

Write-Host "TestingLambdaJava files cleaned"