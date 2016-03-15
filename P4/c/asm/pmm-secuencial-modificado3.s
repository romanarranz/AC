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
	subq	$136, %rsp
LCFI6:
	leaq	120(%rsp), %rdi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, %ebp
	jle	L63
	movq	8(%rbx), %rdi
	call	_atoi
	cltq
	movq	%rax, %rbx
	movq	%rax, 80(%rsp)
	salq	$3, %rax
	movq	%rax, %r14
	movq	%rax, %rdi
	movq	%rax, 88(%rsp)
	call	_malloc
	movq	%r14, %rdi
	movq	%rax, 8(%rsp)
	call	_malloc
	movq	%r14, %rdi
	movq	%rax, %r15
	movq	%rax, 24(%rsp)
	call	_malloc
	testl	%ebx, %ebx
	movq	%rax, %rbp
	jle	L3
	leaq	0(,%rbx,4), %r13
	xorl	%r12d, %r12d
	movl	%ebx, 16(%rsp)
	.align 4
L6:
	movq	%r13, %rdi
	call	_malloc
	movq	%r13, %rdi
	movq	%rax, %r14
	movq	8(%rsp), %rax
	movq	%r14, (%rax,%r12,8)
	call	_malloc
	movq	%r13, %rdi
	movq	%rax, (%r15,%r12,8)
	movq	%rax, %rbx
	call	_malloc
	testq	%r14, %r14
	sete	%sil
	testq	%rbx, %rbx
	movq	%rax, %rdx
	movq	%rax, 0(%rbp,%r12,8)
	sete	%al
	orb	%al, %sil
	jne	L37
	testq	%rdx, %rdx
	je	L37
	addq	$1, %r12
	cmpl	%r12d, 16(%rsp)
	jg	L6
	movl	16(%rsp), %ebx
	xorl	%r15d, %r15d
	movq	%rbp, 16(%rsp)
	.align 4
L7:
	movq	8(%rsp), %rax
	xorl	%ebp, %ebp
	movq	(%rax,%r15,8), %r14
	movq	24(%rsp), %rax
	movq	(%rax,%r15,8), %r13
	movq	16(%rsp), %rax
	movq	(%rax,%r15,8), %r12
	.align 4
L8:
	movl	$0, (%r14,%rbp,4)
	call	_rand
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%ecx, %eax
	andl	$7, %eax
	subl	%ecx, %eax
	movl	%eax, 0(%r13,%rbp,4)
	call	_rand
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%ecx, %eax
	andl	$7, %eax
	subl	%ecx, %eax
	movl	%eax, (%r12,%rbp,4)
	addq	$1, %rbp
	cmpl	%ebp, %ebx
	jg	L8
	addq	$1, %r15
	cmpl	%r15d, %ebx
	jg	L7
	movq	16(%rsp), %rbp
	call	_mach_host_self
	leaq	108(%rsp), %rdi
	movl	$1, %esi
	movq	%rdi, %rdx
	movq	%rdi, 64(%rsp)
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	108(%rsp), %edi
	leaq	112(%rsp), %rax
	movq	%rax, %rsi
	movq	%rax, 72(%rsp)
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	108(%rsp), %esi
	movl	(%rax), %edi
	movq	%rax, 56(%rsp)
	call	_mach_port_deallocate
	movl	112(%rsp), %eax
	cmpl	$4, %ebx
	movq	%rax, 48(%rsp)
	movslq	116(%rsp), %rax
	movq	%rax, 40(%rsp)
	jg	L36
	xorl	%edi, %edi
	movq	0(%rbp), %r8
	movq	8(%rsp), %r9
	movq	24(%rsp), %r10
	jmp	L16
	.align 4
