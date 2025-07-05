FROM mcr.microsoft.com/devcontainers/base:ubuntu
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends xfce4 tightvncserver && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir /zrok && \
    wget -qO- "https://github.com/openziti/zrok/releases/latest/download/zrok_linux_amd64.tar.gz" | \
    tar -xz -C /zrok && \
    mv /zrok/zrok /usr/local/bin/
USER codespace
