FROM python:3-alpine3.9 as builder

RUN apk add --update \
    python3 \
    python3-dev \
    py-pip \
    build-base \
  && rm -rf /var/cache/apk/*

WORKDIR /srv
COPY . /srv
RUN python3 -m venv env
RUN env/bin/pip install -r requirements.txt
RUN env/bin/pip install --upgrade ply

FROM python:3-alpine3.9
RUN apk add --update \
    python3
COPY --from=builder \
  /srv/ \
  /srv/
