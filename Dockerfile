FROM debian:9-slim

# Install required packges.
RUN set -ex; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        bc \
        build-essential \
        ca-certificates \
        cpio \
        file \
        libncurses5-dev \
        python \
        rsync \
        unzip \
        wget; \
    rm -rf /var/lib/apt/lists/*

ARG DISTRO_NAME=buildroot-2019.08
ARG CHECKSUM=04440748d3d7a296af59c43c607639297240040c

# Download Buildroot, verify its checksum, untar and clean up.
RUN set -ex; \
    wget -q https://buildroot.org/downloads/${DISTRO_NAME}.tar.gz; \
    echo "${CHECKSUM} ${DISTRO_NAME}.tar.gz" | sha1sum -c -; \
    mkdir -p /buildroot/output/images; \
    tar -xzf ${DISTRO_NAME}.tar.gz -C /buildroot --strip-components=1; \
    chown -R nobody:nogroup /buildroot; \
    rm ${DISTRO_NAME}.tar.gz

WORKDIR /buildroot
VOLUME /buildroot/dl \
       /buildroot/projects \
       /buildroot/output/images

USER nobody
