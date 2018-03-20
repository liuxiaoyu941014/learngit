#!/bin/bash
set -e

dir=`pwd`
cd $(dirname $0)/..
workdir=`pwd`
cd $dir

RAILS_ENV=${RAILS_ENV:-production}
branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}
version=`date +%Y%m%d%H%M%S`
version=${branch_name}-${version}
build_assets () {
    PROJECT_NAME=${PROJECT_NAME:-dagle} bundle exec \
        rails dbadapter=nulldb \
            assets:clobber \
            assets:precompile \
            webpack:compile
}

build_docker () {
    docker build -t docker.corp.tanmer.com/tanmer/dagle:${version} -f ${workdir}/docker/Dockerfile \
    --build-arg BUNDLE_GEMS__TANMER__COM=${BUNDLE_GEMS__TANMER__COM} \
    --build-arg PROJECT_NAME=${PROJECT_NAME:-dagle} \
    ${workdir}
}

echo "building"
build_assets && \
build_docker && echo "

you can push image to out reigistry with this command:

    docker tag docker.corp.tanmer.com/tanmer/dagle:{${version},${branch_name}}
    docker push docker.corp.tanmer.com/tanmer/dagle:${version}
    docker push docker.corp.tanmer.com/tanmer/dagle:${branch_name}
"
