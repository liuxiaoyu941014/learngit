#!/bin/bash
set -e
source /etc/profile

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

mkdir -p ${rails_root}/tmp/sockets

ln -sf /srv/${APP_NAME}/config/application.yml config/
rm config/settings.${PROJECT_NAME}.yml
ln -sf /srv/${APP_NAME}/config/settings.${PROJECT_NAME}.yml config/
mkdir -p /srv/dagle/tmp/pids/
bundle exec sidekiq