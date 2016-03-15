/*
$ ./bin/schedule-clause 2
 thread 1 suma a[2] suma=2 
 thread 1 suma a[3] suma=5 
 thread 2 suma a[4] suma=4 
 thread 2 suma a[5] suma=9 
 thread 0 suma a[0] suma=0 
 thread 0 suma a[1] suma=1 
 thread 0 suma a[6] suma=7 
Fuera de 'parallel for' suma=7

Las iteraciones 0,1 las hace hebra 0
las iteraciones 2,3 las hace hebra 1
las iteraciones 4,5 las hace hebra 2
las iteraciones 6   las hace hebra 0

$ ./bin/schedule-clause 4
 thread 1 suma a[4] suma=4 
 thread 1 suma a[5] suma=9 
 thread 1 suma a[6] suma=15 
 thread 0 suma a[0] suma=0 
 thread 0 suma a[1] suma=1 
 thread 0 suma a[2] suma=3 
 thread 0 suma a[3] suma=6 
Fuera de 'parallel for' suma=15

Las iteraciones 0,1,2,3 han sido hechas por la hebra 0
las iteraciones	4,5,6   han sido hechas por la hebra 1

*/

#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
	int i, n = 16,chunk, a[n],suma=0;
	
	if(argc < 2) {
		fprintf(stderr,"\nFalta chunk \n");
		exit(-1);
	}

	// numero de iteraciones que se reparten en las hebras si ponemos un 2 y tenemos 4 hebras se reparten asi
	// hebra 0 -> i = 0
	// hebra 1 -> i = 2
	// hebra 2 -> i = 4
	// hebra 3 -> i = 6
	chunk = atoi(argv[1]);	

	// las variables static se asignan en tiempo de compilacion

	for (i=0; i<n; i++) a[i] = i;
	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(static,chunk)
		for (i=0; i<n; i++){
			suma = suma + a[i];
			printf(" thread %d suma a[%d] suma=%d \n", omp_get_thread_num(),i,suma);
		}
	
	printf("Fuera de 'parallel for' suma=%d\n",suma);
}