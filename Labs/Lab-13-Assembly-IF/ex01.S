.section .rodata


.data

# int a = 30
    .globl a
    .align 4
a:  .long 30

# int b = 45
    .globl b
    .align 4
b:  .long 45

# int c = -60 
    .globl c
    .align 4
c:  .long -60

# int d = 25
    .globl d
    .align 4
d:  .long 25

.text

.globl ex01
ex01:

    pushq %rbp 

    movq  %rsp, %rbp

    # Seu código aqui...
        
    movl    a, %eax
    movl    b, %ecx
    cmpl    %ecx, %eax
    jle endif01

    # c = -c
    movl    c, %eax
    negl %eax

    # d = c / 3
    movl    c, %edi
    movl    $3, %ecx
    movl    %edi, %eax
    cltd            # extensão do sinal do eax
    idivl   %ecx    # divisor 

    movl    %eax, d 

endif01:

    movl    b, %edx
    movl    a, %eax
    cmpl    %eax, %edx
    jl endif02

    # c = (a + b) * c
    # a + b
    movl    a, %eax
    movl    b, %ecx
    addl    %ecx, %eax

    # (a+b) * c
    movl    c, %ecx
    imull   %ecx, %eax
    movl    %eax, c   
    
    # d = 1024
    movl    $1024, d

endif02: 

    leave
    ret
