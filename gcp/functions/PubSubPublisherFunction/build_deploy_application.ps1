$BucketName = "cold-start-experiments-functions"
$ZipPath = "PubSubPublisherFunction.zip"

Compress-Archive -Path "./main.py" -DestinationPath $ZipPath

Write-Host "PubSubPublisher function compressed"

gsutil cp $ZipPath "gs://$BucketName/$ZipPath"

Write-Host "PubSubPublisher function uploaded"

Remove-Item $ZipPath

Write-Host "PubSubPublisher files cleaned"

