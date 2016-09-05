#!/bin/sh

if [ ! ${1} ] ; then
  echo "Please specify a project."
  exit 1
fi

curl \
  --insecure \
  --request GET \
  --header 'Accept: application/json' \
  --header 'X-Rundeck-Auth-Token: kEVhlUSJbcpdGnMQaiESd6bRqpVVMiw3' \
  https://localhost/api/14/project/${1}/jobs
