### Installation of Helm
https://helm.sh/docs/intro/install/

```
brew install helm
```

### Install the application
```
helm install tlian-helm-app webapp1/ --values webapp1/values.yaml
```

### Access the application
```
minikube tunnel

# Look for service name - i.e. in this example, the service name is "tlian-helm-app"

kubectl get service

# Port-forward desired port number on the host to exposed port inside container - i.e. in below, 8888 is port number on the host and 80 is port number inside the container.

kubectl port-forward service/tlian-helm-app 8888:80 --namespace default
```

