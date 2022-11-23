ARG linux=ubuntu
ARG release=20.04
FROM ${linux}:${release}
LABEL maintainer="Paolo Bosetti"
LABEL description="Docker image for building C/C++"
ARG IMAGE_TAG=xlinux

# for tzdata:
ARG DEBIAN_FRONTEND="noninteractive" 
ARG TZ="Europe/Rome"

# Add here any additional library and tool you need
RUN apt-get update && apt-get install -y \
    build-essential file\
    autogen automake \
    clang cmake git\
    libssl-dev \
    bison flex \ 
    libncurses5-dev libreadline-dev\
    libtool \
    sed \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir /workdir; mkdir /cross
COPY sh/*.sh /cross

ENV IMAGE_TAG=${IMAGE_TAG}

WORKDIR /workdir

ENTRYPOINT ["/cross/entrypoint.sh"]
