# Booting stuff, the nice way!

* Clone u-boot: `git clone https://source.denx.de/u-boot/u-boot.git`
* `docker run --rm -it --privileged -v $PWD:/workspace kernel-dev` (`--privileged` for permission to mount images)
* `cd bootloader/u-boot`
* Edit `include/configs/qemu-arm.h` and add:
    ```
    #define CONFIG_BOOTCOMMAND \
    "load virtio 0 ${loadaddr} boot.scr; source ${loadaddr}"
    ```
* `make qemu_arm64_defconfig`
* `make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)`
    * Requires `libgnutls28-dev`
* Start QEMU
    * `qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -bios u-boot/u-boot.bin -device virtio-blk-device,drive=disk -drive if=none,file=../initramfs/rootfs.ext4,format=raw,id=disk`
* Compile the `boot.cmd` in Docker: `mkimage -A arm64 -T script -C none -d boot.cmd boot.scr`
