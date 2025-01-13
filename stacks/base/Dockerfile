ARG BASE_IMAGE=mcr.microsoft.com/devcontainers/base:debian
FROM ${BASE_IMAGE}

ARG RELEASE_TAG=openvscode-server-v1.96.0
ARG RELEASE_ORG=gitpod-io
ARG OPENVSCODE_SERVER_ROOT="/home/.openvscode-server"

ARG USER_UID=1000
ARG USER_GID=1000

RUN if [ -z "${RELEASE_TAG}" ]; then \
        echo "The RELEASE_TAG build arg must be set." >&2 && \
        exit 1; \
    fi && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
        arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
        arch="arm64"; \
    elif [ "${arch}" = "armv7l" ]; then \
        arch="armhf"; \
    fi && \
    wget https://github.com/${RELEASE_ORG}/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    mv -f ${RELEASE_TAG}-linux-${arch} ${OPENVSCODE_SERVER_ROOT} && \
    cp ${OPENVSCODE_SERVER_ROOT}/bin/remote-cli/openvscode-server ${OPENVSCODE_SERVER_ROOT}/bin/remote-cli/code && \
    rm -f ${RELEASE_TAG}-linux-${arch}.tar.gz

RUN chown -R $1000:$1000 ${OPENVSCODE_SERVER_ROOT}


# Docker CLI
ENV DOCKER_VERSION="27.5.0"
RUN curl -fsSL "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz" | tar -zxf - --strip=1 -C /usr/local/bin/ docker/docker

# Kubenetes CLI
ENV KUBECTL_VERSION="1.32.0"
RUN arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="amd64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    fi && \
    curl -fsSL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${arch}/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Helm CLI
ENV HELM_VERSION="3.16.4"
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

WORKDIR /home/vscode

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    HOME=/home/vscode \
    EDITOR=code \
    VISUAL=code \
    GIT_EDITOR="code --wait" \
    OPENVSCODE_SERVER_ROOT=${OPENVSCODE_SERVER_ROOT} \
    PATH=${PATH}:${OPENVSCODE_SERVER_ROOT}/bin

EXPOSE 3000

CMD [ "/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server --host 0.0.0.0 --without-connection-token \"${@}\"", "--" ]