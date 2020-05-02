; boot sector that enters 32 bit protected mode
	[org 0x7c00]

	MOV	BP, 0x9000	; set stack
	MOV	SP, BP
	
	MOV	BX,	MSG_REAL_MODE
	CALL	print_string
	
	CALL	SWITCH_TO_PM
	JMP	$

	%include "../asm_utilities_bios/print.asm"
	%include "../gdt/gdt.asm"
	%include "../asm_utilities_32bit/print.asm"
	%include "../pm_switch/pm_switch.asm"
	
	[bits 32]
	;; below is PM 
BEGIN_PM:
	MOV	EBX, MSG_PROT_MODE
	CALL	print_string_pm;
	JMP	$
	
; vars
MSG_REAL_MODE	DB	"Started in 16-bit Real mode",0
MSG_PROT_MODE	DB	"Successfully landed in 32-bit Protected Mode",0

; padding
	times 510-($-$$)	db 0
	DW	0xaa55
