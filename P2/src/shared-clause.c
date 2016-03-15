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
	
	// Se comparte la variable a por todas las hebras --> shared(a)
	#pragma omp parallel for shared(a)
	for (i=0; i<n; i++)
		a[i] += i;
	printf("Después de parallel for:\n");
	
	for (i=0; i<n; i++)
		printf("a[%d] = %d\n",i,a[i]);
}