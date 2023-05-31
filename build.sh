#!/bin/bash
set -eu

# Repository Login
echo "### login to docker.io ###"
podman login docker.io

echo -e "\n### login to quay.io ###"
podman login quay.io

export TAG=less
export DOCKER=docker.io/tnk4on/${TAG}
export QUAY=quay.io/tnk4on/${TAG}

source VERSION

# Build multi-arch images
echo -e "\n### Build multi-arch images ###"
for ARCH in amd64 arm64
do
    echo -e "\n### podman build -t ${TAG}:${ARCH} --platform linux/${ARCH} --manifest ${TAG} . ###"
    podman build -t ${TAG}:${ARCH} --platform linux/${ARCH} --manifest ${TAG} .
done

echo -e "\n### podman tag ${TAG} ${TAG}:${VERSION} ###"
podman tag ${TAG} ${TAG}:${VERSION}

# Test
echo -e "\n### Test ###"
for ARCH in amd64 arm64
do
    echo -e "\n### podman run --rm ${TAG}:${ARCH} --version ###"
    podman run --rm ${TAG}:${ARCH} --version
done

# Push
## Docker.io
echo -e "\n### push to docker.io ###"
podman manifest push --all ${TAG} docker://${DOCKER} --format docker
podman manifest push --all ${TAG}:${VERSION} docker://${DOCKER}:${VERSION} --format docker

### Quay.io
echo -e "\n### push to quay.io ###"
podman manifest push --all ${TAG} docker://${QUAY}
podman manifest push --all ${TAG}:${VERSION} docker://${QUAY}:${VERSION}