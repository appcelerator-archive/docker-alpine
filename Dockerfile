FROM alpine:3.4
MAINTAINER Nicolas Degory <ndegory@axway.com>

RUN apk update && \
    apk --no-cache add python ca-certificates curl bash jq && \
    apk --virtual envtpl-deps add --update py-pip python-dev && \
    curl https://bootstrap.pypa.io/ez_setup.py | python && \
    pip install envtpl && \
    apk del envtpl-deps && rm -rf /var/cache/apk/*

ENV CONTAINER_PILOT_VERSION 2.1.0
RUN apk --virtual builddeps add --update binutils && \
    curl -Lo /tmp/cb.tar.gz https://github.com/joyent/containerpilot/releases/download/$CONTAINER_PILOT_VERSION/containerpilot-$CONTAINER_PILOT_VERSION.tar.gz && \
    tar xzf /tmp/cb.tar.gz && \
    strip ./containerpilot && \
    mv ./containerpilot /bin/ && \
    rm /tmp/cb.tar.gz && \
    apk del builddeps && rm -rf /var/cache/apk/*

ENV CONTAINERPILOT=file:///etc/containerpilot.json
COPY containerpilot.json /etc/containerpilot.json.tpl
COPY start.sh /start.sh
COPY stop.sh /stop.sh
