#! /bin/bash -l
ln -sf /etc/railsconfig/application.yml /srv/app/config/application.yml

exec $@
