; -----------------------------------------------------------------------------
; print_string_pm
; Prints a null-terminated string to VGA text mode memory (0xB8000)
; Runs in 32-bit protected mode
;
; Input:
;   EBX = linear address of null-terminated string
;
; Clobbers:
;   EAX, EDX
;
; Preserves:
;   All general-purpose registers
; -----------------------------------------------------------------------------

[bits 32]

VIDEO_MEM        equ 0xB8000
WHITE_ON_BLACK   equ 0x0F

print_string_pm:
    pusha

    mov edx, VIDEO_MEM + (2 * 80 * 10)      ; VGA text buffer (print in 10th row)

.print_loop:
    mov al, [ebx]           ; load character
    test al, al             ; check for null terminator
    jz .done

    mov ah, WHITE_ON_BLACK  ; attribute
    mov [edx], ax           ; write char + attribute

    inc ebx                 ; next character
    add edx, 2              ; next VGA cell
    jmp .print_loop

.done:
    popa
    ret