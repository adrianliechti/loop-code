# Loop Visual Studio Code Server

## Available Images

Base Images

* ghcr.io/adrianliechti/loop-code

Pre-Configured Images

* ghcr.io/adrianliechti/loop-code:dotnet
* ghcr.io/adrianliechti/loop-code:golang
* ghcr.io/adrianliechti/loop-code:java
* ghcr.io/adrianliechti/loop-code:node
* ghcr.io/adrianliechti/loop-code:python


## Run locally (Example)

```shell
# run golang stack
docker run --name code -v $(pwd):/src -p 3000:3000 ghcr.io/adrianliechti/loop-code
```

Open [http://localhost:3000/?folder=/src](http://localhost:3000/?folder=/src) in your Web Browser