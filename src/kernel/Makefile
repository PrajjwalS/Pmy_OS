# =========================================================
# Kernel Makefile (x86, freestanding)
# =========================================================

ARCH ?= x86
TOPDIR := $(CURDIR)/..

CC := i686-linux-gnu-gcc
LD := i686-linux-gnu-ld
OBJCOPY := i686-linux-gnu-objcopy

BUILD_DIR := $(TOPDIR)/build/kernel
KERNEL_ELF := $(BUILD_DIR)/kernel.elf
KERNEL_BIN := $(BUILD_DIR)/kernel.bin

CFLAGS := -ffreestanding -fno-pic -m32 -nostdlib -nostdinc -fno-builtin -Wall -Wextra
LDFLAGS := -T x86/linker.ld -nostdlib

SRC_C := common/kmain.c common/printk.c
SRC_ASM := x86/entry.asm

OBJ := $(BUILD_DIR)/entry.o $(BUILD_DIR)/kmain.o $(BUILD_DIR)/printk.o

all: $(KERNEL_BIN)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/entry.o: $(SRC_ASM) | $(BUILD_DIR)
	nasm -f elf32 $< -o $@

$(BUILD_DIR)/printk.o: common/printk.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/kmain.o: $(SRC_C) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_ELF): $(OBJ)
	$(LD) $(LDFLAGS) $^ -o $@


#  Here is kernel < 8KB (fits in 16 sectors of 512 bytes), so we pad it. 
#	If >8KB, it fails .... TODO :we need to handle it with proper bootloader ELF parsing.
$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@
	@truncate -s 8192 $@
	@stat -c %s $@ | grep -qx 8192 || \
		(echo "ERROR: kernel.bin must be exactly 8 KB"; exit 1)

clean:
	rm -rf $(BUILD_DIR)