### Definition:

The root file system, often abbreviated as **rootfs**, is the primary file system from which an operating system starts. It encompasses the essential files, directories, and applications required for booting the system. In Unix-like operating systems, the rootfs is typically mounted at the root directory (`/`). From here, other file systems can branch out at various points in the directory hierarchy. It's fundamental to the system's functionality; without it, the system cannot operate or boot. Rootfs stores vital binaries, libraries, and configuration files pivotal for foundational system tasks.

---
---
### Exploring the Content:

To examine the rootfs structure, one can utilize the `man hier` command. The typical hierarchy is:

```lua
#Can Use Command 
man hier
/
|-- bin
|-- boot
|-- dev
|-- etc
|-- home
|-- lib
|-- media
|-- mnt
|-- opt
|-- proc
|-- root
|-- run
|-- sbin
|-- srv
|-- sys
|-- tmp
|-- usr
|-- var
```

1. **bin**: Contains essential command binaries that are needed in both single-user mode and for all users in multi-user mode.
2. **boot**: Holds files required during the boot process, including the Linux kernel and boot loader files.
3. **dev**: Contains device files, which are interfaces to device drivers.
4. **etc**: System-wide configuration files and shell scripts used to initialize system settings for the OS and applications.
5. **home**: Home directories for users. Each user has a subdirectory named after their username.
6. **lib**: Essential shared libraries and kernel modules.
7. **media**: Temporary mount point for removable devices like USB drives, CDs, etc.
8. **mnt**: Temporary mount point for filesystems. Admins or users might mount file systems here manually.
9. **opt**: Optional/additional software packages installed here.
10. **proc**: A virtual file system that contains information about system resources. It's not a 'real' filesystem in the sense of files saved on disk, but a view into the system's kernel.
11. **root**: Home directory for the root user.
12. **run**: Contains runtime data, like the process ID files and lock files. This data is typically cleared at boot.
13. **sbin**: Contains essential system binaries, e.g., `fdisk`, `init`, etc.
14. **srv**: Contains data directories of services like HTTP for a web server or FTP for an FTP server.
15. **sys**: A virtual file system, similar to /proc, that provides an interface to kernel data structures.
16. **tmp**: Temporary files stored by the system and applications. These can be deleted without warning, so it's not for long-term storage.
17. **usr**: Secondary hierarchy for read-only user data; contains the majority of (multi-)user utilities and applications.
18. **var**: Contains variable data files. This includes, among other things, log files, databases, websites, and cache directories.

---
---
### Constructing a Custom Rootfs: :

To create a root file system (rootfs) for embedded or minimalist systems, you often begin with the essentials needed for your target environment. This involves selecting the necessary system libraries, binaries, and utilities that will enable your system to boot and operate correctly. The content is highly dependent on the intended use case and platform. One popular tool for creating such lightweight systems is **BusyBox**.
#### BusyBox:

- **About**: BusyBox combines many common UNIX utilities into one small executable. It offers a minimal replacement for utilities typically found in GNU core utilities and util-Linux. BusyBox is ideal for embedded systems and is fundamental in various lightweight Linux distributions.
- **Functionality**: Unlike having distinct binaries for each utility, BusyBox is a single binary replicating the behavior of multiple utilities. When invoked as `ls`, it operates like the `ls` command.
#### Using BusyBox to Create a Rootfs:

```BASH
#Download Source Code
wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2
tar xf busybox-1.36.1.tar.bz2
cd busybox-1.33.2/
# Config Busybox
make ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu- menuconfig
# Compile Binary
make ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu-
# Install Files in Specific Location
make ARCH=arm64 CROSS_COMPILE=aarch64-rpi4-linux-gnu- CONFIG_PREFIX=/path/to/rootfs install
```

---
---
## Root File System Operations

### 1. Manual File System Creation

To set up a basic directory structure manually:

```BASH
mkdir rootfs
cd rootfs
mkdir {bin,dev,etc,home,lib64,proc,sbin,sys,tmp,usr,var}
mkdir usr/{bin,lib,sbin}
mkdir var/log
# Create a symbolink lib pointing to lib64
ln -s lib64 lib
tree -d
.
├── bin
├── dev
├── etc
├── home
├── lib -> lib64
├── lib64
├── proc
├── sbin
├── sys
├── tmp
├── usr
│   ├── bin
│   ├── lib
│   └── sbin
└── var
    └── log

16 directories
```

---
### 2. Populating the File System

Transfer necessary files to the manually created root filesystem:

```Bash
# Transfer files from BusyBox 
rsync -av ./<BusyBox_Output_Folder> ./rootfs 
# Transfer files from the Toolchain rootfs 
rsync -av ./<Tool_Chain_Output_Folder>/sysroot ./rootfs
```

