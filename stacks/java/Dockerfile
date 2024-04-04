ARG CODE_IMAGE=adrianliechti/loop-code
FROM ${CODE_IMAGE}

USER root

RUN apt update && apt-get install -y --no-install-recommends \
    openjdk-21-jdk-headless \
    openjdk-21-jre-headless \
    gradle \
    maven && \
    rm -rf /var/lib/apt/lists/*

USER 1000

RUN /opt/code/bin/openvscode-server --install-extension vscjava.vscode-java-pack
