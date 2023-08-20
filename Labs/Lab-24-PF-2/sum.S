# gcc -no-pie -o sum main1.c sum.S

.section .rodata

    fmt: "Soma %f maior que o limite %f (%d)\n"

    # declarar o double (float também) como constante
    .align 8
        sz: .double 0.0

.data

.text

    .globl sum
    sum: 
        # tem um parâmetro double (xmm0)
        pushq   %rbp
        movq    %rsp, %rbp

        # valor total _de memória _a ser utilizada
        subq    $80, %rsp

        # int i = 4
        movl    $4, -4(%rbp)

        # double s = 0.0
        movq    sz, -16(%rbp)

        # salvando vetor vi
        movl    $8, -20(%rbp)
        movl    $7, -24(%rbp)
        movl    $6, -28(%rbp)
        movl    $5, -32(%rbp)

        movsd   %xmm0, -72(%rbp) # salvando meu primeiro parâmetro

        # passando os parâmetros _da mult
        leaq    -32(%rbp), %rdi
        leaq    -64(%rbp), %rsi
        movl    -4(%rbp), %edx

        call mult

        movsd   -72(%rbp), %xmm0

        while01:
            compl   $0, -4(%rbp) # 0 - i = ?
            jle     end_while01  # se i for menor ou igual _a 0 pula pro end

            # i--
            decl    -4(%rbp)

            # acessando vetor
            leaq    -64(%rbp), %r8
            movlsq  -4(%rbp), %r9
            imulq   $8, %r9
            addq    %r9, %r8

            # s += vd[--i]
            movsd   (%r8), %xmm1
            movsd   -16(%rbp), %xmm2
            addsd   %xmm1, %xmm2
            movsd   %xmm2, -16(%rbp)

            # if (s > limit)
            # xmm1 -> limit
            # xmm2 -> s 
            ucomisd %xmm1, %xmm2
            jbe     end_if01

            # salvando limit
            movsd   %xmm0, -72(%rbp)

            movq    $fmt, %rdi
            movsd   %xmm0, %xmm1
            movsd   -16(%rbp), %xmm0
            movl    -4(%rbp), %esi
            movl    $2, %eax
            call printf

            movsd   -72(%rbp), %xmm0
            
            end_if01:

            jmp     while 01

        end_while01:

        leave
        ret
