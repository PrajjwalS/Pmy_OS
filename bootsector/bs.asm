
	[ORG 0x7c00]			; specifies where bios will load the boot sector

	MOV	[BOOT_DRIVE],DL		; initally dl holdes the default readble disk
	
	;moving stack to 0x8000
	MOV 	BP,0x8000
	MOV	SP,BP
	
	;printing HELLO_MSG and where the bootsector was loaded
	MOV	BX, HELLO_MSG
	CALL	print_string
	MOV	DX,0x7C00
	CALL	print_hex
	
	;loading the disk sectors at 0x9000 from ESreg (ES:BS i.e. ES+0x9000) 
	MOV	BX,0x9000
	MOV	DH,5		; read 5 sectors
	MOV	DL,[BOOT_DRIVE]
	CALL	load_disk
	
	;printing the loaded disk
	mov	dx,[0x9000]
	call	print_hex
	mov	dx,[0x9000+512]
	call	print_hex
	mov	dx,[0x9000+1024]
	call	print_hex
	jmp 	$			; infinite loop, jumping to current directory
	
	
	%include "../asm_utilities/print.asm"		; including the print utility function file
	%include "../asm_utilities/load_disk.asm"
;DATA
HELLO_MSG:
	DB	'###### Pmy_OS ######',10,13,'Boot Sector was loaded at:',0 
BOOT_DRIVE:
	DB	0

	TIMES	510-($-$$) DB 0		; padding 0 till magic number
	DW	0xAA55

	TIMES	256	DW	0xface
	TIMES	256	DW	0xdada
	TIMES	256	DW	0xabcd
	TIMES	256	DW	0xdcba
	TIMES	256	DW	0xacbd
	
