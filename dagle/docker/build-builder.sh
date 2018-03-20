#!/bin/bash
set -e

build_docker () {
    docker build -t docker.corp.tanmer.com/tanmer/dagle/builder -f Dockerfile.builder .
}

build_docker && echo "

you can push image to out reigistry with this command:

    docker push docker.corp.tanmer.com/tanmer/dagle/builder
"
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`:/srv/workdir docker sh /srv/workdir/docker/build-image.sh