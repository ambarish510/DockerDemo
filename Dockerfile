FROM openjdk:8-jdk-stretch
RUN apt-get update && apt-get upgrade -y && apt-get install -y git curl vim sudo wget && rm -rf /var/lib/apt/lists/*
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home
ARG REF=/usr/share/jenkins/ref

ENV JENKINS_HOME $JENKINS_HOME
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV REF $REF

RUN mkdir /var/run/sshd
RUN apt-get update && apt-get install -y --force-yes openssh-server

RUN mkdir -p $JENKINS_HOME \
  && chown ${uid}:${gid} $JENKINS_HOME \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME $JENKINS_HOME

RUN mkdir -p ${REF}/init.groovy.d

ARG TINI_VERSION=v0.16.1
COPY tini_pub.gpg ${JENKINS_HOME}/tini_pub.gpg
RUN curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-$(dpkg --print-architecture) -o /sbin/tini \
  && curl -fsSL https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-$(dpkg --print-architecture).asc -o /sbin/tini.asc \
  && gpg --no-tty --import ${JENKINS_HOME}/tini_pub.gpg \
  && gpg --verify /sbin/tini.asc \
  && rm -rf /sbin/tini.asc /root/.gnupg \
  && chmod +x /sbin/tini
RUN apt-get update && apt-get install -y maven
RUN chown -R ${user} "$JENKINS_HOME" "$REF"
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN echo jenkins  ALL = NOPASSWD: ALL >> /etc/sudoers
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
USER ${user}
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
