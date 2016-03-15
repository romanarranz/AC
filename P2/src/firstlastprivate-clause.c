/*
	$ gcc -fopenmp -O2 firstlastprivate-clause.c -o firstlastprivate-clause
	$ export OMP_DYNAMIC=FALSE
	$ export OMP_NUM_THREADS=4
	
	$ ./firstlastprivate-clause
	thread 0 suma a[0] suma=0 
	thread 0 suma a[1] suma=1 
	thread 3 suma a[6] suma=6 
	thread 1 suma a[2] suma=2 
	thread 1 suma a[3] suma=5 
 	thread 2 suma a[4] suma=4 
	thread 2 suma a[5] suma=9 

	Fuera de la construcción parallel suma=6

	$ export OMP_NUM_THREADS=2
	$ ./firstlastprivate-clause 
	thread 0 suma a[0] suma=0 
	thread 0 suma a[1] suma=1 
	thread 0 suma a[2] suma=3 
	thread 0 suma a[3] suma=6 
	thread 1 suma a[4] suma=4 
	thread 1 suma a[5] suma=9 
	thread 1 suma a[6] suma=15 

	Fuera de la construcción parallel suma=15

	Basicamente sirve para operaciones de debug en el codigo estas clausulas firstprivate(x) lastprivate(x)
*/
#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main() {
	int i, n = 7;
	int a[n], suma=0;
	for (i=0; i<n; i++)
		a[i] = i;

	// usando firstprivate se inicializa al valor que tuviera esa variable antes, osea el valor que tuviera como variable compartida
	// lastprivate asigna a suma el ultimo valor calculado dentre de la construccion parallel, cuando este bloque termine
	#pragma omp parallel for firstprivate(suma) lastprivate(suma)
		for (i=0; i<n; i++){
			suma = suma + a[i];
			printf(" thread %d suma a[%d] suma=%d \n", omp_get_thread_num(),i,suma);
		}
	
	printf("\nFuera de la construcción parallel suma=%d\n", suma);
}