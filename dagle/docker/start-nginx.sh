#!/bin/sh
set -e
rm -rf /etc/nginx/conf.d/
ln -sf /srv/${APP_NAME}/nginx /etc/nginx/conf.d
nginx -g 'daemon off;'