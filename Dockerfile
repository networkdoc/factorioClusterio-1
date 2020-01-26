# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued

ENV VERSION=latest \
    MODE=master.js

VOLUME /opt/factorioClusterio

RUN apk add --no-cache curl tar xz git nodejs nodejs-npm make g++ python \
    && mkdir -p /opt/factorioClusterio 

WORKDIR /opt/factorioClusterio

EXPOSE 8080 443 34197

CMD ["node","$MODE"]
