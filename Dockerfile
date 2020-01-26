# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued
ARG USER=clusterio
ARG GROUP=clusterio
ARG PUID=1337
ARG PGID=1337

ENV VERSION=latest \
    MODE=master.js

VOLUME /opt/factorioClusterio

RUN apk add --no-cache curl tar xz git nodejs nodejs-npm make g++ python \
    && mkdir -p /opt/factorioClusterio \
    && addgroup -g "$PGID" -S "$GROUP" \
    && adduser -u "$PUID" -G "$GROUP" -s /bin/sh -SDH "$USER" \
    && chown -R "$USER":"$GROUP" /opt/factorioClusterio

WORKDIR /opt/factorioClusterio

EXPOSE 8080 443 34197

CMD node $MODE
