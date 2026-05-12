FROM ghcr.io/cybozu/ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/cybozu-go/website-operator

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
     python3.12 \
     python3-pip \
     python3-venv \
     git \
     openssh-client \
  && rm -rf /var/lib/apt/lists/*

USER 1000:1000
