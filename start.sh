#!/bin/bash

#display env. variables
echo ---------------------------------------------------------------------------
echo "Discovery endpoint: ${CONSUL:-none}"
if [ -z "$CONSUL" ]; then
  exec "${CP_SERVICE_CMD:-/run.sh}"
else
  cat /etc/containerpilot.json.tpl | envtpl | sed 's/}\s*{/}, {/g' > /etc/containerpilot.json
  echo ---------------------------------------------------------------------------
  echo ContainerPilot conffile
  cat /etc/containerpilot.json
  echo ---------------------------------------------------------------------------
  while true
  do
    ready=0
    while [ "$ready" != "1" ]
      do
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
        echo "Waiting for dependencies"
        sleep 10
      fi
    done
    echo "All dependencies are ready"
    /bin/containerpilot "${CP_SERVICE_CMD:-/run.sh}"
    echo "WARNING - containerpilot has exited ($?)"
  done
fi
