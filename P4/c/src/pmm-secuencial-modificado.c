/*
	file: pmm-secuencial-modificado.c

	Compilacion
	----------------------------

	Ensamblador
	$ gcc-4.9 -O0 src/pmm-secuencial-modificado.c -S -o asm/pmm-secuencial-modificado0.s

	Ejecutable
	$ gcc-4.9 -O0 src/pmm-secuencial-modificado.c -o bin/pmm-secuencial-modificado

	No tiene sentido usar la alineacion puesto que las estructuras que estamos utilizando ya estan alineadas ya que las matrices son de
	doubles que son de 8 bits, sin embargo si tuvieramos un struct de double y char serian 9 bits por lo tanto no se podria completar los
	32 o 64 bits de linea de cache satisfactoriamente por lo que si seria interesante alinearlos.

	La precaptacion tampoco tiene mucho sentido ya que el procesador se encarga de realizarlo por el mismo. Para + info mirar el pdf
	de prefetch.pdf

	Como podemos observar el compilador trata de hacer optimizaciones a la hora de recorrer filas y columnas en el producto de matrices

	- En esta primera implementacion el compilador no trata de optimiza el codigo
	=> ijk-algorithm <=
	public static int[][] ijkAlgorithm(int[][] A, int[][] B) {
    	int n = A.length;
    	int[][] C = new int[n][n];
    	for (int i = 0; i < n; i++) {
        	for (int j = 0; j < n; j++) {
            	for (int k = 0; k < n; k++) {
                	C[i][j] += A[i][k] * B[k][j];
            	}
       	 	}
    	}
    	return C;
	}
	
	a) **** PRIMERA MODIFICACION ****
	- En esta segunda implementacion se producen optimizaciones debido a que realizamos el siguiente cambio:
	Antes : recorremos filas de A y columnas de B
	Ahora : recorremos filas de A y filas de B (más eficiente)

	=> ikj-algorithm <=
	public static int[][] ikjAlgorithm(int[][] A, int[][] B) {
    	int n = A.length;
    	int[][] C = new int[n][n];
    	for (int i = 0; i < n; i++) {
        	for (int k = 0; k < n; k++) {
            	for (int j = 0; j < n; j++) {
                	C[i][j] += A[i][k] * B[k][j];
            	}
        	}
    	}
    	return C;
	}

	b) **** SEGUNDA MOFICACION ****
	   Además podemos realizar una optimizacion de codigo en la segunda implementacion ahorrando al programa a realizar multiples
	   accesos al mismo sitio de la memoria guardando parte de esos accesos en una variable temporal.

	for (int k = 0; k < n; k++) {
        int temp = A[i][k];  
        for (int j = 0; j < n; j++) {
            C[i][j] += temp * B[k][j];
        }
    }

    c) ***** TERCERA MODIFICACION ****
       En esta modificación vamos a utilizar el desenrollado de bucles para reducir un cuarto el tiempo de recorrido
       de los datos obtenidos en las columnas de la matriz B.
       El resto de datos que no podamos obtener por ser el numero de elementos de una fila de la matriz B no divisible entre 4
       los haremos en un bucle aparte.

    if(N>4){

		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++){
				int temp = B[i][k]; 
				for(j = 0; j<N; j+=4){
					A[i][j] += temp * C[k][j];
					A[i][j] += temp * C[k][j+1];
					A[i][j] += temp * C[k][j+2];
					A[i][j] += temp * C[k][j+3];
				}
			}
		}

		int restante = N%4;
		if(restante != 0){
			for(i = 0; i<N; i++){
				for(k = 0; k<N; k++){
					int temp = B[i][k]; 
					for(j = N-4; j<N; j++){
						A[i][j] += temp * C[k][j];
					}
				}
			}
		}
	}
	else {
		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++){
				int temp = B[i][k]; 
				for(j = 0; j<N; j++){
					A[i][j] += temp * C[k][j];
				}
			}
		}
	}

*/

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

	if(N>4){

		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++){
				int temp = B[i][k]; 
				for(j = 0; j<N-4; j+=4){
					A[i][j] += temp * C[k][j];
					A[i][j] += temp * C[k][j+1];
					A[i][j] += temp * C[k][j+2];
					A[i][j] += temp * C[k][j+3];
				}
			}
		}

		int restante = N%4;
		if(restante != 0){
			for(i = 0; i<N; i++){
				for(k = 0; k<N; k++){
					int temp = B[i][k]; 
					for(j = N-N%4; j<N; j++){
						A[i][j] += temp * C[k][j];
					}
				}
			}
		}
	}
	else {
		for(i = 0; i<N; i++){
			for(k = 0; k<N; k++){
				int temp = B[i][k]; 
				for(j = 0; j<N; j++){
					A[i][j] += temp * C[k][j];
				}
			}
		}
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