/*
	gcc -fopenmp -O2 private-clause.c -o private-clause
	export OMP_DYNAMIC=FALSE
	export OMP_NUM_THREADS=2

	$ ./private-clause
	thread 0 suma a[0] / thread 0 suma a[1] / thread 0 suma a[2] / thread 0 suma a[3] / thread 1 suma a[4] / thread 1 suma a[5] / thread 1 suma a[6] / 
	* thread 0 suma= 6
	* thread 1 suma= 15
*/

#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main()
{
	int i, n = 7;
	int a[n], suma = 18;
	for (i=0; i<n; i++)
		a[i] = i;

	printf("-- suma_antes_de_parallel = %i\n", suma);
	//Utilizar private es un peligro, en el momento en que una variable compartida la vuelvo privada, se inicializan si o si a basura y se pierde su valor anterior
	#pragma omp parallel private(suma)
	{
		// si comentamos la variable suma "la de aqui debajo" vemos como se suma basura
		suma=0;
		#pragma omp for
		for (i=0; i<n; i++){
			suma = suma + a[i];
			printf("thread %d suma a[%d] / ", omp_get_thread_num(), i);
		}
		printf("\n* thread %d suma= %d", omp_get_thread_num(), suma);
	}
	printf("\n");
	printf("-- suma = %i\n", suma);
}