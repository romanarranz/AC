	.cstring
LC0:
	.ascii "Falta iteraciones\12\0"
LC1:
	.ascii "Error en la reserva de espacio para las matrices\0"
LC3:
	.ascii "Tiempo(seg.):%11.9f\12\0"
LC4:
	.ascii "Tama\303\261o total reservado por las matrices: %lu bytes\12\0"
LC5:
	.ascii "Tama\303\261o de las matrices: %ux%u -> %lu bytes\12\0"
LC6:
	.ascii "A[0][0] = %u ... A[N-1][N-1] = %u \12\0"
LC7:
	.ascii "\12----------- Matriz B ----------- \0"
LC8:
	.ascii "%u\11\0"
LC9:
	.ascii "\12----------- Matriz C ----------- \0"
LC10:
	.ascii "\12----------- Matriz A (Resultado) ----------- \0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB11:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB11:
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
	pushq	%rbx
LCFI5:
	movq	%rsi, %rbx
	subq	$88, %rsp
LCFI6:
	leaq	64(%rsp), %rdi
	call	_time
	movl	%eax, %edi
	call	_srand
	decl	%ebp
	jg	L2
	movq	___stderrp@GOTPCREL(%rip), %rax
	leaq	LC0(%rip), %rdi
	movq	(%rax), %rsi
	call	_fputs
	orl	$-1, %edi
	jmp	L49
L2:
	movq	8(%rbx), %rdi
	call	_atoi
	movslq	%eax, %r14
	leaq	0(,%r14,8), %rax
	movq	%r14, %rbx
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	_malloc
	movq	8(%rsp), %rdi
	movq	%rax, %rbp
	call	_malloc
	movq	8(%rsp), %rdi
	movq	%rax, %r13
	call	_malloc
	movq	%rax, %r12
	leaq	0(,%r14,4), %rax
	xorl	%r14d, %r14d
	movq	%rax, 16(%rsp)
	jmp	L3
L52:
	testq	%rax, %rax
	je	L36
L3:
	cmpl	%r14d, %ebx
	jle	L51
	movq	16(%rsp), %rdi
	call	_malloc
	movq	16(%rsp), %rdi
	movq	%rax, 0(%rbp,%r14,8)
	movq	%rax, 24(%rsp)
	call	_malloc
	movq	16(%rsp), %rdi
	movq	%rax, %r15
	movq	%rax, 0(%r13,%r14,8)
	call	_malloc
	movq	24(%rsp), %rcx
	movq	%rax, (%r12,%r14,8)
	incq	%r14
	testq	%rcx, %rcx
	sete	%cl
	testq	%r15, %r15
	sete	%dl
	orb	%dl, %cl
	je	L52
L36:
	leaq	LC1(%rip), %rdi
	call	_puts
	movl	$-2, %edi
L49:
	call	_exit
L51:
	xorl	%r14d, %r14d
L6:
	cmpl	%r14d, %ebx
	jle	L53
	xorl	%esi, %esi
L8:
	cmpl	%esi, %ebx
	jle	L54
	movq	0(%rbp,%r14,8), %rax
	leaq	0(,%rsi,4), %r15
	movq	%rsi, 32(%rsp)
	movl	$0, (%rax,%rsi,4)
	movq	%r15, %rax
	addq	0(%r13,%r14,8), %rax
	movq	%rax, 24(%rsp)
	call	_rand
	movl	$8, %ecx
	addq	(%r12,%r14,8), %r15
	cltd
	idivl	%ecx
	movq	24(%rsp), %rax
	movl	%edx, (%rax)
	call	_rand
	movl	$8, %ecx
	movq	32(%rsp), %rsi
	cltd
	idivl	%ecx
	incq	%rsi
	movl	%edx, (%r15)
	jmp	L8
L54:
	incq	%r14
	jmp	L6
