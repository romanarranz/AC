// Programa secuencial C que calcula el producto de dos matrices cuadradas M1, M2

#include <stdlib.h>					// Biblioteca para funciones atoi(), malloc() y free()
#include <stdio.h>					// Biblioteca para función printf()
#include <time.h>						// Biblioteca para funcion clock_gettime()

#ifdef __MACH__
#include <mach/clock.h>				// Biblioteca para medir tiempo en Mac OS X
#include <mach/mach.h>
#endif

//#define PRINTF_ALL					// Comentar para quitar el printf que imprime todos los componentes

int main(int argc, char** argv) {

	if(argc < 2) {
		fprintf(stderr, "Uso: %s <Tamaño>\n", argv[0]);
		return -1;
	}
	
	int N = atoi(argv[1]);
	
	double **M1 = (double**) malloc(N*sizeof(double*));	
	double **M2 = (double**) malloc(N*sizeof(double*));
	double **M3 = (double**) malloc(N*sizeof(double*));		// Matriz para el resultado de ejecución	
	
	struct timespec cgt1, cgt2;									// Para el tiempo de ejecución
	double ncgt;
	
	int i, j, k;
	
	if((M1 == NULL) || (M2==NULL) || (M3==NULL)) {
		printf("Error en la reseva de espacio las matrices\n");
		return -2;
	}
		
	for(i=0; i<N; i++)
		M1[i] = (double*) malloc(N*sizeof(double));
	
	for(i=0; i<N; i++)
		M2[i] = (double*) malloc(N*sizeof(double));
		
	for(i=0; i<N; i++)
		M3[i] = (double*) malloc(N*sizeof(double));
	
	// Inicializar Matriz M1
	for(i=0; i<N; i++)
		for(j=0; j<N; j++)
			M1[i][j] = i+j;
	
	// Inicializar Matriz M2
	for(i=0; i<N; i++)
		for(j=0; j<N; j++)
			M2[i][j] = i+j;
	
	// Inicializar Matriz M3
	for(i=0; i<N; i++)
		for(j=0; j<N; j++)
			M3[i][j] = 0;
	
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
	
	// Realizar la multiplicación de M1 por M2
	for(i=0; i<N; i++) {
		for(j=0; j<N; j++)
			for(k=0; k<N; k++)
				M3[i][j] += M1[i][k] * M2[k][j];
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
	
	ncgt = (double) (cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));
	
	// Imprimir el resultado de la multiplicación y el tiempo de ejecución
	#ifdef PRINTF_ALL
		printf("Tiempo(seg.): %11.9f\t / Tamaño Matrices: %u\n", ncgt, N);
	
		printf("M1\n");
		for(i=0; i<N; i++) {
			for(j=0; j<N; j++) 
				printf("%8.6f ", M1[i][j]);
			printf("\n");
		}
		
		printf("M2\n");
		for(i=0; i<N; i++) {
			for(j=0; j<N; j++) 
				printf("%8.6f ", M2[i][j]);
			printf("\n");
		}
		
		printf("M3\n");
		for(i=0; i<N; i++) {
			for(j=0; j<N; j++) 
				printf("%8.6f ", M3[i][j]);
			printf("\n");
		}
		
	#else
		printf("Tiempo(seg.): %11.9f\t / Tamaño Matrices: %u\n		/ M1[0][0]xM2[0]=M3[0][0] %8.6f\n \
		/ M1[%d][%d]*M2[%d][%d]=M3[%d][%d] %8.6f\n", ncgt, N, M3[0][0], N-1, N-1, N-1, N-1, N-1, N-1, M3[N-1][N-1]);
	#endif
	
	// Liberamos la memoria dinámica
	for(i=0; i<N; i++)					// Libera el espacio reservado para cada componente de M1
		free(M1[i]);
	free(M1);								// Libera el espacio reservado para M1
	for(i=0; i<N; i++)					// Libera el espacio reservado para cada componente de M2
		free(M2[i]);
	free(M2);								// Libera el espacio reservado para M2
	for(i=0; i<N; i++)					// Libera el espacio reservado para cada componente de M3
		free(M3[i]);
	free(M3);								// Libera el espacio reservado para M3
	
	return 0;
}
