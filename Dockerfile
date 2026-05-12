FROM ghcr.io/cybozu/ubuntu:24.04 AS base

LABEL org.opencontainers.image.source=https://github.com/cybozu-go/website-operator

FROM base as website-operator
ARG TARGETPLATFORM
COPY $TARGETPLATFORM/website-operator /
USER 1000:1000
ENTRYPOINT ["/website-operator"]

FROM base as repo-checker
RUN apt-get update \
    && apt-get install -y --no-install-recommends git openssh-client \
    && rm -rf /var/lib/apt/lists/*
ARG TARGETPLATFORM
COPY $TARGETPLATFORM/repo-checker /
USER 1000:1000
ENTRYPOINT ["/repo-checker"]

FROM base as ui
COPY ui/frontend/dist /dist
ARG TARGETPLATFORM
COPY $TARGETPLATFORM/website-operator-ui /
USER 1000:1000
ENTRYPOINT ["/website-operator-ui"]
