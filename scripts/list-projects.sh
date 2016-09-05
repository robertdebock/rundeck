#!/bin/sh

curl \
  --request GET \
  --insecure \
  --header 'Accept: application/json' \
  --header 'X-Rundeck-Auth-Token: kEVhlUSJbcpdGnMQaiESd6bRqpVVMiw3' \
  https://localhost/api/1/projects/
