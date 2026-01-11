; -----------------------------------------------------------------------------
; Global Descriptor Table
; -----------------------------------------------------------------------------

gdt_start:

gdt_null:
    dq 0x0000000000000000

gdt_code:
    dq 0x00CF9A000000FFFF   ; base=0, limit=4GB, code segment

gdt_data:
    dq 0x00CF92000000FFFF   ; base=0, limit=4GB, data segment

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; Segment selectors
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start