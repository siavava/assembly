	.file	"mult.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	mov	eax, 96
	ret
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.globl	mult
	.type	mult, @function
mult:
.LFB23:
	.cfi_startproc
	mov	eax, edi
	imul	eax, esi
	ret
	.cfi_endproc
.LFE23:
	.size	mult, .-mult
	.ident	"GCC: (Debian 10.3.0-11) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
