FROM debian:12-slim

RUN apt update && apt install -y --no-install-recommends \
    nasm \
    gcc-i686-linux-gnu \
    binutils-i686-linux-gnu \
    make \
    ca-certificates \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

