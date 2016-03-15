/*
	$ gcc -fopenmp -O2 src/master.c -o bin/master

	master lo ejecuta solo la hebra 0
	diferencias entre single y master:
	- single se parece a master, pero en single es la primera que llegue y la master la ejecuta la hebra 0
	- master no tiene barrera, single si

	$ export OMP_NUM_THREADS=3
	$ ./bin/master 6
	 thread 0 suma de a[0]=0 sumalocal=0
	 thread 0 suma de a[1]=1 sumalocal=1
	 thread 1 suma de a[2]=2 sumalocal=2
	 thread 1 suma de a[3]=3 sumalocal=5
	 thread 2 suma de a[4]=4 sumalocal=4
	 thread 2 suma de a[5]=5 sumalocal=9
	thread master=0 imprime suma=15

*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv) {
	int i, n=20, tid, a[n],suma=0,sumalocal;
	if(argc < 2) {
		fprintf(stderr,"\nFalta iteraciones\n");
		exit(-1);
	}

	n = atoi(argv[1]); 
	if (n>20) 
		n=20;
	for (i=0; i<n; i++)
		a[i] = i;
	#pragma omp parallel private(sumalocal,tid)
	{ 
		sumalocal=0;
		tid=omp_get_thread_num();
		#pragma omp for schedule(static)
		for (i=0; i<n; i++)
		{ 
			sumalocal += a[i];
			printf(" thread %d suma de a[%d]=%d sumalocal=%d\n", tid,i,a[i],sumalocal);
		}
		#pragma omp atomic
			suma += sumalocal;
		#pragma omp barrier
			#pragma omp master
				printf("thread master=%d imprime suma=%d\n",tid,suma);
	}
}