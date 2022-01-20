#!/bin/sh
#1. 도커 BUILDX 설치
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
docker build --platform=local -o . git://github.com/docker/buildx
mkdir -p ~/snap/docker/796/.docker/cli-plugins
cd ~/snap/docker/796/.docker/cli-plugins
wget -O docker-buildx https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64

#2. QEMU + BINFMT 설치
apt-get install -y qemu-user-static binfmt-support
qemu-aarch64-static --version
update-binfmts --version

#3. 빌더 설치
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap