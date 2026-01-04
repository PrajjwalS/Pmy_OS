; -----------------------------------------------------------------------------
; Stage 2 Bootloader
; Switches from Real Mode → 32-bit Protected Mode
; -----------------------------------------------------------------------------

[org 0x8000]
[bits 16]

start_stage2:
    ; -----------------------------
    ; Setup stack (real mode)
    ; -----------------------------
    cli
    xor ax, ax
    mov ss, ax
    mov sp, 0x9000
    sti

    ; -----------------------------
    ; Print Stage 2 message
    ; -----------------------------
    mov bx, msg_stage2
    call print_string

    ; -----------------------------
    ; Switch to protected mode
    ; -----------------------------
    cli
    call switch_to_pm

.hang_rm:
    jmp .hang_rm

; -----------------------------------------------------------------------------
; Real-mode utilities
; -----------------------------------------------------------------------------
%include "utils/print_string.asm"
%include "gdt.asm"
%include "pm_switch.asm"

; -----------------------------------------------------------------------------
; 32-bit Protected Mode
; -----------------------------------------------------------------------------
[bits 32]
begin_pm:
    mov ebx, msg_pm
    call print_string_pm

.hang_pm:
    jmp .hang_pm

; -----------------------------------------------------------------------------
; Protected-mode utilities
; -----------------------------------------------------------------------------
%include "print_pm.asm"

; -------------------- REAL MODE DATA --------------------
[bits 16]
msg_stage2 db "Hello from Stage 2!", 0x0D, 0x0A, 0

; -------------------- PROTECTED MODE DATA --------------------
[bits 32]
msg_pm db "Now in 32-bit Protected Mode", 0