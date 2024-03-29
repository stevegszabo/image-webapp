FROM ubuntu:latest

ARG WEBAPP_VERSION
ARG WEBAPP_ADDRESS
ARG WEBAPP_PORT
ARG WEBAPP_LOG_LEVEL
ARG WEBAPP_APPLICATION
ARG WEBAPP_PROFILE
ARG WEBAPP_DATABASE

ENV DEBIAN_FRONTEND=noninteractive
ENV WEBAPP_VERSION=$WEBAPP_VERSION
ENV WEBAPP_ADDRESS=$WEBAPP_ADDRESS
ENV WEBAPP_PORT=$WEBAPP_PORT
ENV WEBAPP_LOG_LEVEL=$WEBAPP_LOG_LEVEL
ENV WEBAPP_APPLICATION=$WEBAPP_APPLICATION
ENV WEBAPP_PROFILE=$WEBAPP_PROFILE
ENV WEBAPP_DATABASE=$WEBAPP_DATABASE

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget python3 python3-pip gunicorn iproute2 lsof netcat-openbsd && \
    apt-get clean

RUN pip3 install flask

COPY root/app /app
RUN chown -R www-data:www-data /app
EXPOSE $WEBAPP_PORT
USER www-data
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
