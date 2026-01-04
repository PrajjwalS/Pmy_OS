# PmyOS

PmyOS is a from-scratch operating system project without any aim currently.

The project currently targets **x86 (BIOS)** and implements a **multi-stage bootloader** that transitions the CPU from **16-bit real mode to 32-bit protected mode** without relying on external bootloaders (GRUB, Limine, etc.).

This repository is intentionally educational but structured with **real OS design discipline**, so it can scale to:
- UEFI
- multiple architectures
- a real kernel
- user-space programs


## Baby Steps:
 0 ) Install nasm, qemu  
 1 ) make    # Currently only bios boot loader is built as an img.  
 2 ) make run # Currently only bios bootup works.   


## TODO
LOTS TODO!