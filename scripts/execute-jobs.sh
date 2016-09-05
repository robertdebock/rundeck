#!/bin/sh

if [ ! ${1} ] ; then
  echo "Please specify a job id to start."
  exit 1
fi

curl \
  --insecure \
  --request POST \
  --data-urlencode "argString=-tag production-batch00" \
  --header 'X-Rundeck-Auth-Token: kEVhlUSJbcpdGnMQaiESd6bRqpVVMiw3' \
  https://localhost/api/1/job/${1}/executions
