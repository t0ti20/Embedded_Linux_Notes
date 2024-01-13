## **Kernel Definition**

The kernel is the core component of an operating system. It interacts directly with system hardware, provides essential services to the user space, and manages resources such as CPU, memory, and I/O operations.

## **Steps for Building the Kernel**:

1. **Download the Kernel**
2. **Configure the Kernel**
3. **Build the Kernel**
4. **Boot the Kernel**

---

### **1. Download the Kernel**

Choose from either the Vendor Branch or Main Branch:

- **Vendor Branch**: A modified version of the main kernel tailored for specific hardware. For instance, Raspberry Pi kernels can be found [here](https://www.raspberrypi.com/documentation/computers/linux_kernel.html#choosing_sources).

```BASH
git clone --depth=1 --branch rpi-6.5.y https://github.com/raspberrypi/linux
```

- **Main Branch**: Available from Linus Torvalds' official [repository](https://github.com/torvalds/linux). Consider the following branches:
    - **Mainline**: Latest features.
    - **Stable**: Thoroughly tested features.
    - **Long-term**: Offers extended support, suitable for embedded systems.
    
```BASH
git clone --branch v6.5 --depth 1 https://github.com/torvalds/linux.git
```

---

### **2. Configure the Kernel**

Key stages in kernel configuration include:

- **Menuconfig**: A GUI method for kernel configuration.
- **.Config File**: Generated post-`menuconfig`, it stores kernel configuration preferences.
- **KBuild**: Processes `.config` using a toolchain to produce a custom kernel binary.

```BASH
#If you Are Using Vendor Branch You Hve To Download defconfig For SOC
wget https://raw.githubusercontent.com/raspberrypi/linux/rpi-6.5.y/arch/arm/configs/bcm2711_defconfig -O ./arch/arm64/configs/bcm2711_defconfig
#Run Default Configuration 
make KERNEL=kernel8 ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu- bcm2711_defconfig
#Edit Needed Features
make menuconfig
#Create a directory for the modules
mkdir /path/to/modules
#Install The Modules
make INSTALL_MOD_PATH=/path/to/modules modules_install
#To clean all built and intermediate files
make distclean
make clean
```

---

### **3. Build the Kernel**

Before building, determine:

1. **Cross Compiler**: Compiler for building code on one machine for another, e.g., building on PC for an ARM-based Raspberry Pi.
2. **Target Image**: `vmlinux` is the primary kernel output, but bootloaders might prefer `zImage` or `uImage`.
```BASH
#Build Kernal Image And Modules And Device Tree Binary
make -j$(nproc) KERNEL=kernel8 ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu- Image modules dtbs 
```

---

### **4. Boot the Kernel**

Kernel run sequence:
```
u-boot Main_loop --> kernel_entry(device tree,machid) 
kernel Arc/arm/boot/comprressed/head.S --> It is called from u-boot
1-init cpu
2- init mmu
3- decompresse image decompress_kernel in arch/arm/boot/compressed/misc.c
4- back to head.s
5- R13=mmap_switched in /arch/arm/kernel/head-common.s
6- call start_kernel -init/main.c
7- main.c 
8- reset_init 
9- kthread_init 
10- init process
```
Use QEMU to emulate:

```BASH
qemu-system-aarch64.exe \
    -M raspi3b \
    -cpu cortex-a72 \
    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200" \
    -kernel Image \
    -dtb ./dts/broadcom/bcm2710-rpi-3-b.dtb \
    -m 1G -smp 4 \
    -serial stdio \
    -usb -device usb-mouse -device usb-kbd \
        -device usb-net,netdev=net0 \
        -netdev user,id=net0,hostfwd=tcp::5555-:22
```
---

## **References**:

1. [Hazem Khaled](https://github.com/embeddedlinuxworkshop/M2-S3)
2. [Building Raspberry Pi Image](https://hechao.li/2021/12/20/Boot-Raspberry-Pi-4-Using-uboot-and-Initramfs/)