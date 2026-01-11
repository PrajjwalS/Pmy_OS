# =========================================================
# PmyOS - Top-level Makefile
# =========================================================

ARCH ?= x86
TOPDIR := $(CURDIR)

.PHONY: all bios kernel clean run

all: kernel bios

kernel:
	$(MAKE) -C kernel

bios:
	$(MAKE) -C boot/$(ARCH)/bios TOPDIR=$(TOPDIR)

run: bios
	qemu-system-i386 \
		-drive format=raw,file=$(TOPDIR)/build/boot/bios/os.img \
		-display curses

clean:
	$(MAKE) -C kernel clean
	$(MAKE) -C boot/$(ARCH)/bios clean TOPDIR=$(TOPDIR)