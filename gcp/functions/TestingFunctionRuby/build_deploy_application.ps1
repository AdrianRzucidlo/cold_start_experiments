$BucketName = "cold-start-experiments-functions"
$ZipPath = "TestingFunctionRuby.zip"

#fsutil file createnew TestingFunctionRuby/fake.bin 209715200

Push-Location ./TestingFunctionRuby

bundle config set deployment true
bundle config set path 'vendor/bundle'
bundle install

Pop-Location

Compress-Archive -Path "TestingFunctionRuby/*" -DestinationPath $ZipPath

Write-Host "TestingFunctionRuby function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "TestingFunctionRuby function uploaded"

Remove-Item $ZipPath
#Remove-Item TestingFunctionRuby/fake.bin

Write-Host "TestingFunctionRuby files cleaned"

