# Packer Image Creation in Azure - Linux & Windows

[!Warning] 
This module contained "LINUX FLAVOR" and "WINDOWS FLAVOR".
Run the module for one or the other, NOT both at the same time. 

This is a simple code to test.

To run "WINDOWS FLAVOR", please comment out the "LINUX FLAVOR" portion.
To run "LINUX FLAVOR", please comment out the "WINDOWS FLAVOR" portion.

### HOW TO RUN
```
# In *.pkr.hcl, replace the following with target Azure subscription. 
# client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

packer init .
packer fmt .
packer validate .
packer build . 
```


