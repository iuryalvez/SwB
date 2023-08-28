.section .rodata
    fmt1: .string "Objeto local igual!\n"
    fmt2: .string "Objeto global igual!\n"

.data
    .globl gObj # struct gObj;
    .align 4
    gObj:
    .zero 24 # 4

.text
.globl find
find:

    pushq %rbp
    movq %rsp, %rbp
    
    # -8(%rbp) == 1o parametro %rdi
    # -32(%rbp) == lObj
    # -44(%rbp) == pins
    # -48(%rbp) == i
    # -52(%rbp) == j
    # -56(%rbp) == found
    
    subq $64, %rsp
    
    movl $0, -56(%rbp) # found = 0
    movq %rdi, -8(%rbp) # salvando o parametro %rdi
    movq $gObj, %rdi # &gObj
    movl $0, %esi
    
    call init_obj
    movq -8(%rbp), %rdi # recuperando o parametro %rdi
    movq %rdi, -8(%rbp) # salvando o parametro %rdi
    leaq -32(%rbp), %rdi # &lObj
    movl $1, %esi
    
    call init_obj
    movq -8(%rbp), %rdi # recuperando o parametro %rdi
    movq %rdi, -8(%rbp) # salvando o parametro %rdi
    leaq -44(%rbp), %rdi # &pins
    call init_pins
    movq -8(%rbp), %rdi # recuperando o parametro %rdi
    
    # if1 (compare_guid(&lObj.id, id))
    movq %rdi, -8(%rbp) # salvando o parametro %rdi
    movq %rdi, %rsi # id
    leaq -28(%rbp), %rdi # &lObj.id
    
    call compare_guid
    
    movq -8(%rbp), %rdi # recuperando o parametro %rdi
    
    cmpl $0, %eax
    je end_if1
    movq %rdi, -8(%rbp) # salvando o parametro %rdi
    movq $fmt1, %rdi
    movl $0, %eax
    
    call printf
    movq -8(%rbp), %rdi # recuperando o parametro %rdi

end_if1:

    # if2 (compare_guid(id, &gObj.id))
    # não salvar mais rdi porque não precisa mais de id
    # id já está em rdi -> 1o. parâmetro
    movq $gObj, %rsi # &gObj.id
    
    call compare_guid
    
    cmpl $0, %eax
    je end_if2
    movq $fmt2, %rdi
    movl $0, %eax

    call printf

end_if2:

    # for externo
    movl $0, -48(%rbp) # i = 0

begin_for1:
    
    cmpl $2, -48(%rbp)
    jge end_for1
    
    # for interno
    movl $0, -52(%rbp) # j = 0
    
    begin_for2:

        cmpl $3, -52(%rbp)
        jge end_for2
    
        # if3
        # operação para acessar o indice correto
    
        movslq -48(%rbp), %r10 # pegando o valor de i
        imulq $2, %r10 # multiplica o valor de i, pelo tamanho do tipo de pins
        imulq $3, %r10 # multiplica pelo tamanho colunas de pins
        leaq -44(%rbp), %r8 # &pins
        addq %r10, %r8 # adiciona o valor do deslocamento ao endereco de pins

        movslq -52(%rbp), %r10 # pegando o valor de j
        imulq $2, %r10 # multiplica o valor de j, pelo tamanho do tipo de pins
        addq %r10, %r8 # adiciona o valor do deslocamento ao endereco de pins
        movw (%r8), %r9w # r9w = pins[i][j]
        movw -12(%rbp), %r10w # r10w = lObj.pin
    
        cmpw %r9w, %r10w
        jne end_if3
        movl $1, -56(%rbp) # found = 1
        jmp saida

end_if3:

    addl $1, -52(%rbp) # j++
    jmp begin_for2

end_for2:
 
    addl $1, -48(%rbp) # i++
    jmp begin_for1

end_for1:

saida:
    
    movl -56(%rbp), %eax # return found;
    leave
    ret
