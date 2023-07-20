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
    call main

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
        movl    $1, 8(%r8)

        cmpl    $30, 4(%r8) # if (c1.y > 30) c1.color = RED;
        jg  _ifTrue
        cmpb    $1, 8(%r8) # if (c1.filled == 1) c1.color = RED;
        jne _else

        _ifTrue:

            movl    $2, 16(%r8)
            jmp end_if

        _else:

            movl    $1, 16(%r8)

        end_if:

            # padrão do printf
            movq    $fmt, %rdi
            movq    16(%r8), %rsi
            movsbl  8(%r8), %edx

            movl    $0, %eax
            call printf

            movl    $0, %eax

            leave 
            ret
