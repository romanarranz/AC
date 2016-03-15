#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_set_dynamic(0);
	#define omp_set_num_threads(12);
#endif

int main(int argc, char ** argv){
	int **M;
	int	*v1, *v2;
	int	i, k, N;
	double cgt1, cgt2, ncgt; 	//para tiempo de ejecución
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
	// i como private en un for establece que cada hebra tendra una copia de i, pero en parallel for tendra cada una i como sigue
	// i = 0, i = 3, i = 6	para un bucle de N = 9
	#pragma omp parallel for shared(M,N) private(i) default(none)
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
	
	for(i = 0; i<N; i++){
		#pragma omp parallel for shared(M,i,N) private(k) default(none)
		for(k = 0; k<N; k++)
			M[i][k] = rand() % 8;
	}

	#pragma omp parallel for shared(v1,v2,N) private(i) default(none)
	for(i = 0; i<N; i++){
		v1[i] = rand() % 6;
		v2[i] = 0;
	}

	// == Calculo
	// ====================================================>
	cgt1 = omp_get_wtime();
	
	// Dejamos el vector resultado v2 lo dejo como shared para que todas las hebras puedan acceder a el sin necesidad de tener una copia
	// local, pero los accesos a ese vector las hebras lo tienen que hacer de forma atomica sin interfoliaciones.
	for(i = 0; i<N; i++){
		#pragma omp parallel shared(M,i,N,v2,v1) private(k) default(none)
		{
			int sumalocal = 0;
			#pragma omp for
			for(k = 0; k<N; k++)
				sumalocal += M[i][k] * v1[k];
			
			#pragma omp atomic
				v2[i] += sumalocal;
		}
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
	#pragma omp parallel for shared(M,N) private(i) default(none)
	for(i = 0; i<N; i++)
		free(M[i]);
	free(M);
}