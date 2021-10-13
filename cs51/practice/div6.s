	.file	"div6.c"
	.text
	.globl	notBCD
	.type	notBCD, @function
notBCD:
.LFB22:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$3, ret(%rip)
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE22:
	.size	notBCD, .-notBCD
	.globl	isBCD
	.type	isBCD, @function
isBCD:
.LFB23:
	.cfi_startproc
	cmpl	$9, %edi
	jg	.L8
	ret
.L8:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$0, %eax
	call	notBCD
	.cfi_endproc
.LFE23:
	.size	isBCD, .-isBCD
	.globl	notDIV2
	.type	notDIV2, @function
notDIV2:
.LFB24:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$1, ret(%rip)
	movl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE24:
	.size	notDIV2, .-notDIV2
	.globl	notDIV3
	.type	notDIV3, @function
notDIV3:
.LFB25:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2, ret(%rip)
	movl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE25:
	.size	notDIV3, .-notDIV3
	.globl	isDIV2
	.type	isDIV2, @function
isDIV2:
.LFB26:
	.cfi_startproc
	testb	$1, %dil
	jne	.L19
	ret
.L19:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$0, %eax
	call	notDIV2
	.cfi_endproc
.LFE26:
	.size	isDIV2, .-isDIV2
	.globl	isDIV3
	.type	isDIV3, @function
isDIV3:
.LFB27:
	.cfi_startproc
	movslq	%edi, %rax
	imulq	$1431655766, %rax, %rax
	shrq	$32, %rax
	movl	%edi, %edx
	sarl	$31, %edx
	subl	%edx, %eax
	leal	(%rax,%rax,2), %eax
	cmpl	%eax, %edi
	jne	.L26
	ret
.L26:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$0, %eax
	call	notDIV3
	.cfi_endproc
.LFE27:
	.size	isDIV3, .-isDIV3
	.globl	main
	.type	main, @function
main:
.LFB28:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movl	$1, (%rsp)
	movl	$2, 4(%rsp)
	movl	$7, 8(%rsp)
	movl	$5, 12(%rsp)
	movq	%rsp, %rbx
	leaq	16(%rsp), %r12
.L28:
	movl	(%rbx), %ebp
	movl	%ebp, %edi
	call	isBCD
	movl	%ebp, %edi
	call	isDIV2
	movl	%ebp, %edi
	call	isDIV3
	addq	$4, %rbx
	cmpq	%r12, %rbx
	jne	.L28
	movl	$0, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE28:
	.size	main, .-main
	.globl	ret
	.bss
	.align 4
	.type	ret, @object
	.size	ret, 4
ret:
	.zero	4
	.ident	"GCC: (Debian 10.3.0-9) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
