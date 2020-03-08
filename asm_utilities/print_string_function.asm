; custom utility to print null terminated strings on the screen
; supports x86, int 0x10
; NOTE: Before calling this sub-routine, push the address of
;	mov the address of the null terminated string in bx reg
print_string:
	pusha			; push all registers over the stack
loop:	
	mov	al, [bx]
	cmp	al, 0
	je	return
	push	bx
	mov	ah, 0x0e
	int	0x10
	pop	bx
	inc	bx
	jmp	loop
return:
	popa
	ret
