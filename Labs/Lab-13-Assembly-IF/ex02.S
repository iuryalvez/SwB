.section .rodata

.data

    .globl a 
    .align 4
a:  .int 0

    .globl b
    .align 8
b:  .quad 2

.text

.globl ex02
ex02: 

    pushq   %rbp
    movq    %rsp, %rbp
    
    # _if (a)
    cmpl    $0, a 
    je endif01
    
    # _if (b menor q 5)
    cmpq    $5, b
    jge else02

    # a shiftado 1 vez pra esquerda
    movl    a, %eax
    shll    $1, %eax

    # a * b
    movslq  a, %rcx
    imulq   b, %rcx

    # somando os dois anteriores
    movslq  %eax, %rax
    addq    %rcx, %rax

    # b = tudo isso
    movq    %rax, b

    jmp endif02

else02:
    movabs  $0x1F, %rcx # movendo absoluto _de 64bits
    # a = b ^ 0x1FL
    movq    b, %rdx
    xorq    %rcx, %rdx
    movl    %edx, a

endif02:

endif01:

   leave
   ret