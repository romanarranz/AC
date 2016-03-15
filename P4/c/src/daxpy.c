/*
	Compilacion normal
	$ gcc-4.9 -DDP -DROLL src/daxpy.c -o bin/daxpy

	Compilacion para obtener los ficheros en ensamblador
	$ gcc-4.9 -O0 -DROLL -DDP src/daxpy.c -S -o asm/daxpy 
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h> 		// biblioteca donde se encuentra la función clock_gettime()

#ifdef __MACH__
#include <mach/clock.h> // Biblioteca para medir tiempo en Mac OS X
#include <mach/mach.h>
#endif

#ifdef SP
#define REAL float
#define ZERO 0.0
#define ONE 1.0
#define PREC "Single "
#endif

#ifdef DP
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "
#endif

#ifdef ROLL
#define ROLLING "Rolled "
#endif
#ifdef UNROLL
#define ROLLING "Unrolled "
#endif

void daxpy (int n, REAL da, REAL dx[], int incx, REAL dy[], int incy);

int main(int argc, char ** argv)
{
	// Informacion sobre el Hardware de la maquina usada
	// ====================================================>
	// Intel(R) Core(TM) i5-5257U CPU @ 2.70GHz [x64 Family 6 Model 61 Extmodel 3]
	// FLOPS = [numero de zocalos de CPU] [frecuencia cpu] *[cores/cpu] * [instrucciones por ciclo]
	// FLOPS = 1 * 2.7 * 2 * 2 [multiply + accumulate]
	int cores = 2;
	REAL specification_GFLOPS_computer = 10.8;
	REAL specification_GFLOPS_core = specification_GFLOPS_computer/cores;

	// Declaracion de variables usadas
	// ====================================================>
	int i, N, incx, incy;
	REAL da, *dx, *dy, gflops, mflops, flops;
	struct timespec cgt1,cgt2; double ncgt;	// para tiempo de ejecución
	time_t t;
	
	srand((unsigned int)time(NULL));	// Inicializamos la semilla del rand()

	// Obtenemos el numero de elementos
	if(argc < 2){
		fprintf(stderr,"Falta iteraciones\n");
		exit(-1);
	}
	N = atoi(argv[1]);

	da = 2.0;	// constante real de DAXPY
	incx = 1;	// incrementos para vector dx de DAXPY
	incy = 1;	// incrementos para vector dy de DAXPY

	flops = 5.0*(N);

	
	// == Reserva de Memoria
	// ====================================================>
	dx = (REAL*) malloc (N*sizeof(REAL));
	dy = (REAL*) malloc (N*sizeof(REAL));
	if( dx == NULL || dy == NULL){
		printf("Error en la reserva de espacio para las matrices\n");
		exit(-2);
	}

	// == Inicializacion
	// ====================================================>
	float a = 5.0;
	for(i = 0; i<N; i++){
		dx[i] = ((float)rand()/(float)(RAND_MAX)) * a;	// random de flotantes
		dy[i] = ((float)rand()/(float)(RAND_MAX)) * a;
	}

	// == Calculo
	// ====================================================>
	#ifdef __MACH__
		clock_serv_t cclock;
		mach_timespec_t mts;
		host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
		clock_get_time(cclock, &mts);
		mach_port_deallocate(mach_task_self(), cclock);
		cgt1.tv_sec = mts.tv_sec;
		cgt1.tv_nsec = mts.tv_nsec;
	#else
		clock_gettime(CLOCK_REALTIME, &cgt1);
	#endif

	daxpy(N, da, dx, incx, dy, incy);

	#ifdef __MACH__
		host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
		clock_get_time(cclock, &mts);
		mach_port_deallocate(mach_task_self(), cclock);
		cgt2.tv_sec = mts.tv_sec;
		cgt2.tv_nsec = mts.tv_nsec;
	#else
		clock_gettime(CLOCK_REALTIME, &cgt2);
	#endif

	// obtenemos el tiempo que ha transcurrido
	ncgt = (double)(cgt2.tv_sec-cgt1.tv_sec) + (double)((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));
	
	// cantidad de operaciones en MFLOPS
	mflops = flops/(1.0e6*ncgt);
	gflops = flops/(1.0e9*ncgt);
	
	// == Imprimir Mensajes
	// ====================================================>	
	printf("Tiempo(seg.): %11.9f\n", ncgt);
	printf("MFLOPS/DAXPY: %11.2f\n", mflops);
	printf("GFLOPS/DAXPY: %11.2f\n", gflops);
	printf("GFLOPS/Computer: %f\n", specification_GFLOPS_computer);
	printf("GFLOPS/Core: %f\n", specification_GFLOPS_core);
	printf("Rmax: %f\n", gflops);
	printf("Nmax: %f\n", N);
	printf("N1/2: %f\n", gflops/2);
	printf("Rpico: %f GFLOPS\n", specification_GFLOPS_computer);
} 

void daxpy(int n, REAL da, REAL dx[], int incx, REAL dy[], int incy)
/*
     constant times a vector plus a vector.
     jack dongarra, linpack, 3/11/78.

     n - Nsize
     da - constant REAL 
     dx - array of REAL
     incx - increment of x array
     dy - array of REAL
     incy - increment of y array
*/

{
    int i,ix,iy,m,mp1;

    mp1 = 0;
    m = 0;

    if(n <= 0) return;
    if (da == ZERO) return;

    if(incx != 1 || incy != 1) {

            /* code for unequal increments or equal increments
               not equal to 1                                       */

            ix = 0;
            iy = 0;
            if(incx < 0) ix = (-n+1)*incx;
            if(incy < 0) iy = (-n+1)*incy;
            for (i = 0;i < n; i++) {
                dy[iy] = dy[iy] + da*dx[ix];
                ix = ix + incx;
                iy = iy + incy;
                 
            }
            return;
    }
    
    /* code for both increments equal to 1 */
    

	#ifdef ROLL

       	for (i = 0;i < n; i++) {
            dy[i] = dy[i] + da*dx[i];
        }


	#endif

	#ifdef UNROLL

        m = n % 4;
        if ( m != 0) {
            for (i = 0; i < m; i++) 
                dy[i] = dy[i] + da*dx[i];
                    
            if (n < 4) return;
        }
        for (i = m; i < n; i = i + 4) {
            dy[i] = dy[i] + da*dx[i];
            dy[i+1] = dy[i+1] + da*dx[i+1];
            dy[i+2] = dy[i+2] + da*dx[i+2];
            dy[i+3] = dy[i+3] + da*dx[i+3];
                
        }

	#endif
	return;
}