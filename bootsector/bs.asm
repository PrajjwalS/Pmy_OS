; ############### BOOT-SECTOR ##########

mov	ah,0x0e	;for teletype mode interupt
mov	al,'H'
int	0x10
mov	al,'E'
int	0x10
mov	al,'L'
int	0x10
mov	al,'L'
int	0x10
mov	al,'O'
int	0x10
mov	al,' '
int	0x10
mov	al,'O'
int	0x10
mov	al,'S'
int	0x10

jmp	$	; Jumping to current address
times	510-($-$$)	db 0
dw	0xaa55
















