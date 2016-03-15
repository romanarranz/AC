	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB1:
	.text
LHOTB1:
	.align 4,0x90
	.globl _daxpy
_daxpy:
LFB19:
	testl	%edi, %edi
	setle	%r9b
	jle	L1
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	setnp	%al
	cmovne	%r9d, %eax
	testb	%al, %al
	jne	L1
	cmpl	$1, %edx
	jne	L13
	xorl	%eax, %eax
	cmpl	$1, %r8d
	jne	L13
	.align 4,0x90
L14:
	movsd	(%rsi,%rax,8), %xmm1
	mulsd	%xmm0, %xmm1
	addsd	(%rcx,%rax,8), %xmm1
	movsd	%xmm1, (%rcx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %edi
	jg	L14
L1:
	ret
	.align 4,0x90
L13:
	xorl	%r9d, %r9d
	testl	%edx, %edx
	js	L19
L6:
	xorl	%eax, %eax
	testl	%r8d, %r8d
	js	L20
L7:
	movslq	%r8d, %r8
	cltq
	movslq	%edx, %rdx
	leaq	(%rcx,%rax,8), %rax
	movslq	%r9d, %r9
	salq	$3, %r8
	leaq	(%rsi,%r9,8), %rsi
	salq	$3, %rdx
	xorl	%ecx, %ecx
	.align 4,0x90
L8:
	movsd	(%rsi), %xmm1
	addl	$1, %ecx
	addq	%rdx, %rsi
	mulsd	%xmm0, %xmm1
	addsd	(%rax), %xmm1
	movsd	%xmm1, (%rax)
	addq	%r8, %rax
	cmpl	%ecx, %edi
	jg	L8
	ret
	.align 4,0x90
L20:
	movb	$1, %al
	subl	%edi, %eax
	imull	%r8d, %eax
	jmp	L7
	.align 4,0x90
L19:
	movb	$1, %r9b
	subl	%edi, %r9d
	imull	%edx, %r9d
	jmp	L6
LFE19:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE1:
	.text
LHOTE1:
	.cstring
LC2:
	.ascii "Falta iteraciones\12\0"
LC6:
	.ascii "Tiempo(seg.): %11.9f\12\0"
LC8:
	.ascii "Mflops: %11.2f\12\0"
LC9:
	.ascii "Gflops: %11.2f\12\0"
LC11:
	.ascii "GFLOPS/Computer: %f\12\0"
LC13:
	.ascii "GFLOPS/Core: %f\12\0"
LC14:
	.ascii "Rmax: %f\12\0"
LC15:
	.ascii "Nmax: %f\12\0"
LC17:
	.ascii "N1/2: %f\12\0"
LC18:
	.ascii "Rpico: %f GFLOPS\12\0"
	.align 3
LC19:
	.ascii "Error en la reserva de espacio para las matrices\0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB22:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB22:
	.align 4
	.globl _main
_main:
LFB18:
	pushq	%r15
LCFI0:
	pushq	%r14
LCFI1:
	pushq	%r13
LCFI2:
	pushq	%r12
LCFI3:
	pushq	%rbp
LCFI4:
	movl	%edi, %ebp
	xorl	%edi, %edi
	pushq	%rbx
LCFI5:
	movq	%rsi, %rbx
	subq	$56, %rsp
LCFI6:
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, %ebp
	jle	L30
	movq	8(%rbx), %rdi
	call	_atoi
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	movslq	%eax, %r12
	movl	%r12d, %edx
	movq	%r12, %rbx
	imull	%r12d, %edx
	cvtsi2sd	%edx, %xmm1
	movl	%edx, %eax
	imull	%r12d, %eax
	salq	$3, %r12
	movq	%r12, %rdi
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm1, %xmm1
	addsd	%xmm0, %xmm0
	divsd	LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsp)
	call	_malloc
	movq	%r12, %rdi
	movq	%rax, %rbp
	call	_malloc
	testq	%rax, %rax
	movq	%rax, %r12
	je	L23
	testq	%rbp, %rbp
	je	L23
	xorl	%r13d, %r13d
	testl	%ebx, %ebx
	jle	L25
	.align 4
