#!/bin/sh
set -e
IMAGE_NAME=${@:-tanmer-corp/tanmer-account}

echo Build for ${IMAGE_NAME}, press to continue...
read

branch_name=$(git rev-parse --abbrev-ref HEAD)
commit_hash=$(git rev-parse --short HEAD)
tag=$(git tag --points-at HEAD)
# timestamp=$(date +%Y%m%d%H%S)

if [[ ! -z $tag ]]; then
  version=$tag
elif [[ "$branch_name" == "HEAD" ]]; then
  version=$commit_hash
else
  version=${branch_name}-${commit_hash}
fi

RAILS_ENV=production bundle exec rails assets:clobber assets:precompile && \
  docker build -t docker.corp.tanmer.com/${IMAGE_NAME}:${version} . && echo "

you can push image to out reigistry with this command:
    docker push docker.corp.tanmer.com/${IMAGE_NAME}:${version}
    docker tag docker.corp.tanmer.com/${IMAGE_NAME}:{${version},latest}
    docker push docker.corp.tanmer.com/${IMAGE_NAME}:latest
"
