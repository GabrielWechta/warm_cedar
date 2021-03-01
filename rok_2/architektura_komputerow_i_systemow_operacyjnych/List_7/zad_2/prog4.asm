section .data                           ;Data segment
   blank db ' '
   lenBlank equ $-blank 
   newLine db 0xA, 0xD
   lenNewLine equ $-newLine           
            
section	.bss
   num resb 1
   size resb 1
   iteration resb 1
   
section	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point
   mov eax, 3
   mov ebx, 2
   mov ecx, size
   mov edx, 1          ;5 bytes (numeric, 1 for sign) of that information
   int 0x80

   mov ebx, [size]
   mov [iteration], byte '1'
	
l1:
   push ebx
   mov eax, '1'
   mov ebx, [iteration]

   l2:
      push ebx
      mov [num], eax

      mov eax, 4
      mov ebx, 1
      mov ecx, num        
      mov edx, 2    
      int 0x80

      mov eax, 4
      mov ebx, 1
      mov ecx, blank    
      mov edx, lenBlank   
      int 0x80
      
      mov eax, [num]
      inc eax

      pop ebx
      cmp eax, ebx
      jle l2
      
   push ebx
   mov eax, 4
   mov ebx, 1
   mov ecx, newLine      
   mov edx, lenNewLine 
   int 0x80

   pop eax
   pop ebx
   inc eax
   mov [iteration], eax
   mov ecx, [iteration]

   cmp eax, ebx
   jle l1
   
	
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel


