#!/bin/bash
set -e
source /etc/profile

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

# seed db if database doesn't exists
(bundle exec rails r "1" 2>&1|grep "NoDatabaseError" || \
 bundle exec rails r "puts User.table_exists?" | grep "false"
) && bundle exec rails db:setup

bundle exec rails db:migrate

exit 0