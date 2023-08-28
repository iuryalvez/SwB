.section .rodata

    fmt: .string "a = %f, b = %f, e = %f\n"

.text

.globl calc2
calc2:
    
    pushq %rbp
    movq %rsp, %rbp

    # %xmm0 = -4(%rbp)
    # %xmm1 = -8(%rbp)
    # e = -16(%rbp)

    subq $16, %rsp

    movss %xmm0, -4(%rbp)
    movss %xmm1, -8(%rbp)
    cvtss2sd %xmm1, %xmm0

    call cos

    movsd %xmm0, %xmm11
    movss -4(%rbp), %xmm0
    movss -8(%rbp), %xmm1
    cvtss2sd %xmm0, %xmm2
    addsd %xmm11, %xmm2
    movsd %xmm2, -16(%rbp)
    movq $fmt, %rdi
    cvtss2sd -4(%rbp), %xmm0
    cvtss2sd -8(%rbp), %xmm1
    movl $3, %eax

    call printf
    
    movsd -8(%rbp), %xmm0
    
    leave
    ret
    