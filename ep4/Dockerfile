FROM debian:jessie-slim

COPY server_new.c /tmp/server_new.c

RUN apt-get update && \
    apt-get install -y \
    curl \
    cmake \
    build-essential \
    openssl \
    libssl-dev \
    zlib1g-dev \
    ca-certificates \
    heimdal-dev \
    libsasl2-modules-gssapi-heimdal \
    libgssapi3-heimdal \
    xz-utils \
    wget \
    openssh-client

RUN cd /tmp && wget https://www.libssh.org/files/0.7/libssh-0.7.4.tar.xz \
    && tar xvf libssh-0.7.4.tar.xz \
    && cp server_new.c libssh-0.7.4/examples/samplesshd-cb.c \
    && cd libssh-0.7.4 \
    && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug .. \
    && make

RUN cd /tmp && wget https://www.libssh.org/files/0.7/libssh-0.7.6.tar.xz \
    && tar xvf libssh-0.7.6.tar.xz \
    && cp server_new.c libssh-0.7.6/examples/samplesshd-cb.c \
    && cd libssh-0.7.6 \
    && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug .. \
    && make

RUN ssh-keygen -b 1024 -t dsa -f ~/.ssh/id_dsa -q -N "" \
    && ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
