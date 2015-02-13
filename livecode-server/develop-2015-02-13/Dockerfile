FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG develop-2015-02-13
ENV LIVECODE_DATE 2015-02-13
ENV LIVECODE_REPO https://github.com/runrev/livecode.git
ENV LIVECODE_BRANCH develop
ENV LIVECODE_COMMIT 5abaa3939af98d9d3c8236e6e6bf29dcd8a910fc

RUN yum update -y
RUN yum clean all

# Clean out the locales, see https://bugzilla.redhat.com/show_bug.cgi?id=156477#c30
# saves ~100MB on the image size.
RUN localedef --delete-from-archive $(localedef --list-archive) \
    && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
    && build-locale-archive

ADD livecode-server.tar.gz /
ENV PATH $PATH:/opt/livecode/server




