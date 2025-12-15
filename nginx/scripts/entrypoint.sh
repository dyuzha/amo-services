#!/bin/sh
set -e

VARS="$(sed 's/.*/${&}/' /etc/nginx/vars.list | tr '\n' ' ')"

envsubst "$VARS" \
  < /etc/nginx/nginx.conf.template \
  > /etc/nginx/nginx.conf

exec openresty -g 'daemon off;'
