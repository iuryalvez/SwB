.data

# long last = 0;
.globl last
.align 8
last:   .quad 0

# long values[5] = {50, -10, 60, -20, 70};
.globl values
.align 8
values: .quad 50,-10,60,-20,70

.text

.globl swap

swap:

    pushq %rbp
    movq  %rsp, %rbp

    movl $4, %ecx # int j = 4
    movl $0, %eax # int i = 0

for01:
    cmpl    %ecx, %eax # i - j
    jge fim_for01

    # acessando values[i]
    movq    $values, %r8
    movslq  %eax, %r9
    imulq   $8, %r9
    addq    %r8, %r9 # r9 = &values[i]

    movq    (%r9), %rdx # rdx = tmp = values[i]

    # acessando values[j]
    movq    $values, %r8
    movslq  %ecx, %r10
    imulq   $8, %r10
    addq    %r8, %r10 # r10 = &values[j]

    movq    (%r10), %r11 # r11 = values[j]
    movq    %r11, (%r9) # values[i] = values[j]

    movq    %rdx, (%r10) # values[j] = tmp

    incl %eax
    decl %ecx
    
    jmp for01

fim_for01:

    movq    $values, %r8
    movq    32(%r8), %r10 # r10 = values[4]
    movq    %r10, last 

    leave
    ret