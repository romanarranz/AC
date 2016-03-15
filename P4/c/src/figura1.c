/*
	a) **** PRIMERA MODIFICACION ****
	Combinar los cuerpos de varios bucles en un solo bucle.
	Unión balanceada de operaciones.
	La primera modificacion que podemos hacer es aunar los bucles anidados intermedios para ya que estos tienen
	el mismo rango de recorrido y asi ahorramos bastante tiempo de computo (para que recorrer dos veces lo mismo?)

	for (ii=1; ii<=40000; ii++) {
		X1 = 0;
		X2 = 0;
		
		for(i=0; i<5000; i++){
			X1 += s[i].a << 1 + ii;
			X2 += 3 * s[i].b - ii;
		}
		
		if (X1<X2){
			R[ii]=X1;
		}
		else {
			R[ii]=X2;
		}
	}

	b) **** SEGUNDA MODIFICACION ****
	Reemplazo de multiplicaciones/divisiones enteras por operaciones de desplazamiento.
	(No es factible puesto que tarda mas tiempo) pero nos servira como caso de estudio
	Desenrollado de bucle interno (nos ahorramos saltos N/4)

	register int X11, X12, X13, X14;
	register int X21, X22, X23, X24;

	for (ii=1; ii<=40000; ii++) {
		X1 = X11 = X12 = X13 = X14 = 0;
		X2 = X21 = X22 = X23 = X24 = 0;
		
		for(i=0; i<5000; i+=4){
			X11 += s[i].a << 1 + ii;
			X12 += s[i+1].a << 1 + ii;
			X13 += s[i+2].a << 1 + ii;
			X14 += s[i+3].a << 1 + ii;

			X21 += 3 * s[i].b - ii;
			X22 += 3 * s[i+1].b - ii;
			X23 += 3 * s[i+2].b - ii;
			X24 += 3 * s[i+3].b - ii;
		}
		X1 = X11 + X12 + X13 + X14;
		X2 = X21 + X22 + X23 + X24;
		
		if (X1<X2){
			R[ii]=X1;
		}
		else {
			R[ii]=X2;
		}
	}

	c) **** TERCERA MODIFICACION ****
	Desenrollado de bucle externo

	register int X11, X12, X13, X14;
	register int X21, X22, X23, X24;

	for (ii=1; ii<=40000; ii+=4) {
		X1 = X11 = X12 = X13 = X14 = 0;
		X2 = X21 = X22 = X23 = X24 = 0;
		
		for(i=0; i<5000; i+=4){
			X11 += s[i].a << 1 + ii;
			X12 += s[i+1].a << 1 + ii;
			X13 += s[i+2].a << 1 + ii;
			X14 += s[i+3].a << 1 + ii;

			X11 += s[i].a << 1 + ii+1;
			X12 += s[i+1].a << 1 + ii+1;
			X13 += s[i+2].a << 1 + ii+1;
			X14 += s[i+3].a << 1 + ii+1;

			X11 += s[i].a << 1 + ii+2;
			X12 += s[i+1].a << 1 + ii+2;
			X13 += s[i+2].a << 1 + ii+2;
			X14 += s[i+3].a << 1 + ii+2;

			X11 += s[i].a << 1 + ii+3;
			X12 += s[i+1].a << 1 + ii+3;
			X13 += s[i+2].a << 1 + ii+3;
			X14 += s[i+3].a << 1 + ii+3;

			
			X21 += 3 * s[i].b - ii;
			X22 += 3 * s[i+1].b - ii;
			X23 += 3 * s[i+2].b - ii;
			X24 += 3 * s[i+3].b - ii;

			X21 += 3 * s[i].b - ii+1;
			X22 += 3 * s[i+1].b - ii+1;
			X23 += 3 * s[i+2].b - ii+1;
			X24 += 3 * s[i+3].b - ii+1;

			X21 += 3 * s[i].b - ii+2;
			X22 += 3 * s[i+1].b - ii+2;
			X23 += 3 * s[i+2].b - ii+2;
			X24 += 3 * s[i+3].b - ii+2;

			X21 += 3 * s[i].b - ii+3;
			X22 += 3 * s[i+1].b - ii+3;
			X23 += 3 * s[i+2].b - ii+3;
			X24 += 3 * s[i+3].b - ii+3;
		}
		X1 = X11 + X12 + X13 + X14;
		X2 = X21 + X22 + X23 + X24;
		
		if (X1<X2){
			R[ii]=X1;
			R[ii+1]=X1;
			R[ii+2]=X1;
			R[ii+3]=X1;
		}
		else {
			R[ii]=X2;
			R[ii+1]=X2;
			R[ii+2]=X2;
			R[ii+3]=X2;
		}
	}

	d) **** CUARTA MODIFICACION ****
	Desenrollado de bucle interno (de nuevo) pero con variables temporales que no se acumulan sino que las sumamos a otro registro.
	Y ademas he eliminado el else de la condicion de sentencia asignando por omision en primer lugar R[ii] = X2 y comprobando con un
	if despues, con esto ahorramos un salto.
	int X11, X12, X13, X14;
	int X21, X22, X23, X24;
	for (ii=1; ii<=40000; ii++) {
		X1 = 0;
		X2 = 0;
		
		for(i=0; i<5000; i+=4){
			X11 = s[i].a << 1 + ii;
			X12 = s[i+1].a << 1 + ii;
			X13 = s[i+2].a << 1 + ii;
			X14 = s[i+3].a << 1 + ii;

			X21 = s[i].b * 3 - ii;
			X22 = s[i+1].b * 3 - ii;
			X23 = s[i+2].b * 3 - ii;
			X24 = s[i+3].b * 3 - ii;

			X1 += X11 + X12 + X13 + X14;
			X2 += X11 + X12 + X13 + X14;
		}
	
		R[ii] = X2;
		if(X1<X2) R[ii] = X1;
	}

	e) **** QUINTA MODIFICACION ****
	Podemos sacar factor común del producto con 2 y con 3 ya que tendríamos lo siguiente
	[(x11 * 2 + ii) + (x12 * 2 + ii) + (x13 * 2 + ii) +...+x1n] = 
	= 2*(x11+x12+x13+...+x1n) + 5000*ii


	int X11, X12, X13, X14;
	int X21, X22, X23, X24;
	for (ii=1; ii<=40000; ii++) {
		X1 = 0;
		X2 = 0;
		
		for(i=0; i<5000; i+=4){
			X11 = s[i].a;
			X12 = s[i+1].a;
			X13 = s[i+2].a;
			X14 = s[i+3].a;

			X21 = s[i].b;
			X22 = s[i+1].b;
			X23 = s[i+2].b;
			X24 = s[i+3].b;

			X1 += X11 + X12 + X13 + X14;
			X2 += X11 + X12 + X13 + X14;
		}
		X1 = (X1 << 1) + (5000*ii);
		X2 = (X2 * 3) - (5000*ii);
		R[ii] = X2;
		if(X1<X2) R[ii] = X1;
	}

*/

