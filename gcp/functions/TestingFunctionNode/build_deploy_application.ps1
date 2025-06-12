$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionNode.zip"

#fsutil file createnew TestingFunctionNode/fake.bin 209715200

Push-Location ./TestingFunctionNode

npm install

Pop-Location

Compress-Archive -Path "TestingFunctionNode/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionNode function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionNode function uploaded"

Remove-Item $ZipPath
#Remove-Item TestingFunctionNode/fake.bin

Write-Host "TestingFunctionNode files cleaned"

