# (UNOFFICIAL) factorioClusterio


image for running the latest version of clusterio on the image from factoriotools/factorio-docker.
this image is alpha.

## usage
Use the right tag for your server

thenetworkdoctor/factorio-clusterio_2.0:master

thenetworkdoctor/factorio-clusterio_2.0:client

### this image requires manual work after pulling

Run the docker (it will fail)

run the docker with parameter "-it /bin/sh"

Execute the following commands (basically install clusterio)

    git clone -b master https://github.com/clusterio/factorioClusterio.git .
    wget -O factorio.tar.gz https://www.factorio.com/get-download/latest/headless/linux64
    tar -xf factorio.tar.gz
    npm install --only=production
    cp config.json.dist config.json
    node ./lib/npmPostinstall

Edit the config file, watch out with file permissions. 

Restart the docker, it will load the config now, the master auth key will be created.

run your clusterio
