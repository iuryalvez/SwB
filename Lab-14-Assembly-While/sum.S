.data

.globl s
.align 4
s:  .long 0

.globl nums
.align 4
nums:  .long 65,-105,111,34

.text

.globl sum

sum:

    pushq %rbp

    movq  %rsp, %rbp

    # int i = 0
    movl $0, %ecx

    # while () {
while01:
    cmpl    $4, %ecx
    jge     fim_while01

    movq    $nums, %rdx # pegando o ponteiro do nums
    movslq  %ecx, %r8   # alargando o int para 8 bytes (ponteiro)
    imulq   $4, %r8     # sizeof int * i
    addq    %r8, %rcx   # endereço do nums + r8

    movl    (%rdx), %eax
    addl    s, %eax
    movl    %eax, s

    # i++
    incl    %ecx

    jmp while01

fim_while01:

    leave

    ret