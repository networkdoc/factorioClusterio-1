#!/bin/bash
set -eoux pipefail

FACTORIO_VOL=/opt/factorioClusterio/factorio
CLUSTERIO_VOL=/opt/factorioClusterio
LOAD_LATEST_SAVE="${LOAD_LATEST_SAVE:-true}"
GENERATE_NEW_SAVE="${GENERATE_NEW_SAVE:-false}"
SAVE_NAME="${SAVE_NAME:-""}"

#mkdir -p "$FACTORIO_VOL"

if [[ ! -f $CLUSTERIO_VOL/secret-api-token.txt ]]; then
	git clone -b master https://github.com/clusterio/factorioClusterio.git "$CLUSTERIO_VOL" \
    && npm install --only=production \
    && node ./lib/npmPostinstall
fi

if [[ ! -f $CLUSTERIO_VOL/config.json ]]; then
  # Copy default settings if config.json doesn't exist
  cp "$CLUSTERIO_VOL/config.json.dist" "$CLUSTERIO_VOL/config.json"
fi

if [[ ! -f $FACTORIO_VOL/bin/x64/factorio ]]; then
  curl -s -L -S -k https://www.factorio.com/get-download/$VERSION/headless/linux64 -o factorio.tar.gz \
  && tar -xf factorio.tar.gz -C "$FACTORIO_VOL"\
  && rm factorio.tar.gz
fi

if [[ $(id -u) = 0 ]]; then
  # Update the User and Group ID based on the PUID/PGID variables
  usermod -o -u "$PUID" clusterio
  groupmod -o -g "$PGID" clusterio
  # Take ownership of factorio data if running as root
  chown -R clusterio:clusterio "$CLUSTERIO_VOL"
  # Drop to the clusterio user
  SU_EXEC="su-exec clusterio"
else
  SU_EXEC=""
fi

exec $SU_EXEC node $CLUSTERIO_VOL "$MODE" "$@"
