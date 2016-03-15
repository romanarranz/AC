	.cstring
LC0:
	.ascii "Falta iteraciones\12\0"
	.align 3
LC1:
	.ascii "Error en la reserva de espacio para las matrices\0"
LC3:
	.ascii "Tiempo(seg.):%11.9f\12\0"
	.align 3
LC4:
	.ascii "Tama\303\261o total reservado por las matrices: %lu bytes\12\0"
	.align 3
LC5:
	.ascii "Tama\303\261o de las matrices: %ux%u -> %lu bytes\12\0"
	.align 3
LC6:
	.ascii "A[0][0] = %u ... A[N-1][N-1] = %u \12\0"
	.align 3
LC7:
	.ascii "\12----------- Matriz B ----------- \0"
LC8:
	.ascii "%u\11\0"
	.align 3
LC9:
	.ascii "\12----------- Matriz C ----------- \0"
	.align 3
LC10:
	.ascii "\12----------- Matriz A (Resultado) ----------- \0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB11:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB11:
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
	pushq	%rbx
LCFI5:
	movq	%rsi, %rbx
	subq	$104, %rsp
LCFI6:
	leaq	88(%rsp), %rdi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, %ebp
	jle	L65
	movq	8(%rbx), %rdi
	call	_atoi
	cltq
	movq	%rax, %r14
	movq	%rax, 32(%rsp)
	salq	$3, %rax
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%rax, 40(%rsp)
	call	_malloc
	movq	%rbx, %rdi
	movq	%rax, (%rsp)
	call	_malloc
	movq	%rbx, %rdi
	movq	%rax, %r15
	movq	%rax, 16(%rsp)
	call	_malloc
	testl	%r14d, %r14d
	movq	%rax, %rbx
	jle	L3
	leaq	0(,%r14,4), %r12
	xorl	%ebp, %ebp
	movl	%r14d, 8(%rsp)
	.align 4
L6:
	movq	%r12, %rdi
	call	_malloc
	movq	%r12, %rdi
	movq	%rax, %r13
	movq	(%rsp), %rax
	movq	%r13, (%rax,%rbp,8)
	call	_malloc
	movq	%r12, %rdi
	movq	%rax, (%r15,%rbp,8)
	movq	%rax, %r14
	call	_malloc
	testq	%r13, %r13
	sete	%sil
	testq	%r14, %r14
	movq	%rax, %rdx
	movq	%rax, (%rbx,%rbp,8)
	sete	%al
	orb	%al, %sil
	jne	L36
	testq	%rdx, %rdx
	je	L36
	addq	$1, %rbp
	cmpl	%ebp, 8(%rsp)
	jg	L6
	movl	8(%rsp), %r14d
	xorl	%r15d, %r15d
	movq	%rbx, 8(%rsp)
	.align 4
L7:
	movq	(%rsp), %rax
	xorl	%ebx, %ebx
	movq	(%rax,%r15,8), %r13
	movq	16(%rsp), %rax
	movq	(%rax,%r15,8), %r12
	movq	8(%rsp), %rax
	movq	(%rax,%r15,8), %rbp
	.align 4