L53:
	call	_mach_host_self
	leaq	60(%rsp), %rdx
	movl	$1, %esi
	movq	%rdx, 24(%rsp)
	leaq	72(%rsp), %r15
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	60(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	60(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	72(%rsp), %eax
	xorl	%ecx, %ecx
	cmpl	$4, %ebx
	movq	%rax, 32(%rsp)
	movslq	76(%rsp), %rax
	movq	%rax, 40(%rsp)
	jle	L10
L9:
	movq	0(%r13,%rcx,8), %r14
	xorl	%edx, %edx
	movq	0(%rbp,%rcx,8), %r11
L12:
	movl	(%r14,%rdx,4), %edi
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	movq	(%r12,%rdx,8), %rsi
L11:
	movl	(%rsi,%rax), %r10d
	addl	$4, %r8d
	movl	4(%rsi,%rax), %r9d
	imull	%edi, %r10d
	addl	(%r11,%rax), %r10d
	imull	%edi, %r9d
	addl	%r9d, %r10d
	movl	8(%rsi,%rax), %r9d
	imull	%edi, %r9d
	addl	%r9d, %r10d
	movl	12(%rsi,%rax), %r9d
	imull	%edi, %r9d
	addl	%r10d, %r9d
	movl	%r9d, (%r11,%rax)
	addq	$16, %rax
	cmpl	%ebx, %r8d
	jl	L11
	incq	%rdx
	cmpl	%edx, %ebx
	jg	L12
	incq	%rcx
	cmpl	%ecx, %ebx
	jg	L9
	testb	$3, %bl
	jne	L14
L20:
	call	_mach_host_self
	movq	24(%rsp), %rdx
	movl	$1, %esi
	movl	%ebx, %r14d
	movl	%eax, %edi
	imull	%ebx, %r14d
	call	_host_get_clock_service
	movl	60(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	60(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	72(%rsp), %eax
	leaq	LC3(%rip), %rdi
	subq	32(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movslq	76(%rsp), %rax
	subq	40(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	movb	$1, %al
	divsd	LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	_printf
	leal	(%r14,%r14,2), %esi
	xorl	%eax, %eax
	leaq	LC4(%rip), %rdi
	movslq	%esi, %rsi
	salq	$2, %rsi
	call	_printf
	movslq	%r14d, %rcx
	movl	%ebx, %edx
	movl	%ebx, %esi
	leaq	LC5(%rip), %rdi
	salq	$2, %rcx
	xorl	%eax, %eax
	call	_printf
	movq	8(%rsp), %rax
	leaq	LC6(%rip), %rdi
	movq	16(%rsp), %rcx
	movq	-8(%rbp,%rax), %rax
	movl	-4(%rax,%rcx), %edx
	movq	0(%rbp), %rax
	movl	(%rax), %esi
	xorl	%eax, %eax
	call	_printf
	cmpl	$3, %ebx
	jg	L16
	jmp	L55
L14:
	leal	-4(%rbx), %esi
	xorl	%edx, %edx
	salq	$2, %rsi
L17:
	movq	0(%r13,%rdx,8), %r9
	xorl	%eax, %eax
L19:
	movl	(%r9,%rax,4), %r10d
	xorl	%ecx, %ecx
L18:
	movq	(%r12,%rax,8), %r11
	leaq	(%rcx,%rsi), %r8
	addq	$4, %rcx
	movq	%r8, %rdi
	addq	0(%rbp,%rdx,8), %rdi
	movl	(%r11,%r8), %r14d
	imull	%r10d, %r14d
	addl	%r14d, (%rdi)
	cmpq	$16, %rcx
	jne	L18
	incq	%rax
	cmpl	%eax, %ebx
	jg	L19
	incq	%rdx
	cmpl	%edx, %ebx
	jg	L17
	jmp	L20
L22:
	movl	(%rdi,%rdx,4), %r10d
	xorl	%eax, %eax
	movq	(%r12,%rdx,8), %r9
L21:
	movl	(%r9,%rax,4), %r8d
	imull	%r10d, %r8d
	addl	%r8d, (%rsi,%rax,4)
	incq	%rax
	cmpl	%eax, %ebx
	jg	L21
	incq	%rdx
	cmpl	%edx, %ebx
	jg	L22
	incq	%rcx
L10:
	cmpl	%ecx, %ebx
	jle	L20
	movq	0(%r13,%rcx,8), %rdi
	xorl	%edx, %edx
	movq	0(%rbp,%rcx,8), %rsi
	jmp	L22
L16:
	xorl	%r14d, %r14d
	jmp	L23
L55:
	leaq	LC7(%rip), %rdi
	xorl	%r14d, %r14d
	call	_puts
L24:
	cmpl	%r14d, %ebx
	jle	L56
	xorl	%r15d, %r15d
L25:
	movq	0(%r13,%r14,8), %rax
	leaq	LC8(%rip), %rdi
	movl	(%rax,%r15,4), %esi
	xorl	%eax, %eax
	incq	%r15
	call	_printf
	cmpl	%r15d, %ebx
	jg	L25
	movl	$10, %edi
	incq	%r14
	call	_putchar
	jmp	L24
L56:
	leaq	LC9(%rip), %rdi
	xorl	%r14d, %r14d
	call	_puts
L26:
	cmpl	%r14d, %ebx
	jle	L57
	xorl	%r15d, %r15d
L27:
	movq	(%r12,%r14,8), %rax
	leaq	LC8(%rip), %rdi
	movl	(%rax,%r15,4), %esi
	xorl	%eax, %eax
	incq	%r15
	call	_printf
	cmpl	%r15d, %ebx
	jg	L27
	movl	$10, %edi
	incq	%r14
	call	_putchar
	jmp	L26
L57:
	leaq	LC10(%rip), %rdi
	xorl	%r14d, %r14d
	call	_puts
L28:
	cmpl	%r14d, %ebx
	jle	L16
	xorl	%r15d, %r15d
L29:
	movq	0(%rbp,%r14,8), %rax
	leaq	LC8(%rip), %rdi
	movl	(%rax,%r15,4), %esi
	xorl	%eax, %eax
	incq	%r15
	call	_printf
	cmpl	%r15d, %ebx
	jg	L29
	movl	$10, %edi
	incq	%r14
	call	_putchar
	jmp	L28
L23:
	cmpl	%r14d, %ebx
	jle	L58
	movq	0(%rbp,%r14,8), %rdi
	call	_free
	movq	0(%r13,%r14,8), %rdi
	call	_free
	movq	(%r12,%r14,8), %rdi
	incq	%r14
	call	_free
	jmp	L23
L58:
	movq	%rbp, %rdi
	call	_free
	movq	%r13, %rdi
	call	_free
	movq	%r12, %rdi
	call	_free
	addq	$88, %rsp
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
LCOLDE11:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTE11:
	.literal8
	.align 3
LC2:
	.long	0
	.long	1104006501
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
	.quad	LFB18-.
	.set L$set$2,LFE18-LFB18
	.quad L$set$2
	.byte	0
	.byte	0x4
	.set L$set$3,LCFI0-LFB18
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x8f
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.byte	0x18
	.byte	0x8e
	.byte	0x3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.byte	0x20
	.byte	0x8d
	.byte	0x4
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xe
	.byte	0x28
	.byte	0x8c
	.byte	0x5
	.byte	0x4
	.set L$set$7,LCFI4-LCFI3
	.long L$set$7
	.byte	0xe
	.byte	0x30
	.byte	0x86
	.byte	0x6
	.byte	0x4
	.set L$set$8,LCFI5-LCFI4
	.long L$set$8
	.byte	0xe
	.byte	0x38
	.byte	0x83
	.byte	0x7
	.byte	0x4
	.set L$set$9,LCFI6-LCFI5
	.long L$set$9
	.byte	0xe
	.byte	0x90,0x1
	.byte	0x4
	.set L$set$10,LCFI7-LCFI6
	.long L$set$10
	.byte	0xe
	.byte	0x38
	.byte	0x4
	.set L$set$11,LCFI8-LCFI7
	.long L$set$11
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$12,LCFI9-LCFI8
	.long L$set$12
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$13,LCFI10-LCFI9
	.long L$set$13
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$14,LCFI11-LCFI10
	.long L$set$14
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$15,LCFI12-LCFI11
	.long L$set$15
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$16,LCFI13-LCFI12
	.long L$set$16
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE1:
	.subsections_via_symbols
