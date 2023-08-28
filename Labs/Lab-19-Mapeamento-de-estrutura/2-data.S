.section .rodata

    fmt: .string "%ld\n"
.data

.text

.globl show
show:

    pushq %rbp
    movq %rsp, %rbp

    # ptr -> -8(%rbp)
    # i -> -12(%rbp)
    # rdi -> -24(%rbp) parametro (struct data *d)

    subq $32, %rsp
    movq %rdi, %r8
    addq $8, %r8 # somando 8 ao endereço de d, para acessar d->elems
    
    # for
    movl $0, -12(%rbp) # i = 0
    
    begin_for:
        
        movl (%rdi), %eax # pegando o valor de d->len
        cmpl %eax, -12(%rbp) # if (i >= d->len) -> end
        jge end_for
        
        # operação para acessar o indice correto
        movslq -12(%rbp), %r10 # pegando o valor de i
        imulq $8, %r10 # multiplica o valor de i, pelo tamanho do tipo de ptr
        addq %r8, %r10 # adiciona o valor do deslocamento ao endereco de ptr
        # r10 = &ptr[i]
        
        # printf
        movq %rdi, -24(%rbp) # salva rdi
        movq %r8, -8(%rbp) # salva ptr
        
        movq (%r10), %rsi # move o valor do endereço de ptr[i] para o segundo parametro de printf

        movq $fmt, %rdi
        movl $0, %eax
        call printf
        movq -24(%rbp), %rdi
        movq -8(%rbp), %r8
        addl $1, -12(%rbp) # i++
        jmp begin_for

    end_for:
    
    leave
    ret
