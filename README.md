# PlaceOS Nginx

nginx configuration for PlaceOS.

The container entrypoint generates a self-signed certificate if one is not present.

## Files

- `/etcd/config/nginx.conf`: PlaceOS nginx configuration
- `/etcd/config/bearer.lua`: lua script for JWT based access control
- `/etcd/config/ssl`: SSL certificates

## Environment

- `JWT_PUBLIC`: public key for verification of JWTs
- `INFLUX_API_KEY`: api key for upstream InfluxDB
- `PLACE_DOMAIN`: domain for SSL certificate
