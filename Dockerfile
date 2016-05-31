FROM alpine:3.3
MAINTAINER Nicolas Degory <ndegory@axway.com>

RUN apk --no-cache add ca-certificates bash make gcc g++ curl wget jq vim python
