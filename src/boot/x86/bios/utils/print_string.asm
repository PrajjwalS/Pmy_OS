; -----------------------------------------------------------------------------
; print_string
; Prints a null-terminated string using BIOS teletype output
;
; Input:
;   BX = address of null-terminated string
;
; Clobbers:
;   AL, AH
;
; Preserves:
;   All general-purpose registers
; -----------------------------------------------------------------------------

[bits 16]

print_string:
    pusha

.print_loop:
    mov     al, [bx]        ; load current character
    cmp     al, 0           ; end of string?
    je      .done

    mov     ah, 0x0E        ; BIOS teletype function
    int     0x10

    inc     bx              ; move to next character
    jmp     .print_loop

.done:
    popa
    ret