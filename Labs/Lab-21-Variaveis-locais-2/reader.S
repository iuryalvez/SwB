#; gcc -no-pie -o reader main.c aux.c reader.S

.section rodata

.data

.text

    .globl
    reader:

        # registro _de ativação 
        pushq   %rbp
        movq    %rbp, %rsp

        subq    $144, %rsp
        movq    $0, -4(%rbp)  # int id1 
        movq    $0, -8(%rbp)  # int id2
        movq    $0, -12(%rbp) # int id3
        

        
        movq    %rdi, -144(%rbp)



    .globl
    showPerson:

    .globl
    showCar:


