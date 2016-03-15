/*
El tipo guiado es lo mismo que el tipo dinamico solo que repartimos de forma max(n/h,chunk)

si tenemos 20 iteraciones y 3 hebras => n = 20, h = 3
chunk = 2

- a la primera hebra libre le damos (20/3, 2) => (round(6.66666) = 7, 2) le damos 7	=> n = 20 - 7 = 13
- a la siguiente hebra libre le damos (13/3, 2) => (round(4.3333) = 4,2) => le damos 4 => n = 14 - 4 = 10
.... etc

$ ./bin/scheduleg-clause 20 2
 thread 0 suma a[0]=0 suma=0 
 thread 0 suma a[1]=1 suma=1 
 thread 0 suma a[2]=2 suma=3 
 thread 0 suma a[3]=3 suma=6 
 thread 0 suma a[4]=4 suma=10 
 thread 0 suma a[5]=5 suma=15 
 thread 0 suma a[6]=6 suma=21 
 thread 0 suma a[15]=15 suma=36 
 thread 0 suma a[16]=16 suma=52 
 thread 0 suma a[17]=17 suma=69 
 thread 0 suma a[18]=18 suma=87 
 thread 0 suma a[19]=19 suma=106 
 thread 2 suma a[12]=12 suma=12 
 thread 2 suma a[13]=13 suma=25 
 thread 2 suma a[14]=14 suma=39 
 thread 1 suma a[7]=7 suma=7 
 thread 1 suma a[8]=8 suma=15 
 thread 1 suma a[9]=9 suma=24 
 thread 1 suma a[10]=10 suma=34 
 thread 1 suma a[11]=11 suma=45 
Fuera de 'parallel for' suma=106
*/

#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
	int i, n=20,chunk,a[n],suma=0;
	
	if(argc < 3) {
		fprintf(stderr,"\nFalta iteraciones y/o chunk \n");
		exit(-1);
	}
	
	n = atoi(argv[1]);

	if (n>20)
		n=20;
	chunk = atoi(argv[2]);

	for (i=0; i<n; i++)
		a[i] = i;

	//omp_set_num_threads(3);
	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(guided,chunk)
	for (i=0; i<n; i++){
		suma = suma + a[i];
		printf(" thread %d suma a[%d]=%d suma=%d \n",
		omp_get_thread_num(),i,a[i],suma);
	}

	printf("Fuera de 'parallel for' suma=%d\n",suma);
}