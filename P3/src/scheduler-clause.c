/*

Se ve si es estatico, dinamico o guiado

O bien se toma de la variable de control run-sched-var
o de la variable de entorno OMP_SCHEDULE
o bien omp_set_schedule(kind,modifier)

1.- run-sched-var
2.- OMP_SCHEDULE
3.- omp_set_schedule(kind,modifier)

$ export OMP_SCHEDULE="static,2"
$ ./bin/scheduler-clause 8
 thread 0 suma a[0]=0 suma=0 
 thread 0 suma a[1]=1 suma=1 
 thread 0 suma a[6]=6 suma=7 
 thread 0 suma a[7]=7 suma=14 
 thread 2 suma a[4]=4 suma=4 
 thread 2 suma a[5]=5 suma=9 
 thread 1 suma a[2]=2 suma=2 
 thread 1 suma a[3]=3 suma=5 
Fuera de 'parallel for' suma=14


$ export OMP_SCHEDULE="dynamic,2"
$ ./bin/scheduler-clause 8
 thread 1 suma a[0]=0 suma=0 
 thread 1 suma a[1]=1 suma=1 
 thread 1 suma a[6]=6 suma=7 
 thread 1 suma a[7]=7 suma=14 
 thread 0 suma a[4]=4 suma=4 
 thread 0 suma a[5]=5 suma=9 
 thread 2 suma a[2]=2 suma=2 
 thread 2 suma a[3]=3 suma=5


$ export OMP_SCHEDULE="guided,2"
$ ./bin/scheduler-clause 8
 thread 0 suma a[0]=0 suma=0 
 thread 0 suma a[1]=1 suma=1 
 thread 0 suma a[2]=2 suma=3 
 thread 0 suma a[7]=7 suma=10 
 thread 1 suma a[3]=3 suma=3 
 thread 1 suma a[4]=4 suma=7 
 thread 2 suma a[5]=5 suma=5 
 thread 2 suma a[6]=6 suma=11 
Fuera de 'parallel for' suma=10

Representacion de los 3 tipos defindos en los ejemplos default, scheduled-clause.c, scheduleg-clause.c
*/

#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
	int i, n=20,a[n],suma=0;
	if(argc < 2) {
		fprintf(stderr,"\nFalta iteraciones \n");
		exit(-1);
	}
	
	n = atoi(argv[1]); 	
	if (n>20) 
		n=20;

	for (i=0; i<n; i++) 
		a[i] = i;
	
	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(runtime)
	for (i=0; i<n; i++){
		suma = suma + a[i];
		printf(" thread %d suma a[%d]=%d suma=%d \n",
		omp_get_thread_num(),i,a[i],suma);
	}
	
	printf("Fuera de 'parallel for' suma=%d\n",suma);
}