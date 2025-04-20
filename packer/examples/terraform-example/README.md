## Simple Example to spin up a Windows server in Azure

```
git clone git@github.com:tlian/dummy-tutorial.git
terraform init
terraform plan -out example.tfplan
terraform apply example.tfplan

# Detroy resources
terraform plan -destroy -out destroy-example.tfplan
terraform apply destroy-example.tfplan
```

### Pre-requisite: Install Azure CLI 
```
# on Mac OS
brew update
brew install azure-cli

# Authenticate with Azure - it will pop up a Web browser to login
az login
```

The following error will pop up if not authenticate with Azure first. 
To authenticate with Azure, install Azure CLI as mentionted above. 

```
│ Error: unable to build authorizer for Resource Manager API: could not configure AzureCli Authorizer: could not parse Azure CLI version: launching Azure CLI: exec: "az": executable file not found in $PATH
│ 
│   with provider["registry.terraform.io/hashicorp/azurerm"],
│   on providers.tf line 16, in provider "azurerm":
│   16: provider "azurerm" {
```
