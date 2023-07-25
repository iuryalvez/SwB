.section rodata

    .globl fmt
    fmt: .string "Soma: %ld\n"

.data

.text

    .globl main

    main:
        pushq   %rbp
        movq    %rbp, %rsp
        
        # short s
        movb    $0, %di # _ja vai ser passado como parametro

        subq    $32, %rsp

        movq    $0,   -4(%rbp)  # int i = 0
        movl    $0,   -16(%rbp) # long l = 0

        call constante
        movsbw  %al, %di

        # passando parametros

        leaq    -4(%rbp), %rsi
        leaq    -16(%rbp), %rdx
        movq    %rdi, -24(%rbp) # salvando rdi na pilha antes _da chamada

        call init       

        movswq  %di, %r12
        movslq  -4(%rbp), %rbx
        addq    %r12, %rbx
        addq    %rbx, -16(%rbp)

        movq    fmt, %rdi
        movq    -16(%rbp), %rsi
        
        call printf

        movl    $0, %eax
        leave
        ret
