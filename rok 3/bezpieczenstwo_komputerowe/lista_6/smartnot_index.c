#include<unistd.h>
/*
   │0x56557020 <shellcode>          jmp    0x56557043 <shellcode+35>                                 │
   │0x56557025 <shellcode+5>        mov    eax,0x4 ;sysscal pritnf                                    │
   │0x5655702a <shellcode+10>       mov    ebx,0x1 ;fd (?)                                          │
   │0x5655702f <shellcode+15>       pop    ecx     ;wskaznik na poczatek                           │
   │0x56557030 <shellcode+16>       mov    edx,0xf ;długość                                       │
   │0x56557035 <shellcode+21>       int    0x80                                                      │
   │0x56557037 <shellcode+23>       mov    eax,0x1                                                   │
   │0x5655703c <shellcode+28>       mov    ebx,0x0                                                   │
   │0x56557041 <shellcode+33>       int    0x80                                                      │
   │0x56557043 <shellcode+35>       call   0x56557025 <shellcode+5>                                  │
   │0x56557048 <shellcode+40>       xor    dh,BYTE PTR ds:0x31313130                                 │
   │0x5655704e <shellcode+46>       or     eax,0xa 
*/

char shellcode[] =     
    "\xe9\x1e\x00\x00\x00"
    "\xb8\x04\x00\x00\x00" 
    "\xbb\x01\x00\x00\x00" 
    "\x59"                 
    "\xba\x0f\x00\x00\x00"
    "\xcd\x80"              
    "\xb8\x01\x00\x00\x00" 
    "\xbb\x00\x00\x00\x00"
    "\xcd\x80"              
    "\xe8\xdd\xff\xff\xff" 
    "250111\r\n";   

int main(int argc, char* argv[])
{
	int *ret;
	ret = (int *)&ret +2;
	(*ret) = (int)shellcode;
}
