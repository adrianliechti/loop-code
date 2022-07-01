FROM adrianliechti/loop-code

USER root

RUN apt update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk-headless \
    openjdk-17-jre-headless \
    gradle \
    maven && \
    rm -rf /var/lib/apt/lists/*

USER 1000

RUN /opt/code/bin/openvscode-server --install-extension vscjava.vscode-java-pack && \
    /opt/code/bin/openvscode-server --install-extension Pivotal.vscode-boot-dev-pack
