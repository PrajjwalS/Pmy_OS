
; Utility to print hex numbers
;  inlcude print_string.asm
;  supports x86 
;  expects the hex value to be stored in DX

add_nibble:			; adds the nibble stored in AX (lower 4 bits) to HEX_STRING
					; expects BX to store address of the next index of HEX_STRING
				
	CMP	AX,0x000A
	JL	lesser_0xA
	ADD	AX,0x0007
lesser_0xA:
	ADD	AX,0x0030
	INC	BX
	MOV	[BX],AX
	RET	


print_hex:	
	
	PUSHA
	MOV	BX,HEX_STRING
	ADD	BX,1

	MOV CX,4
repeat:
	MOV	AX,DX
	AND AX,[MASK]
	PUSH CX
	MOV CL,[SHIFT]
	SHR AX,CL
	POP CX
	CALL add_nibble
	SHR WORD [MASK],4
	SUB	BYTE [SHIFT],4			
	LOOP repeat	
	
	MOV	BX,HEX_STRING	
	CALL print_string
	POPA
	RET
	;%include "../asm_utilities/print_string_function.asm"		; including the print utility function file

;DATA
HEX_STRING:
	TIMES 7 DB '0x',0
MASK:
	 DW 0xF000
SHIFT:
	 DB 12		