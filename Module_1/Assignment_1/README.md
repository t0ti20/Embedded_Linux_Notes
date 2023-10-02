# filesystems

## Hardware needed
1. SDCARD or USB Flash

![Screenshot 2023-09-27 at 8 24 00 AM](https://github.com/embeddedlinuxworkshop/filesystems/assets/139722851/521b5456-4243-485e-94ba-d55dd6e69f2d)

## Software Needed.
1. gparted.

-------------------------------------------------------

## Requirements.

1. Make at least two partitions on your SD-CARD using *gparted*.
2. Create for each partitions filesystem ( first one *ext4* & second one *ext2* ).
3. Mount two partitions on your root filesystem.
4. Add some files inside each one.
5. reboot your machine.
6. check if mounting points still exists, *it should not*.
7. Make the *ext4* persistance by adding /etc/fstab file ----> (search how you can do that).
8. reboot your system.
9. Check if the *ext4* is mounted.
---------------------------------------------------------