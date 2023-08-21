.section .rodata

fmt: .string "Soma: %ld\n"

.data

    # Definição das variáveis aqui...

    .globl sum
    .align 8
    sum: .quad 0

    .globl vet
    .align 8
    vet: .quad 10, 20, 30, 40, 50

.text

.globl main

main:

    pushq   %rbp

    movq    %rsp, %rbp

    # Inicializações de 'i' e 'ptr' aqui...

    movl    $0, %ecx # incialização de i
    movq    $vet, %r8 # inicialização de ptr

beginwhile:

    cmpl    $5, %ecx # _cmp = %ecx - 5

    jge  endwhile      # while() {

    # Bloco do while aqui...

    movq    sum, %rax # rax = sum
    addq    (%r8), %rax # rax = rax + conteúdo de r8
    movq    %rax, sum # sum = eax

    addq    $8, %r8    # r8 é um endereco de memoria multiplo de 8
    incl    %ecx   

    jmp beginwhile     # }

endwhile:

    movq    $fmt, %rdi    # printf()

    movq    sum, %rsi

    movl    $0, %eax

    call printf

    movl    $0, %eax      # return 0

    leave

    ret