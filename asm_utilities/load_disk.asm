; a utility to load DH number of sectors to ES:BX from drive DL
load_disk:
	PUSH	DX	;push DX to later check how much was read
	
	MOV	AH,0x02	;read sector routine for bios is 0x02
	MOV	AL,DH	;to read DH number of sectors
	MOV	CH,0x00	;  	from cylinder 0
	MOV	DH,0x00	;	from head 0
	MOV	CL,0x02	;	from 2nd sector (ie, just after boot sector) 
	INT	0x13	;Interrupt BIOS to read
	
	JC	DISK_ERROR	;jump to show if error occurs
				; (error is when carry flag is set)
	POP	DX	; restoring DX from stack to check if correctly
			; DH number of sectors were read
	CMP	DH,AL
	JNE	DISK_ERROR
	RET
	
DISK_ERROR:
	MOV	BX, DISK_ERROR_MESSAGE
	CALL	print_string
	JMP	$
DISK_ERROR_MESSAGE:
	DB	10,13,"ERROR READING DISK.",0
CHECK:	
	DB	10,13,"CHECK"
