/*
	$ gcc -fopenmp -O2 src/barrier.c -o bin/barrier
	$ export OMP_NUM_THREADS=4
	$ ./bin/barrier 
	Hebra 0 Tiempo=0 seg.
	Hebra 1 Tiempo=0 seg.
	Hebra 2 Tiempo=3 seg.
	Hebra 3 Tiempo=3 seg.
	
	Si el identificador de la hebra es menor que la mitad esperan 3 segundos y la barrera espera a que todas acaben
	Vamos a usar la directiva barrier cuando haga falta una barrera osea casi nunca.

*/
#include <stdlib.h>
#include <time.h>

#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
	#define omp_get_num_threads() 1
#endif

main() {
	int tid;
	time_t t1,t2;
	#pragma omp parallel private(tid,t1,t2)
	{
		tid = omp_get_thread_num();
		if (tid < omp_get_num_threads()/2 ) system("sleep 3");
			t1= time(NULL);
		
		#pragma omp barrier
			t2= time(NULL)-t1;
		printf("Hebra %d Tiempo=%d seg.\n", tid, t2);
	}
}