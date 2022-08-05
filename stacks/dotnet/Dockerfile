ARG CODE_IMAGE=adrianliechti/loop-code
FROM ${CODE_IMAGE}

USER root

RUN apt update && apt-get install -y --no-install-recommends \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu70 \
    libssl3 \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/dotnet && \
    curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -c Current --install-dir /opt/dotnet

ENV PATH=$PATH:/opt/dotnet

ENV ASPNETCORE_URLS=http://+:80 \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false \
    DOTNET_NOLOGO=true \
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    NUGET_XMLDOC_MODE=skip

USER 1000

RUN /opt/code/bin/openvscode-server --install-extension muhammad-sammy.csharp