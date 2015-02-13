#!/bin/bash
###############################################################################
export MAINTAINER="Stephen Tawn <stephen.tawn@livecode.com>"
export NAMESPACE=livecodestephen/
export DATE=$(date +"%F")

export REPO=https://github.com/runrev/livecode.git
export BRANCH=develop
export COMMIT=$(git ls-remote --heads $REPO $BRANCH | awk '{ print $1 }') || exit 1

export TAG=$BRANCH-$DATE

export BASE=fedora:21

###############################################################################

function die() {
    echo "$*" 1>&2
    exit 1
}

function make_dockerfile() {
    mkdir -p $1/$TAG
    cat $1/Dockerfile.template \
	| envsubst '$MAINTAINER $NAMESPACE $DATE $REPO $BRANCH $COMMIT $TAG $BASE'\
	> $1/$TAG/Dockerfile
}

###############################################################################

# Set the working dir to the location of this script
cd $(dirname $(readlink -f "$0"))

# Check that there have been changes since the previous build
if [ -a BUILD_HEAD.$BRANCH ] && [ "$(cat BUILD_HEAD.$BRANCH)" = "$COMMIT" ]; then
    echo "No commited changes since previous build."
    exit 0
fi
echo $COMMIT > BUILD_HEAD.$BRANCH


########################################
# Make the Dockerfiles

make_dockerfile livecode-server-build
make_dockerfile livecode-server


########################################
# Make the containers

echo "Building ${NAMESPACE}livecode-server-build:$TAG"
docker build -t ${NAMESPACE}livecode-server-build:$TAG livecode-server-build/$TAG \
    || die "Build failed!"

echo "Extracting livecode server"
docker run -i --rm ${NAMESPACE}livecode-server-build:$TAG /usr/bin/tar -czP /opt/livecode \
    > livecode-server/$TAG/livecode-server.tar.gz \
    || die "Extracting /opt/livecode failed!"

echo "Building ${NAMESPACE}livecode-server:$TAG"
docker build -t ${NAMESPACE}livecode-server:$TAG livecode-server/$TAG \
    || die "Build failed!"

docker tag ${NAMESPACE}livecode-server-build:$TAG ${NAMESPACE}livecode-server-build:latest
docker tag ${NAMESPACE}livecode-server:$TAG ${NAMESPACE}livecode-server:latest


########################################
# Push the images

docker push ${NAMESPACE}livecode-server-build \
    || die "Failed to push ${NAMESPACE}livecode-server-build!"
docker push ${NAMESPACE}livecode-server \
    || die "Failed to push ${NAMESPACE}livecode-server-build!"


########################################
# Update git

git add BUILD_HEAD.$BRANCH
git add livecode-server-build/$TAG/Dockerfile
git add livecode-server/$TAG/Dockerfile
git commit --author "Build bot <>" -m "Built $TAG" 
git push
