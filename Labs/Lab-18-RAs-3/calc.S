.section .rodata

    fmt01:  .string "%d: sum = %ld\n" # formato do 1ª printf
    fmt02:  .string "retorno = %ld\n" # formato do 2º printf

.data

    .globl v
    .align 2
    v: .short 1,2,3,4,5

    .globl max
    .align 2
    max: .short 0

.text

    .globl calc
    calc:
        # registro _de ativação, salvando na pilha
        pushq   %rbp
        movq    %rsp, %rbp

        # r10w -> short value
        movl    $0, %r11d # int i = 0
        
        subq    $64, %rsp

        # salvando registradores
        movq    %r12, -8(%rbp)
        movq    %r13, -16(%rbp)
        movq    %r14, -24(%rbp)

        # long sum = 0
        movq    $0, r12 

        #; while (i < size)
        while01:
            cmpl %r11d, %esi #; compara i com size
            jle end_while01  #; se size for menor ou igual que i, encerra o while

            #; acessando a posição i de vet
            movq    %rsi, %r13  #; r13 aponta para o início do vetor %rsi (+0)
            movslq  %r11d, %r12 #; i = (short) i
            imulq   $2, %r12    #; i = i * sizeof(short)
            addq    %r12, %r13  #; r13 + i

            #; value = vet[i]
            movw    (%r13), %r10w 

            #; if (*max < value)
            if01: 
                cmpw    (%rcx), %r10w
                jle end_if01 #; se value for menor ou igual, não entra no if

                #; *max = value
                movw    %r10w, (%rcx)

            end_if01:

            #; sum = (long)(*max * (short)factor)


        end_while01:

        #; recuperando registradores
        movq    -8(rbp), %r12
        movq    -16(%rbp), %r13
        movq    -24(%rbp), %r14

        leave #; retira o RA da pilha
        ret   #; volta para o endereço anterior

    .globl main
    main:
        #; registro de ativação, salvando na pilha
        pushq   %rbp 
        movq    %rsp, %rbp
        
        #; sequência dos registradores: rdi, rsi, rdx, rcx, r8, r9
        #; chamando a função calc:

        movq    v, %rdi
        movl    $5, %esi
        movl    $2, %edx
        movq    $max, %rcx #; $ indica que é endereço de max
        movb    $1, %r8b
        
        #; como não utilizamos outros registradores, não precisamos salvá-los na pilha
        #; para ser recuperado depois da função
        #; agora podemos chamar a função calc

        call calc

        #; se tudo tiver ocorrido certo, podemos chamar a função printf

        movq    fmt02, %rdi #; primeiro parâmetro é o formato da string
        movq    %rax, %rsi  #; outros parâmetros ...
        movl    $0, %eax    #; zerar o %eax sempre antes de chamar a printf

        call printf

        movl    $0, %eax #; return 0;

        leave #; retirando da pilha o RA
        ret   #; encerra, retorna para o último endereço antes de chamar a main  
