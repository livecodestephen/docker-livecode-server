FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG develop-2015-02-27
ENV LIVECODE_DATE 2015-02-27
ENV LIVECODE_REPO https://github.com/runrev/livecode.git
ENV LIVECODE_BRANCH develop
ENV LIVECODE_COMMIT 32797220c60412faeaf4b27d0102fe69b52af604

RUN yum update -y

# Build packages
RUN yum install -y \
    bison \
    bzip2 \
    flex \
    fontconfig-devel \
    gcc \
    gcc-c++ \
    git \
    libX11-devel \
    make \
    tar

RUN yum clean all

# Clean out the locales, see https://bugzilla.redhat.com/show_bug.cgi?id=156477#c30
# saves ~100MB on the image size.
RUN localedef --delete-from-archive $(localedef --list-archive) \
    && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
    && build-locale-archive

RUN mkdir /usr/src/livecode
WORKDIR /usr/src/livecode

RUN git clone --depth=5 -b develop https://github.com/runrev/livecode.git . \
    && git checkout 32797220c60412faeaf4b27d0102fe69b52af604 \
    && git submodule init \
    && git submodule update thirdparty \
    && (cd prebuilt; ./fetch-libraries.sh linux) \
    && make MODE=release bootstrap \
    && make MODE=release server-all

RUM make MODE=release lc-run-check lc-test-check

RUN make MODE=release server-install
