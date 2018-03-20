#!/bin/bash
set -e
source /etc/profile

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

# bundle exec puma -C config/puma.rb -b unix://${rails_root}/tmp/sockets/cable.sock ${rails_root}/cable/config.ru
mkdir -p ${rails_root}/tmp/sockets
ln -sf /srv/${APP_NAME}/config/application.yml config/
rm config/settings.${PROJECT_NAME}.yml
ln -sf /srv/${APP_NAME}/config/settings.${PROJECT_NAME}.yml config/

ENABLE_ACTION_CABLE=true ACTION_CABLE_ONLY=true bundle exec rails s -p 5000