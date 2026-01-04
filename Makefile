# =========================================================
# PmyOS - Top-level Makefile
# =========================================================

ARCH ?= x86
TOPDIR := $(CURDIR)

.PHONY: all bios clean run

all: bios

bios:
	$(MAKE) -C boot/$(ARCH)/bios TOPDIR=$(TOPDIR)

run: bios
	qemu-system-i386 \
		-drive format=raw,file=$(TOPDIR)/build/boot/bios/os.img \
		-display curses

clean:
	$(MAKE) -C boot/$(ARCH)/bios clean TOPDIR=$(TOPDIR)