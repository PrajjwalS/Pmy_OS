; -----------------------------------------------------------------------------
; Stage 1 Bootloader
; Prints a message and jumps to protected mode.
; -----------------------------------------------------------------------------
[org 0x7C00]
[bits 16]

start:
    ; -----------------------------
    ; Setup stack
    ; -----------------------------
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; -----------------------------
    ; Print message
    ; -----------------------------
    mov bx, msg_stage1
    call print_string

    ; -----------------------------
    ; Load Stage 2 from disk
    ; -----------------------------
    mov ax, 0x0000
    mov es, ax          ; ES = 0
    mov bx, 0x8000      ; Offset
    mov cl, 0x02        ; sector 2 = stage2
    mov al, 1           ; Read 1 sector
    ; DL already contains boot drive
    call load_disk

    jmp 0x0000:0x8000


.hang:
    jmp .hang

; -----------------------------------------------------------------------------
; Real-mode utilities
; -----------------------------------------------------------------------------
%include "utils/print_string.asm"
%include "utils/load_disk.asm"

; -----------------------------------------------------------------------------
; Data
; -----------------------------------------------------------------------------
msg_stage1 db "Hello from Stage 1! ", 0

; -----------------------------------------------------------------------------
; Boot sector padding & signature
; -----------------------------------------------------------------------------
times 510 - ($ - $$) db 0
dw 0xAA55