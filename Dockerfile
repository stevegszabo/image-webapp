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
ENV PATH=$PATH:/app/.local/bin

USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget python3 python3-pip python3.10-venv iproute2 lsof netcat-openbsd && \
    apt-get clean

COPY root/app /app
RUN usermod -d /app www-data
RUN chown -R www-data:www-data /app

USER www-data
RUN python3 -m venv /app/virtual && \
    . /app/virtual/bin/activate && \
    python3 -m pip install -r /app/requirements.txt

EXPOSE $WEBAPP_PORT
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
