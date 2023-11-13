FROM debian:stable-slim

ARG VERSION=12.3.1-1.1

RUN ARCH="$(dpkg --print-architecture)" && \
    case $ARCH in \
    "amd64") \
        ARCH_TAG="x64" \
        ;; \
    "arm64") \
        ARCH_TAG="arm64" \
        ;; \
    esac && \
    # Get nessecary packages
    apt-get update && \
    apt-get install \
    --no-install-recommends \
    make \
    cmake \
    wget \
    ca-certificates \
    -y && \
    rm -rf /var/cache/apt && \
    mkdir /workdir && \
    cd /workdir && \
    wget https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v${VERSION}/xpack-arm-none-eabi-gcc-${VERSION}-linux-${ARCH_TAG}.tar.gz && \
    tar xvf xpack-arm-none-eabi-gcc-${VERSION}-linux-${ARCH_TAG}.tar.gz && \
    rm xpack-arm-none-eabi-gcc-${VERSION}-linux-${ARCH_TAG}.tar.gz
    
RUN echo 'export PATH="/workdir/xpack-arm-none-eabi-gcc-'${VERSION}'/bin:$PATH"' >> /etc/bashrc

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
