FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG develop-2015-03-13
ENV LIVECODE_DATE 2015-03-13
ENV LIVECODE_REPO https://github.com/runrev/livecode.git
ENV LIVECODE_BRANCH develop
ENV LIVECODE_COMMIT 7afd46380b6e4109084067c57c59d2457fb9661d

RUN yum update -y
RUN yum clean all

# Clean out the locales, see https://bugzilla.redhat.com/show_bug.cgi?id=156477#c30
# saves ~100MB on the image size.
RUN localedef --delete-from-archive $(localedef --list-archive) \
    && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
    && build-locale-archive

ADD livecode-server.tar.gz /
ENV PATH $PATH:/opt/livecode/server




