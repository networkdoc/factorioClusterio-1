# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued

ENV VERSION=latest \
    MODE=master.js

VOLUME /factorioClusterio

RUN apk add --no-cache curl tar xz git nodejs nodejs-npm make g++ python \
    && mkdir -p /factorioClusterio 

WORKDIR /factorioClusterio

RUN git clone -b master https://github.com/clusterio/factorioClusterio.git && cd /factorioClusterio
RUN curl -s -L -S -k https://www.factorio.com/get-download/$VERSION/headless/linux64 -o factorio.tar.gz && tar -xf factorio.tar.gz

EXPOSE 8080 443 34197

CMD ["node", "master.js" ]
