	.text
	.globl _daxpy
_daxpy:
LFB19:
	testl	%edi, %edi
	jle	L16
	pxor	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	setnp	%al
	movl	$0, %r9d
	cmovne	%r9d, %eax
	testb	%al, %al
	jne	L16
	cmpl	$1, %edx
	jne	L3
	cmpl	$1, %r8d
	jne	L3
	movl	$0, %eax
	testl	%edi, %edi
	jg	L11
	ret
L3:
	movl	$0, %eax
	testl	%edx, %edx
	jns	L5
	movb	$1, %al
	subl	%edi, %eax
	imull	%edx, %eax
L5:
	movl	$0, %r9d
	testl	%r8d, %r8d
	jns	L6
	movb	$1, %r9b
	subl	%edi, %r9d
	imull	%r8d, %r9d
L6:
	testl	%edi, %edi
	jle	L16
	pushq	%rbx
LCFI0:
	movl	$0, %r10d
L7:
	movslq	%r9d, %r11
	leaq	(%rcx,%r11,8), %r11
	movslq	%eax, %rbx
	movapd	%xmm0, %xmm1
	mulsd	(%rsi,%rbx,8), %xmm1
	addsd	(%r11), %xmm1
	movsd	%xmm1, (%r11)
	addl	%edx, %eax
	addl	%r8d, %r9d
	addl	$1, %r10d
	cmpl	%edi, %r10d
	jne	L7
	jmp	L1
L11:
LCFI1:
	movapd	%xmm0, %xmm1
	mulsd	(%rsi,%rax,8), %xmm1
	addsd	(%rcx,%rax,8), %xmm1
	movsd	%xmm1, (%rcx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %edi
	jg	L11
	ret
L1:
LCFI2:
	popq	%rbx
LCFI3:
L16:
	ret
LFE19:
	.cstring
LC1:
	.ascii "Falta iteraciones\12\0"
	.align 3
LC3:
	.ascii "Error en la reserva de espacio para las matrices\0"
LC8:
	.ascii "Tiempo(seg.): %11.9f\12\0"
LC10:
	.ascii "Mflops: %11.2f\12\0"
LC11:
	.ascii "Gflops: %11.2f\12\0"
LC13:
	.ascii "GFLOPS/Computer: %f\12\0"
LC15:
	.ascii "GFLOPS/Core: %f\12\0"
LC16:
	.ascii "Rmax: %f\12\0"
LC17:
	.ascii "Nmax: %f\12\0"
LC19:
	.ascii "N1/2: %f\12\0"
LC20:
	.ascii "Rpico: %f GFLOPS\12\0"
	.section __TEXT,__text_startup,regular,pure_instructions
	.globl _main
_main:
LFB18:
	pushq	%r15
LCFI4:
	pushq	%r14
LCFI5:
	pushq	%r13
LCFI6:
	pushq	%r12
LCFI7:
	pushq	%rbp
LCFI8:
	pushq	%rbx
LCFI9:
	subq	$40, %rsp
LCFI10:
	movl	%edi, %ebp
	movq	%rsi, %rbx
	movl	$0, %edi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, %ebp
	jg	L18
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC1(%rip), %rdi
	call	_fwrite
	movl	$-1, %edi
	call	_exit
L18:
	movq	8(%rbx), %rdi
	call	_atoi
	movl	%eax, %ebx
	movl	%eax, %edx
	imull	%eax, %edx
	movl	%edx, %eax
	imull	%ebx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm0, %xmm0
	divsd	LC2(%rip), %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sd	%edx, %xmm1
	addsd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsp)
	movslq	%ebx, %r12
	salq	$3, %r12
	movq	%r12, %rdi
	call	_malloc
	movq	%rax, %rbp
	movq	%r12, %rdi
	call	_malloc
	movq	%rax, %r12
	testq	%rax, %rax
	je	L19
	testq	%rbp, %rbp
	je	L19
	movl	$0, %r13d
	testl	%ebx, %ebx
	jg	L23
	jmp	L21
