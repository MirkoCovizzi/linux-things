# Getting to the gooder stuff

* Create root filesystem: `rootfs`
* Download busybox: `wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-armv7l`
* Make it executable
* Create the filesystem: `mkdir -p bin sbin etc proc sys usr/bin usr/sbin dev`
* Copy busybox: `cp busybox-armv7l bin/busybox`
* Important! Link busybox: `cd bin; ln -s busybox sh`
* Create `init`
* Package the initramfs:
    * `cd rootfs; find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz`
* Start qemu with the initramfs:
    * `qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel ../kernel_build/linux/arch/arm64/boot/Image -initrd initramfs.cpio.gz -append "console=ttyAMA0 init=/init" -m 1024`