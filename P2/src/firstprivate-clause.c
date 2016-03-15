/*
	gcc -fopenmp -O2 firstprivate-clause.c -o firstprivate-clause
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

	// La clausula firstprivate(suma) fuerza a que haya una variable suma privada a cada thread y a que 
	// esta variable se inicialice al valor que tiene la variable compartida suma declarada en el thread master.
	#pragma omp parallel for firstprivate(suma)
		for (i=0; i<n; i++){
			suma = suma + a[i];
			printf(" thread %d suma a[%d] suma=%d \n", omp_get_thread_num(),i,suma);
		}
	
	printf("\nFuera de la construcción parallel suma=%d\n", suma);
}