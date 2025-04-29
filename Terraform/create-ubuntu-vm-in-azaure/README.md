# Spin up a simple Ubuntu VM
This module will spin up a simple Ubuntu VM in Azure. 
Please make sure to destroy afterward to avoid incurring charges. 

[!Warning]
> User is responsible for any charges that may incur.

### Install Azure CLI 
- [How to install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

### Authenticate with Azure
```
# After running the following command, it will pop up a browser window to authenticate. Once successfully authenticated, Select target subscription (if multiple subscription) to create resources. 

az login
```

### Terraform plan and apply
```
terraform plan -out main.tfplan
terraform apply main.tfplan
```

### Terraform destroy
```
terraform plan -destroy -out destroy.tfplan
terraform apply destroy.tfplan
```
