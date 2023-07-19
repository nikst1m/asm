global	_start

section	.data

numbers	dd 65545467

section	.bss

buffer	resb 50 

section .text

; procedure print_num ([ebp+8]=count; [ebp+12]=address)
print_num:
	push	ebp
	mov	ebp, esp
	push	edx

	mov	eax, 4		; syscall write
	mov	ebx, 1
	mov	ecx, [ebp+12] 
	mov	edx, [ebp+8] 
	int	80h
	
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret

; procedure strlen([ebp+
strlen:
	push	ebp
	mov	ebp, esp

	xor	eax, eax

	mov	esp, ebp
	pop	ebp
	ret

; procedure rotate_str ([ebp+8]=address)
rotate_str:
	push	ebp
	mov	ebp, esp
	
	mov	esi, [ebp+8]	; start str
	
	mov	esp, ebp
	pop	ebp
	ret

; procedure convert_num ([ebp+8]=buffer address; ebp+12=number)
convert_num:
	push 	ebp
	mov	ebp, esp
	push	edi
	
	mov	eax, dword [ebp+12]
	mov	ebx, dword 10
	mov	edi, [ebp+8]
	
.again:	xor	edx, edx
	div	ebx
	add	dl, "0"
	mov	byte [edi], dl
	inc	edi
	cmp	eax, 0
	jne	.again
	
	mov	byte [edi], 0
	mov	esp, ebp
	pop	ebp
	ret


; Main
_start:	
	mov	eax, 20			; call getpid
	int	80h	

	push	dword eax
	push	dword buffer
	call 	convert_num	
	add	esp, 8 

	push	dword buffer
	push	dword 50 
	call	print_num
	add	esp, 8

	mov	eax, 1		; syscall _exit
	mov	ebx, 0
	int	80h	

