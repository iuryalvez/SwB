.section .rodata

fmt:    .string "%d\n"

.text

.globl show

show:

    pushq   %rbp
    movq    %rsp, %rbp

    movl    $1, %ecx
for01:
    cmpl    %esi, %ecx # if (i >= size)
    jge     end_for01

    

    call printf

    incl    %ecx
    jmp     for01

end_for01:

    leave
    ret
