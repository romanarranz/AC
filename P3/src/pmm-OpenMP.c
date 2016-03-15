#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_set_dynamic(0);
	#define omp_set_num_threads(4);
#endif

int main(int argc, char ** argv){
	int **A, **B, **C;
	int	i, k, j, N;
	double cgt1, cgt2, ncgt; 	//para tiempo de ejecución
	time_t t;

	// Semilla de rand()
   	srand((unsigned) time(&t));

	// Obtenemos el numero de filas x columnas de la matriz cuadrada
	if(argc < 4){
		fprintf(stderr,"Error: %s <N_filas> <N_hebras/max> <Chunk default/(0...i)> <Sched (static, dynamic, guided)>\n", argv[0]);
		exit(-1);
	}
	N = atoi(argv[1]);

	// == Directivas de OpenMP
	// ====================================================>
	int chunk = 0;
	omp_sched_t kind;
	if(strcmp(argv[3], "default") == 0)
		omp_get_schedule(&kind, &chunk);
	else
		chunk = atoi(argv[3]);

	// Modificar OMP_SCHEDULE
		 if(strcmp(argv[4], "static") == 0)		omp_set_schedule(1, chunk);
	else if(strcmp(argv[4], "dynamic") == 0)	omp_set_schedule(2, chunk);
	else if(strcmp(argv[4], "guided") == 0)		omp_set_schedule(3, chunk);
	else {
		printf("Error en el metodo de asignacion de trabajo a las hebras (static, dynamic, guided)\n");
		exit(-1);
	}

	int nhebras;
	if(strcmp(argv[2], "max") == 0)	omp_set_num_threads(omp_get_num_procs());
	else {
		nhebras = atoi(argv[2]);
		omp_set_num_threads(nhebras);
	}

	// == Reserva de Memoria
	// ====================================================>
	A = (int**) malloc (N*sizeof(int*));
	B = (int**) malloc (N*sizeof(int*));
	C = (int**) malloc (N*sizeof(int*));

	#pragma omp parallel for shared(A,B,C,N) private(i) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		A[i] = (int*) malloc (N*sizeof(int));
		B[i] = (int*) malloc (N*sizeof(int));
		C[i] = (int*) malloc (N*sizeof(int));
		if( A[i] == NULL || B[i] == NULL || C[i] == NULL){
			printf("Error en la reserva de espacio para las matrices\n");
			exit(-2);
		}
	}
	// == Inicializacion
	// ====================================================>
	#pragma omp parallel for shared(A,B,C,N) private(i,k) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		for(k = 0; k<N; k++){
			A[i][k] = 0;
			B[i][k] = rand() % 8;
			C[i][k] = rand() % 8;
		}
	}

	// == Calculo
	// ====================================================>
	cgt1 = omp_get_wtime();
	#pragma omp parallel for shared(A,B,C,N) private(i,j,k) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		for(j = 0; j<N; j++)
			for(k = 0; k<N; k++)
				A[i][j] += B[i][k] * C[k][j];
	}
	cgt2 = omp_get_wtime();

	ncgt = (double)(cgt2 - cgt1);

	// == Imprimir Mensajes
	// ====================================================>	
	printf("Tiempo(seg.):%11.9f\n", ncgt);
	printf("Tamaño total reservado por las matrices: %lu bytes\n", 3*N*N*sizeof(int));
	printf("Tamaño de las matrices: %ux%u -> %lu bytes\n", N, N, N*N*sizeof(int));
	// Imprimir el primer y último componente del resultado evita que las optimizaciones del compilador 
	// eliminen el código de la suma.
	printf("A[0][0] = %u ... A[N-1][N-1] = %u \n", A[0][0], A[N-1][N-1]);

	if(N < 4){
		printf("\n----------- Matriz B ----------- \n");
				for(i = 0; i<N; i++){
			for(k = 0; k<N; k++)
				printf("%u\t", B[i][k]);
			printf("\n");
		}

		printf("\n----------- Matriz C ----------- \n");
		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++)
				printf("%u\t", C[i][k]);
			printf("\n");
		}

		printf("\n----------- Matriz A (Resultado) ----------- \n");
		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++)
				printf("%u\t", A[i][k]);
			printf("\n");
		}
	}

	// == Liberar Memoria
	// ====================================================>
	#pragma omp parallel for private(i) shared(A,B,C,N) default(none) schedule(runtime)
	for(i = 0; i<N; i++){
		free(A[i]);
		free(B[i]);
		free(C[i]);
	}
	free(A);
	free(B);
	free(C);
}