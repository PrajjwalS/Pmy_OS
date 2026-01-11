# PmyOS

PmyOS is a from-scratch operating system project without any aim currently.

The project currently targets **x86 (BIOS)** and implements a **multi-stage bootloader** that transitions the CPU from **16-bit real mode to 32-bit protected mode** without relying on external bootloaders (GRUB, Limine, etc.).

This repository is intentionally educational but structured with **real OS design discipline**, so it can scale to:
- UEFI
- multiple architectures
- a real kernel
- user-space programs

## Dependencies
Install for running os in emulator: qemu-system-x86



# Baby Steps:
### 1  Create the image for build container  
`make build_img`

### 2 Build the PmyOS images (this should generate the files in build dir)
`make build`

### 3 Run on qemu x86 32 bit mode.
`make run`

##### If you didnt install the qemu ui stuff, then you can run it in terminal via curses too:
`./scripts/run -display curses`
####### TODO : integrate this in Makefile itself

# TODO
LOTS TODO!
1) Add docs explaining the C kernel related changes and compilation.
2) Add docs to explain the x86 bios boot image compilation.
3) Enhance the kernel upto a point where we can build a simple userspace app.
4) Re write the docs/progress.md related to the new changes.
5) Add docs for docker related stuff and top level Makefile
