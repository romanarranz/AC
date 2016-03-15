/*
	gcc -fopenmp -O2 src/critical.c -o bin/critical
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

main(int argc, char **argv) {
	int i, n=20, a[n],suma=0,sumalocal;
	if(argc < 2) {
		fprintf(stderr,"\nFalta iteraciones\n"); exit(-1);
	}
	n = atoi(argv[1]); if (n>20) n=20;
	for (i=0; i<n; i++)
		a[i] = i;
	
	#pragma omp parallel private(sumalocal)
	{ 
		sumalocal=0;
		#pragma omp for schedule(static)
		for (i=0; i<n; i++)
		{ 
			sumalocal += a[i];
			printf(" thread %d suma de a[%d]=%d sumalocal=%d\n", omp_get_thread_num(),i,a[i],sumalocal);
		}// primera barrera en la que todas las hebras tiene su suma parcial
		#pragma omp critical
			suma = suma + sumalocal; // van entrando las hebras para ir conformando la suma total, cada uno contenia su soma parcial
		// aqui no hay barrera
	}
	printf("Fuera de 'parallel' suma=%d\n",suma); return(0);
}