#include <stdlib.h> 	// biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h> 		// biblioteca donde se encuentra la función printf()
#include <time.h> 		// biblioteca donde se encuentra la función clock_gettime()

#ifdef __MACH__
#include <mach/clock.h>				// Biblioteca para medir tiempo en Mac OS X
#include <mach/mach.h>
#endif

struct {
	int a;
	int b;
} s[5000];

int main(){
	int i, ii, X1, X2;
	int * R;
	struct timespec cgt1,cgt2; double ncgt;		//para tiempo de ejecución
	time_t t;

	// Semilla de rand()
   	srand((unsigned) time(&t));

	R = (int*) malloc (40000*sizeof(int));
	for(ii=1; ii<=40000; ii++)
		R[ii] = 0;

	for(ii=0; ii<5000; ii++){
		s[ii].a = rand() % 8;
		s[ii].b = rand() % 8;
	}

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

	int X11, X12, X13, X14;
	int X21, X22, X23, X24;
	for (ii=1; ii<=40000; ii++) {
		X1 = 0;
		X2 = 0;
		
		for(i=0; i<5000; i+=4){
			X11 = s[i].a;
			X12 = s[i+1].a;
			X13 = s[i+2].a;
			X14 = s[i+3].a;

			X21 = s[i].b;
			X22 = s[i+1].b;
			X23 = s[i+2].b;
			X24 = s[i+3].b;

			X1 += X11 + X12 + X13 + X14;
			X2 += X11 + X12 + X13 + X14;
		}
		X1 = (X1 << 1) + (5000*ii);
		X2 = (X2 * 3) - (5000*ii);
		R[ii] = X2;
		if(X1<X2) R[ii] = X1;
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

	printf("Tiempo(seg.):%11.9f\n", ncgt);
	printf("X1:%i\n", X1);
	printf("X2:%i\n", X2);
	printf("%11.9f\n", ncgt);
}