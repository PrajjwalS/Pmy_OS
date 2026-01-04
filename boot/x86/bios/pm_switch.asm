; -----------------------------------------------------------------------------
; Switch from Real Mode to Protected Mode
; -----------------------------------------------------------------------------

[bits 16]

switch_to_pm:
    cli
    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; Far jump to flush pipeline
    jmp CODE_SEG:pm_entry

; -----------------------------------------------------------------------------
; Protected mode entry
; -----------------------------------------------------------------------------
[bits 32]

pm_entry:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x9FC00     ; safe 32-bit stack

    jmp begin_pm