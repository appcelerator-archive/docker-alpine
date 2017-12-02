FROM alpine:3.7

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://nl.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories && \
    echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN TZ=UTC date > /etc/appcelerator-alpine-update && \
    apk update && \
    apk upgrade && \
    apk add ca-certificates curl bash jq gosu@testing tini@community && \
    curl -o /usr/bin/envtpl -L https://github.com/appcelerator/envtpl/blob/v1.0.0/envtpl?raw=true && \
    chmod a+x /usr/bin/envtpl && \
    rm -rf /var/cache/apk/*
