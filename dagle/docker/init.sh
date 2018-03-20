#!/bin/bash
set -e

dir=`pwd`
cd $(dirname $0)/..
rails_root=`pwd`
cd $dir

echo "Settting up env..."
${rails_root}/docker/setup-env.sh
echo "Setting up Nginx"
${rails_root}/docker/setup-nginx.sh
echo "Completed."