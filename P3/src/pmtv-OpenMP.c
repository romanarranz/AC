/*
	gcc -fopenmp -O2 src/pmtv-OpenMP.c -o bin/pmtv-OpenMP
*/
#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_set_dynamic(0);
	#define omp_set_num_threads(4);
#endif

int main(int argc, char ** argv){
	int **M;
	int	*v1, *v2;
	int	i, k, a, N;
	double cgt1, cgt2, ncgt; 	//para tiempo de ejecución
	time_t t;

	// Semilla de rand()
   	srand((unsigned) time(&t));

	// Obtenemos el numero de filas x columnas de la matriz cuadrada
	if(argc < 4){
		fprintf(stderr,"Error: %s <N_filas> <Chunk (0...I)> <Sched (static, dynamic, guided)>\n", argv[0]);
		exit(-1);
	}
	N = atoi(argv[1]);

	// == Directivas de OpenMP
	// ====================================================>
	int chunk = 0;
	omp_sched_t kind;
	if(strcmp(argv[2], "default") == 0)
		omp_get_schedule(&kind, &chunk);
	else
		chunk = atoi(argv[2]);

	// Modificar OMP_SCHEDULE
		 if(strcmp(argv[3], "static") == 0)		omp_set_schedule(1, chunk);
	else if(strcmp(argv[3], "dynamic") == 0)	omp_set_schedule(2, chunk);
	else if(strcmp(argv[3], "guided") == 0)		omp_set_schedule(3, chunk);
	else {
		printf("Error en el metodo de asignacion de trabajo a las hebras (static, dynamic, guided)\n");
		exit(-1);
	}

	// El numero de hebras que se vayan a usar debe ser el mismo que el numero de procesadores disponibles
	omp_set_num_threads(omp_get_num_procs());

	// == Reserva de Memoria
	// ====================================================>
	v1 = (int *) malloc(N*sizeof(int));
	v2 = (int *) malloc(N*sizeof(int));
	if ( v1 == NULL || v2 == NULL ){
		printf("Error en la reserva de espacio para los vectores\n");
		exit(-2);
	}

	M = (int**) malloc (N*sizeof(int*));
	// i como private en un for establece que cada hebra tendra una copia de i, pero en parallel for tendra cada una i como sigue
	// i = 0, i = 3, i = 6	para un bucle de N = 9
	#pragma omp parallel for shared(M,N) private(i) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		M[i] = (int*) malloc (N*sizeof(int));
		if( M[i] == NULL ){
			printf("Error en la reserva de espacio para los vectores\n");
			exit(-2);
		}
	}
	// == Inicializacion
	// ====================================================>
	// M, v1, v2, N, i compartidas
	// Cada hebra se encargará de una parte del bucle usando i

	// k es privada
	// Para que cada hebra que este calculando la parte iesima del bucle y tenga una copia de k = 0 propia, parte k es secuencial
	#pragma omp parallel for shared(N,M) private(i,k,a) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		if(i>0){
			for(a = 0; a<i; a++)
				M[i][a] = 0;
			for(k = a; k<N; k++)
				M[i][k] = rand() % 8;
		}
		else {
			for(k = 0; k<N; k++){
				M[i][k] = rand() % 8;
			}
		}
	}

	#pragma omp parallel for shared(v1,v2,N) private(i) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		v1[i] = rand() % 6;
		v2[i] = 0;
	}

	// == Calculo
	// ====================================================>
	cgt1 = omp_get_wtime();
	#pragma omp parallel for shared(v1,v2,M,N) private(i,k) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		for(k = i; k<N; k++)
			v2[i] += M[i][k] * v1[k];
		
	}
	cgt2 = omp_get_wtime();

	ncgt = (double)(cgt2 - cgt1);

	// == Imprimir Mensajes
	// ====================================================>	
	printf("Tiempo(seg.):%11.9f\n", ncgt);
	printf("Tamaño de los vectores: %u\n", N);
	printf("\tv1 = %uElem -> %lu bytes\n\tv2 = %uElem -> %lu bytes\n", N, N*sizeof(int), N, N*sizeof(int));
	printf("Tamaño de la matriz: %ux%u -> %lu bytes\n", N, N, N*N*sizeof(int));
	// Imprimir el primer y último componente del resultado evita que las optimizaciones del compilador 
	// eliminen el código de la suma.
	printf("v2[0] = %u ... v2[N-1] = %u \n", v2[0], v2[N-1]);

	// Para tamaños pequeños de N < 15 mostrar los valores calculados
	if(N < 15){
		printf("\n----------- Matriz M ----------- \n");
		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++)
				printf("%u\t", M[i][k]);
			printf("\n");
		}
		printf("\n----------- Vector V1 ----------- \n");
		for(i = 0; i<N; i++)
			printf("%u\t", v1[i]);
		printf("\n");

		printf("\n----------- Vector V2----------- \n");
		for(i = 0; i<N; i++)
			printf("%u\t", v2[i]);
		printf("\n");
	}

	// == Liberar Memoria
	// ====================================================>
	free(v1);
	free(v2);
	#pragma omp parallel for shared(M,N) private(i) default(none) schedule(runtime)
	for(i = 0; i<N; i++)
		free(M[i]);
	free(M);
}