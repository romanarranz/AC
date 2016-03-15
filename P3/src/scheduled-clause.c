/*
Ventajas del tiempo dinamco frente al estatico es que se optimiza el tiempo de ejecucion, ya que vamos repartiendo conforme las hebras van 
quedando libres.

Inconvenientes del tipo dinamico es que consume mas recursos que el tipo estatico, ya que la comunicacion de las hebras es mas costosa

Se utiliza cuando desconozco el tiempo de ejecucion del codigo y obtengo resultados diferentes en varias mediciones de tiempo.

$ ./bin/scheduled-clause 7 2
 thread 0 suma a[2]=2 suma=2 
 thread 0 suma a[3]=3 suma=5 
 thread 0 suma a[6]=6 suma=11 
 thread 1 suma a[4]=4 suma=4 
 thread 1 suma a[5]=5 suma=9 
 thread 2 suma a[0]=0 suma=0 
 thread 2 suma a[1]=1 suma=1 
Fuera de 'parallel for' suma=11

Ejemplo omp_set_num_threads(3);
-------------------------------------
$ ./bin/scheduled-clause 20 5
 thread 0 suma a[0]=0 suma=0 
 thread 0 suma a[1]=1 suma=1 
 thread 0 suma a[2]=2 suma=3 
 thread 0 suma a[3]=3 suma=6 
 thread 0 suma a[4]=4 suma=10 
 thread 0 suma a[15]=15 suma=25 
 thread 0 suma a[16]=16 suma=41 
 thread 0 suma a[17]=17 suma=58 
 thread 0 suma a[18]=18 suma=76 
 thread 0 suma a[19]=19 suma=95 
 thread 1 suma a[10]=10 suma=10 
 thread 1 suma a[11]=11 suma=21 
 thread 1 suma a[12]=12 suma=33 
 thread 1 suma a[13]=13 suma=46 
 thread 1 suma a[14]=14 suma=60 
 thread 2 suma a[5]=5 suma=5 
 thread 2 suma a[6]=6 suma=11 
 thread 2 suma a[7]=7 suma=18 
 thread 2 suma a[8]=8 suma=26 
 thread 2 suma a[9]=9 suma=35 
Fuera de 'parallel for' suma=95

Tal como van quedando libres las hebras se va asignando trabajo a ellas, de esta manera tenemos siempre las hebras trabajando
y forzamos a que no esten las hebras ociosas.

*/

#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
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
	
	//omp_set_num_threads(3);
	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(dynamic,chunk)
	for (i=0; i<n; i++){
		suma = suma + a[i];
		printf(" thread %d suma a[%d]=%d suma=%d \n",
		omp_get_thread_num(),i,a[i],suma);
	}
	
	printf("Fuera de 'parallel for' suma=%d\n",suma);
}