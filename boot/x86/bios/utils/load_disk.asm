; -----------------------------------------------------------------------------
; load_disk
; Reads sectors from disk using BIOS INT 13h
;
; Input:
;   DL = drive number (provided by BIOS)
;   ES:BX = destination buffer
;   AL = number of sectors to read
;   CL = start sector index
;
; Reads:
;   From CHS 0/0/2 (immediately after boot sector)
;
; Clobbers:
;   AX, CX, DX
;
; On error:
;   Prints message and halts
; -----------------------------------------------------------------------------

[bits 16]

load_disk:
    pusha

    mov ah, 0x02        ; BIOS read sectors
    mov ch, 0x00        ; cylinder 0
    mov dh, 0x00        ; head 0

    int 0x13
    jc  disk_error     ; CF set = error

    popa
    ret

disk_error:
    mov bx, disk_error_msg
    call print_string
.hang:
    jmp .hang

disk_error_msg db "Disk read error!", 0