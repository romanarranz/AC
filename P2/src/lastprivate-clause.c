/*
	gcc -fopenmp -O2 lastprivate-clause.c -o lastprivate-clause
*/
#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main() {
	int i, n = 7;
	int a[n], v;
	for (i=0; i<n; i++)
		a[i] = i+1;
	
	// asigna el valor de la variable que estamos haciendo privada y tras el parallel SÍ conserva el valor que tenga al salir del parallel
	#pragma omp parallel for lastprivate(v)
		for (i=0; i<n; i++){
			v = a[i];
			printf("thread %d v=%d / ", omp_get_thread_num(), v);
		}
	printf("\nFuera de la construcción'parallel for' v=%d\n", v);
}