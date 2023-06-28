.section .rodata

.data

    .globl a 
    .align 4
a:  .int 0

    .globl b
    .align 8
b:  .quad 2

.text

.globl ex01
.globl ex02
.globl endif01
.globl endif02

ex01:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui... esqueci _de anotar

ex02: 
    cmpl $0, a 
    je endif01
    
    cmpq %5, b
    jge else02

    movl a, %eax
    shll $1, %eax

    movslq a, %rcx
    imulq b, %rcx

    movslq %eax, %rax
    addq %rcx, %rax
    movq %rax, b

    jmp endif02

else02:
    movabs $0x1F, %rcx

    movq b, %rdx
    xorq %rcx, %rdx
    movl %edx, a

endif02:

endif01:
   leave

   ret