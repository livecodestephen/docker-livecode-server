FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG develop-2015-03-06
ENV LIVECODE_DATE 2015-03-06
ENV LIVECODE_REPO https://github.com/runrev/livecode.git
ENV LIVECODE_BRANCH develop
ENV LIVECODE_COMMIT ebb7d2304d05f425b69f664ded86b2ab728be594

RUN yum update -y
RUN yum clean all

# Clean out the locales, see https://bugzilla.redhat.com/show_bug.cgi?id=156477#c30
# saves ~100MB on the image size.
RUN localedef --delete-from-archive $(localedef --list-archive) \
    && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
    && build-locale-archive

ADD livecode-server.tar.gz /
ENV PATH $PATH:/opt/livecode/server




