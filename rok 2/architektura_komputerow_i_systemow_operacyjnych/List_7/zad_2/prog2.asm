global main
extern scanf
extern printf

section .bss
x       resd 1
sinh    resd 1
arcsinh resd 1

section .data
prompt          db "your number: ", 0
scan_format     db "%f"
sinh_format     db "sinh (x)", 0x09, "= %f", 0x0a, 0
arcsinh_format  db "sinh^(-1) (x)", 0x09, "= %f", 0x0a, 0

section .text
main:
    push prompt
    call printf
    push x
    push scan_format
    call scanf
    finit

    fld dword[x]
    fldl2e  ; log2(e)
    fmulp   ; log2(e^x)
    fld st0
    frndint
    fxch
    fsub st0, st1
    f2xm1
    fld1
    faddp
    fxch
    fld1
    fscale
    fstp st1
    fmulp

    fld dword[x]
    fchs    ; -x
    fldl2e  ; log2(e)
    fmulp   ; log2(e^-x)
    fld st0
    frndint
    fxch
    fsub st0, st1
    f2xm1
    fld1
    faddp
    fxch
    fld1
    fscale
    fstp st1
    fmulp

    fsubp   ; e^x - e^-x

    fld1
    fld1
    faddp
    fdivp
    fst dword[sinh]

    sub esp, 8
    fstp qword [esp]
    push sinh_format
    call printf
    add esp, 8

    fld1            ; st0=1
    fld dword[x]    ; st0=x, st1=1
    fld dword[x]    ; st0=x, st1=x, st2=1
    fmulp           ; st0=x^2, st1=1
    fld1            ; st0=1, st1=x^2, st2=1
    faddp           ; st0=1+x^2, st1=1
    fsqrt           ; st0=sqrt(1+x^2), st1=1
    fld dword[x]    ; st0=x, st1=sqrt(1+x^2), st2=1
    faddp           ; st0=x+sqrt(1+x^2), st1=1
    fyl2x           ; st0=log2(x+sqrt(1+x^2))
    fldl2e          ; st0=log2(e), st1=log2(x+sqrt(1+x^2)) 
    fdivp           ; st0=ln(x+sqrt(1+x^2))

    sub esp, 8
    fstp qword [esp]
    push arcsinh_format
    call printf
    add esp, 8

    add esp, 4

    mov eax, 1
    mov ebx, 0
    int 0x80
