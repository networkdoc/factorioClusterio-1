# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued

ENV VERSION=latest \
    MODE=master

VOLUME /factorioClusterio

RUN apk add --no-cache curl tar xz nodejs git

WORKDIR /factorioClusterio

RUN git clone -b master https://github.com/clusterio/factorioClusterio.git . \
    && curl -s -L -S -k https://www.factorio.com/get-download/$VERSION/headless/linux64 -o factorio.tar.gz \
    && tar -xf factorio.tar.gz \
    && npm install --only=production \
    && cp config.json.dist config.json \
    && node ./lib/npmPostinstall

EXPOSE 8080 34197

CMD ["node","$MODE"]
