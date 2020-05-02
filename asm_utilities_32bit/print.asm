; UTILITY TO PRINT A NULL TERMINATED STRING ON THE SCREEN
; IN VGA MODE, 32 bit Protected mode
	[bits 32]

	VIDEO_MEM	EQU	0xB8000
	WHITE_ON_BLACK	EQU	0x0F

print_string_pm:

	PUSHA
	MOV	EDX,VIDEO_MEM
 LOOP:
	MOV	AL, [EBX]	; AL stores the character ascii
	MOV	AH, WHITE_ON_BLACK	; AH stores the character attribute
	CMP	AL, 0
	JE	LOOP_END
	MOV	[EDX], AX
	ADD	EBX, 1
	ADD	EDX, 2
	JMP	LOOP
 LOOP_END:
	POPA
	RET

