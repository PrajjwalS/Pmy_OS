#!/bin/bash
qemu-system-i386 \
  -drive format=raw,file=src/build/boot/bios/os.img \
  $@
