#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_set_dynamic(0);
	#define omp_set_num_threads(12);
#endif
	int main(void) {
		#pragma omp parallel
			printf("(%d:!!!Hello world!!!)",
		omp_get_thread_num());
	return(0);
}