L64:
	cmpl	$2, %ebx
	je	L33
	cmpl	$4, %ebx
	jne	L34
	movl	(%rcx), %esi
	movl	(%r8), %r11d
	imull	%esi, %r11d
	addl	%edx, %r11d
	movl	4(%r8), %edx
	imull	%esi, %edx
	addl	%edx, 4(%rax)
	movl	8(%r8), %edx
	imull	%esi, %edx
	imull	12(%r8), %esi
	addl	%esi, 12(%rax)
	movq	8(%rbp), %rsi
	addl	%edx, 8(%rax)
	movl	4(%rcx), %edx
	movl	(%rsi), %r12d
	imull	%edx, %r12d
	addl	%r12d, %r11d
	movl	4(%rsi), %r12d
	imull	%edx, %r12d
	addl	%r12d, 4(%rax)
	movl	8(%rsi), %r12d
	imull	%edx, %r12d
	imull	12(%rsi), %edx
	movq	16(%rbp), %rsi
	addl	%r12d, 8(%rax)
	addl	%edx, 12(%rax)
	movl	8(%rcx), %edx
	movl	(%rsi), %r12d
	imull	%edx, %r12d
	addl	%r12d, %r11d
	movl	4(%rsi), %r12d
	imull	%edx, %r12d
	addl	%r12d, 4(%rax)
	movl	8(%rsi), %r12d
	imull	%edx, %r12d
	imull	12(%rsi), %edx
	addl	%r12d, 8(%rax)
	addl	%edx, 12(%rax)
	movq	24(%rbp), %rsi
	movl	12(%rcx), %edx
	movl	(%rsi), %ecx
	imull	%edx, %ecx
	addl	%r11d, %ecx
	movl	4(%rsi), %r11d
	imull	%edx, %r11d
	addl	%r11d, 4(%rax)
	movl	8(%rsi), %r11d
	imull	%edx, %r11d
	imull	12(%rsi), %edx
	addl	%r11d, 8(%rax)
	addl	%edx, 12(%rax)
L35:
	addq	$1, %rdi
	cmpl	%edi, %ebx
	movl	%ecx, (%rax)
	jle	L10
L16:
	movq	(%r9,%rdi,8), %rax
	cmpl	$1, %ebx
	movq	(%r10,%rdi,8), %rcx
	movl	(%rax), %edx
	jne	L64
	movl	(%r8), %esi
	imull	(%rcx), %esi
	addl	%esi, %edx
	movl	%edx, (%rax)
