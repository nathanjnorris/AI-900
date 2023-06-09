$output = az account show | ConvertFrom-Json
if (!$output) {
    az login
} 

echo "Setting environment variables for Terraform"
$env:ARM_SUBSCRIPTION_ID="10e49fde-b365-4682-b48e-786d7dfbfb43"
$env:ARM_CLIENT_ID="54ddb1a1-e405-4c5e-bb72-80c6b0e7f118"
$env:ARM_CLIENT_SECRET="$(az keyvault secret show --name spTerraformToAzure --vault-name kv-terraform-svc --query value -o tsv)"
$env:ARM_TENANT_ID="5e3c4ffb-78eb-48a1-abdd-94bb9d93cb21"
$env:ARM_ACCOUNT_KEY="$(az keyvault secret show --name stterraformsvcAccountKey --vault-name kv-terraform-svc --query value -o tsv)"
y
terraform init -upgrade

terraform plan -out main.tfplan


$title    = 'Deploy to Azure'
$question = 'Are you sure you want to proceed?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    terraform apply main.tfplan
} else {
    echo "Deploy cancelled!"
}