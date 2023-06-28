.data

# char c = -20;
    .globl c
    .align 1
c:  .byte -20

# int i = -256;
    .globl i
    .align 4
i:  .int -256

# int j = 512;
    .globl j
    .align 4
j:  .int 512

# long l = 128;
    .globl l
    .align 8
l:  .quad 128

# unsigned short us = 111;
    .globl us
    .align 2
us: .short 111

# unsigned int ui = 1024;
    .globl ui
    .align 4
ui: .int 1024

# unsigned long ul = 2048;
    .globl ul
    .align 8
ul: .quad 2048


.text

.globl aux

aux:

    pushq %rbp

    movq  %rsp, %rbp

    # Se necessário, usar apenas os registradores (ou suas variações) abaixo:

    # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

    # Seu código aqui...

    # j = 68000;
    j:  .movl $68000, j

    # l = 4096;
    l:  .movq $4096, l

    # i = j;
    movl    j, %eax
    movl    %eax, i

    # j = 10 + i - 5;
    movl    i, %eax
    addl    $10, %eax
    subl    $5, %eax    
    movl    %eax, j

    # i = (i * 2) - (j + 5);
    movl    i, %ecx
    imull   $2, %ecx
    movl    j, %edx
    addl    $5, %edx
    
    subl    %edx, %ecx
    movl    %ecx, i

    # ui = i;
    movl    i, %eax
    movl    %eax, ui

    # j = c;
    movsbl  c, %edx
    movl    %edx, i

    leave

    ret
