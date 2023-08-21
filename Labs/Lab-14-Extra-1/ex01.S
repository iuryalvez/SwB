.section rodata

.data

    .globl vet
    .align 2
    vet: .word 50, 10, 67, 42

    .globl max
    .align 2
    max: .word 0

.text

.globl ex01
ex01:

    pushq   %rbp
    movq    %rsp, %rbp

    movb    $0, %al # char i = 0

start_for:

    cmpb    $4, %al # i - 4
    jge end_for

    # acessar vet[i]
    movq    $vet, %rcx
    movsbq  %al, %rdx
    imulq   $2, %rdx
    addq    %rdx, %rcx # rcx = &vet[i]

    movw    (%rcx), %di

    # se vet[i] maior q max
    cmpw    max, %di # %di - max
    jle end_if

    # max = vet[i]
    movw    %di, max    

end_if:

    incb %al
    jmp start_for # voltar para o _for

end_for:

    leave
    ret