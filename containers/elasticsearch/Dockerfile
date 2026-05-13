FROM docker.elastic.co/elasticsearch/elasticsearch:8.19.13@sha256:b9f90aa70522c9a26ded74095755ba574294474e4a1cde902c0bc221e2a15daf

LABEL org.opencontainers.image.source=https://github.com/cybozu-go/website-operator

RUN elasticsearch-plugin install analysis-kuromoji \
    && elasticsearch-plugin install analysis-icu
