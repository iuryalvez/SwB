.text

.globl collect
collect:

    pushq %rbp
    movq %rsp, %rbp
    
    subq $64, %rsp
    
    movq %rbx, -8(%rbp) # salva rbx
    movsd F0, %xmm1 # sum = xmm1 = 0.0
    movl $0, %ebx # i = ebx = 0
    movq %rdi, -16(%rbp) # salva ptr
    movss %xmm0, -20(%rbp) # salva limit
    movl %esi, -24(%rbp) # salva count
    movss %xmm1, -52(%rbp) # salva sum
    leaq -48(%rbp), %rdi # rdi = &t
    
    call t_init
    
    movq -16(%rbp), %rdi # recupera ptr
    movss -20(%rbp), %xmm0 # recupera limit
    movl -24(%rbp), %esi # recupera count
    movss -52(%rbp), %xmm1 # recupera sum
    
    begin_while:
    cmpl %esi, %ebx # if (i >= count) -> end_while
    jge end_while
    
    # _if (ptr[i].sum < limit)
    movq %rdi, %r8 # r8 = ptr
    movslq %ebx, %r9 # r9 = (long)i
    imulq $8, %r9 # r9 = r9 * sizeof(data)
    addq %r8, %r9 # r9 = &ptr[i]
    movss (%r9), %xmm4 # xmm4 = ptr[i].sum
    
    ucomisd %xmm0, %xmm4 # if (ptr[i].sum >= limit) -> else_if
    jae else_if
    cvtsi2ss -32(%rbp), %xmm3 # xmm3 = (float)t.repeated
    mulss (%r9), %xmm3 # xmm3 = (float)t.repeated * ptr[i].sum
    addss %xmm3, %xmm1 # sum = sum + xmm3
    jmp end_if
    
    else_if:

    movq %rdi, -16(%rbp) # salva ptr
    
    movss %xmm0, -20(%rbp) # salva limit
    
    movl %esi, -24(%rbp) # salva count

    movss %xmm1, -52(%rbp) # salva sum
    movq $fmt, %rdi # 1o. param (string)
    cvtss2sd %xmm0, %xmm1 # 3o. param (limit)
    cvtss2sd (%r9), %xmm0 # 2o. param (ptr[i].sum)
    
    # count = esi # 4o. param (count)
    movl $2, %eax # imprime 2 FP
    
    call printf
    
    movq -16(%rbp), %rdi # recupera ptr
    movss -20(%rbp), %xmm0 # recupera limit
    movl -24(%rbp), %esi # recupera count
    movss -52(%rbp), %xmm1 # recupera sum
    incl 4(%r9) # ptr[i].fail++
    
    end_if:

    incl %ebx # i++
    jmp begin_while
    
    end_while:

    movq -8(%rbp), %rbx # recupera rbx
    movss %xmm1, %xmm0 # return sum
    
    leave
    ret
