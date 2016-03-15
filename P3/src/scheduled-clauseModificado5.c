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
			// Modificar dyn-var
			// ======================================================>
			// imprimir dyn-var
			printf("\tdyn-var antes => %d\n", omp_get_dynamic());
			// modificar dyn-var
			omp_set_dynamic(1);
			// imprimr dyn-var
			printf("\tdyn-var despues => %d\n", omp_get_dynamic());

			// Modificar nthreads-var
			// ======================================================>
			// imprimir nthreads-var
			printf("\tnthreads-var antes => %d\n", omp_get_max_threads());
			// modificar nthreads-var
			omp_set_num_threads(4);
			// imprimir nthreads-var
			printf("\tnthreads-var despues => %d\n", omp_get_max_threads());

			// imprimir thread-limit-var
			printf("\tthread-limit-var => %d\n", omp_get_thread_limit());
	
			// Modificar run-sched-var
			// ======================================================>
			// imprimir run-sched-var
			omp_get_schedule(&kind, &modifier);
			printf("\trun-sched-var antes => kind : %d modifier : %d\n", kind, modifier);
			// omp_set_schedule(kind, modifier) 
			// kind 0 -> auto, 1 -> static, 2 -> dynamic, 3 -> guided
			// modifier es la granularidad
			omp_set_schedule(2, 6);
			// imiprimir run-sched-var
			omp_get_schedule(&kind, &modifier);
			printf("\trun-sched-var despues => kind : %d modifier : %d\n", kind, modifier);

			// imprimir omp_get_num_threads() "numero de threads usadas en una region paralela"
			printf("\thebras usadas en la region paralela => %d\n", omp_get_num_threads());
			// imprimir omp_get_num_procs() "numero de procesadores disponibles para el programa"
			printf("\tprocesadores disponibles => %d\n", omp_get_num_procs());
			// imprimr omp_in_parallel() "true si se llama en un parallel, false en caso contrario"
			printf("\t¿region paralela? => %d\n", omp_in_parallel());
		}
	}

	printf("\nFuera de 'parallel' suma=%d\n",suma);

	// imprimir dyn-var
	printf("\tdyn-var antes => %d\n", omp_get_dynamic());
	// modificar dyn-var
	omp_set_dynamic(1);
	// imprimr dyn-var
	printf("\tdyn-var despues => %d\n", omp_get_dynamic());	

	// Modificar nthreads-var
	// ======================================================>
	// imprimir nthreads-var
	printf("\tnthreads-var antes => %d\n", omp_get_max_threads());
	// modificar nthreads-var
	omp_set_num_threads(4);
	// imprimir nthreads-var
	printf("\tnthreads-var despues => %d\n", omp_get_max_threads());

	// imprimir thread-limit-var
	printf("\tthread-limit-var => %d\n", omp_get_thread_limit());
	
	// Modificar run-sched-var
	// ======================================================>
	// imprimir run-sched-var
	omp_get_schedule(&kind, &modifier);
	printf("\trun-sched-var antes => kind : %d modifier : %d\n", kind, modifier);
	// omp_set_schedule(kind, modifier) 
	// kind 0 -> auto, 1 -> static, 2 -> dynamic, 3 -> guided
	// modifier es la granularidad
	omp_set_schedule(1, 4);
	// imiprimir run-sched-var
	omp_get_schedule(&kind, &modifier);
	printf("\trun-sched-var despues => kind : %d modifier : %d\n", kind, modifier);

	// imprimir omp_get_num_threads() "numero de threads usadas en una region paralela"
	printf("\thebras usadas fuera de la region paralela => %d\n", omp_get_num_threads());
	// imprimir omp_get_num_procs() "numero de procesadores disponibles para el programa"
	printf("\tprocesadores disponibles => %d\n", omp_get_num_procs());
	// imprimr omp_in_parallel() "true si se llama en un parallel, false en caso contrario"
	printf("\t¿region paralela? => %d\n", omp_in_parallel());
}