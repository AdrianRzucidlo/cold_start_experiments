$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionRuby.zip"

Compress-Archive -Path "TestingFunctionRuby/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionRuby function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionRuby function uploaded"

Remove-Item $ZipPath

Write-Host "TestingFunctionRuby files cleaned"

