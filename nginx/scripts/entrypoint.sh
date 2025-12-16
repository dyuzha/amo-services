#!/bin/sh
set -e

VARS="$(sed 's/.*/${&}/' /etc/nginx/vars.list | tr '\n' ' ')"

envsubst "$VARS" \
  < /etc/nginx/nginx.conf.template \
  > /usr/local/openresty/nginx/conf/nginx.conf
  # > /etc/nginx/nginx.conf

exec openresty -g 'daemon off;'
