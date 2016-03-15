	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB1:
	.text
LHOTB1:
	.globl _daxpy
_daxpy:
LFB19:
	testl	%edi, %edi
	setle	%r9b
	jle	L1
	xorps	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	setnp	%al
	cmovne	%r9d, %eax
	testb	%al, %al
	jne	L1
	cmpl	$1, %edx
	jne	L13
	xorl	%eax, %eax
	cmpl	$1, %r8d
	je	L14
L13:
	xorl	%eax, %eax
	testl	%edx, %edx
	jns	L6
	movb	$1, %al
	subl	%edi, %eax
	imull	%edx, %eax
L6:
	xorl	%r9d, %r9d
	testl	%r8d, %r8d
	jns	L7
	movb	$1, %r9b
	subl	%edi, %r9d
	imull	%r8d, %r9d
L7:
	cltq
	movslq	%r8d, %r8
	movslq	%r9d, %r9
	leaq	(%rsi,%rax,8), %rsi
	movslq	%edx, %rdx
	salq	$3, %r8
	leaq	(%rcx,%r9,8), %rcx
	salq	$3, %rdx
	xorl	%eax, %eax
L8:
	movsd	(%rsi), %xmm1
	incl	%eax
	addq	%rdx, %rsi
	mulsd	%xmm0, %xmm1
	addsd	(%rcx), %xmm1
	movsd	%xmm1, (%rcx)
	addq	%r8, %rcx
	cmpl	%edi, %eax
	jl	L8
	ret
L14:
	movsd	(%rsi,%rax,8), %xmm1
	mulsd	%xmm0, %xmm1
	addsd	(%rcx,%rax,8), %xmm1
	movsd	%xmm1, (%rcx,%rax,8)
	incq	%rax
	cmpl	%eax, %edi
	jg	L14
L1:
	ret
LFE19:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE1:
	.text
LHOTE1:
	.cstring
LC2:
	.ascii "Falta iteraciones\12\0"
LC4:
	.ascii "Error en la reserva de espacio para las matrices\0"
LC9:
	.ascii "Tiempo(seg.): %11.9f\12\0"
LC11:
	.ascii "Mflops: %11.2f\12\0"
LC12:
	.ascii "Gflops: %11.2f\12\0"
LC14:
	.ascii "GFLOPS/Computer: %f\12\0"
LC16:
	.ascii "GFLOPS/Core: %f\12\0"
LC17:
	.ascii "Rmax: %f\12\0"
LC18:
	.ascii "Nmax: %f\12\0"
LC20:
	.ascii "N1/2: %f\12\0"
LC21:
	.ascii "Rpico: %f GFLOPS\12\0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB22:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB22:
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
	decl	%ebp
	jg	L20
	movq	___stderrp@GOTPCREL(%rip), %rax
	leaq	LC2(%rip), %rdi
	movq	(%rax), %rsi
	call	_fputs
	orl	$-1, %edi
	jmp	L28
L20:
	movq	8(%rbx), %rdi
	call	_atoi
	movslq	%eax, %rbp
	movl	%ebp, %eax
	movq	%rbp, %rbx
	imull	%ebp, %eax
	cvtsi2sd	%eax, %xmm1
	movl	%eax, %edx
	imull	%ebp, %edx
	salq	$3, %rbp
	movq	%rbp, %rdi
	cvtsi2sd	%edx, %xmm0
	addsd	%xmm1, %xmm1
	addsd	%xmm0, %xmm0
	divsd	LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 16(%rsp)
	call	_malloc
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	_malloc
	testq	%rax, %rax
	movq	%rax, %r13
	je	L25
	xorl	%ebp, %ebp
	testq	%r12, %r12
	jne	L26
L25:
	leaq	LC4(%rip), %rdi
	call	_puts
	movl	$-2, %edi
L28:
	call	_exit
L26:
	cmpl	%ebp, %ebx
	jle	L29
	call	_rand
	cvtsi2ss	%eax, %xmm0
	mulss	LC5(%rip), %xmm0
	mulss	LC6(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm4
	movsd	%xmm4, (%r12,%rbp,8)
	call	_rand
	cvtsi2ss	%eax, %xmm0
	mulss	LC5(%rip), %xmm0
	mulss	LC6(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm5
	movsd	%xmm5, 0(%r13,%rbp,8)
	incq	%rbp
	jmp	L26
L29:
	call	_mach_host_self
	leaq	36(%rsp), %rbp
	movl	$1, %esi
	leaq	40(%rsp), %r15
	movq	%rbp, %rdx
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	36(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	36(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movslq	44(%rsp), %rax
	movq	%r13, %rcx
	movq	%r12, %rsi
	movsd	LC7(%rip), %xmm0
	movl	$1, %r8d
	movl	%ebx, %edi
	movl	$1, %edx
	movl	40(%rsp), %r14d
	movq	%rax, 8(%rsp)
	call	_daxpy
	call	_mach_host_self
	movq	%rbp, %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	36(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	36(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movslq	44(%rsp), %rdx
	leaq	LC9(%rip), %rdi
	subq	8(%rsp), %rdx
	movsd	LC8(%rip), %xmm2
	movl	40(%rsp), %eax
	movsd	16(%rsp), %xmm3
	cvtsi2sdq	%rdx, %xmm1
	subq	%r14, %rax
	cvtsi2sdq	%rax, %xmm0
	movb	$1, %al
	divsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	mulsd	%xmm1, %xmm2
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 24(%rsp)
	divsd	%xmm2, %xmm3
	movsd	%xmm3, 8(%rsp)
	call	_printf
	movsd	24(%rsp), %xmm1
	leaq	LC11(%rip), %rdi
	movb	$1, %al
	mulsd	LC10(%rip), %xmm1
	movsd	16(%rsp), %xmm0
	divsd	%xmm1, %xmm0
	call	_printf
	movsd	8(%rsp), %xmm0
	leaq	LC12(%rip), %rdi
	movb	$1, %al
	call	_printf
	leaq	LC14(%rip), %rdi
	movb	$1, %al
	movsd	LC13(%rip), %xmm0
	call	_printf
	leaq	LC16(%rip), %rdi
	movb	$1, %al
	movsd	LC15(%rip), %xmm0
	call	_printf
	movsd	8(%rsp), %xmm0
	leaq	LC17(%rip), %rdi
	movb	$1, %al
	call	_printf
	movl	%ebx, %esi
	xorl	%eax, %eax
	leaq	LC18(%rip), %rdi
	call	_printf
	movsd	8(%rsp), %xmm0
	leaq	LC20(%rip), %rdi
	movb	$1, %al
	mulsd	LC19(%rip), %xmm0
	call	_printf
	leaq	LC21(%rip), %rdi
	movb	$1, %al
	movsd	LC13(%rip), %xmm0
	call	_printf
	addq	$56, %rsp
LCFI7:
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
	.literal4
	.align 2
LC5:
	.long	805306368
	.align 2
LC6:
	.long	1084227584
	.literal8
	.align 3
LC7:
	.long	0
	.long	1073741824
	.align 3
LC8:
	.long	0
	.long	1104006501
	.align 3
LC10:
	.long	0
	.long	1093567616
	.align 3
LC13:
	.long	2576980378
	.long	1076205977
	.align 3
LC15:
	.long	2576980378
	.long	1075157401
	.align 3
LC19:
	.long	0
	.long	1071644672
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
	.align 3
LEFDE3:
	.subsections_via_symbols
