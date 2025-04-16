# Getting to the gooder stuff

* Create root filesystem: `rootfs`
* Clone busybox: `git clone https://git.busybox.net/busybox`
* Build it:
    ```bash
    cd busybox
    make defconfig
    make menuconfig
    ```
    Then modify `.config` and enable `CONFIG_STATIC` and disable `CONFIG_TC`.
    Then:
    ```
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
    ```
* Make it executable
* Create the filesystem: `mkdir -p bin sbin etc proc sys usr/bin usr/sbin dev`
* Copy busybox: `cd ..; cp busybox/busybox rootfs/bin/busybox`
* Important! Link busybox: `cd rootfs/bin; ln -s busybox sh;`
* Create `init`
* Package the initramfs:
    * `cd rootfs; find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz`
    * Check that everything looks good by extracting:
        ```bash
        mkdir /tmp/initfs
        cd /tmp/initfs
        gzip -dc /workspace/initramfs/initramfs.cpio.gz | cpio -idmv
        ls -lh
        ```
* Start qemu with the initramfs:
    * `qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel ../kernel_build/linux/arch/arm64/boot/Image -initrd initramfs.cpio.gz -append "console=ttyAMA0 init=/init" -m 1024 -bios ../bootloader/u-boot/u-boot.bin`