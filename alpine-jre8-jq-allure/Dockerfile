FROM frolvlad/alpine-java:jre8.202.08-cleaned
MAINTAINER Ambarish A <ambarish.a@flipkart>

RUN apk update \
 && apk add jq \
 && rm -rf /var/cache/apk/*

ENV JAVA_HOME="/usr/lib/jvm/default-jvm/jre/"
COPY allure-2.13.0 /opt/allure/
ENV PATH="/opt/allure/bin:${PATH}"

RUN apk add --no-cache bash libxml2-utils

RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["/bin/ash"]