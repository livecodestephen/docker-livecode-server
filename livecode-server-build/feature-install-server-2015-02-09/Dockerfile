FROM fedora:21

MAINTAINER Stephen Tawn <stephen.tawn@livecode.com>
ENV LIVECODE_TAG feature-install-server-2015-02-09
ENV LIVECODE_DATE 2015-02-09
ENV LIVECODE_REPO https://github.com/livecodestephen/livecode.git
ENV LIVECODE_BRANCH feature-install-server
ENV LIVECODE_COMMIT b547f302bc306e8023860cdb35754f7c9dffcf22

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

RUN mkdir /usr/src/livecode
WORKDIR /usr/src/livecode

RUN git clone --depth=5 -b feature-install-server https://github.com/livecodestephen/livecode.git . \
    && git checkout b547f302bc306e8023860cdb35754f7c9dffcf22 \
    && git submodule init \
    && git submodule update thirdparty \
    && (cd prebuilt; ./fetch-libraries.sh linux) \
    && make MODE=release bootstrap \
    && make MODE=release server-all

#RUM make MODE=release lc-run-check lc-test-check

RUN make MODE=release server-install
