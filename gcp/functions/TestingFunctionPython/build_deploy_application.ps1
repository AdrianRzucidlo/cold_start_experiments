$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionPython.zip"

Compress-Archive -Path "TestingFunctionPython/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionPython function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionPython function uploaded"

Remove-Item $ZipPath

Write-Host "TestingFunctionPython files cleaned"

