.text
.globl calc
calc:
    pushq %rbp
    movq %rsp, %rbp

    # %r12 == i -> -8(%rbp)
    # %r13 == j -> -16(%rbp)
    # sum -> -20(%rbp)
    # vet1 -> -40(%rbp)
    # vet2 -> -50(%rbp)
    
    subq $64, %rsp
    
    # salvando registradores verdes
    movq %r12, -8(%rbp) # %r12 == i
    movq %r13, -16(%rbp) # %r13 == j
    movl $0, %r12d # i = 0
    movl $4, %r13d # j = 4
    leaq -40(%rbp), %rdi # endereço de vet1, primeiro parametro de filli
    
    movl $5, %esi # 5, segundo parametro
    movl %r12d, %edx # i, terceiro parametro
    call filli
    leaq -50(%rbp), %rdi # endereço de vet2, primeiro parametro de fills
    movl $5, %esi # 5, segundo parametro
    
    movl %r13d, %edx # j, terceiro parametro
    
    call fills
    
    movl $0, -20(%rbp) # sum = 0;
    
    begin_for:

        cmpl $5, %r12d 
        jge end_for
        
        # operação para acessar o indice correto
        
        leaq -40(%rbp), %rdx # endereço absoluto de vet1
        movslq %r12d, %r9 # %r9 == (long)i
        imulq $4, %r9 # multiplica o valor de i, pelo tamanho do tipo de vet1
        addq %r9, %rdx # adiciona o valor do deslocamento ao endereco de vet1
        movl (%rdx), %edi # %edi = vet1[i]
        
        # operação para acessar o indice correto
        leaq -50(%rbp), %rdx # endereço absoluto de vet2
        movslq %r13d, %r10 # %r10 == (long)j
        imulq $2, %r10 # multiplica o valor de j, pelo tamanho do tipo de vet2
        addq %r10, %rdx # adiciona o valor do deslocamento ao endereco de vet2
        
        movw (%rdx), %cx # %cx = vet2[j]
        
        movswl %cx, %ecx # cast %ecx = (int)%cx
        addl %edi, %ecx # vet1[i] + vet2[j]
        addl %ecx, -20(%rbp) # sum += vet1[i] + vet2[j]
        incl %r12d # i++
        decl %r13d # j--
        jmp begin_for

    end_for:

    # retornando registradores verdes
    movq -8(%rbp), %r12
    movq -16(%rbp), %r13
    movl -20(%rbp), %eax # return sum
    leave
    ret