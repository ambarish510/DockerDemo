# Using official image of openjdk jre stretch as base
FROM openjdk:8u181-jre-stretch
MAINTAINER Ambarish A (ambarish.a@flipkart.com)

# update repos
RUN echo "deb http://10.47.4.220/repos/infra-cli/8 /" | tee -a /etc/apt/sources.list.d/infra.list
RUN echo "deb http://10.47.4.220/repos/fk-jq/1 /" | tee /etc/apt/sources.list.d/fk-jq.list
RUN apt-get update && apt-get install --yes --allow-unauthenticated  sudo curl fk-jq
RUN mkdir /var/run/sshd
RUN apt-get install --yes --allow-unauthenticated  openssh-server
#ADD https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.13.0/allure-commandline-2.13.0.zip /opt/allure/
COPY allure-2.13.0 /opt/allure/
ENV PATH="/opt/allure/bin:${PATH}"

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
# Install Java & reposervice cli
RUN apt-get install --yes --allow-unauthenticated infra-cli

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN env | grep _ >> /etc/environment

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
