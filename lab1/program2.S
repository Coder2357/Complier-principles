.arch armv7-a

@ comm section save global variable without initialization
.comm n, 4 @global variables
.text
.align 2

@ rodata section save constant
.section .rodata
.align 2
_str0:
.ascii "%d\0"@\000 is also one representation for `null character`
.align 2
_str1:
.ascii "Factorial result is : %d\n"

@ text section code
.text
.align 2

.global factorial
factorial: @ function int factorial(int n)
str fp, [sp, #-4]! @ pre-index mode, sp = sp - 4, push fp
mov fp, sp
sub sp, sp, #4 @ allocate space for local variables
str r0, [fp, #-4] @ r0 = [fp, #-4] = n
mov r1, #1

.L0:
cmp r0, #1
ble .L1 @ If n <= 1, return 1
@ if not jump
mul r1, r1, r0        @ r1 *= result of factorial(n-1)
sub r0, r0, #1
b .L0

.L1:
mov r0, r1
.L2:
add sp, fp, #0
ldr fp, [sp], #4 @ post-index mode, pop fp, sp = sp + 4
bx lr @ recover sp fp pc

.global main
main:
push {fp, lr}
add fp, sp, #4
ldr r1, _bridge @ r1 = &n
ldr r0, _bridge+4 @ *r0 = "%d\000"
bl __isoc99_scanf @ scanf("%d", &n)

ldr r3, _bridge @ r3 = &n
ldr r0, [r3] @ r0 = n
bl factorial @ factorial

@ print result
mov r1, r0
ldr r0, _bridge+8 @ *r0 = "Factorial result is : %d\n"
bl printf
mov r0, #0
pop {fp, pc} @ return 0

_bridge:
.word n
.word _str0
.word _str1

.section .note.GNU-stack,"",%progbits
