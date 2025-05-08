$ProjectId = "cold-start-experiments"

gcloud config set project $ProjectId

Write-Host "Initializing Terraform..."
terraform init

Write-Host "Terraform apply..."
terraform apply -auto-approve

Write-Host "Deployment finished."
