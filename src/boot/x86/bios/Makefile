# =========================================================
# x86 BIOS bootloader Makefile
# =========================================================

NASM := nasm

# TOPDIR is passed from the root Makefile
BUILD_DIR := $(TOPDIR)/build/boot/bios

# Assume the kernel is already built by the time we build the bootloader
KERNEL_BIN := $(TOPDIR)/build/kernel/kernel.bin

INCLUDES := \
	-I . \
	-I utils \
	-I ../pm

STAGE1_SRC := boot_stage1.asm
STAGE2_SRC := boot_stage2.asm

STAGE1_BIN := $(BUILD_DIR)/stage1.bin
STAGE2_BIN := $(BUILD_DIR)/stage2.bin
OS_IMAGE   := $(BUILD_DIR)/os.img

.PHONY: all clean

all: $(OS_IMAGE)

# ---------------------------------------------------------
# Stage 1
# ---------------------------------------------------------
$(STAGE1_BIN): $(STAGE1_SRC)
	@mkdir -p $(BUILD_DIR)
	$(NASM) -f bin $(INCLUDES) $< -o $@
	@echo "Checking Stage 1 size..."
	@stat -c %s $@ | grep -qx 512 || \
		(echo "ERROR: Stage 1 must be exactly 512 bytes"; exit 1)

# ---------------------------------------------------------
# Stage 2
# ---------------------------------------------------------
$(STAGE2_BIN): $(STAGE2_SRC)
	@mkdir -p $(BUILD_DIR)
	$(NASM) -f bin $(INCLUDES) $< -o $@

# ---------------------------------------------------------
# Disk image with kernel (depends on kernel being already built)
# ---------------------------------------------------------
$(OS_IMAGE): $(STAGE1_BIN) $(STAGE2_BIN) $(KERNEL_BIN)
	cat $(STAGE1_BIN) $(STAGE2_BIN) $(KERNEL_BIN) > $(OS_IMAGE)

clean:
	rm -rf $(BUILD_DIR)