L24:
	call	_rand
	pxor	%xmm0, %xmm0
	pxor	%xmm3, %xmm3
	cvtsi2ss	%eax, %xmm0
	mulss	LC20(%rip), %xmm0
	mulss	LC21(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm3
	movsd	%xmm3, 0(%rbp,%r13,8)
	call	_rand
	pxor	%xmm0, %xmm0
	pxor	%xmm4, %xmm4
	cvtsi2ss	%eax, %xmm0
	mulss	LC20(%rip), %xmm0
	mulss	LC21(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm4
	movsd	%xmm4, (%r12,%r13,8)
	addq	$1, %r13
	cmpl	%r13d, %ebx
	jg	L24
L25:
	call	_mach_host_self
	leaq	28(%rsp), %r14
	movl	$1, %esi
	leaq	32(%rsp), %r13
	movq	%r14, %rdx
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	28(%rsp), %edi
	movq	%r13, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	28(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movslq	36(%rsp), %rax
	movq	%r12, %rcx
	movq	%rbp, %rsi
	movsd	LC4(%rip), %xmm0
	movl	$1, %r8d
	movl	%ebx, %edi
	movl	$1, %edx
	movl	32(%rsp), %r15d
	movq	%rax, 8(%rsp)
	call	_daxpy
	call	_mach_host_self
	movq	%r14, %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	28(%rsp), %edi
	movq	%r13, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rdx
	movl	28(%rsp), %esi
	movl	(%rdx), %edi
	call	_mach_port_deallocate
	movl	32(%rsp), %eax
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	movsd	(%rsp), %xmm5
	leaq	LC6(%rip), %rdi
	movsd	LC5(%rip), %xmm2
	subq	%r15, %rax
	cvtsi2sdq	%rax, %xmm0
	movslq	36(%rsp), %rax
	subq	8(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %eax
	divsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	mulsd	%xmm1, %xmm2
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 8(%rsp)
	divsd	%xmm2, %xmm5
	movd	%xmm5, %rbp
	call	_printf
	movsd	8(%rsp), %xmm1
	movl	$1, %eax
	movsd	(%rsp), %xmm0
	leaq	LC8(%rip), %rdi
	mulsd	LC7(%rip), %xmm1
	divsd	%xmm1, %xmm0
	call	_printf
	movd	%rbp, %xmm0
	movl	$1, %eax
	leaq	LC9(%rip), %rdi
	call	_printf
	leaq	LC11(%rip), %rdi
	movl	$1, %eax
	movsd	LC10(%rip), %xmm0
	call	_printf
	leaq	LC13(%rip), %rdi
	movl	$1, %eax
	movsd	LC12(%rip), %xmm0
	call	_printf
	movd	%rbp, %xmm0
	movl	$1, %eax
	leaq	LC14(%rip), %rdi
	call	_printf
	movl	%ebx, %esi
	xorl	%eax, %eax
	leaq	LC15(%rip), %rdi
	call	_printf
	movd	%rbp, %xmm0
	movl	$1, %eax
	mulsd	LC16(%rip), %xmm0
	leaq	LC17(%rip), %rdi
	call	_printf
	leaq	LC18(%rip), %rdi
	movl	$1, %eax
	movsd	LC10(%rip), %xmm0
	call	_printf
	addq	$56, %rsp
LCFI7:
	xorl	%eax, %eax
	popq	%rbx
LCFI8:
	popq	%rbp
LCFI9:
	popq	%r12
LCFI10:
	popq	%r13
LCFI11:
	popq	%r14
LCFI12:
	popq	%r15
LCFI13:
	ret
L30:
LCFI14:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC2(%rip), %rdi
	movq	(%rax), %rcx
	call	_fwrite
	orl	$-1, %edi
	call	_exit
L23:
	leaq	LC19(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
LFE18:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE22:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTE22:
	.literal8
	.align 3
LC3:
	.long	0
	.long	1074266112
	.align 3
LC4:
	.long	0
	.long	1073741824
	.align 3
LC5:
	.long	0
	.long	1104006501
	.align 3
LC7:
	.long	0
	.long	1093567616
	.align 3
LC10:
	.long	2576980378
	.long	1076205977
	.align 3
LC12:
	.long	2576980378
	.long	1075157401
	.align 3
LC16:
	.long	0
	.long	1071644672
	.literal4
	.align 2
LC20:
	.long	805306368
	.align 2
LC21:
	.long	1084227584
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0
	.byte	0x1
	.ascii "zR\0"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 3
LECIE1:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB19-.
	.set L$set$2,LFE19-LFB19
	.quad L$set$2
	.byte	0
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$3,LEFDE3-LASFDE3
	.long L$set$3
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB18-.
	.set L$set$4,LFE18-LFB18
	.quad L$set$4
	.byte	0
	.byte	0x4
	.set L$set$5,LCFI0-LFB18
	.long L$set$5
	.byte	0xe
	.byte	0x10
	.byte	0x8f
	.byte	0x2
	.byte	0x4
	.set L$set$6,LCFI1-LCFI0
	.long L$set$6
	.byte	0xe
	.byte	0x18
	.byte	0x8e
	.byte	0x3
	.byte	0x4
	.set L$set$7,LCFI2-LCFI1
	.long L$set$7
	.byte	0xe
	.byte	0x20
	.byte	0x8d
	.byte	0x4
	.byte	0x4
	.set L$set$8,LCFI3-LCFI2
	.long L$set$8
	.byte	0xe
	.byte	0x28
	.byte	0x8c
	.byte	0x5
	.byte	0x4
	.set L$set$9,LCFI4-LCFI3
	.long L$set$9
	.byte	0xe
	.byte	0x30
	.byte	0x86
	.byte	0x6
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xe
	.byte	0x38
	.byte	0x83
	.byte	0x7
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xe
	.byte	0x70
	.byte	0x4
	.set L$set$12,LCFI7-LCFI6
	.long L$set$12
	.byte	0xa
	.byte	0xe
	.byte	0x38
	.byte	0x4
	.set L$set$13,LCFI8-LCFI7
	.long L$set$13
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$14,LCFI9-LCFI8
	.long L$set$14
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$15,LCFI10-LCFI9
	.long L$set$15
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$16,LCFI11-LCFI10
	.long L$set$16
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$17,LCFI12-LCFI11
	.long L$set$17
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$18,LCFI13-LCFI12
	.long L$set$18
	.byte	0xe
	.byte	0x8
	.byte	0x4
	.set L$set$19,LCFI14-LCFI13
	.long L$set$19
	.byte	0xb
	.align 3
LEFDE3:
	.subsections_via_symbols
