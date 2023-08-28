.section .rodata

    fmt: .string "color: %ld, filled: %d\n"

.data

    .globl c1
    .align 8
    c1:
        .zero 24
            # x = +0
            # y = +4
            # filled = +8
            # color = +16

.text

    .globl main
    main:
        
        pushq   %rbp
        movq    %rsp, %rbp

        movq    $c1, %r8
        
        # c1.x = 10
        movl    $10, (%r8)

        # c1.y = 2 * c1.x
        movl    (%r8), %eax
        imull   $2, %eax
        movl    %eax, 4(%r8)

        # c1.filled = 1
        movb    $1, %r9b
        movb    %r9b, 8(%r8)

        movl    4(%r8), %r9d
        cmpl    $30, %r9d 
        jg  _ifTrue

        movb    8(%r8), %r10b
        cmpb    $1, %r10b
        jne _else

        _ifTrue:

            movq    $2, 16(%r8)
            jmp end_if

        _else:

            movq    $1, 16(%r8)

        end_if:

            # padrão do printf
            movq    $fmt, %rdi
            movq    16(%r8), %rsi
            movb    8(%r8), %r11b
            movsbl  %r11b, %edx

            movl    $0, %eax # nao tem ponto flutuante
            call printf

            movl    $0, %eax

            leave 
            ret
