ARG BASE_IMAGE=mcr.microsoft.com/devcontainers/base:debian
FROM ${BASE_IMAGE}

# Docker CLI
ENV DOCKER_VERSION="27.1.2"
RUN curl -fsSL "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz" | tar -zxf - --strip=1 -C /usr/local/bin/ docker/docker

# Kubenetes CLI
ENV KUBECTL_VERSION="1.31.0"
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${arch}/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Helm CLI
ENV HELM_VERSION="3.15.4"
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-${arch}.tar.gz | tar -zxf - --strip=1 -C /usr/local/bin/ linux-${arch}/helm

# Skaffold CLI
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-${arch} -o /usr/local/bin/skaffold && \
    chmod +x /usr/local/bin/skaffold

# VS Code CLI
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -Lo vscode_cli.tar.gz "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-$arch" && \
    tar -xzf vscode_cli.tar.gz -C /usr/local/bin --no-same-owner && \
    rm vscode_cli.tar.gz

USER 1000

WORKDIR /home/vscode

# VS Code Server
# RUN commit=$(code --version | grep -oP '(?<=commit )\w+') && \
#     arch=$(uname -m) && \
#     if [ "${arch}" = "x86_64" ]; then \
#     arch="x64"; \
#     elif [ "${arch}" = "aarch64" ]; then \
#     arch="arm64"; \
#     fi && \
#     mkdir -p ~/.vscode/cli/serve-web/${commit} && \
#     curl -Lo vscode_server.tar.gz "https://update.code.visualstudio.com/commit:${commit}/server-linux-${arch}/stable" && \
#     tar -xzf vscode_server.tar.gz -C ~/.vscode/cli/serve-web/${commit} --strip-components=1 --no-same-owner && \
#     echo [\"$commit\"] > ~/.vscode/cli/serve-web/lru.json && \
#     rm vscode_server.tar.gz

EXPOSE 3000

CMD ["code", "serve-web", "--host", "0.0.0.0", "--port", "3000", "--without-connection-token", "--accept-server-license-terms" ]