/*
	$ gcc -fopenmp -O2 reduction-clause.c -o reduction-clause
*/
#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
	int i, n=20, a[n],suma=0;
	
	if(argc < 2) {
		fprintf(stderr,"Falta iteraciones\n");
		exit(-1);
	}
	
	n = atoi(argv[1]); 
	if (n>20){
		n=20; 
		printf("n=%d\n",n);
	}
	
	for (i=0; i<n; i++) 
		a[i] = i;
	
	// Sobre una variable que fuera de reduction es compartida, realiza un calculo acumulativo (global)
	// de forma que dentro de reduction la varibale se comporta como private

	// realiza calculos de forma privada para los calculos que le toquen, y al salir de reduction 
	// se asigna el resultado en la variable que vuelve a ser compartida 
	#pragma omp parallel for reduction(+:suma)
	for (i=0; i<n; i++)
		suma += a[i];
	
	printf("Tras 'parallel' suma=%d\n",suma);
}