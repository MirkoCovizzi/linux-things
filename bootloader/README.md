# Booting stuff, the nice way!

* Clone u-boot: `git clone https://source.denx.de/u-boot/u-boot.git`
* `docker run --rm -it -v $PWD:/workspace kernel-dev`
* `cd bootloader/u-boot`
* `make qemu_arm64_defconfig`
* `make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)`
    * Requires `libgnutls28-dev`
