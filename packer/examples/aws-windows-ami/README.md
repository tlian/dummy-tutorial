# Learn Packer - Build a Windows AMI in AWS

This is a companion repository for the Hashicorp [Build a Windows AMI tutorial](https://developer.hashicorp.com/packer/tutorials/integrations/aws-windows-image). It contains 
conifguration files for you to use to learn how to build and customize Windows machine images.

> [!NOTE]
> To use/test this module required AWS account, create AWS Access and Secret Key. Using this module will not typcially incur any charges as long as resources are deleted as soon as possible. Highly recommend to delete AWS resources as soon as desired job is completed. 

## Create AWS Access and Secret Key
https://docs.aws.amazon.com/keyspaces/latest/devguide/create.keypair.html

## How to use this module
```
git clone git@ghe.misoenergy.org:miso/packer-images.git
cd packer-images/aws-windows-ami
# Set environment variable
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxx"
export WINRM_PASSWORD="xxxxxxxxxxxxxxx" # This is a random password of choice
export WINRM_USER="xxxxxxxxxxxxxxx" # This is a random user name of choice
# Execute packer to build the image
packer init .
packer fmt .
packer validate .
packer build .
```

> [!WARNING]
Ensure to delete AWS resources to avoid incurring charges.
 - De-register AMI
 - Delete the snapshot associated with the AMI
