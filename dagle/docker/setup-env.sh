#!/bin/bash
set -e
source /etc/profile

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

mkdir -p /srv/${APP_NAME}/config/

cat << EOS > /srv/${APP_NAME}/config/application.yml
APP_NAME: ${APP_NAME}
PROJECT_NAME: ${PROJECT_NAME}
POSTGRESQL_DATABASE_HOST: ${POSTGRESQL_DATABASE_HOST}
POSTGRESQL_DATABASE_NAME: ${POSTGRESQL_DATABASE_NAME}
POSTGRESQL_DATABASE_USERNAME: ${POSTGRESQL_DATABASE_USERNAME}
POSTGRESQL_DATABASE_PASSWORD: ${POSTGRESQL_DATABASE_PASSWORD}
RAILS_ENV: ${RAILS_ENV}
RAILS_MAX_THREADS: ${RAILS_MAX_THREADS}
SECRET_KEY_BASE: ${SECRET_KEY_BASE}
REDIS_URL: ${REDIS_URL}
EOS

echo "${SETTINGS_YML}" > /srv/${APP_NAME}/config/settings.${PROJECT_NAME}.yml

mkdir -p /srv/${APP_NAME}/public/{ckeditor_assets,photos,attachments,system}

# link cms-templates
# if [ -L ${rails_root}/public/templetes ]; then unlink ${rails_root}/public/templetes ;fi
# if [ -d ${rails_root}/public/templetes ]; then rmdir -rf ${rails_root}/public/templetes ;fi
# ln -sf /srv/cms-templates ${rails_root}/public/templetes

exit 0