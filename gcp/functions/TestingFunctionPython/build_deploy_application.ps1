$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionPython.zip"

#fsutil file createnew TestingFunctionPython/fake.bin 209715200

Compress-Archive -Path "TestingFunctionPython/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionPython function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionPython function uploaded"

Remove-Item $ZipPath
#Remove-Item TestingFunctionPython/fake.bin

Write-Host "TestingFunctionPython files cleaned"

