ARG CODE_IMAGE=adrianliechti/loop-code
FROM ${CODE_IMAGE}

USER root

RUN apt update && apt-get install -y --no-install-recommends \
    g++ \
    gcc \
    libc6-dev \
    make \
    pkg-config && \
    rm -rf /var/lib/apt/lists/*

ENV GO_VERSION=1.22.2
ENV GOPATH=$HOME/go

RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://dl.google.com/go/go$GO_VERSION.linux-${arch}.tar.gz | tar -C /usr/local -xzf -

ENV PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

USER 1000

# https://github.com/golang/vscode-go/blob/master/tools/allTools.ts.in
RUN go install -v github.com/fatih/gomodifytags@latest && \
    go install -v github.com/haya14busa/goplay/cmd/goplay@latest && \
    go install -v github.com/josharian/impl@latest && \
    go install -v mvdan.cc/gofumpt@latest && \
    go install -v golang.org/x/tools/cmd/goimports@latest && \
    go install -v github.com/cweill/gotests/gotests@latest && \
    go install -v golang.org/x/lint/golint@latest && \
    go install -v honnef.co/go/tools/cmd/staticcheck@latest && \
    go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest && \
    go install -v github.com/mgechev/revive@latest && \
    go install -v golang.org/x/tools/gopls@latest && \
    go install -v github.com/go-delve/delve/cmd/dlv@latest && \
    sudo rm -rf $HOME/.cache $GOPATH/src $GOPATH/pkg

RUN /opt/code/bin/openvscode-server --install-extension golang.Go