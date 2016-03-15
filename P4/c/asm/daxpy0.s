	.cstring
LC1:
	.ascii "Falta iteraciones\12\0"
	.align 3
LC4:
	.ascii "Error en la reserva de espacio para las matrices\0"
LC9:
	.ascii "Tiempo(seg.): %11.9f\12\0"
LC10:
	.ascii "Mflops: %11.2f\12\0"
LC11:
	.ascii "Gflops: %11.2f\12\0"
LC12:
	.ascii "GFLOPS/Computer: %f\12\0"
LC13:
	.ascii "GFLOPS/Core: %f\12\0"
LC14:
	.ascii "Rmax: %f\12\0"
LC15:
	.ascii "Nmax: %f\12\0"
LC16:
	.ascii "N1/2: %f\12\0"
LC17:
	.ascii "Rpico: %f GFLOPS\12\0"
	.text
	.globl _main
_main:
LFB18:
	pushq	%rbp
LCFI0:
	movq	%rsp, %rbp
LCFI1:
	pushq	%rbx
	subq	$184, %rsp
LCFI2:
	movl	%edi, -180(%rbp)
	movq	%rsi, -192(%rbp)
	movl	$2, -24(%rbp)
	movabsq	$4622269477551708570, %rax
	movq	%rax, -32(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2sd	-24(%rbp), %xmm0
	movq	-32(%rbp), %rax
	movd	%rax, %xmm2
	divsd	%xmm0, %xmm2
	movd	%xmm2, %rax
	movq	%rax, -40(%rbp)
	movl	$0, %edi
	call	_time
	movl	%eax, %edi
	call	_srand
	cmpl	$1, -180(%rbp)
	jg	L2
	movq	___stderrp@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	movl	$18, %edx
	movl	$1, %esi
	leaq	LC1(%rip), %rdi
	call	_fwrite
	movl	$-1, %edi
	call	_exit
L2:
	movq	-192(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_atoi
	movl	%eax, -44(%rbp)
	movabsq	$4611686018427387904, %rax
	movq	%rax, -56(%rbp)
	movl	$1, -60(%rbp)
	movl	$1, -64(%rbp)
	movl	-44(%rbp), %eax
	imull	-44(%rbp), %eax
	imull	-44(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	movapd	%xmm0, %xmm3
	addsd	%xmm0, %xmm3
	movd	%xmm3, %rax
	movabsq	$4613937818241073152, %rdx
	movd	%rax, %xmm1
	movd	%rdx, %xmm3
	divsd	%xmm3, %xmm1
	movl	-44(%rbp), %eax
	imull	-44(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rax
	movq	%rax, -72(%rbp)
	movl	-44(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -80(%rbp)
	movl	-44(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -88(%rbp)
	cmpq	$0, -80(%rbp)
	je	L3
	cmpq	$0, -88(%rbp)
	jne	L4
L3:
	leaq	LC4(%rip), %rdi
	call	_puts
	movl	$-2, %edi
	call	_exit
L4:
	movl	LC5(%rip), %eax
	movl	%eax, -92(%rbp)
	movl	$0, -20(%rbp)
	jmp	L5
L6:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	call	_rand
	pxor	%xmm4, %xmm4
	cvtsi2ss	%eax, %xmm4
	movd	%xmm4, %eax
	movl	LC6(%rip), %edx
	movd	%eax, %xmm4
	movd	%edx, %xmm5
	divss	%xmm5, %xmm4
	movd	%xmm4, %eax
	movd	%eax, %xmm0
	mulss	-92(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm6
	movd	%xmm6, %rax
	movq	%rax, (%rbx)
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-88(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	call	_rand
	pxor	%xmm7, %xmm7
	cvtsi2ss	%eax, %xmm7
	movd	%xmm7, %eax
	movl	LC6(%rip), %edx
	movd	%eax, %xmm5
	movd	%edx, %xmm3
	divss	%xmm3, %xmm5
	movd	%xmm5, %eax
	movd	%eax, %xmm0
	mulss	-92(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm4
	movd	%xmm4, %rax
	movq	%rax, (%rbx)
	addl	$1, -20(%rbp)
L5:
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	L6
	call	_mach_host_self
	movl	%eax, %ecx
	leaq	-164(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %esi
	movl	%ecx, %edi
	call	_host_get_clock_service
	movl	-164(%rbp), %eax
	leaq	-176(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	_clock_get_time
	movl	-164(%rbp), %edx
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	_mach_port_deallocate
	movl	-176(%rbp), %eax
	movl	%eax, %eax
	movq	%rax, -144(%rbp)
	movl	-172(%rbp), %eax
	cltq
	movq	%rax, -136(%rbp)
	movl	-64(%rbp), %r8d
	movq	-88(%rbp), %rcx
	movl	-60(%rbp), %edx
	movq	-80(%rbp), %rsi
	movq	-56(%rbp), %rdi
	movl	-44(%rbp), %eax
	movd	%rdi, %xmm0
	movl	%eax, %edi
	call	_daxpy
	call	_mach_host_self
	movl	%eax, %ecx
	leaq	-164(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %esi
	movl	%ecx, %edi
	call	_host_get_clock_service
	movl	-164(%rbp), %eax
	leaq	-176(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	_clock_get_time
	movl	-164(%rbp), %edx
	movq	_mach_task_self_@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	_mach_port_deallocate
	movl	-176(%rbp), %eax
	movl	%eax, %eax
	movq	%rax, -160(%rbp)
	movl	-172(%rbp), %eax
	cltq
	movq	%rax, -152(%rbp)
	movq	-160(%rbp), %rdx
	movq	-144(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-152(%rbp), %rdx
	movq	-136(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm5, %xmm5
	cvtsi2sdq	%rax, %xmm5
	movd	%xmm5, %rax
	movabsq	$4741671816366391296, %rdx
	movd	%rax, %xmm0
	movd	%rdx, %xmm6
	divsd	%xmm6, %xmm0
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rdx
	movabsq	$4696837146684686336, %rax
	movd	%rdx, %xmm0
	movd	%rax, %xmm7
	mulsd	%xmm7, %xmm0
	movq	-72(%rbp), %rax
	movd	%rax, %xmm6
	divsd	%xmm0, %xmm6
	movd	%xmm6, %rax
	movq	%rax, -112(%rbp)
	movq	-104(%rbp), %rdx
	movabsq	$4741671816366391296, %rax
	movd	%rdx, %xmm0
	movd	%rax, %xmm2
	mulsd	%xmm2, %xmm0
	movq	-72(%rbp), %rax
	movd	%rax, %xmm7
	divsd	%xmm0, %xmm7
	movd	%xmm7, %rax
	movq	%rax, -120(%rbp)
	movq	-104(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC9(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-112(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC10(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-120(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC11(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-32(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC12(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-40(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC13(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-120(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC14(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	leaq	LC15(%rip), %rdi
	movl	$0, %eax
	call	_printf
	movq	-120(%rbp), %rax
	movabsq	$4611686018427387904, %rdx
	movd	%rax, %xmm2
	movd	%rdx, %xmm3
	divsd	%xmm3, %xmm2
	movd	%xmm2, %rax
	movd	%rax, %xmm0
	leaq	LC16(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movq	-32(%rbp), %rax
	movd	%rax, %xmm0
	leaq	LC17(%rip), %rdi
	movl	$1, %eax
	call	_printf
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
LCFI3:
	ret
LFE18:
	.globl _daxpy
_daxpy:
LFB19:
	pushq	%rbp
LCFI4:
	movq	%rsp, %rbp
LCFI5:
	movl	%edi, -36(%rbp)
	movsd	%xmm0, -48(%rbp)
	movq	%rsi, -56(%rbp)
	movl	%edx, -40(%rbp)
	movq	%rcx, -64(%rbp)
	movl	%r8d, -68(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -20(%rbp)
	cmpl	$0, -36(%rbp)
	jg	L8
	jmp	L7
L8:
	movl	$0, %eax
	movd	%rax, %xmm3
	ucomisd	-48(%rbp), %xmm3
	jp	L10
	movl	$0, %eax
	movd	%rax, %xmm4
	ucomisd	-48(%rbp), %xmm4
	jne	L10
	jmp	L7
L10:
	cmpl	$1, -40(%rbp)
	jne	L12
	cmpl	$1, -68(%rbp)
	je	L13
L12:
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	cmpl	$0, -40(%rbp)
	jns	L14
	movl	$1, %eax
	subl	-36(%rbp), %eax
	imull	-40(%rbp), %eax
	movl	%eax, -8(%rbp)
L14:
	cmpl	$0, -68(%rbp)
	jns	L15
	movl	$1, %eax
	subl	-36(%rbp), %eax
	imull	-68(%rbp), %eax
	movl	%eax, -12(%rbp)
L15:
	movl	$0, -4(%rbp)
	jmp	L16
L17:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movd	%rax, %xmm0
	mulsd	-48(%rbp), %xmm0
	movd	%rdx, %xmm1
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rax
	movq	%rax, (%rcx)
	movl	-40(%rbp), %eax
	addl	%eax, -8(%rbp)
	movl	-68(%rbp), %eax
	addl	%eax, -12(%rbp)
	addl	$1, -4(%rbp)
L16:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	L17
	jmp	L7
L13:
	movl	$0, -4(%rbp)
	jmp	L18
L19:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movd	%rax, %xmm0
	mulsd	-48(%rbp), %xmm0
	movd	%rdx, %xmm2
	addsd	%xmm0, %xmm2
	movd	%xmm2, %rax
	movq	%rax, (%rcx)
	addl	$1, -4(%rbp)
L18:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	L19
	nop
L7:
	popq	%rbp
LCFI6:
	ret
LFE19:
	.literal4
	.align 2
LC5:
	.long	1084227584
	.align 2
LC6:
	.long	1325400064
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
LSFDE3:
	.set L$set$7,LEFDE3-LASFDE3
	.long L$set$7
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB19-.
	.set L$set$8,LFE19-LFB19
	.quad L$set$8
	.byte	0
	.byte	0x4
	.set L$set$9,LCFI4-LFB19
	.long L$set$9
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE3:
	.subsections_via_symbols
