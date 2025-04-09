# More stuff

* Dump the QEMU device tree:
    * `qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel ../kernel_build/linux/arch/arm64/boot/Image -initrd ../initramfs/initramfs.cpio.gz -append "console=ttyAMA0 init=/init" -m 1024 -machine dumpdtb=qemu-default.dtb` Notice that it's the same command
    used for booting, but instead we append `-machine dumpdtb=qemu-default.dtb.original`

* Decompile the device tree blob
    * First we need `dtc`: this is identified by the Debian package `device-tree-compiler`, already installed in the Docker container
    * Then `dtc -I dtb -O dts qemu-default.dtb.original -o qemu-default.dts.original`
    * Then copy the original .dts into `qemu-default.dts`
    * Modify it, by adding:
        ```
        mirko-sensor@1000 {
            compatible = "mirko,temp-sensor";
            reg = <0x1000 0x10>;
            label = "fake-temp-sensor";
        };
        ```
    * Recompile the modified .dts: `dtc -I dts -O dtb qemu-default.dts -o qemu-default.dtb`
    * Run QEMU with the new DTB:
        ```bash
        mirko@mirko-VMware20-1:~/Documents/projects/linux-things/initramfs$ qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel ../kernel_build/linux/arch/arm64/boot/Image -initrd initramfs.cpio.gz -append "console=ttyAMA0 init=/init" -m 1024 -dtb ../device_tree/qemu-default.dtb
        ```
    * Observe that the device-tree node has been created:
        ```
        cat /proc/device-tree/mirko-sensor@1000/label
        ```
        Should output:
        ```
        fake-temp-sensor
        ```