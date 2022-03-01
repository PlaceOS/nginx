FROM openresty/openresty:1.19.9.1-alpine-fat

RUN apk add --no-cache \
  'expat>=2.4.5-r0' \
  git \
  openssl

# TODO: install lua-resty-jwt then base off a smaller open-resty image
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

COPY ./config /etc/nginx

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