L10:
	call	_mach_host_self
	movq	64(%rsp), %rdx
	movl	$1, %esi
	movl	%ebx, %r12d
	movl	%eax, %edi
	imull	%ebx, %r12d
	call	_host_get_clock_service
	movq	72(%rsp), %rsi
	movl	108(%rsp), %edi
	call	_clock_get_time
	movq	56(%rsp), %rax
	movl	108(%rsp), %esi
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	112(%rsp), %eax
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	subq	48(%rsp), %rax
	leaq	LC3(%rip), %rdi
	cvtsi2sdq	%rax, %xmm1
	movslq	116(%rsp), %rax
	subq	40(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	movl	$1, %eax
	divsd	LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	_printf
	leal	(%r12,%r12,2), %esi
	xorl	%eax, %eax
	leaq	LC4(%rip), %rdi
	movslq	%esi, %rsi
	salq	$2, %rsi
	call	_printf
	movslq	%r12d, %rcx
	movl	%ebx, %edx
	movl	%ebx, %esi
	leaq	LC5(%rip), %rdi
	salq	$2, %rcx
	xorl	%eax, %eax
	call	_printf
	movq	8(%rsp), %rdi
	movq	88(%rsp), %rsi
	movq	-8(%rdi,%rsi), %rax
	movq	80(%rsp), %rsi
	movl	-4(%rax,%rsi,4), %edx
	movq	(%rdi), %rax
	leaq	LC6(%rip), %rdi
	movl	(%rax), %esi
	xorl	%eax, %eax
	call	_printf
	cmpl	$3, %ebx
	jle	L17
L18:
	movq	8(%rsp), %r13
	xorl	%r12d, %r12d
	movq	24(%rsp), %r14
	.align 4
L19:
	movq	0(%r13,%r12,8), %rdi
	call	_free
	movq	(%r14,%r12,8), %rdi
	call	_free
	movq	0(%rbp,%r12,8), %rdi
	addq	$1, %r12
	call	_free
	cmpl	%r12d, %ebx
	jg	L19
L30:
	movq	8(%rsp), %rdi
	call	_free
	movq	24(%rsp), %rdi
	call	_free
	movq	%rbp, %rdi
	call	_free
	addq	$136, %rsp
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
L36:
LCFI14:
	movq	8(%rsp), %r13
	xorl	%r12d, %r12d
	movq	24(%rsp), %r14
L31:
	movq	(%r14,%r12,8), %r11
	xorl	%r10d, %r10d
	movq	0(%r13,%r12,8), %r9
	.align 4
L12:
	movl	(%r11,%r10,4), %edi
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	movq	0(%rbp,%r10,8), %rsi
	.align 4
L11:
	movl	(%rsi,%rcx), %eax
	addl	$4, %r8d
	movl	4(%rsi,%rcx), %r15d
	movl	8(%rsi,%rcx), %edx
	imull	%edi, %eax
	addl	(%r9,%rcx), %eax
	imull	%edi, %r15d
	imull	%edi, %edx
	addl	%r15d, %eax
	addl	%eax, %edx
	movl	12(%rsi,%rcx), %eax
	imull	%edi, %eax
	addl	%edx, %eax
	movl	%eax, (%r9,%rcx)
	addq	$16, %rcx
	cmpl	%r8d, %ebx
	jg	L11
	addq	$1, %r10
	cmpl	%r10d, %ebx
	jg	L12
	addq	$1, %r12
	cmpl	%r12d, %ebx
	jg	L31
	testb	$3, %bl
	je	L10
	movq	$0, 16(%rsp)
	leal	-4(%rbx), %r11d
	movq	16(%rsp), %rax
	movslq	%r11d, %r11
	salq	$2, %r11
	leaq	4(%r11), %r13
	leaq	8(%r11), %r12
	leaq	12(%r11), %r15
L14:
	movq	24(%rsp), %rdi
	xorl	%edx, %edx
	movq	(%rdi,%rax,8), %r14
	movq	8(%rsp), %rdi
	movq	(%rdi,%rax,8), %rax
	leaq	(%rax,%r11), %rdi
	movl	(%rax,%r13), %r9d
	movq	%rdi, 32(%rsp)
	movl	(%rax,%r12), %esi
	movl	(%rdi), %edi
	movl	(%rax,%r15), %r8d
	.align 4
L15:
	movq	0(%rbp,%rdx,8), %rcx
	movl	(%r14,%rdx,4), %eax
	addq	$1, %rdx
	movl	(%rcx,%r11), %r10d
	imull	%eax, %r10d
	addl	%r10d, %edi
	movl	(%rcx,%r13), %r10d
	imull	%eax, %r10d
	addl	%r10d, %r9d
	movl	(%rcx,%r12), %r10d
	imull	%eax, %r10d
	imull	(%rcx,%r15), %eax
	addl	%r10d, %esi
	addl	%eax, %r8d
	cmpl	%edx, %ebx
	jg	L15
	movq	32(%rsp), %rax
	movd	%esi, %xmm1
	movd	%r8d, %xmm2
	movd	%edi, %xmm0
	addq	$1, 16(%rsp)
	movd	%r9d, %xmm3
	punpckldq	%xmm2, %xmm1
	punpckldq	%xmm3, %xmm0
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	movq	16(%rsp), %rax
	cmpl	%eax, %ebx
	jg	L14
	jmp	L10
L3:
	call	_mach_host_self
	leaq	108(%rsp), %rdi
	movl	$1, %esi
	movq	%rdi, %rdx
	movq	%rdi, 64(%rsp)
	movl	%eax, %edi
	call	_host_get_clock_service
	movl	108(%rsp), %edi
	leaq	112(%rsp), %rax
	movq	%rax, %rsi
	movq	%rax, 72(%rsp)
	call	_clock_get_time
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	108(%rsp), %esi
	movl	(%rax), %edi
	movq	%rax, 56(%rsp)
	call	_mach_port_deallocate
	movl	112(%rsp), %eax
	movq	%rax, 48(%rsp)
	movslq	116(%rsp), %rax
	movq	%rax, 40(%rsp)
	jmp	L10
L34:
	movl	(%rcx), %r11d
	movl	(%r8), %esi
	movq	8(%rbp), %r12
	imull	%r11d, %esi
	addl	%esi, %edx
	movl	4(%r8), %esi
	imull	%r11d, %esi
	imull	8(%r8), %r11d
	addl	%esi, 4(%rax)
	addl	%r11d, 8(%rax)
	movl	(%r12), %esi
	movl	4(%rcx), %r11d
	imull	%r11d, %esi
	addl	%edx, %esi
	movl	4(%r12), %edx
	imull	%r11d, %edx
	imull	8(%r12), %r11d
	addl	%r11d, 8(%rax)
	movq	16(%rbp), %r11
	addl	%edx, 4(%rax)
	movl	8(%rcx), %edx
	movl	(%r11), %ecx
	imull	%edx, %ecx
	addl	%esi, %ecx
	movl	4(%r11), %esi
	imull	%edx, %esi
	imull	8(%r11), %edx
	addl	%esi, 4(%rax)
	addl	%edx, 8(%rax)
	jmp	L35
L33:
	movq	8(%rbp), %r12
	movl	(%rcx), %r11d
	movl	4(%rcx), %esi
	movl	(%r8), %ecx
	movl	(%r12), %r13d
	imull	%r11d, %ecx
	imull	%esi, %r13d
	imull	4(%r12), %esi
	addl	%ecx, %edx
	leal	0(%r13,%rdx), %ecx
	movl	4(%r8), %edx
	imull	%r11d, %edx
	addl	%esi, %edx
	addl	%edx, 4(%rax)
	jmp	L35
L17:
	leaq	LC7(%rip), %rdi
	call	_puts
	testl	%ebx, %ebx
	jle	L65
	movq	24(%rsp), %r15
	leal	-1(%rbx), %eax
	xorl	%r14d, %r14d
	movq	%rbp, 16(%rsp)
	leaq	4(,%rax,4), %r13
L23:
	movq	(%r15,%r14,8), %rbp
	leaq	0(%rbp,%r13), %r12
	.align 4
L22:
	movl	0(%rbp), %esi
	xorl	%eax, %eax
	addq	$4, %rbp
	leaq	LC8(%rip), %rdi
	call	_printf
	cmpq	%r12, %rbp
	jne	L22
	movl	$10, %edi
	addq	$1, %r14
	call	_putchar
	cmpl	%r14d, %ebx
	jg	L23
	leaq	LC9(%rip), %rdi
	movq	16(%rsp), %rbp
	xorl	%r14d, %r14d
	call	_puts
L26:
	movq	0(%rbp,%r14,8), %r12
	leaq	(%r12,%r13), %r15
	.align 4
L25:
	movl	(%r12), %esi
	xorl	%eax, %eax
	addq	$4, %r12
	leaq	LC8(%rip), %rdi
	call	_printf
	cmpq	%r15, %r12
	jne	L25
	movl	$10, %edi
	addq	$1, %r14
	call	_putchar
	cmpl	%r14d, %ebx
	jg	L26
	leaq	LC10(%rip), %rdi
	xorl	%r13d, %r13d
	call	_puts
	movq	8(%rsp), %r15
L29:
	movq	(%r15,%r13,8), %r14
	xorl	%r12d, %r12d
	.align 4
L28:
	movl	(%r14,%r12,4), %esi
	xorl	%eax, %eax
	addq	$1, %r12
	leaq	LC8(%rip), %rdi
	call	_printf
	cmpl	%r12d, %ebx
	jg	L28
	movl	$10, %edi
	addq	$1, %r13
	call	_putchar
	cmpl	%r13d, %ebx
	jg	L29
	jmp	L18
L37:
	leaq	LC1(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L65:
	leaq	LC9(%rip), %rdi
	call	_puts
	leaq	LC10(%rip), %rdi
	call	_puts
	jmp	L30
L63:
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
	.byte	0xc0,0x1
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
