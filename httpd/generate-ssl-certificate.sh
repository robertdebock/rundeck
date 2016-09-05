#!/bin/sh

dir="/usr/local/apache2/conf"
crt="${dir}/server.crt"
key="${dir}/server.key"

openssl req  -nodes -new -x509  -keyout ${key} -out ${crt}  -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCATION}/O=${SSL_ORGANIZATION}/OU=${SSL_ORGANIZATIONAL_UNIT}/CN=${SSL_COMMONNAME}"
