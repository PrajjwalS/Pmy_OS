# PmyOS – Roadmap & Future Objectives

This document describes the **planned evolution of PmyOS**, starting from the
current working BIOS bootloader and extending toward a real, multi-architecture
operating system.

The roadmap is intentionally **ordered and phased** to avoid over-engineering
and to keep the project fun, educational, and useful.

---

## Current State (Baseline)

The following functionality is already implemented and working:

- BIOS Stage 1 bootloader (512 bytes)
- BIOS Stage 2 loader
- Disk loading using BIOS `int 13h`
- Global Descriptor Table (GDT)
- Transition from 16-bit real mode to 32-bit protected mode
- Flat memory model (4 GB)
- VGA text output in protected mode (no BIOS)
- Clean directory layout:
  - `boot/x86/bios`
  - future-ready structure for kernel and other architectures
- Directory-level Makefiles
- Clean `.gitignore`
- End-to-end bootable image via QEMU

This baseline solves most of the **hard bootstrapping problems**.

---

## Phase 1 – Kernel Entry & Minimal Kernel (Done)

### Goal
Transition from “bootloader-only project” to a **real kernel running in C**.

This phase establishes the **boot → kernel boundary**, which everything else
builds upon.

### Objectives (in order)

1. Define a kernel entry contract (ABI)
   - CPU mode: 32-bit protected mode
   - Paging: disabled
   - Interrupts: disabled
   - Stack: known, initialized
   - Entry point: fixed symbol (e.g., `kernel_entry`)
   - No arguments initially

2. Create kernel directory structure
kernel/
├── common/
│ ├── kmain.c
│ └── printk.c
└── x86/
├── entry.asm
└── linker.ld

3. Implement `kernel/x86/entry.asm`
- Set up stack (if needed)
- Call `kmain()` in C
- Never return

4. Implement a minimal C kernel
- `kmain()` prints a message via VGA
- No libc
- No dynamic memory
- Halt or loop forever

### Outcome
- Kernel runs
- Kernel prints text
- Kernel is independent of BIOS details

This is the **single most important milestone** in the project.

---

## Phase 2 – Kernel Infrastructure (Core OS Foundations) (Next Phase)

### Goal
Turn the minimal kernel into a stable execution environment.

### Objectives

1. Proper VGA text console
- Cursor tracking
- Newlines
- Scrolling
- Clear screen

2. Interrupt Descriptor Table (IDT)
- CPU exception handlers
- Basic fault reporting
- Prevent triple faults
- Kernel panic screen

3. Timer support
- PIT (initially)
- Periodic timer interrupts
- Tick counter

4. Keyboard input
- IRQ handling
- Scancode decoding
- Simple input buffer

### Outcome
- Interactive kernel
- Safe debugging
- Time awareness

---

## Phase 3 – Memory Management

### Goal
Gain control over memory and virtual address space.

### Objectives

1. Physical memory discovery
- BIOS memory map (temporary solution)
- Track usable vs reserved memory

2. Paging (x86)
- Identity-map kernel
- Enable paging
- Page fault handler

3. Kernel memory allocator
- Start with bump allocator
- Move to free lists later
- Kernel heap support

### Outcome
- Protected memory
- Virtual addressing
- Foundation for processes

---

## Phase 4 – User Space & Programs

### Goal
Transform the kernel into a real operating system.

### Objectives

1. System call mechanism
- Software interrupt or syscall instruction
- Minimal syscall table

2. User programs
- Hard-coded binaries initially
- Example programs:
  - `hello`
  - `uptime`
  - `clear`

3. Simple shell
- Read user input
- Execute commands
- Built-in commands

### Outcome
- User/kernel separation
- Executable programs
- Interactive OS experience

---

## Phase 5 – UEFI Support (After Kernel Exists)

### Important Design Rule
UEFI should be **another boot path**, not a different OS.

Both BIOS and UEFI must lead to the **same kernel binary**.

### Objectives

1. Define boot-independent kernel ABI
- Kernel must not know:
  - BIOS
  - UEFI
  - Firmware details

2. Add UEFI bootloader
boot/x86/uefi/

3. UEFI responsibilities
- Load kernel image
- Provide memory map
- Exit boot services
- Jump to kernel entry

### Outcome
- Same kernel
- Multiple boot methods
- Modern firmware support

---

## Phase 6 – Multi-Architecture Support (Optional / Advanced)

### Goal
Extend PmyOS beyond x86.

### Recommended Order
1. x86_64
2. RISC-V
3. ARM

### Structure
boot/
x86/
arm/
riscv/

kernel/
x86/
arm/
riscv/
common/

### Notes
- Kernel core remains shared
- Architecture-specific code stays isolated
- Boot and kernel remain separate concerns

---

## Design & Project Recommendations

1. Treat each phase as a release
   - Tag milestones (e.g., `v0.2-kernel-entry`)
   - Keep motivation high

2. Avoid premature abstraction
   - No fancy allocators early
   - No complex frameworks
   - Clarity over cleverness

3. Keep the OS bootable at all times
   - If it stops booting, fix that first

4. Document lightly but consistently
   - Short notes in `README.md` or `docs/`
   - Focus on decisions, not code dumps

5. Optimize for learning and enjoyment
   - This is a systems playground
   - Practical understanding > completeness

---

## Immediate Next Step (Recommended)

Begin **Phase 1**:

> Define the kernel entry ABI and implement `kernel/x86/entry.asm`
> followed by a minimal `kmain()` in C.

This is where PmyOS truly becomes an operating system.