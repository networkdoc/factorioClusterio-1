# glibc is required for Factorio Server binaries to run
FROM frolvlad/alpine-glibc

#MAINTAINER to-be-continued
ENV VERSION=latest \
    MODE=master.js

RUN apk add --no-cache curl tar xz git nodejs nodejs-npm make g++ python \
    && mkdir -p /opt/factorioClusterio

VOLUME /opt/factorioClusterio

WORKDIR /opt/factorioClusterio

EXPOSE 8080 443 34197

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["node","$MODE"]
