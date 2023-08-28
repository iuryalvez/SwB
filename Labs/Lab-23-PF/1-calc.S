.text

.globl calc1
calc1:
    
    pushq %rbp
    movq %rsp, %rbp
    
    cvtss2sd %xmm1, %xmm2 # float b -> double b
    movsd %xmm2, %xmm3 # xmm3 -> double b
    addsd %xmm0, %xmm2 # (a+b)
    subsd %xmm3, %xmm0 # (a-b)
    mulsd %xmm2, %xmm0 # (%xmm2 = a+b)*(%xmm0 = a-b)
    
    leave
    ret
