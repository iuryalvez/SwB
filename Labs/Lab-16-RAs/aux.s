	.file	"aux.c"
	.text
	.globl	x
	.data
	.align 8
	.type	x, @object
	.size	x, 8
x:
	.quad	10
	.section	.rodata
.LC0:
	.string	"Valor: x = %ld, i = %d\n"
	.text
	.globl	aux
	.type	aux, @function
aux:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$5, x(%rip)
	movq	x(%rip), %rax
	movl	-4(%rbp), %edx
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	x(%rip), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	aux, .-aux
	.ident	"GCC: (GNU) 13.1.1 20230429"
	.section	.note.GNU-stack,"",@progbits
