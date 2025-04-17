setenv bootargs "console=ttyAMA0 earlyprintk=ttyAMA0 init=/init"

setenv fdt_addr_r 0x45000000

load virtio 0 ${kernel_addr_r} Image
load virtio 0 ${ramdisk_addr_r} initramfs.uImage
load virtio 0 ${fdt_addr_r} qemu-default.dtb

booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
