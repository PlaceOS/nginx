#! /usr/bin/env bash

set -eu

# PlaceOS nginx entrypoint

nginx_config="/etc/nginx"
certs_path="${nginx_config}/ssl/default-domain"

# Generate self-signed SSL certificates if none present
if [ ! -d "${nginx_config}/ssl" ]; then
  mkdir -p "${certs_path}"

  openssl req -newkey rsa:2048 -nodes -days 365 -x509 \
    -subj "/C=AU/ST=NSW/L=Sydney/O=PlaceOS/CN=${PLACE_DOMAIN}" \
    -keyout "${certs_path}/privkey.pem" -out "${certs_path}/fullchain.pem"

  openssl dhparam -out "${nginx_config}/ssl/dhparam.pem" 1024
fi

# Extract the port to use when upgrading connection to HTTPS if it has not been
# explicitly set. This port may differ from the local HTTPS when remapped within
# different deployment environments.
if [ -z ${HTTPS_REDIRECT_PORT+x} ]; then
  export HTTPS_REDIRECT_PORT=${PLACE_DOMAIN#*:}
fi

# Start OpenResty
/usr/local/openresty/bin/openresty -c "${nginx_config}/nginx.conf"
