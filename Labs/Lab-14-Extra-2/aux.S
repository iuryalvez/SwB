.section rodata

.data

    .globl v1
    .align 2
    v1: .word 32,34,27,4

    .globl v2
    .align 4
    v2: .int 12,22,31,23,6

    .globl v3
    .align 1
    v3: .byte 0,0,0,0

    .globl v4
    .align 8
    v4: .quad 0,0,0,0,0,0,0,0

    .globl i
    .align 4
    i: .int 8

    .globl j
    .align 2
    j: .word 0

.text

.globl aux
aux:
    pushq   %rbp
    movq    %rsp, %rbp

    movl    $0, i

start_for:
    
    cmpl    $4, i
    jge end_for

    movl    $0, j

start_while:

    cmpw    $5, j 
    jge end_while

    movl    i, %eax
    movswl  j, %edi
    cmpl    %edi, %eax # se (i == j)
    jne else01

    # acessar v1
    movq    $v1, %r8
    movslq  i, %r9
    imulq   $2, %r9
    addq    %r9, %r8

    # acessar v2
    movq    $v2, %r9
    movswq  j, %r10
    imulq   $4, %r10
    addq    %r10, %r9

    # somar
    movb    (%r8), %r11b
    addb    (%r9), %r11b # v1[i] + v2[j]

    # acessar v3
    movq    $v3, %rcx
    movslq  i, %rdx
    addq    %rdx, %rcx
    
    # passar valor p v3
    movb    %r11b, (%rcx)

    jmp end_if

else01:

    # acessar v1
    movq    $v1, %r8
    movslq  i, %r9
    imulq   $2, %r9
    addq    %r9, %r8

    # acessar v2
    movq    $v2, %r9
    movswq  j, %r10
    imulq   $4, %r10
    addq    %r10, %r9

    # somar
    movswq  (%r8), %r11
    movslq  (%r9), %rdx 
    addq    %rdx, %r11 # v1[i] + v2[j]

    # acessar v4[i+j]
    movq    $v4, %r10
    movslq  i, %rcx
    movswq  j, %rdx
    addq    %rdx, %rcx
    imulq   $8, %rcx

    addq    %r10, %rcx # %rcx = &v4[i+j]

    addq    %r11, (%rcx)

    jmp end_if

end_if:

    incw j
    jmp start_while

end_while:

    incl i
    jmp start_for

end_for:

    leave
    ret