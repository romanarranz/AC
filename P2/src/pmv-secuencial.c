#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#include <time.h> 		// biblioteca donde se encuentra la función clock_gettime()

int main(int argc, char ** argv){
	int **M;
	int	*v1, *v2;
	int	i, k, N;
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
	v1 = (int *) malloc(N*sizeof(int));
	v2 = (int *) malloc(N*sizeof(int));
	if ( v1 == NULL || v2 == NULL ){
		printf("Error en la reserva de espacio para los vectores\n");
		exit(-2);
	}

	M = (int**) malloc (N*sizeof(int*));
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

	for(i = 0; i<N; i++){
		for(k = 0; k<N; k++)
			M[i][k] = rand() % 8;
	}

	for(i = 0; i<N; i++){
		v1[i] = rand() % 6;
		v2[i] = 0;
	}

	// == Calculo
	// ====================================================>
	clock_gettime(CLOCK_REALTIME,&cgt1);	// iniciamos el cronómetro
	for(i = 0; i<N; i++){
		for(k = 0; k<N; k++)
			v2[i] += M[i][k] * v1[k];
	}
	clock_gettime(CLOCK_REALTIME,&cgt2);	// paramos el cronómetro

	// obtenemos el tiempo que ha transcurrido
	ncgt = (double)(cgt2.tv_sec-cgt1.tv_sec) + (double)((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

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
	for(i = 0; i<N; i++)
		free(M[i]);
	free(M);
}