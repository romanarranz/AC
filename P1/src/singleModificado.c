/*
	$ gcc -fopenmp -O2 src/single.c -o bin/single
	$ ./bin/single 
	Introduce valor de inicialización a: 1
	Single ejecutada por el thread 0
	Depués de la región parallel:
	b[0] = 1	b[1] = 1	b[2] = 1	b[3] = 1	b[4] = 1	b[5] = 1	b[6] = 1	b[7] = 1	b[8] = 1	
*/
#include <stdio.h>
#include <omp.h>

main() {
	int n = 9, i, a, b[n];
	for (i=0; i<n; i++)
		b[i] = -1;
	
	#pragma omp parallel
	{
		#pragma omp single
		{
			printf("Introduce valor de inicialización a: ");
			scanf("%d", &a );
			printf("Single ejecutada por el thread %d\n", omp_get_thread_num());
		}
		#pragma omp for
			for (i=0; i<n; i++){
				b[i] = a;
				printf("b[%d] = %d\t", i, a);
			}
	}
	printf("\n");
}