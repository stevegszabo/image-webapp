FROM ubuntu:latest

MAINTAINER steve.g.szabo

ARG WEBAPP_VERSION
ARG WEBAPP_ADDRESS
ARG WEBAPP_PORT
ARG WEBAPP_LOG_LEVEL
ARG WEBAPP_APPLICATION

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl wget python3 python3-pip gunicorn && \
    apt-get clean

RUN pip3 install flask

ENV WEBAPP_VERSION=$WEBAPP_VERSION
ENV WEBAPP_ADDRESS=$WEBAPP_ADDRESS
ENV WEBAPP_PORT=$WEBAPP_PORT
ENV WEBAPP_LOG_LEVEL=$WEBAPP_LOG_LEVEL
ENV WEBAPP_APPLICATION=$WEBAPP_APPLICATION

COPY root/app /app
RUN chown -R www-data:www-data /app
EXPOSE $WEBAPP_PORT
USER www-data
ENTRYPOINT ["/app/entrypoint.sh"]
