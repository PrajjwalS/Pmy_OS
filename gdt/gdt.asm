; GDT - Global Descriptor Table
GDT_START:

 GDT_NULL:	; manditory null global descriptor
	
	DD	0x00
	DD	0x00	; DD defines double word i.e. 4 bytes

 GDT_CODE:	; code segment descriptor
	
	DW	0xFFFF	; Limit (0-15 bits)
	DW	0x0	; BASE  (0-15 bits)
	DB	0x0	; BASE	(16-23 bits)
	DB	10011010b;1st flags, type flags
	DB	11001111b; 2nd flags, limit (16-19 bits)
	DB	0x0	;base(bits 24-31)

 GDT_DATA:	; data segment descriptor

	DW	0xFFFF	; Limit (0-15 bits)
	DW	0x0	; BASE  (0-15 bits)
	DB	0x0	; BASE	(16-23 bits)
	DB	10010010b;1st flags, type flags
	DB	11001111b; 2nd flags, limit (16-19 bits)
	DB	0x0	;base(bits 24-31)
GDT_END:

GDT_DESCRIPTOR:		; GDT Descriptor
	DW	GDT_END - GDT_START - 1	; size of GDT less 1
	DD	GDT_START	; start address of GDT
	; some constants
CODE_SEG	EQU	GDT_CODE - GDT_START
DATA_SEG	EQU	GDT_DATA - GDT_START
