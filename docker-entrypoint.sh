#!/bin/bash
set -eoux pipefail

if [[ ! -f /opt/factorioClusterio/secret-api-token.txt ]]; then
	git clone -b master https://github.com/clusterio/factorioClusterio.git /opt/factorioClusterio \
    && npm install --only=production \
    && node ./lib/npmPostinstall
fi

if [[ ! -f /opt/factorioClusterio/config.json ]]; then
  # Copy default settings if config.json doesn't exist
  cp "$CLUSTERIO_VOL/config.json.dist" "$CLUSTERIO_VOL/config.json"
fi

if [[ ! -f /opt/factorioClusterio/factorio/bin/x64/factorio ]]; then
  curl -s -L -S -k https://www.factorio.com/get-download/$VERSION/headless/linux64 -o factorio.tar.gz \
  && tar -xf factorio.tar.gz -C "$FACTORIO_VOL"\
  && rm factorio.tar.gz
fi

exec "$@"
