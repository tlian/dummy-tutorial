# How to run Application within Kubternetes
(The following instruction was executed on MacOS)

### Steps 
(For simplicity, run the following commands from within this directory - i.e. \**/**/k8s)

1. Pre-req: 

   [Install Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download)

   [Install & setup Kubectl on MacOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/) 

2. Use Minikube's built-in Docker daemon. See [More info](https://stackoverflow.com/questions/56392041/getting-errimageneverpull-in-pods)

```
eval $(minikube docker-env)
```

3. Build Docker image

```docker build . -t flaks-web-app -f ./Dockerfile```

4.  Deploy the app in Kubernetes 

```kubectl apply -f ./deployments/deployment.yaml```

5. Forward the port so that the application can be accessed from the host

```
kubectl port-forward <pod-name> <port-on-host>:<port-inside-container> 

For example: 
kubectl port-forward flask-app-tlian-deployment-5c5968b564-lfs49 5002:5000
```

6. Access the application

   http://127.0.0.1:5002