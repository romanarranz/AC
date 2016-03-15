#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#include <time.h> 		// biblioteca donde se encuentra la función clock_gettime()

#ifdef __MACH__
#include <mach/clock.h>				// Biblioteca para medir tiempo en Mac OS X
#include <mach/mach.h>
#endif

int main(int argc, char ** argv){
	int **A, **B, **C;
	int	i, k, j, N;
	struct timespec cgt1,cgt2; double ncgt;		//para tiempo de ejecución
	time_t t;

	// Semilla de rand()
   	srand((unsigned) time(&t));

	// Obtenemos el numero de filas x columnas de la matriz cuadrada
	if(argc < 2){
		fprintf(stderr,"Falta iteraciones\n");
		exit(-1);
	}
	N = atoi(argv[1]);

	// == Reserva de Memoria
	// ====================================================>
	A = (int**) malloc (N*sizeof(int*));
	B = (int**) malloc (N*sizeof(int*));
	C = (int**) malloc (N*sizeof(int*));
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
	for(i = 0; i<N; i++){
		for(k = 0; k<N; k++){
			A[i][k] = 0;
			B[i][k] = rand() % 8;
			C[i][k] = rand() % 8;
		}
	}


	// == Calculo
	// ====================================================>
	#ifdef __MACH__
		clock_serv_t cclock;
		mach_timespec_t mts;
		host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
		clock_get_time(cclock, &mts);
		mach_port_deallocate(mach_task_self(), cclock);
		cgt1.tv_sec = mts.tv_sec;
		cgt1.tv_nsec = mts.tv_nsec;
	#else
		clock_gettime(CLOCK_REALTIME, &cgt1);
	#endif
		
	for(i = 0; i<N; i++){
		for(j = 0; j<N; j++)
			for(k = 0; k<N; k++)
				A[i][j] += B[i][k] * C[k][j];
	}
	
	#ifdef __MACH__
		host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
		clock_get_time(cclock, &mts);
		mach_port_deallocate(mach_task_self(), cclock);
		cgt2.tv_sec = mts.tv_sec;
		cgt2.tv_nsec = mts.tv_nsec;
	#else
		clock_gettime(CLOCK_REALTIME, &cgt2);
	#endif

	// obtenemos el tiempo que ha transcurrido
	ncgt = (double)(cgt2.tv_sec-cgt1.tv_sec) + (double)((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

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
	for(i = 0; i<N; i++){
		free(A[i]);
		free(B[i]);
		free(C[i]);
	}
	free(A);
	free(B);
	free(C);
}