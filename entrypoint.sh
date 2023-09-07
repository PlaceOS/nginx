#! /usr/bin/env bash

set -eu

# PlaceOS nginx entrypoint

nginx_config="/etc/nginx"

envsubst '$SECRET_KEY_BASE' < ${nginx_config}/templates/nginx.conf.template > ${nginx_config}/nginx.conf

# Start OpenResty
/usr/local/openresty/bin/openresty -c "${nginx_config}/nginx.conf"
