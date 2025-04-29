# Spin up a simple Ubuntu VM

### Plan and apply
```
terraform plan -out main.tfplan
terraform apply main.tfplan
```

### Destroy
```
terraform plan -destroy -out destroy.tfplan
terraform apply destroy.tfplan
```
