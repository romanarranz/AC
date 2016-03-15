#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
	omp_sched_t kind;
  	int modifier;

	int i, n=200,chunk,a[n],suma=0;
	if(argc < 3) {
		fprintf(stderr,"\nFalta iteraciones o chunk \n");
		exit(-1);
	}

	n = atoi(argv[1]);
	if (n>200)
		n=200; 
	chunk = atoi(argv[2]);

	for (i=0; i<n; i++) 
		a[i] = i;
	
	printf("Dentro de 'parallel'\n");
	//omp_set_num_threads(3);
	#pragma omp parallel 
	{
		#pragma omp for firstprivate(suma) lastprivate(suma) schedule(dynamic,chunk)
		for (i=0; i<n; i++){
			suma = suma + a[i];
			printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma);
		}

		#pragma omp master
		{
			// imprimir dyn-var
			printf("\tdyn-var => %d\n", omp_get_dynamic());
			// imprimir nthreads-var
			printf("\tnthreads-var => %d\n", omp_get_max_threads());
			// imprimir thread-limit-var
			printf("\tthread-limit-var => %d\n", omp_get_thread_limit());
			// imprimir run-sched-var
			omp_get_schedule(&kind, &modifier);
			printf("\trun-sched-var => kind : %d modifier : %d\n", kind, modifier);
		}
	}

	printf("\nFuera de 'parallel' suma=%d\n",suma);

	// imprimir dyn-var
	printf("\tdyn-var => %d\n", omp_get_dynamic());
	// imprimir nthreads-var
	printf("\tnthreads-var => %d\n", omp_get_max_threads());
	// imprimir thread-limit-var
	printf("\tthread-limit-var => %d\n", omp_get_thread_limit());
	// imprimir run-sched-var
	omp_get_schedule(&kind, &modifier);
	printf("\trun-sched-var => kind : %d modifier : %d\n", kind, modifier);
}