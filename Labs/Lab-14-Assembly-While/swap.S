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

    movl $0, %eax
    movl $4, %ecx

for01:
    cmpl %eax, %ecx
    jle fim_for01

    movq $values, %r8
    movslq %eax, %r9
    imulq $8, %r9
    addq %r8, %r9 # r9 = &values[i]

    movq (%r9), %rdx # rdx = tmp

    movq $values, %r8
    movslq %ecx, %r9
    imulq $8, %r9
    addq %r8, %r9 # r9 = &values[i]

    movq (%r9), %r10 # r10 = values[j]

    movq $values, %r8
    movslq %eax, %r9
    imulq $8, %r9
    addq %r8, %r9

    movq %r10, (%r9) # values[i] = values[j]

    incl %eax
    decl %ecx
    
    jmp for01

fim_for01:

    movq $values, %r8
    movq 32(%r8), %r10 # r10 = values[4]
    movq %r10, last 

    leave

    ret