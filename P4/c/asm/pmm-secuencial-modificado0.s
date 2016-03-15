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
	.text
	.globl _main
_main:
LFB18:
	pushq	%rbp
LCFI0:
	movq	%rsp, %rbp
LCFI1:
	pushq	%rbx
	subq	$152, %rsp
LCFI2:
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	leaq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, -148(%rbp)
	jg	L2
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC0(%rip), %rdi
	call	_fwrite
	movl	$-1, %edi
	call	_exit
L2:
	movq	-160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_atoi
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -40(%rbp)
	movl	-32(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -48(%rbp)
	movl	-32(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -56(%rbp)
	movl	$0, -20(%rbp)
	jmp	L3
L6:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	-32(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, (%rbx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	-32(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, (%rbx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	-32(%rbp), %eax
	cltq
	salq	$2, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, (%rbx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	L4
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	L4
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	L5
L4:
	leaq	LC1(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L5:
	addl	$1, -20(%rbp)
L3:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L6
	movl	$0, -20(%rbp)
	jmp	L7
L10:
	movl	$0, -24(%rbp)
	jmp	L8
L9:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	$0, (%rax)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %rbx
	call	_rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$29, %eax
	addl	%eax, %edx
	andl	$7, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, (%rbx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %rbx
	call	_rand
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$29, %eax
	addl	%eax, %edx
	andl	$7, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, (%rbx)
	addl	$1, -24(%rbp)
L8:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L9
	addl	$1, -20(%rbp)
L7:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L10
	call	_mach_host_self
	movl	%eax, %ecx
	leaq	-124(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %esi
	movl	%ecx, %edi
	call	_host_get_clock_service
	movl	-124(%rbp), %eax
	leaq	-144(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	_clock_get_time
	movl	-124(%rbp), %edx
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	_mach_port_deallocate
	movl	-144(%rbp), %eax
	movl	%eax, %eax
	movq	%rax, -96(%rbp)
	movl	-140(%rbp), %eax
	cltq
	movq	%rax, -88(%rbp)
	cmpl	$4, -32(%rbp)
	jle	L11
	movl	$0, -20(%rbp)
	jmp	L12
L17:
	movl	$0, -24(%rbp)
	jmp	L13
L16:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -60(%rbp)
	movl	$0, -28(%rbp)
	jmp	L14
L15:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-60(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	addq	$1, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-60(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	addq	$2, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-60(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	addq	$3, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-60(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	addl	$4, -28(%rbp)
L14:
	movl	-28(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L15
	addl	$1, -24(%rbp)
L13:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L16
	addl	$1, -20(%rbp)
L12:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L17
	movl	-32(%rbp), %eax
	cltd
	shrl	$30, %edx
	addl	%edx, %eax
	andl	$3, %eax
	subl	%edx, %eax
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	je	L18
	movl	$0, -20(%rbp)
	jmp	L19
L24:
	movl	$0, -24(%rbp)
	jmp	L20
L23:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -68(%rbp)
	movl	-32(%rbp), %eax
	subl	$4, %eax
	movl	%eax, -28(%rbp)
	jmp	L21
L22:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-68(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	addl	$1, -28(%rbp)
L21:
	movl	-28(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L22
	addl	$1, -24(%rbp)
L20:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L23
	addl	$1, -20(%rbp)
L19:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L24
L18:
	jmp	L25
L11:
	movl	$0, -20(%rbp)
	jmp	L26
L31:
	movl	$0, -24(%rbp)
	jmp	L27
L30:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -72(%rbp)
	movl	$0, -28(%rbp)
	jmp	L28
L29:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %esi
	movslq	%esi, %rsi
	salq	$2, %rsi
	addq	%rsi, %rax
	movl	(%rax), %eax
	imull	-72(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, (%rdx)
	addl	$1, -28(%rbp)
L28:
	movl	-28(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L29
	addl	$1, -24(%rbp)
L27:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L30
	addl	$1, -20(%rbp)
L26:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L31
L25:
	call	_mach_host_self
	movl	%eax, %ecx
	leaq	-124(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %esi
	movl	%ecx, %edi
	call	_host_get_clock_service
	movl	-124(%rbp), %eax
	leaq	-144(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	_clock_get_time
	movl	-124(%rbp), %edx
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	_mach_port_deallocate
	movl	-144(%rbp), %eax
	movl	%eax, %eax
	movq	%rax, -112(%rbp)
	movl	-140(%rbp), %eax
	cltq
	movq	%rax, -104(%rbp)
	movq	-112(%rbp), %rdx
	movq	-96(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm2, %xmm2
	cvtsi2sdq	%rax, %xmm2
	movd	%xmm2, %rax
	movabsq	$4741671816366391296, %rdx
	movd	%rax, %xmm0
	movd	%rdx, %xmm3
	divsd	%xmm3, %xmm0
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC3(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movl	-32(%rbp), %eax
	imull	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rsi
	leaq	LC4(%rip), %rdi
	movl	$0, %eax
	call	_printf
	movl	-32(%rbp), %eax
	imull	-32(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movl	-32(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%eax, %esi
	leaq	LC5(%rip), %rdi
	movl	$0, %eax
	call	_printf
	movl	-32(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-32(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	subq	$4, %rdx
	addq	%rdx, %rax
	movl	(%rax), %edx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	LC6(%rip), %rdi
	movl	$0, %eax
	call	_printf
	cmpl	$3, -32(%rbp)
	jg	L32
	leaq	LC7(%rip), %rdi
	call	_puts
	movl	$0, -20(%rbp)
	jmp	L33
L36:
	movl	$0, -24(%rbp)
	jmp	L34
L35:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	LC8(%rip), %rdi
	movl	$0, %eax
	call	_printf
	addl	$1, -24(%rbp)
L34:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L35
	movl	$10, %edi
	call	_putchar
	addl	$1, -20(%rbp)
L33:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L36
	leaq	LC9(%rip), %rdi
	call	_puts
	movl	$0, -20(%rbp)
	jmp	L37
L40:
	movl	$0, -24(%rbp)
	jmp	L38
L39:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	LC8(%rip), %rdi
	movl	$0, %eax
	call	_printf
	addl	$1, -24(%rbp)
L38:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L39
	movl	$10, %edi
	call	_putchar
	addl	$1, -20(%rbp)
L37:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L40
	leaq	LC10(%rip), %rdi
	call	_puts
	movl	$0, -20(%rbp)
	jmp	L41
L44:
	movl	$0, -24(%rbp)
	jmp	L42
L43:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-24(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	LC8(%rip), %rdi
	movl	$0, %eax
	call	_printf
	addl	$1, -24(%rbp)
L42:
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L43
	movl	$10, %edi
	call	_putchar
	addl	$1, -20(%rbp)
L41:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L44
L32:
	movl	$0, -20(%rbp)
	jmp	L45
L46:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_free
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_free
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_free
	addl	$1, -20(%rbp)
L45:
	movl	-20(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl	L46
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_free
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_free
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_free
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
LCFI3:
	ret
LFE18:
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
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0x83
	.byte	0x3
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE1:
	.subsections_via_symbols
