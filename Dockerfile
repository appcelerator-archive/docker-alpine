FROM alpine:3.5

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://nl.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk --no-cache add ca-certificates curl wget bash jq gosu@testing && \
    curl -o /usr/bin/envtpl -L https://github.com/subfuzion/envtpl/blob/master/envtpl?raw=true && \
    chmod a+x /usr/bin/envtpl && \
    rm -rf /var/cache/apk/*

COPY sut /usr/local/sut
