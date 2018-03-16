
FROM		centos:7
MAINTAINER 	JAkub Scholz "www@scholzj.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y git tar curl wget sudo yum-utils device-mapper-persistent-data lvm2 bats epel-release && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum install -y qpid-proton-c qpid-proton-c-devel qpid-proton-cpp qpid-proton-cpp-devel python-qpid-proton python-qpid python-qpid-common python-qpid-messaging qpid-cpp-client qpid-cpp-client-devel qpid-tools qpid-tests && \
    yum clean all
RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER circleci