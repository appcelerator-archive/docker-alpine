# docker-alpine

Docker base image for [Alpine Linux](http://www.alpinelinux.org/), its purpose is to be used as base Docker image.

It includes python, curl, bash, jq, [envtpl](https://github.com/andreasjansson/envtpl) and [ContainerPilot](https://github.com/joyent/containerpilot).

## Usage

To enable ContainerPilot, add the following variables:

    ENV CP_SERVICE_NAME=svcName
    ENV CP_SERVICE_PORT=8092
    ENV CP_SERVICE_BIN=binName
    ENV CP_DEPENDENCIES='[{"name": "influxdb", "poll": "10", "onChange": "/stop.sh"}, {"name": "amp-log-agent", "poll": "10", "onChange": "/stop.sh"} ]'

This example will have influxdb and amp-log-agent as dependencies to a svcName service, the pid will be check on a binary called binName.

### ContainerPilot default values

Log level default value is ERROR, it can be overriden with the environment variable CP_LOG_LEVEL.

Polling interval default value is 3, it can be overriden with the environment variable CP_POLL.

TTL default value is 20, it can be overriden with the environment variable CP_TTL.

Command launched by ContainerPilot is /run.sh, it can be overriden with the environment variable CP_SERVICE_CMD.

## Tags

- latest
