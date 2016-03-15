/*
	-O0123  reduce el tiempo de ejecucion porque el compilador busca optimizar las instrucciones maquina
	-Os reduce el tamaño del ejecutable en lugar de optimizar el tiempo

	1- Decodifico Instruc
	2- Capto Operandos
	3- Opero
	4- Almaceno

	1, 2, 3, 4 
	   1, 2, 3, 4

	Paralelismo a nivel de instruccion completamente segmentado
	for(i = 0; i<N; i++)
		tmp += a[i] * b[i];	// se produce un salto por cada operacion matematica


	DESENROLLADO DE BUCLE
	for(i = 0; i<N; i+=4){
		tmp0 += a[i] * b[i];
		tmp1 += a[i+1] * b[i+1];
		tmp2 += a[i+2] * b[i+2];
		tmp3 += a[i+3] * b[i+3];
	}

	ESTO NO ES UN DESENRROLLADO DE BUCLE (porque tenemos menos saltos, pero seguimos teniendo las mismas operaciones)
	for(i = 0; i<N; i+=3){
		tmp+=a[i];
		tmp+=a[i+1];
		tmp+=a[i+2];
	}

	El desenrrollado de bucles: lo que se obtiene es un conjunto de instrucciones independientes para aprovechar la arquitectura del procesador
								en proceso de ejecucion y la segunda ventaja es que tengo un menor numero de saltos en el proceso de ejecucion

	A veces los condicionales sobran:
	for(i = 0, i<100; i++) 100 veces algo, operacion de incremento de y, operacion de asignacion a 0 y comprobacion de y con 100 (~300 ops)
		if(i%2 == 0)
			a[i] = x
		else
			a[i] = y;

	for(i = 0; i<100; i+=2){ hacemos la mitad (~150 ops)
		a[i] = x;
		a[i+1] = y; 
	}

	------------- CODIGO AMBIGUO ------------------
	int j;
	void mars (init *v){
		j = 7.0;
		*v=15;	// quien me dice que v no apunta a j para decir que j es igual a 1 cuando acabe la ejecucion ed este codigo
		j/7;
		..........
	}	

	El abuso de punteros hace que el compilador esté manco.
	Hace que el codigo sea obtuso (dificil de leer), de gestionar de manipular etc...
	Y a parte dificultan la labor del compilador para optimizar ciertas cosas

	------- MANDAR PUNTEROS ALINEADOS A LA CACHE -------------
	Si tenems un cuello de botella podemos mandar los datos alineados de la RAM a la Caché cono lo siguiente:
	BOUND = 32; // para sistemas de 32 para sistemas de 64 bits ponemos BOUND = 64
	p = (struct s*) malloc (sizeof() BOUND-1);
	new_p = (struct s*) ((int) p + BOUND-1) & ~(BOUND-1)

	Forzamos un alineamiento
	1. Reservamos mas memoria de la cuenta
	2. Forzamso a que ese puntero este en la siguiente linea
	3. A ese puntero le ponemos su ultimo bit a 0 y por lo tanto quedan alineados
	
	En hexadecimal
	p = A 7 3 4 8 9
	new_p = A 7 3 4 8 0

	Podemos mejorar un 40% la velocidad ya que no se producen el doble de fallos de liena de cache

	---- CACHES DE MEMORIIAS ASOCIATIVAS ----
	Comprueban a traves de hw si un dato esta en unas lineas de cache
	pero a fin de cuentas tarda tiempo ya que aun en paralelo llva tiempo

	---- CACHES DIRECTAS --------
	la memoria comprueba un dato de la sgueinte forma P[ 6bits indican la linea de cache, 6 bits indican el offset dentro de esa linea]
	Si se hacen 2 comprobaciones simultaneas a la misma linea y offset el programa da fallo continuo de cache

	---- CACHES ASOCIATIVAS POR CONJUNTOS -------
	Mezcla de las 2 se manda un dato de RAM al bloque de caché que se indique.
	La caché ahora se compone por Nbloques y cada bloque tiene 8 conjuntos.

	Cuando se quiere consultar ese dato se busca dentro de todas las lineas del bloque de una vez.

	Se debe recorrer las matrices por filas para que se lleven los vectores a la cache y no se produzcan fallos de cache,
	si lo recorremos en columnas es como si no tuvieramos cache.

*/

#include <stdio.h>
#include <math.h>
#include <time.h>

#ifdef __MACH__
#include <mach/clock.h>				// Biblioteca para medir tiempo en Mac OS X
#include <mach/mach.h>
#endif

int suma_prod(int a, int b, int n);

main(){
	int i,j,a,b,n,c;
	clock_t start,stop;

	start = clock();
		n=6000;a=1;b=2;
		for (j=1;j<=10000;j++){
			printf("a=%d b=%d n=%d\n",a,b,n);
			c=suma_prod(a,b,n);
			printf("resultado= %d\n",c);
		}
	stop = clock();

	printf("Tiempo= %f",difftime(stop,start));
	return 0;
}