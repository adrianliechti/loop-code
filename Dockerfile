FROM ubuntu:22.04

ARG VERSION=v1.84.0

RUN apt update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    netbase \
    sudo \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/code && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    wget -q https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-${VERSION}/openvscode-server-${VERSION}-linux-${arch}.tar.gz && \
    tar -xzf openvscode-server-${VERSION}-linux-${arch}.tar.gz -C /opt/code --strip 1 && \
    cp /opt/code/bin/remote-cli/openvscode-server /opt/code/bin/remote-cli/code && \
    chown -R root:root /opt/code && \
    rm -f openvscode-server-${VERSION}-linux-${arch}.tar.gz

RUN groupadd -g 1000 code && \
    useradd -u 1000 -g 1000 -m -s /bin/bash code && \
    echo code ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/code && \
    chmod 0440 /etc/sudoers.d/code

RUN mkdir -p /workspace && \
    chown -R code:code /workspace

# Docker CLI
ENV DOCKER_VERSION="24.0.7"
RUN curl -fsSL "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz" | tar -zxf - --strip=1 -C /usr/local/bin/ docker/docker

# Kubenetes CLI
ENV KUBECTL_VERSION="1.28.4"
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${arch}/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Helm CLI
ENV HELM_VERSION="3.13.2"
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

USER 1000

ENV PATH /opt/code/bin:$PATH

WORKDIR /home/code

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    HOME=/home/code \
    EDITOR=code \
    VISUAL=code \
    GIT_EDITOR="code --wait"

EXPOSE 3000

RUN /opt/code/bin/openvscode-server --install-extension ms-azuretools.vscode-docker && \
    /opt/code/bin/openvscode-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools && \
    /opt/code/bin/openvscode-server --install-extension redhat.vscode-xml && \
    /opt/code/bin/openvscode-server --install-extension redhat.vscode-yaml

CMD [ "/bin/sh", "-c", "exec /opt/code/bin/openvscode-server --host 0.0.0.0 --without-connection-token" ]