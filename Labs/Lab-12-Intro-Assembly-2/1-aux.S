.data

# Definição da variável 'str' aqui...
.globl str
str: .string "BEBAMUITOCAFE"

.text
.globl process

process:

    pushq %rbp

    movq  %rsp, %rbp

   # Inicialização de 'ptr' aqui...

    movq $str, %r8 # o endereço inicial de str é passado para r8

   # ptr = str

beginwhile:

    cmpb $0, (%r8) # _cmp = (%r8) - 0

    je endwhile            # while() {
        
    # Bloco do while

    movb (%r8), %al # passa o conteúdo de r8 para um registrador de tamanho de 1 byte
    addb $32, %al # soma 32 no al
    movb %al, (%r8) # devolve o valor para o endereço de r8
    
    addq $1, %r8 # atualiza r8 para o próximo

    jmp beginwhile         # }

endwhile:

    leave

    ret