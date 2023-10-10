.arch armv7-a

@ comm section save global variable without initialization
.text
.align 2

@ rodata section save constant
.section .rodata
_str:
.ascii "Hello World!\n"

@ text section code
.text
.align 2

.global main
main:
push {fp, lr}
ldr r0,_bridge
bl printf
mov r0, #0
pop {fp, pc} @ return 0

_bridge:
.word _str

.section .note.GNU-stack,"",%progbits 