L19:
	leaq	LC3(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L23:
	call	_rand
	pxor	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	LC4(%rip), %xmm0
	mulss	LC5(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm3
	movsd	%xmm3, 0(%rbp,%r13,8)
	call	_rand
	pxor	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	mulss	LC4(%rip), %xmm0
	mulss	LC5(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm4
	movsd	%xmm4, (%r12,%r13,8)
	addq	$1, %r13
	cmpl	%r13d, %ebx
	jg	L23
L21:
	call	_mach_host_self
	leaq	28(%rsp), %r14
	movq	%r14, %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	leaq	16(%rsp), %r13
	movq	%r13, %rsi
	movl	28(%rsp), %edi
	call	_clock_get_time
	movl	28(%rsp), %esi
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	16(%rsp), %r15d
	movslq	20(%rsp), %rax
	movq	%rax, 8(%rsp)
	movl	$1, %r8d
	movq	%r12, %rcx
	movl	$1, %edx
	movq	%rbp, %rsi
	movsd	LC6(%rip), %xmm0
	movl	%ebx, %edi
	call	_daxpy
	call	_mach_host_self
	movq	%r14, %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	movq	%r13, %rsi
	movl	28(%rsp), %edi
	call	_clock_get_time
	movl	28(%rsp), %esi
	movq	_mach_task_self_@GOTPCREL(%rip), %rdx
	movl	(%rdx), %edi
	call	_mach_port_deallocate
	movl	16(%rsp), %eax
	subq	%r15, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movslq	20(%rsp), %rax
	subq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	LC7(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rbp
	mulsd	%xmm1, %xmm2
	movsd	(%rsp), %xmm5
	divsd	%xmm2, %xmm5
	movd	%xmm5, %r12
	movapd	%xmm1, %xmm0
	leaq	LC8(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movd	%rbp, %xmm0
	mulsd	LC9(%rip), %xmm0
	movsd	(%rsp), %xmm5
	divsd	%xmm0, %xmm5
	movapd	%xmm5, %xmm0
	leaq	LC10(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movd	%r12, %xmm0
	leaq	LC11(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movsd	LC12(%rip), %xmm0
	leaq	LC13(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movsd	LC14(%rip), %xmm0
	leaq	LC15(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movd	%r12, %xmm0
	leaq	LC16(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movl	%ebx, %esi
	leaq	LC17(%rip), %rdi
	movl	$0, %eax
	call	_printf
	movd	%r12, %xmm0
	mulsd	LC18(%rip), %xmm0
	leaq	LC19(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movsd	LC12(%rip), %xmm0
	leaq	LC20(%rip), %rdi
	movl	$1, %eax
	call	_printf
	addq	$40, %rsp
LCFI11:
	popq	%rbx
LCFI12:
	popq	%rbp
LCFI13:
	popq	%r12
LCFI14:
	popq	%r13
LCFI15:
	popq	%r14
LCFI16:
	popq	%r15
LCFI17:
	ret
LFE18:
	.literal8
	.align 3
LC2:
	.long	0
	.long	1074266112
	.literal4
	.align 2
LC4:
	.long	805306368
	.align 2
LC5:
	.long	1084227584
	.literal8
	.align 3
LC6:
	.long	0
	.long	1073741824
	.align 3
LC7:
	.long	0
	.long	1104006501
	.align 3
LC9:
	.long	0
	.long	1093567616
	.align 3
LC12:
	.long	2576980378
	.long	1076205977
	.align 3
LC14:
	.long	2576980378
	.long	1075157401
	.align 3
LC18:
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
	.byte	0x4
	.set L$set$3,LCFI0-LFB19
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x83
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.byte	0x8
	.byte	0xc3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.byte	0x10
	.byte	0x83
	.byte	0x2
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xc3
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$7,LEFDE3-LASFDE3
	.long L$set$7
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB18-.
	.set L$set$8,LFE18-LFB18
	.quad L$set$8
	.byte	0
	.byte	0x4
	.set L$set$9,LCFI4-LFB18
	.long L$set$9
	.byte	0xe
	.byte	0x10
	.byte	0x8f
	.byte	0x2
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xe
	.byte	0x18
	.byte	0x8e
	.byte	0x3
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xe
	.byte	0x20
	.byte	0x8d
	.byte	0x4
	.byte	0x4
	.set L$set$12,LCFI7-LCFI6
	.long L$set$12
	.byte	0xe
	.byte	0x28
	.byte	0x8c
	.byte	0x5
	.byte	0x4
	.set L$set$13,LCFI8-LCFI7
	.long L$set$13
	.byte	0xe
	.byte	0x30
	.byte	0x86
	.byte	0x6
	.byte	0x4
	.set L$set$14,LCFI9-LCFI8
	.long L$set$14
	.byte	0xe
	.byte	0x38
	.byte	0x83
	.byte	0x7
	.byte	0x4
	.set L$set$15,LCFI10-LCFI9
	.long L$set$15
	.byte	0xe
	.byte	0x60
	.byte	0x4
	.set L$set$16,LCFI11-LCFI10
	.long L$set$16
	.byte	0xe
	.byte	0x38
	.byte	0x4
	.set L$set$17,LCFI12-LCFI11
	.long L$set$17
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$18,LCFI13-LCFI12
	.long L$set$18
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$19,LCFI14-LCFI13
	.long L$set$19
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$20,LCFI15-LCFI14
	.long L$set$20
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$21,LCFI16-LCFI15
	.long L$set$21
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$22,LCFI17-LCFI16
	.long L$set$22
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE3:
	.subsections_via_symbols
