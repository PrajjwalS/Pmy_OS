; switches to 32 bit protected mode

	[bits 16]

SWITCH_TO_PM:
	CLI	; disables 16bit bios interrupts
	LGDT	[GDT_DESCRIPTOR]	;loads GDT, containing code and data segments
	
	MOV	EAX, CR0
	OR	EAX, 0x1
	MOV	CR0, EAX

	JMP	CODE_SEG:INIT_PM

	[bits 32]
INIT_PM:
	MOV	AX, DATA_SEG
	MOV	DS, AX
	MOV	SS, AX
	MOV	ES, AX
	MOV	FS, AX
	MOV	GS, AX
	
	MOV 	EBP, 0x90000	;position stack to the top of the free space
	MOV	ESP, EBP
	
	CALL	BEGIN_PM




	
