# Packer Image Creation in Azure - Linux & Windows

[!Warning] 
This module contained "LINUX FLAVOR" and "WINDOWS FLAVOR".
Run the module for one or the other, NOT both at the same time. 

This is a simple code to test.

To run "WINDOWS FLAVOR", please comment out the "LINUX FLAVOR" portion.
To run "LINUX FLAVOR", please comment out the "WINDOWS FLAVOR" portion.

### HOW TO RUN
```
# # Azure Authentication
# Ensure to export the following environment variables before running packer
# export AZURE_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxx"
# export AZURE_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxx"
# export AZURE_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxx"
# export AZURE_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxx"

packer init .
packer fmt .
packer validate .
packer build . 
```


