FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG develop-2015-03-11
ENV LIVECODE_DATE 2015-03-11
ENV LIVECODE_REPO https://github.com/runrev/livecode.git
ENV LIVECODE_BRANCH develop
ENV LIVECODE_COMMIT 8d8037f6b68330d28d9d53947ec5ca3b176b7706

RUN yum update -y
RUN yum clean all

# Clean out the locales, see https://bugzilla.redhat.com/show_bug.cgi?id=156477#c30
# saves ~100MB on the image size.
RUN localedef --delete-from-archive $(localedef --list-archive) \
    && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
    && build-locale-archive

ADD livecode-server.tar.gz /
ENV PATH $PATH:/opt/livecode/server




