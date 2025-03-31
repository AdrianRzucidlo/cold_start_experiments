$StackName = "cold-start-experiments-stack"
$TemplateFile = "cloudformation.yaml"
$Region = "eu-north-1"

$StackExists = aws cloudformation describe-stacks --stack-name $StackName --region $Region 2>$null

if ($StackExists) {
    Write-Host "Stack already exists"
	
	aws cloudformation wait stack-delete-complete --stack-name $StackName
    
    aws cloudformation update-stack `
        --stack-name $StackName `
        --template-body file://$TemplateFile `
        --parameters "ParameterKey=SNSInvokerSchedule,ParameterValue='rate(1 hour)'" `
        --capabilities CAPABILITY_NAMED_IAM `
        --region $Region

    Write-Host "Updating stack..."
    aws cloudformation wait stack-update-complete --stack-name $StackName --region $Region
} 
else {
    Write-Host "Creating new stack '$StackName'..."
    
    aws cloudformation create-stack `
        --stack-name $StackName `
        --template-body file://$TemplateFile `
        --parameters "ParameterKey=SNSInvokerSchedule,ParameterValue='rate(1 hour)'" `
        --capabilities CAPABILITY_NAMED_IAM `
        --region $Region

    aws cloudformation wait stack-create-complete --stack-name $StackName --region $Region
}

Write-Host "Deployment finished"
