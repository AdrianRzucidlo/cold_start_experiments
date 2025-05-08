gsutil cp LogsProcessingFunction.zip "gs://cold-start-experiments-functions/LogsProcessingFunction.zip"

Write-Host "LogsProcessingFunction uploaded to cloud storage"

Remove-Item LogsProcessingFunction.zip

Write-Host "LogsProcessingFunction files cleaned"