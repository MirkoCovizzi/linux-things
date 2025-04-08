# What happens here?

* Setup a Docker container for clean and reproducible development
    * First install docker, follow the official documentation: https://docs.docker.com/engine/install/ubuntu/
    * `docker build -t kernel-dev .`
    * This will fail at first. You need to add yourself to the `docker` group: `sudo usermod -aG docker $USER` then `newgrp docker`, then test it with `docker run hello-world`.
    * `docker run --rm -it -v $PWD:/workspace kernel-dev`
* Download the Linux kernel from the man himself (on the GitHub mirror though)
    * `git clone --depth=1 https://github.com/torvalds/linux.git`
    * Insert a printk inside `start_kernel`
    * Build:
        ```bash
        make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
        make -j$(nproc) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image dtbs
        ```
