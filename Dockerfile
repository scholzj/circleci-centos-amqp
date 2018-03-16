
FROM		centos:7
MAINTAINER 	JAkub Scholz "www@scholzj.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y git tar curl wget gcc sudo make yum-utils device-mapper-persistent-data lvm2 bats && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all
RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install AMQP support
RUN curl -o /etc/yum.repos.d/qpid-proton-devel.repo http://repo.effectivemessaging.com/qpid-proton-stable.repo \
        && curl -o /etc/yum.repos.d/qpid-python-devel.repo http://repo.effectivemessaging.com/qpid-python-stable.repo \
        && curl -o /etc/yum.repos.d/qpid-python-devel.repo http://repo.effectivemessaging.com/qpid-cpp-stable.repo \
        && yum -y --setopt=tsflag=nodocs install epel-release \
        && yum -y --setopt=tsflag=nodocs install qpid-proton-c qpid-proton-c-devel python-qpid-proton python-qpid python-qpid-common python-qpid-messaging qpid-cpp-client qpid-cpp-client-devel qpid-tools\
        && yum clean all


USER circleci
