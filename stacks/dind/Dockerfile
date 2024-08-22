ARG BASE_IMAGE=ghcr.io/adrianliechti/loop-code
FROM ${BASE_IMAGE}

USER root

RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
    procps \
    uidmap \
    iptables \
    nftables \
    pigz \
    xz-utils \
    e2fsprogs \
    xfsprogs \
    cgroupfs-mount \
    dbus-user-session \
    rootlesskit \
    slirp4netns \
    fuse-overlayfs \
    tini && \
    curl -fsSL "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION}.tgz" | tar -zxf - --strip=1 -C /usr/local/bin/ && \
    curl -fsSL "https://raw.githubusercontent.com/moby/moby/master/hack/dind" -o /usr/local/bin/dind && chmod +x /usr/local/bin/dind && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh

USER 1000

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["code", "serve-web", "--host", "0.0.0.0", "--port", "3000", "--without-connection-token", "--accept-server-license-terms" ]