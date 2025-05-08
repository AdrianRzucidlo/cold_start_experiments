$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionNode.zip"

Compress-Archive -Path "TestingFunctionNode/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionNode function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionNode function uploaded"

Remove-Item $ZipPath

Write-Host "TestingFunctionNode files cleaned"