L8:
	movl	$0, 0(%r13,%rbx,4)
	call	_rand
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%ecx, %eax
	andl	$7, %eax
	subl	%ecx, %eax
	movl	%eax, (%r12,%rbx,4)
	call	_rand
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%ecx, %eax
	andl	$7, %eax
	subl	%ecx, %eax
	movl	%eax, 0(%rbp,%rbx,4)
	addq	$1, %rbx
	cmpl	%ebx, %r14d
	jg	L8
	addq	$1, %r15
	cmpl	%r15d, %r14d
	jg	L7
	movq	8(%rsp), %rbx
	leaq	80(%rsp), %r15
	call	_mach_host_self
	leaq	76(%rsp), %rdi
	movl	$1, %esi
	movq	%rdi, %rdx
	movq	%rdi, 24(%rsp)
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	76(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rbp
	movl	76(%rsp), %esi
	movl	0(%rbp), %edi
	call	_mach_port_deallocate
	movl	80(%rsp), %eax
	cmpl	$4, %r14d
	movslq	84(%rsp), %r9
	movq	%rax, 8(%rsp)
	jle	L66
	movq	%rbp, 56(%rsp)
	movq	16(%rsp), %r12
	xorl	%r13d, %r13d
	movq	(%rsp), %rbp
	movq	%r9, 48(%rsp)
L34:
	movq	(%r12,%r13,8), %r11
	xorl	%r10d, %r10d
	movq	0(%rbp,%r13,8), %r9
	.align 4
L12:
	movl	(%r11,%r10,4), %esi
	xorl	%edx, %edx
	xorl	%edi, %edi
	movq	(%rbx,%r10,8), %rcx
	.align 4
L11:
	movl	(%rcx,%rdx), %r8d
	addl	$4, %edi
	movl	4(%rcx,%rdx), %eax
	imull	%esi, %r8d
	addl	(%r9,%rdx), %r8d
	imull	%esi, %eax
	addl	%r8d, %eax
	movl	8(%rcx,%rdx), %r8d
	imull	%esi, %r8d
	addl	%eax, %r8d
	movl	12(%rcx,%rdx), %eax
	imull	%esi, %eax
	addl	%r8d, %eax
	movl	%eax, (%r9,%rdx)
	addq	$16, %rdx
	cmpl	%edi, %r14d
	jg	L11
	addq	$1, %r10
	cmpl	%r10d, %r14d
	jg	L12
	addq	$1, %r13
	cmpl	%r13d, %r14d
	jg	L34
	testb	$3, %r14b
	movq	48(%rsp), %r9
	movq	56(%rsp), %rbp
	je	L10
	movq	16(%rsp), %r13
	leal	-4(%r14), %r10d
	xorl	%r12d, %r12d
	movslq	%r10d, %r10
	salq	$2, %r10
L14:
	movq	(%rsp), %rax
	movq	%r10, %rdx
	xorl	%esi, %esi
	movq	0(%r13,%r12,8), %r11
	addq	(%rax,%r12,8), %rdx
	.align 4
L16:
	movq	%r10, %rdi
	movl	(%r11,%rsi,4), %r8d
	xorl	%eax, %eax
	addq	(%rbx,%rsi,8), %rdi
L15:
	movl	(%rdi,%rax), %ecx
	imull	%r8d, %ecx
	addl	%ecx, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$16, %rax
	jne	L15
	addq	$1, %rsi
	cmpl	%esi, %r14d
	jg	L16
	addq	$1, %r12
	cmpl	%r12d, %r14d
	jg	L14
L10:
	movq	%r9, 48(%rsp)
	call	_mach_host_self
	movq	24(%rsp), %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	76(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movl	76(%rsp), %esi
	movl	0(%rbp), %edi
	movl	%r14d, %ebp
	imull	%r14d, %ebp
	call	_mach_port_deallocate
	movl	80(%rsp), %eax
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	subq	8(%rsp), %rax
	leaq	LC3(%rip), %rdi
	movq	48(%rsp), %r9
	cvtsi2sdq	%rax, %xmm1
	movslq	84(%rsp), %rax
	subq	%r9, %rax
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	divsd	LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	_printf
	leal	0(%rbp,%rbp,2), %esi
	xorl	%eax, %eax
	leaq	LC4(%rip), %rdi
	movslq	%esi, %rsi
	salq	$2, %rsi
	call	_printf
	movslq	%ebp, %rcx
	movl	%r14d, %edx
	movl	%r14d, %esi
	leaq	LC5(%rip), %rdi
	salq	$2, %rcx
	xorl	%eax, %eax
	call	_printf
	movq	(%rsp), %rdi
	movq	40(%rsp), %rsi
	movq	-8(%rdi,%rsi), %rax
	movq	32(%rsp), %rsi
	movl	-4(%rax,%rsi,4), %edx
	movq	(%rdi), %rax
	leaq	LC6(%rip), %rdi
	movl	(%rax), %esi
	xorl	%eax, %eax
	call	_printf
	cmpl	$3, %r14d
	jle	L20
L21:
	movq	(%rsp), %r12
	xorl	%ebp, %ebp
	movq	16(%rsp), %r13
	.align 4
L22:
	movq	(%r12,%rbp,8), %rdi
	call	_free
	movq	0(%r13,%rbp,8), %rdi
	call	_free
	movq	(%rbx,%rbp,8), %rdi
	addq	$1, %rbp
	call	_free
	cmpl	%ebp, %r14d
	jg	L22
L33:
	movq	(%rsp), %rdi
	call	_free
	movq	16(%rsp), %rdi
	call	_free
	movq	%rbx, %rdi
	call	_free
	addq	$104, %rsp
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
L3:
LCFI14:
	call	_mach_host_self
	leaq	76(%rsp), %rdi
	movl	$1, %esi
	movq	%rdi, 24(%rsp)
	leaq	80(%rsp), %r15
	movq	%rdi, %rdx
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	76(%rsp), %edi
	movq	%r15, %rsi
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rbp
	movl	76(%rsp), %esi
	movl	0(%rbp), %edi
	call	_mach_port_deallocate
	movl	80(%rsp), %eax
	movslq	84(%rsp), %r9
	movq	%rax, 8(%rsp)
	jmp	L10
L66:
	movq	(%rsp), %r12
	xorl	%r11d, %r11d
	movq	16(%rsp), %r13
L19:
	movq	0(%r13,%r11,8), %r10
	xorl	%r8d, %r8d
	movq	(%r12,%r11,8), %rdx
	.align 4
L18:
	movl	(%r10,%r8,4), %edi
	xorl	%eax, %eax
	movq	(%rbx,%r8,8), %rsi
	.align 4
L17:
	movl	(%rsi,%rax,4), %ecx
	imull	%edi, %ecx
	addl	%ecx, (%rdx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	L17
	addq	$1, %r8
	cmpl	%r8d, %r14d
	jg	L18
	addq	$1, %r11
	cmpl	%r11d, %r14d
	jg	L19
	jmp	L10
L20:
	leaq	LC7(%rip), %rdi
	call	_puts
	testl	%r14d, %r14d
	jle	L67
	movq	16(%rsp), %r15
	leal	-1(%r14), %eax
	xorl	%r13d, %r13d
	movq	%rbx, 8(%rsp)
	leaq	4(,%rax,4), %r12
L26:
	movq	(%r15,%r13,8), %rbx
	leaq	(%rbx,%r12), %rbp
	.align 4
L25:
	movl	(%rbx), %esi
	leaq	LC8(%rip), %rdi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	_printf
	cmpq	%rbp, %rbx
	jne	L25
	movl	$10, %edi
	addq	$1, %r13
	call	_putchar
	cmpl	%r13d, %r14d
	jg	L26
	leaq	LC9(%rip), %rdi
	movq	8(%rsp), %rbx
	xorl	%r13d, %r13d
	call	_puts
L29:
	movq	(%rbx,%r13,8), %rbp
	leaq	0(%rbp,%r12), %r15
	.align 4
L28:
	movl	0(%rbp), %esi
	xorl	%eax, %eax
	addq	$4, %rbp
	leaq	LC8(%rip), %rdi
	call	_printf
	cmpq	%r15, %rbp
	jne	L28
	movl	$10, %edi
	addq	$1, %r13
	call	_putchar
	cmpl	%r13d, %r14d
	jg	L29
	leaq	LC10(%rip), %rdi
	xorl	%r12d, %r12d
	call	_puts
	movq	(%rsp), %r15
L32:
	movq	(%r15,%r12,8), %r13
	xorl	%ebp, %ebp
	.align 4
L31:
	movl	0(%r13,%rbp,4), %esi
	xorl	%eax, %eax
	addq	$1, %rbp
	leaq	LC8(%rip), %rdi
	call	_printf
	cmpl	%ebp, %r14d
	jg	L31
	movl	$10, %edi
	addq	$1, %r12
	call	_putchar
	cmpl	%r12d, %r14d
	jg	L32
	jmp	L21
L36:
	leaq	LC1(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L67:
	leaq	LC9(%rip), %rdi
	call	_puts
	leaq	LC10(%rip), %rdi
	call	_puts
	jmp	L33
L65:
	movq	___stderrp@GOTPCREL(%rip), %rax
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC0(%rip), %rdi
	movq	(%rax), %rcx
	call	_fwrite
	orl	$-1, %edi
	call	_exit
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
	.byte	0xa0,0x1
	.byte	0x4
	.set L$set$10,LCFI7-LCFI6
	.long L$set$10
	.byte	0xa
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
	.byte	0x4
	.set L$set$17,LCFI14-LCFI13
	.long L$set$17
	.byte	0xb
	.align 3
LEFDE1:
	.subsections_via_symbols
