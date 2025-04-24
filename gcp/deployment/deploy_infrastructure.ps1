$ProjectId = "cold-start-experiments"

gcloud auth application-default login
gcloud config set project $ProjectId


Write-Host "Initializing Terraform..."
terraform init

Write-Host "Terraform apply..."
terraform apply -auto-approve

Write-Host "Deployment finished."
