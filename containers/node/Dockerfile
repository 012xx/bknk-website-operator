ARG NODE_VERSION=24.14.1
ARG PNPM_VERSION=v10.33.0
ARG BASE_TAG=24.04

FROM scratch AS node-amd64
ARG NODE_VERSION
ADD --checksum=sha256:ace9fa104992ed0829642629c46ca7bd7fd6e76278cb96c958c4b387d29658ea \
    https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz /node.tar.gz

FROM scratch AS node-arm64
ARG NODE_VERSION
ADD --checksum=sha256:734ff04fa7f8ed2e8a78d40cacf5ac3fc4515dac2858757cbab313eb483ba8a2 \
    https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-arm64.tar.gz /node.tar.gz

FROM scratch AS pnpm-amd64
ARG PNPM_VERSION
ADD --checksum=sha256:8d4e8f7d778e8ac482022e2577011706a872542f6f6f233e795a4d9f978ea8b5 \
    https://github.com/pnpm/pnpm/releases/download/${PNPM_VERSION}/pnpm-linux-x64 /pnpm

FROM scratch AS pnpm-arm64
ARG PNPM_VERSION
ADD --checksum=sha256:06755ad2817548b84317d857d5c8003dc6e9e28416a3ea7467256c49ab400d48 \
    https://github.com/pnpm/pnpm/releases/download/${PNPM_VERSION}/pnpm-linux-arm64 /pnpm

# Select the right download stage based on the target architecture
FROM node-${TARGETARCH} AS node-download
FROM pnpm-${TARGETARCH} AS pnpm-download

FROM ghcr.io/cybozu/ubuntu:${BASE_TAG} AS builder

LABEL org.opencontainers.image.source=https://github.com/cybozu-go/website-operator

USER root

RUN --mount=type=bind,from=node-download,source=/node.tar.gz,target=/tmp/node.tar.gz \
    mkdir -p /opt/node \
 && tar xf /tmp/node.tar.gz -C /opt/node --strip-components=1
ENV PATH="/opt/node/bin:${PATH}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
        # necessary for cloning repository
        git \
        openssh-client \
        # necessary for plantuml
        default-jre \
        graphviz \
 && rm -rf /var/lib/apt/lists/*

RUN --mount=type=bind,from=pnpm-download,source=/pnpm,target=/tmp/pnpm \
    install -m 0755 /tmp/pnpm /usr/local/bin/pnpm \
 && pnpm config set -g minimumReleaseAge 1440

USER 1000:1000
