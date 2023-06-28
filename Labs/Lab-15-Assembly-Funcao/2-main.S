.section rodata


.data

.globl i
.align 4
i: .long 0

.globl bias
.align 8
bias: .quad 256

.globl vet
vet: .byte 12, 3, 20, 8

.text

.globl main

main:

    pushq   %rbp

    movq    %rsp, %rbp

    # Código:

    movl $0, i
    
for:
    cmpl $4, i  # compara i com 4
    jge end_for # se i for maior ou igual que 4, vai pra endfor

    movq $vet, %r8 # passa o endereço do vet em r8
    movslq i, %r9  # move (para r9) e alarga (para quad) o i
    imulq $1, %r9  # r9 * sizeof(unsigned char)
    addq %r8, %r9  # soma o endereço do vet com i alargado (nosso índice variável)

    movb (%r9), %dil # pega o 
    movl $10, %esi
    movq bias, %rdx
    
    call filtro
    
    movq %rax, bias

    incl i
    
    jmp for

end_for:

    movq $0, %rax

    leave
    
    ret