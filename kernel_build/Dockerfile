FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git build-essential libncurses-dev flex bison \
    libssl-dev libelf-dev bc \
    gcc-aarch64-linux-gnu make \
    qemu-system-arm qemu-system-aarch64 \
    vim curl cpio device-tree-compiler wget \
    libgnutls28-dev

WORKDIR /workspace

CMD ["/bin/bash"]
