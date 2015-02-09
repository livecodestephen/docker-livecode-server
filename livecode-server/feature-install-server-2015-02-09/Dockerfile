FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG feature-install-server-2015-02-09
ENV LIVECODE_DATE 2015-02-09
ENV LIVECODE_REPO https://github.com/livecodestephen/livecode.git
ENV LIVECODE_BRANCH feature-install-server
ENV LIVECODE_COMMIT b547f302bc306e8023860cdb35754f7c9dffcf22

RUN yum update -y

ADD livecode-server.tar.gz /
ENV PATH $PATH:/opt/livecode/server




