	.file	"main01.c"
	.text
	.globl	vet
	.data
	.align 16
	.type	vet, @object
	.size	vet, 28
vet:
	.long	1
	.long	2
	.long	3
	.long	0
	.long	4
	.long	5
	.long	0
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$7, %esi
	leaq	vet(%rip), %rax
	movq	%rax, %rdi
	call	show@PLT
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.1.1 20230429"
	.section	.note.GNU-stack,"",@progbits
