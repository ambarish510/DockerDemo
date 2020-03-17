FROM frolvlad/alpine-java:jdk8.202.08-slim
MAINTAINER Ambarish A <ambarish.a@flipkart>

RUN apk update \
 && rm -rf /var/cache/apk/*

ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn


RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["/bin/sh"]