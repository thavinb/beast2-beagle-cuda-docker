#!/bin/bash

set -e -o pipefail

# Silence some warnings about Readline. Checkout more over her$
# https://github.com/phusion/baseimage-docker/issues/58
DEBIAN_FRONTEND=noninteractive
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# This install with ubuntu 20.04 focal repository
# Change accordingly to choosen cuda image.
# Add some basics
apt-get update
#--no-install-recommends
# Change g++ and gcc complier to version 9
# Add more pkg for latest beagle-lib build
# Perhaps more recent version jdk if not working
apt-get install -y -qq \
	lsb-release ca-certificates wget rsync curl \
	python3-crcmod less nano vim git locales make \
	dirmngr \
	liblz4-tool pigz bzip2 lbzip2 zstd \
	libtool autoconf g++-9 gcc-9 \
	ant \
	openjdk-8-jre openjdk-8-jdk \
    cmake subversion pkg-config automake \
    build-essential

mkdir -p /usr/local/cuda/bin
ln -s /usr/bin/gcc-9 /usr/local/cuda/bin/gcc
ln -s /usr/bin/g++-9 /usr/local/cuda/bin/g++

# Auto-detect platform
DEBIAN_PLATFORM="$(lsb_release -c -s)"
echo "Debian platform: $DEBIAN_PLATFORM"

# Upgrade and clean
apt-get upgrade -y
apt-get clean -y

locale-gen en_US.UTF-8
