; custom utility to print null terminated strings 
;	and hex numberson the screen
; supports x86, int 0x10

; NOTE: Before calling this sub-routine, 
;	MOV the address of the null terminated string in bx reg 
;	MOV the hex value to dx reg

;;;;;;;;;;;;;; FOR STRINGS ;;;;;;;;;;;
print_string:
	PUSHA			; push all registers over the stack
loop:	
	MOV		AL, [BX]
	CMP		AL, 0
	JE		return
	PUSH 	BX
	MOV		AH, 0x0E
	INT		0x10
	POP		BX
	INC		BX
	JMP		loop
return:
	POPA
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; FOR HEX ;;;;;;;;;;;;;;;

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
	; resetting String and other vars
	MOV  AX,[RESET_STRING]
	MOV	 [HEX_STRING],AX
	MOV  WORD [MASK],0xF000
	MOV  BYTE [SHIFT],12
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;DATA
HEX_STRING:
	TIMES 7 DB 0
RESET_STRING:
	DB	'0x',0,0
MASK:
	 DW 0xF000
SHIFT:
	 DB 12		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;