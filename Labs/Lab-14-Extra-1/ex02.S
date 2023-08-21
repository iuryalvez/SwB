.section rodata

.data

    .globl letters
    letters: .string "abcdefghij"

    .globl even
    .align 4
    even: .long 0

    .globl odd
    .align 4
    odd: .long 0

.text

.globl ex02
ex02:

    pushq   %rbp
    movq    %rsp, %rbp

    movl    $0, %eax # unsigned int count = 0

start_while:

    # acessar array na posicao eax
    movq    $letters, %rcx
    movslq  %eax, %rdx
    addq    %rdx, %rcx

    movb    (%rcx), %sil
    cmpb    $0, %sil
    je end_while
    
    # _if (letters[count] & 1)
    incl %eax
    andb    $1, %sil
    cmpb    $0, %sil
    je else01
    
    incl odd
    jmp start_while

else01:

    incl even
    jmp start_while

end_while:

    leave
    ret