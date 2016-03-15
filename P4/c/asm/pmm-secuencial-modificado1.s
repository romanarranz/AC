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
	.section __TEXT,__text_startup,regular,pure_instructions
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
	pushq	%rbx
LCFI5:
	subq	$88, %rsp
LCFI6:
	movl	%edi, %ebp
	movq	%rsi, %rbx
	leaq	72(%rsp), %rdi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, %ebp
	jg	L2
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC0(%rip), %rdi
	call	_fwrite
	movl	$-1, %edi
	call	_exit
L2:
	movq	8(%rbx), %rdi
	call	_atoi
	movl	%eax, %ebx
	cltq
	movq	%rax, %r14
	movq	%rax, 32(%rsp)
	salq	$3, %rax
	movq	%rax, %r15
	movq	%rax, 40(%rsp)
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, %r13
	movq	%r15, %rdi
	call	_malloc
	movq	%rax, 16(%rsp)
	movq	%r15, %rdi
	call	_malloc
	movq	%rax, %r15
	testl	%ebx, %ebx
	jle	L3
	leaq	0(,%r14,4), %r12
	movl	$0, %ebp
	movl	%ebx, 8(%rsp)
L6:
	movq	%r12, %rdi
	call	_malloc
	movq	%rax, %r14
	movq	%rax, 0(%r13,%rbp,8)
	movq	%r12, %rdi
	call	_malloc
	movq	%rax, %rbx
	movq	16(%rsp), %rax
	movq	%rbx, (%rax,%rbp,8)
	movq	%r12, %rdi
	call	_malloc
	movq	%rax, (%r15,%rbp,8)
	testq	%r14, %r14
	sete	%cl
	testq	%rbx, %rbx
	sete	%dl
	orb	%dl, %cl
	jne	L37
	testq	%rax, %rax
	jne	L4
