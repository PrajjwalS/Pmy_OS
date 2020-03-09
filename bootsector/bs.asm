
	[org 0x7c00]			; specifies where bios will load the boot sector
	
	mov bx, HELLO_MSG		
	call print_string		; calling the print utility
	mov dx,0x7C00
	call print_hex
	jmp $				; infinite loop, jumping to current directory

	%include "../asm_utilities/print.asm"		; including the print utility function file

;DATA
HELLO_MSG:
	db '###### Pmy_OS ######',10,13,'Boot Sector was loaded at:',0 
	
				
	times 510-($-$$) db 0		; padding 0 till magic number
	dw 0xaa55

