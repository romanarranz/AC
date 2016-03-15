/*
	gcc -fopenmp -O2 shared-clause.c -o shared-clause
*/

#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#endif

main()
{
	int i, n = 7;
	int a[n];
	for (i=0; i<n; i++)
		a[i] = i+1;
	
	// Privadas 	-> i
	// Compartidas 	-> a,n 
	// Si el vector o matriz la pusieramos como private
	// 1- Estariamos reservando una copia local de cada uno de ellos en las hebras
	// 2- Copiariamos solo el puntero y no sus datos, por lo que tendriamos basura
	#pragma omp parallel for shared(a,n) private(i) default(none)
	for (i=0; i<n; i++)
		a[i] += i;
	printf("Después de parallel for:\n");
	
	for (i=0; i<n; i++)
		printf("a[%d] = %d\n",i,a[i]);
}