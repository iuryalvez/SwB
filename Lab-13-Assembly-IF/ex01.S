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
d:  .int 25

.text

.globl ex01
.globl endif01
.globl endif02

ex01:

    pushq %rbp 

    movq  %rsp, %rbp

    # Seu código aqui...
        
    movl a, %eax
    cmpl b, %eax
    jle endif01

    # c = -c
    negl c 

    movl c, %ecx 
    imull $3, %ecx 
    movl %ecx, d

endif01:

    movl b, %edx
    cmpl a, %edx
    jl endif02

    # c = (a + b) * c
    movl a, %eax   # Move o valor de 'a' para o registrador %eax
    addl b, %eax   # Adiciona o valor de 'b' ao valor de %eax
    imull c, %eax  # Multiplica o valor de %eax pelo valor de 'c'
    movl %eax, c   # Move o resultado da multiplicação para 'c'
    movl $1024, d  # Move o valor 1024 para 'd'


endif02: 
