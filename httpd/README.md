# About this container.

A docker container to serve as a proxy in front of RUNDECK. This container
features:
- (Self signed) SSL certificate.
- http to https redirect.
- Reversed proxy to RUNDECK.

This container works well with docker-compose: https://github.com/robertdebock/docker-compose-rundeck

# Running this container.

To run this application, use:

    docker run \
    -p 8080:80 \
    -p 8443:443 \
    -e SSL_COUNTRY=NL \
    -e SSL_STATE=UTRECHT \
    -e SSL_LOCATION=Breukelen \
    -e SSL_ORGANIZATION="Me in IT Consultancy" \
    -e SSL_ORGANIZATIONAL_UNIT="IT Department" \
    -e SSL_COMMONNAME=rundeck.meinit.nl \
    -d \
    robertdebock/docker-rundeck-httpd
    
# Usage explained.
This are the meaning of the different options:

|option|default value|usage|
|---|---|---|
|-p|-|Any (TCP) port, you may want to map an external port to this local port using: "external:internal". (i.e. "8080:80")|
|-e SSL_COUNTRY|NL|A country to be used in the certificate.|
|-e SSL_STATE|UTRECHT|A state to be used in the certificate.|
|-e SSL_LOCATION|Breukelen|A location to be used in the certificate.|
|-e SSL_ORGANIZATION|Me in IT Consultancy|An organization to be used in the certificate.|
|-e SSL_ORGANIZATIONAL_UNIT|IT Department|An organizational unix to be used in the certificate.|
|-e SSL_COMMONNAME|rundeck.meinit.nl|A state to be used in the certificate.|
|-d|n.a.|Detach to the background.|
|robertdebock/docker-rundeck-httpd|n.a.|Refers to this container.|
