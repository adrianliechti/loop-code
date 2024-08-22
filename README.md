# Loop Visual Studio Code Server

## Available Images

Base Images

* ghcr.io/adrianliechti/loop-code
* ghcr.io/adrianliechti/loop-code:dind

Pre-Configured Images

* ghcr.io/adrianliechti/loop-code:golang
* ghcr.io/adrianliechti/loop-code:golang-dind
* ghcr.io/adrianliechti/loop-code:python
* ghcr.io/adrianliechti/loop-code:python-dind
* ghcr.io/adrianliechti/loop-code:java
* ghcr.io/adrianliechti/loop-code:java-dind
* ghcr.io/adrianliechti/loop-code:dotnet
* ghcr.io/adrianliechti/loop-code:dotnet-dind


## Run locally (Example)

```shell
# run golang stack
docker run --name code -v $(pwd):/src -p 3000:3000 ghcr.io/adrianliechti/loop-code
```

With Docker Support

```shell
# run golang stack with docker-in-docker support
docker run --name code --privileged -v $(pwd):/src -p 3000:3000 adrianliechti/loop-code:dind
```

Open [http://localhost:3000/?folder=/src](http://localhost:3000/?folder=/src) in your Web Browser

## Install on Kubernetes (Example)

This creates the following in the Namespace "loop"

- a deployment with a persistent volume
- a privileged sidecare container running docker
- a service account & cluster-admin role binding (to manage Kubernetes)
- a service accessable by http

```shell
# deploy on kubernetes
kubectl apply -f https://raw.githubusercontent.com/adrianliechti/loop-code/main/kubernetes/install.yaml

# change stack if needed
kubectl set image deployment/code code=ghcr.io/adrianliechti/loop-code:python
```