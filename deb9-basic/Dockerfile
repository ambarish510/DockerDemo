# Using official image of stretch as base
FROM debian:stretch
MAINTAINER Ambarish A (ambarish.a@flipkart.com)

# update repos
#RUN echo "deb http://10.47.4.220/repos/infra-cli/8 /" | tee -a /etc/apt/sources.list.d/infra.list
#RUN apt-get update

# Install basic utilities
RUN apt-get update && apt-get install -y --force-yes sudo curl
RUN mkdir /var/run/sshd
RUN apt-get update && apt-get install -y --force-yes openssh-server


RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

# Install Java & reposervice cli
# RUN apt-get install --yes --allow-unauthenticated infra-cli

##############################################################################################
########################### ADD YOUR CUSTOM CODE HERE ########################################
##############################################################################################


RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*



EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
