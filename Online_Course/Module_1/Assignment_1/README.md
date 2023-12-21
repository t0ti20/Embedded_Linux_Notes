# Filesystems Task Guide

## Prerequisites

### Hardware
- SD CARD or USB Flash

   ![Hardware](https://github.com/embeddedlinuxworkshop/filesystems/assets/139722851/521b5456-4243-485e-94ba-d55dd6e69f2d)

### Software
- `gparted`

## Steps

1. **Partitioning the Storage Device**:
   - Using `gparted`, create at least two partitions on your SD-CARD or USB Flash.
     
     ![Partition](https://github.com/t0ti20/Embedded_Linux/assets/61616031/24d27e0d-ed51-48d6-a725-850d7059add5)

2. **Setting Up Filesystems**:
   - For each partition, set up a filesystem:
     - First partition: `ext4`
     - Second partition: `ext2`
     
     ![Filesystems](https://github.com/t0ti20/Embedded_Linux/assets/61616031/3ff4d388-9672-46c5-9fd3-e05b93493fd5)

3. **Mounting Partitions**:
   - Mount the two partitions on your root filesystem.
     
     ![Mounting](https://github.com/t0ti20/Embedded_Linux/assets/61616031/020ef078-3430-4e27-91ef-71db9c42adcf)

4. **Populate Partitions with Files**:
   - Add some files inside each partition.
     
     ![Files](https://github.com/t0ti20/Embedded_Linux/assets/61616031/70e7e64e-c2bb-4f23-80d6-6dcc11d8a4e8)

5. **Reboot**:
   - Reboot your machine and ensure the system comes up properly.
     
     ![Reboot1](https://github.com/t0ti20/Embedded_Linux/assets/61616031/1ee484ee-c7dc-4599-a1f6-1efd5e3168ca)

6. **Verify Mount Points**:
   - After the reboot, check if the mounting points still exist. They should **not** be automatically mounted (unless defined in `/etc/fstab`).
     
     ![Check](https://github.com/t0ti20/Embedded_Linux/assets/61616031/9a71ec65-74fd-4123-91e1-14a623bd4e30)

7. **Making the ext4 Partition Persistent**:
   - Make the `ext4` partition persistent across reboots by adding an entry in the `/etc/fstab` file. (Note: Research and ensure you add the correct entry).
     
     ![Fstab](https://github.com/t0ti20/Embedded_Linux/assets/61616031/ac24cbc9-79d5-40dc-95cb-d8469a3bed5a)

8. **Final Reboot**:
   - Reboot your system one more time to ensure the `ext4` partition mounts automatically as defined in `/etc/fstab`.
     
     ![Reboot2](https://github.com/t0ti20/Embedded_Linux/assets/61616031/84907df5-cd98-4234-94ce-397c3ab9fd2b)
