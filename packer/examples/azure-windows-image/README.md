# Learn Packer - Build a Windows Image in Azure

This folder contained packer configuration files that spins up Windows image in Azure.


## Pre-requisite
- [Create Azure account](https://azure.microsoft.com/en-us/Free)
- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)


> [!NOTE]

> Anyone can open Azure account for free. Please note that there are many free resources you may be able to use while some will not be. Please take caution about what you are doing. Running this example code should not really incur any charges as long as you scraped away Azure resource after use. The user of this example code/module will be responsible for any charges in Azure.

## Create Azure Credential (Secret key) to interact with Azure programatically
```
# Login first
az login --use-device-code

# Create credential - replace <subscription_id> with your own scription id in Azure
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<subscription_id> --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

### Output will look like the following ###
{
    "client_id": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "client_secret": "0e760437-bf34-4aad-9f8d-870be799c55d",
    "tenant_id": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
```

## How to use this module
```
git clone git@github.com:tlian/dummy-tutorial.git
cd dummy-tutorial/packer/examples/azure-windows-image

# Set environment variable
export AZURE_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxx"
export AZURE_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxx"
export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxxxxxx"
export AZURE_TENANT_ID="xxxxxxxxxxxxxxx"

# Execute packer to build the image
packer init .
packer fmt .
packer validate .
packer build .
```

> [!WARNING]
Ensure to delete Azure resources created above to avoid incurring charges (i.e. the Windows image created in Azure)
 ```
 - Go to Azure console delete the image created manually
 or
 - az image delete --image-name <IMAGE-NAME> -g <NAME-OF-RESOURCE-GROUP>
```