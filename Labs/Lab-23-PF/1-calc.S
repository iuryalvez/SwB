# gcc -no-pie -o calc1 main1.c calc1.S

.section rodata

.data

.text

    .globl calc1
    calc1:
        pushq   %rbp
        movq    %rsp, %rbp

        # return (a+b)*(a-b)
        # passar o _a para outro registrador para fazer _a operação
        cvtssd2sd   %xmm1, %xmm1 # convertendo float p/ double
        movsd   %xmm0, %xmm10    # salvando o primeiro parâmetro

        # xmm10 = xmm10 + b   # a = a + b     
        addsd   %xmm1, %xmm10 # a = a + b

        movsd   %xmm0, %xmm11 # salvando o primeiro parâmetro
        subsd 


        leave
        ret
