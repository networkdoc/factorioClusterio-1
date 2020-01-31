# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued

ENV FAC-VERSION=latest

RUN apk add --no-cache curl tar xz git nodejs nodejs-npm make g++ python \
    && mkdir -p /opt/factorioClusterio 

RUN git clone -b master https://github.com/clusterio/factorioClusterio.git

WORKDIR /factorioClusterio

RUN curl -s -L -S -k https://www.factorio.com/get-download/latest/headless/linux64 -o factorio.tar.gz
RUN tar -xf factorio.tar.gz
RUN npm install --only=production
RUN cp config.json.dist config.json
RUN node ./lib/npmPostinstall

EXPOSE 8080 443 34197

VOLUME /factorioClusterio

CMD ["node","client.js", "start"]
