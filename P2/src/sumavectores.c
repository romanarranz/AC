#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
main(int argc, char **argv) {
	int i, n=20, a[n], suma=0;
	
	if(argc < 2) {
		fprintf(stderr,"\nFalta iteraciones\n");
		exit(-1);
	}
	n = atoi(argv[1]); if (n>20) n=20;
	for (i=0; i<n; i++)
		a[i] = i;

	// Las variables fuera de omp parallel son compartidas
	#pragma omp parallel
	{
		// Cada hebra tiene su propia sumalocal = 0 ya que tiene esta variable local por cada una de las hebras
		int sumalocal = 0;

		// Solo los indices de pragma omp for tiene que ser variables privadas para que hagan sus propias iteraciones
		#pragma omp for schedule(static)
		for(i = 0; i<n; i++){
			sumalocal += a[i];
			printf("thread %d suma de a[%d]=%d sumalocal=%d \n",
			omp_get_thread_num(),i,a[i],sumalocal);
		}

		// definimos una seccion critica para que no se produzcan conflictos en las sumas producidas por cada hebra
		#pragma omp atomic
			suma += sumalocal;
	}
	printf("Fuera de 'parallel' suma=%d\n",suma); return(0);
}