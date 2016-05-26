#!/bin/bash

ready=1
for service in $(echo $CP_DEPENDENCIES | jq  -r '. | map(.name) | .[]'); do
  status=$(curl --max-time 3 -s http://$CONSUL/v1/health/checks/$service)
  if [[ $status =~ ^.*\"Status\":\"passing\" ]]; then
    echo $service" is ready"
  else
    echo $service" is not yet ready"
    ready=0
  fi
done
if [ "$ready" == "0" ]; then
  echo "At least one dependency is not ready: Send SIGTERM (15) signal"
  kill SIGTERM $(pidof ${CP_SERVICE_BIN:-$CP_SERVICE_NAME})
fi
