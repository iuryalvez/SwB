# compilar com gcc -no-pie -o find common.c compare.c find.S

.section rodata

.data

    # mapeamento _de estrutura
    .globl g0bj
    .align 4
    g0bj:
        .zero 24
            # char enabled = +0
            # guid_t
                # unsigned int part1 = +4
                # unsigned short part2 = +8
                # unsigned short part3 = +10
                # unsigned char part4[8] = +18
            # short pin = +20

.text

    .globl find
    find:

        pushq   %rbp
        movq    %rbp, %rsp

        subq    40, %rsp

        movl    $0, -4(%rbp) # int found = 0
        movw    $0, -8(%rbp) # short pin = 0
        movb    $0, -16(%rbp) # p4
        movw    $0, -18(%rbp) # p3 = 0
        movw    $0, -20(%rbp) # p2 = 0
        movl    $0, -24(%rbp) # p1 = 0
        movb    $0, -28(%rbp) # char enabled = 0
