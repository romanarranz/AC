/*
	gcc -fopenmp -O2 src/hola.c -o bin/hola

	Para compilar sin usar openmp y ver que no se ejecutan en paralelo
	es código portable porque nos sirve tanto de forma paralela como de forma normal
	gcc -O2 src/hola.c -o bin/hola

*/

#include <stdio.h>

#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main() {
	int ID;
	#pragma omp parallel private(ID)
	{
	ID = omp_get_thread_num();
	printf("Hello(%d)",ID);
	printf("World(%d)\n",ID);
	}
}