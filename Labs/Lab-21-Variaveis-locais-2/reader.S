.section .rodata
    fmt0: .string "id1 = %d, id2 = %d, id3 = %d\n"
    fmt1: .string "Person ID: %ld\n"
    fmt2: .string "tipo = %d, ID = %ld, nome = '%s', idade = %d\n"
    fmt3: .string "tipo = %d, ID = %ld, nome = '%s', cor = '%s'\n"

.text

.globl reader
reader:

    pushq %rbp
    movq %rsp, %rbp
    
    # pilha ---> 0
    # -36 ---> p
    # -76 ---> c[1]
    # -116 ---> c[0]
    # -120 ---> id1
    # -124 ---> id2
    # -128 ---> id3
    # -136 ---> %rdi parametro verbose
    
    subq $144, %rsp

    movq %rdi, -136(%rbp) # salvando o parametro verbose
    leaq -36(%rbp), %rdi # 1o parametro
    leaq -120(%rbp), %rsi # 2o parametro
    call readPerson

    leaq -116(%rbp), %rdi # 1o parametro
    leaq -124(%rbp), %rsi # 2o parametro
    call readCar
    
    leaq -76(%rbp), %rdi # 1o parametro
    leaq -128(%rbp), %rsi # 2o parametro
    call readCar

    movq -136(%rbp), %rdi
    cmpq $0, %rdi
    je end_if
    
    # printf
    movq $fmt0, %rdi
    movl -120(%rbp), %esi # 2o parametro
    movl -124(%rbp), %edx # 3o parametro
    movl -128(%rbp), %ecx # 4o parametro
    movl $0, %eax
    call printf

    # printf
    movq $fmt1, %rdi
    leaq -28(%rbp), %r8 # %r8 == &p.ID
    movq (%r8), %rsi # 2o parametro
    movl $0, %eax
    call printf

end_if:

    leaq -36(%rbp), %rdi # &p
    call showPerson

    leaq -116(%rbp), %rdi # &c[0]
    call showCar

    leaq -76(%rbp), %rdi # &c[1]
    call showCar

    leave
    ret

.globl showPerson
showPerson:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r10
    movq $fmt2, %rdi
    movl (%r10), %esi
    movq 8(%r10), %rdx
    movq %r10, %r11
    addq $16, %r11
    movq %r11, %rcx
    movl 32(%r10), %r8d
    movl $0, %eax
    call printf

    leave
    ret

.globl showCar
showCar:

    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %r10
    movq $fmt3, %rdi
    movl (%r10), %esi
    movq 8(%r10), %rdx
    movq %r10, %r11
    addq $16, %r11
    movq %r11, %rcx

    movq %r10, %r11
    addq $32, %r11
    movq %r11, %r8
    movl $0, %eax
    
    call printf

    leave
    ret