L37:
	leaq	LC1(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L4:
	addq	$1, %rbp
	cmpl	%ebp, 8(%rsp)
	jg	L6
	movl	8(%rsp), %ebx
	leal	-1(%rbx), %eax
	leaq	4(,%rax,4), %rax
	movq	%rax, 8(%rsp)
	movl	$0, %r12d
	movl	%ebx, 24(%rsp)
	movq	16(%rsp), %r14
	jmp	L7
L8:
	movq	0(%r13,%r12,8), %rax
	movl	$0, (%rax,%rbx)
	movq	%rbx, %rbp
	addq	(%r14,%r12,8), %rbp
	call	_rand
	cltd
	shrl	$29, %edx
	addl	%edx, %eax
	andl	$7, %eax
	subl	%edx, %eax
	movl	%eax, 0(%rbp)
	movq	%rbx, %rbp
	addq	(%r15,%r12,8), %rbp
	call	_rand
	cltd
	shrl	$29, %edx
	addl	%edx, %eax
	andl	$7, %eax
	subl	%edx, %eax
	movl	%eax, 0(%rbp)
	addq	$4, %rbx
	cmpq	8(%rsp), %rbx
	jne	L8
	addq	$1, %r12
	cmpl	%r12d, 24(%rsp)
	jle	L9
L7:
	movl	$0, %ebx
	jmp	L8
L3:
	call	_mach_host_self
	leaq	68(%rsp), %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	leaq	48(%rsp), %rsi
	movl	68(%rsp), %edi
	call	_clock_get_time
	movl	68(%rsp), %esi
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	48(%rsp), %r14d
	movslq	52(%rsp), %rax
	movq	%rax, 8(%rsp)
	jmp	L10
L12:
	movl	0(%rbp,%r11,4), %edi
	movq	(%r15,%r11,8), %rsi
	movl	$0, %ecx
L11:
	movslq	%ecx, %r8
	leaq	0(,%r8,4), %rax
	leaq	(%r10,%rax), %rdx
	movl	%edi, %r9d
	imull	(%rsi,%r8,4), %r9d
	movl	%r9d, %r8d
	addl	(%rdx), %r8d
	movl	%edi, %r9d
	imull	4(%rsi,%rax), %r9d
	addl	%r8d, %r9d
	movl	%edi, %r8d
	imull	8(%rsi,%rax), %r8d
	addl	%r9d, %r8d
	movl	%edi, %r9d
	imull	12(%rsi,%rax), %r9d
	movl	%r9d, %eax
	addl	%r8d, %eax
	movl	%eax, (%rdx)
	addl	$4, %ecx
	cmpl	%ecx, %ebx
	jg	L11
	addq	$1, %r11
	cmpl	%r11d, %ebx
	jg	L12
	addq	$1, %r12
	cmpl	%r12d, %ebx
	jg	L30
	jmp	L53
L35:
	movl	$0, %r12d
	movq	%r14, 24(%rsp)
	movq	16(%rsp), %r14
L30:
	movq	(%r14,%r12,8), %rbp
	movq	0(%r13,%r12,8), %r10
	movl	$0, %r11d
	jmp	L12
L16:
	movl	0(%rbp,%r8,4), %edi
	movl	%r10d, %eax
	cmpl	%r10d, %ebx
	jle	L14
	movq	0(%r13,%r11,8), %rcx
	movq	(%r15,%r8,8), %r9
L15:
	movslq	%eax, %rdx
	movl	%edi, %esi
	imull	(%r9,%rdx,4), %esi
	addl	%esi, (%rcx,%rdx,4)
	addl	$1, %eax
	cmpl	%eax, %ebx
	jg	L15
L14:
	addq	$1, %r8
	cmpl	%r8d, %ebx
	jg	L16
	addq	$1, %r11
	cmpl	%r11d, %ebx
	jg	L32
	jmp	L10
L36:
	movl	$0, %r11d
	leal	-4(%rbx), %r10d
	movq	16(%rsp), %r12
L32:
	movq	(%r12,%r11,8), %rbp
	movl	$0, %r8d
	jmp	L16
L18:
	movl	(%r9,%r8,4), %edi
	movq	(%r15,%r8,8), %rsi
	movl	$0, %eax
L17:
	movl	%edi, %ecx
	imull	(%rsi,%rax,4), %ecx
	addl	%ecx, (%rdx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ebx
	jg	L17
	addq	$1, %r8
	cmpl	%r8d, %ebx
	jg	L18
	addq	$1, %r10
	cmpl	%r10d, %ebx
	jle	L10
L31:
	movq	(%r11,%r10,8), %r9
	movq	0(%r13,%r10,8), %rdx
	movl	$0, %r8d
	jmp	L18
L10:
	call	_mach_host_self
	leaq	68(%rsp), %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	leaq	48(%rsp), %rsi
	movl	68(%rsp), %edi
	call	_clock_get_time
	movl	68(%rsp), %esi
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	48(%rsp), %eax
	subq	%r14, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movslq	52(%rsp), %rax
	subq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	divsd	LC2(%rip), %xmm0
	addsd	%xmm1, %xmm0
	leaq	LC3(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movl	%ebx, %ebp
	imull	%ebx, %ebp
	movslq	%ebp, %rbp
	leaq	0(%rbp,%rbp,2), %rsi
	salq	$2, %rsi
	leaq	LC4(%rip), %rdi
	movl	$0, %eax
	call	_printf
	leaq	0(,%rbp,4), %rcx
	movl	%ebx, %edx
	movl	%ebx, %esi
	leaq	LC5(%rip), %rdi
	movl	$0, %eax
	call	_printf
	movq	40(%rsp), %rax
	movq	-8(%r13,%rax), %rax
	movq	32(%rsp), %rdi
	movl	-4(%rax,%rdi,4), %edx
	movq	0(%r13), %rax
	movl	(%rax), %esi
	leaq	LC6(%rip), %rdi
	movl	$0, %eax
	call	_printf
	cmpl	$3, %ebx
	jle	L19
	testl	%ebx, %ebx
	jg	L20
	jmp	L21
L19:
	leaq	LC7(%rip), %rdi
	call	_puts
	testl	%ebx, %ebx
	jle	L22
	leal	-1(%rbx), %eax
	leaq	4(,%rax,4), %r12
	movl	$0, %r14d
	movq	%r13, 8(%rsp)
	movq	16(%rsp), %r13
	jmp	L23
L24:
	movq	0(%r13,%r14,8), %rax
	movl	(%rax,%rbp), %esi
	leaq	LC8(%rip), %rdi
	movl	$0, %eax
	call	_printf
	addq	$4, %rbp
	cmpq	%r12, %rbp
	jne	L24
	movl	$10, %edi
	call	_putchar
	addq	$1, %r14
	cmpl	%r14d, %ebx
	jle	L25
L23:
	movl	$0, %ebp
	jmp	L24
L26:
	movq	(%r15,%r14,8), %rax
	movl	(%rax,%rbp), %esi
	leaq	LC8(%rip), %rdi
	movl	$0, %eax
	call	_printf
	addq	$4, %rbp
	cmpq	%r12, %rbp
	jne	L26
	movl	$10, %edi
	call	_putchar
	addq	$1, %r14
	cmpl	%r14d, %ebx
	jle	L27
L33:
	movl	$0, %ebp
	jmp	L26
L28:
	movq	0(%r13,%r12,8), %rax
	movl	(%rax,%rbp,4), %esi
	movq	%r14, %rdi
	movl	$0, %eax
	call	_printf
	addq	$1, %rbp
	cmpl	%ebp, %ebx
	jg	L28
	movl	$10, %edi
	call	_putchar
	addq	$1, %r12
	cmpl	%r12d, %ebx
	jle	L20
L34:
	movl	$0, %ebp
	jmp	L28
L20:
	movl	$0, %ebp
	movq	16(%rsp), %r12
L29:
	movq	0(%r13,%rbp,8), %rdi
	call	_free
	movq	(%r12,%rbp,8), %rdi
	call	_free
	movq	(%r15,%rbp,8), %rdi
	call	_free
	addq	$1, %rbp
	cmpl	%ebp, %ebx
	jg	L29
	jmp	L21
L9:
	movl	24(%rsp), %ebx
	call	_mach_host_self
	leaq	68(%rsp), %rdx
	movl	$1, %esi
	movl	%eax, %edi
	call	_host_get_clock_service
	leaq	48(%rsp), %rsi
	movl	68(%rsp), %edi
	call	_clock_get_time
	movl	68(%rsp), %esi
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	call	_mach_port_deallocate
	movl	48(%rsp), %r14d
	movslq	52(%rsp), %rax
	movq	%rax, 8(%rsp)
	cmpl	$4, %ebx
	jg	L35
	movl	$0, %r10d
	movq	16(%rsp), %r11
	jmp	L31
L53:
	movq	24(%rsp), %r14
	movl	$4, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ecx
	testl	%edx, %edx
	jne	L36
	jmp	L10
L22:
	leaq	LC9(%rip), %rdi
	call	_puts
	leaq	LC10(%rip), %rdi
	call	_puts
	jmp	L21
L25:
	movq	8(%rsp), %r13
	leaq	LC9(%rip), %rdi
	call	_puts
	movl	$0, %r14d
	jmp	L33
L27:
	leaq	LC10(%rip), %rdi
	call	_puts
	movl	$0, %r12d
	leaq	LC8(%rip), %r14
	jmp	L34
L21:
	movq	%r13, %rdi
	call	_free
	movq	16(%rsp), %rdi
	call	_free
	movq	%r15, %rdi
	call	_free
	movl	$0, %eax
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
