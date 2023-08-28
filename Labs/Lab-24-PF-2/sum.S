.section .rodata

    # Constante 0.0
    .align 8
    C0: .double 0.0
    fmt: .string "Soma %f maior que o limite %f (%d)\n"

.text

.globl sum
sum:

    pushq %rbp
    movq %rsp, %rbp

    # rbx -> -8 (i)
    # xmm0 -> -16 (limit)
    # xmm1 -> -24 (s)
    # vi -> -40
    # vd -> -72
    
    subq $80, %rsp
    
    movq %rbx, -8(%rbp) # salva rbx
    movl $4, %ebx # i = 4
    
    movsd C0, %xmm1 # s = 0.0
    
    movl $5, -40(%rbp) # vi[0] = 5
    
    movl $6, -36(%rbp) # vi[1] = 6
    
    movl $7, -32(%rbp) # vi[2] = 7
    
    movl $8, -28(%rbp) # vi[3] = 8
    
    movsd %xmm0, -16(%rbp) # salva limit
    movsd %xmm1, -24(%rbp) # salva s
    leaq -40(%rbp), %rdi # 1o. param: &vi
    leaq -72(%rbp), %rsi # 2o. param: &vd
    movl %ebx, %edx # 3o. param: i
    
    call mult
    
    movsd -16(%rbp), %xmm0 # recupera limit
    movsd -24(%rbp), %xmm1 # recupera s
    
    begin_while:
    cmpl $0, %ebx # if (i <= 0) -> end_while
    jle end_while
    
    decl %ebx # i--
    
    leaq -72(%rbp), %r8 # r8 = &vd
    movslq %ebx, %r9 # r9 = (long)i
    imulq $8, %r9 # r9 = r9 * sizeof(long)
    addq %r8, %r9 # r9 = &vd[i]
    addsd (%r9), %xmm1 # s = s + vd[i]

    ucomisd %xmm0, %xmm1
    jp end_if
    jbe end_if # if (s <= limit) -> end_if
    
    movsd %xmm0, -16(%rbp) # salva limit
    movsd %xmm1, -24(%rbp) # salva s
    movq $fmt, %rdi # 1o. param inteiro: string
    movsd %xmm1, %xmm0 # 1o. param Floating-Point: s
    movsd -16(%rbp), %xmm1 # 2o. param FP: (double)limit
    movl %ebx, %esi # 2o. param inteiro: i
    movl $2, %eax # Vai imprimir 2 FP (s e limit)
    
    call printf
    
    movsd -16(%rbp), %xmm0 # recupera limit
    movsd -24(%rbp), %xmm1 # recupera s
    
    end_if:
    
    jmp begin_while
    
    end_while:
    
    movsd %xmm1, %xmm0 # return s
    movq -8(%rbp), %rbx # recupera rbx
    
    leave
    ret
    