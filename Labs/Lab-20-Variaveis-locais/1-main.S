.section .rodata

    fmt: .string "Soma: %ld\n"

.text

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    
    # l -> -8(%rbp)
    # i -> -12(%rbp)
    # s -> -14(%rbp)

    subq $16, %rsp
    
    call constante
    
    movw %ax, %r9w # %r9w -> s // s = (short)constante();
    movw %r9w, -14(%rbp) # salvando s
    movw %r9w, %di
    
    leaq -8(%rbp), %rsi # %rsi = &l
    
    leaq -12(%rbp), %rdx # %rdx = &i
    
    call init
    
    movw -14(%rbp), %r9w # retornando s
    
    # printf
    movq $fmt, %rdi
    movq -8(%rbp), %rsi # %rsi = l
    movl -12(%rbp), %ecx # %ecx = i
    movslq %ecx, %rcx # cast (long)i
    addq %rcx, %rsi # %rsi = l + i
    movswq %r9w, %r9 # cast (long)s
    addq %r9, %rsi # %rsi = %rsi + s
    movl $0, %eax

    call printf
    
    movl $0, %eax
    leave
    ret
    