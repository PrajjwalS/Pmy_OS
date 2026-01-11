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

    ; --------------------------------------
    ; Load kernel (16 sectors) to 0x00010000 (this is fixed for now.)
    ; --------------------------------------
    mov ax, 0x1000      ; ES = 0x1000 → physical 0x00010000
    mov es, ax
    xor bx, bx

    mov cl, 0x03        ; kernel starts at sector 3
    mov al, 16          ; kernel size = 16 sectors (8 KB)
    call load_disk



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
%include "utils/load_disk.asm"

; -----------------------------------------------------------------------------
; 32-bit Protected Mode
; -----------------------------------------------------------------------------
[bits 32]
begin_pm:
    ; --------------------------
    ; Print a msg (useless almost)
    ; --------------------------
    mov ebx, msg_pm
    call print_string_pm

    ; --------------------------
    ; Jump to kernel 
    ; TODO : Make this and a lot of hardcoded stuff Macro-ed
    ; --------------------------
    jmp 0x08:0x00010000

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

;------- padding this to exactly 512 bytes to fit in exactly 1 sector ---------
times 512 - ($ - $$) db 0