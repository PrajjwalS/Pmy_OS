; =========================================================
; x86 Kernel Entry Point
; =========================================================
; ABI CONTRACT:
; - CPU in 32-bit protected mode
; - Paging disabled
; - Interrupts disabled
; - Flat GDT loaded
; - No arguments passed
;
; Entry symbol: kernel_entry
; =========================================================

[bits 32]

global kernel_entry     ; This is what linker script jumps to
extern kmain

SECTION .text

kernel_entry:
    ; Setup kernel stack
    mov esp, kernel_stack_top

    ; Call C kernel
    call kmain

.hang:
    cli
    hlt
    jmp .hang


SECTION .bss
align 16

kernel_stack:
    resb 16384          ; 16 KB stack
kernel_stack_top: