# kernel_cleaner
Clean the uncompiled files in kernel, just for study stuff.

Usage:

    cp /boot/config-4.18.0-394.el8.x86_64 linux-4.18.0-394.el8/.config
    cd linux-4.18.0-394.el8
    bear make ARCH=x86_64 -j4 bzImage
    make clean
    cd ..

    cp -r linux-4.18.0-394.el8 linux-4.18.0-394.el8.bak

    kernel_cleaner/clean.sh linux-4.18.0-394.el8

