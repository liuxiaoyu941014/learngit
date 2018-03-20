#!/bin/sh
set -e

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

mkdir -p /srv/${APP_NAME}/nginx/

cat << EOS > /srv/${APP_NAME}/nginx/default.conf

upstream webstream {
  server web:3000 fail_timeout=0;
}

upstream cablestream {
  server cable:5000 fail_timeout=0;
}

server {
  listen 80 default;
  root ${rails_root}/public;
  try_files \$uri/index.html \$uri @web;

  client_max_body_size 32M;
  keepalive_timeout 10;

  access_log /var/log/nginx.access.log;
  error_log /var/log/nginx.error.log;
  
  location @web {
    proxy_pass http://webstream;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header Host \$http_host;
    proxy_redirect off;
  }

  location /cable {
    proxy_pass http://cablestream;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
  }

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  location ^~ /webpack/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  if (\$request_method !~ ^(GET|HEAD|PUT|PATCH|POST|DELETE|OPTIONS)\$ ){
    return 405;
  }
}
EOS

if [ -n "${DESKTOP_DOMAIN}" ]; then
  cat << EOS > /srv/${APP_NAME}/nginx/desktop.conf
  server {
    listen 80;
    server_name ${DESKTOP_DOMAIN};
    root /srv/dagle-desktop/dist;

    access_log /var/log/nginx-desktop.access.log;
    error_log /var/log/nginx-desktop.error.log;
  }
EOS
else
  rm -f /srv/${APP_NAME}/nginx/desktop.conf
fi

if [ -n "${API_DOMAIN}" ]; then
  cat << EOS > /srv/${APP_NAME}/nginx/api.conf
  upstream apistream {
    server api:3000 fail_timeout=0;
  }

  server {
    listen 80;
    server_name ${API_DOMAIN};
    root ${rails_root}/public;
    try_files \$uri/index.html \$uri @web;

    client_max_body_size 32M;
    keepalive_timeout 10;

    access_log /var/log/nginx-api.access.log;
    error_log /var/log/nginx-api.error.log;
    
    location @web {
      proxy_pass http://apistream;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_host;
      proxy_redirect off;
    }

    if (\$request_method !~ ^(GET|HEAD|PUT|PATCH|POST|DELETE|OPTIONS)\$ ){
      return 405;
    }
  }
EOS
else
  rm -f /srv/${APP_NAME}/nginx/api.conf
fi

cp ${rails_root}/docker/start-nginx.sh /srv/${APP_NAME}/

exit 0