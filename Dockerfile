FROM alpine:3.4
MAINTAINER Nicolas Degory <ndegory@axway.com>

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk --no-cache add python ca-certificates curl wget bash jq gosu@testing && \
    apk --virtual envtpl-deps add --update py-pip python-dev && \
    curl https://bootstrap.pypa.io/ez_setup.py | python && \
    pip install envtpl && \
    apk del envtpl-deps && rm -rf /var/cache/apk/* /setuptools-*.zip

COPY sut /usr/local/sut
