/*
$ export OMP_NUM_THREADS=3
$ ./bin/if-clause 4
 thread 0 suma de a[0]=0 sumalocal=0 
 thread 0 suma de a[1]=1 sumalocal=1 
 thread 0 suma de a[2]=2 sumalocal=3 
 thread 0 suma de a[3]=3 sumalocal=6 
thread master=0 imprime suma=6

Ya que no se realiza el fork join de las hebras en la region parallel if(n>4)

$ ./bin/if-clause 5
 thread 0 suma de a[0]=0 sumalocal=0 
 thread 0 suma de a[1]=1 sumalocal=1 
 thread 1 suma de a[2]=2 sumalocal=2 
 thread 1 suma de a[3]=3 sumalocal=5 
 thread 2 suma de a[4]=4 sumalocal=4 
thread master=0 imprime suma=10


Ejecucion con omp_set_num_threads(5);
----------------------------------------------
$ ./bin/if-clause 10
 thread 4 suma de a[8]=8 sumalocal=8 
 thread 4 suma de a[9]=9 sumalocal=17 
 thread 1 suma de a[2]=2 sumalocal=2 
 thread 1 suma de a[3]=3 sumalocal=5 
 thread 0 suma de a[0]=0 sumalocal=0 
 thread 0 suma de a[1]=1 sumalocal=1 
 thread 3 suma de a[6]=6 sumalocal=6 
 thread 3 suma de a[7]=7 sumalocal=13 
 thread 2 suma de a[4]=4 sumalocal=4 
 thread 2 suma de a[5]=5 sumalocal=9 
thread master=0 imprime suma=45

Ejecucion con omp_set_num_threads(2);
----------------------------------------------
$ ./bin/if-clause 10 thread 0 suma de a[0]=0 sumalocal=0 
 thread 0 suma de a[1]=1 sumalocal=1 
 thread 0 suma de a[2]=2 sumalocal=3 
 thread 0 suma de a[3]=3 sumalocal=6 
 thread 0 suma de a[4]=4 sumalocal=10 
 thread 1 suma de a[5]=5 sumalocal=5 
 thread 1 suma de a[6]=6 sumalocal=11 
 thread 1 suma de a[7]=7 sumalocal=18 
 thread 1 suma de a[8]=8 sumalocal=26 
 thread 1 suma de a[9]=9 sumalocal=35 
thread master=0 imprime suma=45


Si no especificamos el numero de hebras se utiliza tantas hebras como cores tengamos en el sistema,
sino variable de entorno
sino funcion omp_set_num_threads()

1- omp_set_num_threads
2- export OMP_NUM_THREADS
3- default numCores
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv){
	int i, n=20, tid, h;
	int a[n],suma=0,sumalocal;
	
	if(argc < 3) {
		fprintf(stderr,"[ERROR]-Falta iteraciones y num_threads\n");
		exit(-1);
	}

	n = atoi(argv[1]); if (n>20) n=20;
	h = atoi(argv[2]); if (h>4) h=4;
	for (i=0; i<n; i++) {
		a[i] = i;
	}

	// podemos especificar el numero de hebras directamente
	omp_set_num_threads(h);
	#pragma omp parallel if(n>4) default(none) private(sumalocal,tid) shared(a,suma,n)
	{ 
		sumalocal=0;
		tid=omp_get_thread_num();
		// nowait no necesito que las demas hebras terminen el for porque como tenemos un atomc despues, cuando entre las demas se pararan
		// hasta que la hebra termine de escribir en suma
		#pragma omp for private(i) schedule(static) nowait
		for (i=0; i<n; i++){
			sumalocal += a[i];
			printf(" thread %d suma de a[%d]=%d sumalocal=%d \n", tid,i,a[i],sumalocal);
		}
	
		#pragma omp atomic
		suma += sumalocal;
		#pragma omp barrier

		#pragma omp master
		printf("thread master=%d imprime suma=%d\n",tid,suma);
	}
}