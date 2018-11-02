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

ARG DISTRO_NAME=buildroot-2018.08.2
ARG CHECKSUM=1f9e02722362ece517251bcc1bac60f678676b7c

# Download Buildroot, verify its checksum, untar and clean up.
RUN set -ex; \
    wget -q https://buildroot.org/downloads/${DISTRO_NAME}.tar.gz; \
    echo "${CHECKSUM} ${DISTRO_NAME}.tar.gz" | sha1sum -c -; \
    tar -xzf ${DISTRO_NAME}.tar.gz; \
    chown -R nobody:nogroup ${DISTRO_NAME}; \
    rm ${DISTRO_NAME}.tar.gz

WORKDIR ${DISTRO_NAME}
VOLUME ["/output", "/dl"]

USER nobody