---
---
## Root File System Types

During the Linux system boot process, the root filesystem is essential. Various root filesystems are used in different boot stages. Here's a deeper dive into these stages:
### 1. **Initramfs (Initial RAM File System)**

- **Purpose**: The primary objective of initramfs is to mount the real root filesystem. This is especially crucial for situations where the root filesystem is on a software RAID, LVM, or requires specific modules to mount.
- **Creation**: `initramfs` is often created using tools like `mkinitrd` or `mkinitramfs`, which bundle the necessary binaries, scripts, and modules.
- **Loading**: During the boot process, the bootloader (like GRUB) loads both the kernel and the initramfs image into memory. Once the kernel starts executing, it unpacks the initramfs archive into a temporary, in-memory filesystem.
- **Switching**: After it's done with its tasks (like loading necessary modules or discovering disks), the system switches from the `initramfs` root to the actual root filesystem using a process called "pivoting."

```BASH
cd ./rootfs
#Creates a `cpio` archive in the `newc` format
find . | cpio -H newc -ov --owner root:root -F ../initramfs.cpio
find . -print0 | cpio --null -ov --format=newc > initramfs.cpio
#Optional Compress the cpio archive using gzip
gzip initramfs.cpio
#Run On Qemu
qemu-system-aarch64.exe -M virt -cpu cortex-a72 -m 1G -kernel Image -append "console=ttyAMA0 rdinit=/bin/sh" -initrd initramfs.cpio.gz -nographic
#creat a U-Boot compatible image of an initial RAM disk
/u-boot/tools/mkimage -A arm64 -O linux -T ramdisk -d initramfs.cpio.gz uRamdisk
sudo rm -f /mnt/boot/uRamdisk
#To Boot using u-boot
setenv bootpart usb 0:1
fatload ${bootpart} ${kernel_addr_r} Image
fatload ${bootpart} ${ramdisk_addr_r} uRamdisk
fatload ${bootpart} ${fdt_addr_r} bcm2711-rpi-4-b.dtb
booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr}
#In Case If You Want to Make SRC File
u-boot/tools/mkimage -A arm64 -O linux -T script -C none -d <Commands>.txt boot.scr
sudo cp boot.scr /mnt/boot/
```

---
### 2. Disk-based Root Filesystem

- **Purpose**: This is the primary and persistent filesystem that houses the OS, applications, user data, and configurations.
- **Mounting**: After the preliminaries of initramfs, the real root filesystem (often found on a physical disk) is mounted. The exact location (like `/dev/sda1`) is either predetermined or discovered by initramfs scripts.
- **Operation**: Once mounted, `/sbin/init` or an equivalent initialization process begins, which starts system services, user-space processes, and prepares the environment for user interaction.

```BASH
#Mout Root ext4 Partition 
sudo mount /dev/sdb1 /mnt/root
#Clone rootfs 
cp -r ~/rootfs/* /mnt/root/
#To Boot using u-boot
setenv bootpart usb 0:1
fatload ${bootpart} ${kernel_addr_r} Image
fatload ${bootpart} ${fdt_addr_r} bcm2711-rpi-4-b.dtb
booti ${kernel_addr_r} - ${fdt_addr}
#In Case If You Want to Make SRC File
u-boot/tools/mkimage -A arm64 -O linux -T script -C none -d <Commands>.txt boot.scr
sudo cp boot.scr /mnt/boot/
```

---
### 3. Remote Root Filesystem (e.g., Network File System or NFS)

- **Purpose**: In diskless clients, embedded systems, or specific clustered environments, the root filesystem might reside on a remote server and accessed over the network.
- **Initramfs Role**: The initramfs becomes especially important here. It ensures the network interfaces are up, and necessary protocols (like DHCP) are run to obtain an IP address. It then mounts the remote filesystem as root.
- **NFS**: Network File System (NFS) is a popular choice for such setups. The remote server shares a directory via NFS, and the client mounts it as its root.
- **Pivoting**: Like with disk-based setups, once the remote root is established, the system "pivots" from initramfs to the newly mounted root.
**Benefits of Remote Root Filesystem**:
- **Central Management**: Updates or changes can be made in one place, affecting all clients.
- **Stateless Clients**: Clients can be stateless, making them easily replaceable or reproducible.
However, relying on a network for the root filesystem introduces potential points of failure and latency. Adequate network infrastructure and failover strategies are essential.

---
## **References**:

1. [Hazem Khaled](https://github.com/embeddedlinuxworkshop/M2-S4/)
2. [Building Raspberry Pi Image](https://hechao.li/2021/12/20/Boot-Raspberry-Pi-4-Using-uboot-and-Initramfs/)