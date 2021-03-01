.data
 
.balign 4
message1: .asciz "Hey, type 1st number: "

.balign 4
message2: .asciz "Type 2nd number: "

.balign 4
A_read: .word 0

.balign 4
B_read: .word 0

.balign 4
scan_pattern : .asciz "%d"

.balign 4
message3: .asciz "My ARM brain tells me gcd is: %d\n"

.balign 4
return: .word 0
 
.text
 
.global main
main:
    ldr r1, address_of_return        /* r1 ← &address_of_return */
    str lr, [r1]                     /* *r1 ← lr */
 
    ldr r0, address_of_message1      /* r0 ← &message1 */
    bl printf                        
 
    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_A_read	     /* r1 ← &A_read */
    bl scanf                         

    ldr r0, address_of_message2      /* r0 ← &message2 */
    bl printf                        

    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_B_read        /* r1 ← &B_read */
    bl scanf         

    ldr r0, address_of_A_read        /* r0 ← &A_read */
    ldr r0, [r0]                     /* r0 ← *r0 */

    ldr r1, address_of_B_read        /* r0 ← &A_read */
    ldr r1, [r1]                     /* r0 ← *r0 */

gcd:    
	cmp	r0, r1
	beq	end
	blt	less

    	sub	r0, r0, r1  
	b	gcd
less:
	sub	r1, r1, r0  
	b	gcd
end:
    ldr r0, address_of_message3      /* r0 ← &message3 */ 
    bl printf                        /* I don't load rd1 cause value to print is still in there */
 
    ldr lr, address_of_return        /* lr ← &address_of_return */
    ldr lr, [lr]                     /* lr ← *lr */
    bx 	lr                            /* return from main using lr */

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_A_read : .word A_read
address_of_B_read : .word B_read
address_of_return : .word return
 
/* External */
.global printf
.global scanf
