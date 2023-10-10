.arch armv7-a

@ comm section save global variable without initialization
.comm n, 4 @global variables
.text
.align 2

@ rodata section save constant
.section .rodata
.align 2
_str0:
.ascii "Enter n:%d\n"
.align 2
_str1:
.ascii "Factorial result is : %d\n"

@ text section code
.text
.align 2

.global factorial


.global main
main:
push {fp, lr}




mov r0, #0
pop {fp, pc} @ return 0

_bridge:


.section .note.GNU-stack,"",%progbits
