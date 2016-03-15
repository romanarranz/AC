#ifndef _STRASSEN_MATRIX_
#define _STRASSEN_MATRIX_

#ifdef _DEBUG
#undef _DEBUG
#include <omp.h>
#define _DEBUG
#else
#include <omp.h>
#endif

#include "Var.h"

typedef double ** TMatrix;

TMatrix GenMatrix(const int);
void FreeMatrix(TMatrix A,const int dim);
void PrintMatrix(TMatrix, const int);
TMatrix SumMatrix(TMatrix A, TMatrix B, const int dim);
TMatrix DiffMatrix(TMatrix A, TMatrix B, const int dim);
TMatrix MultMatrix(TMatrix A, TMatrix B, const int dim);
TMatrix MultMatrixStrassen(TMatrix A, TMatrix B, const int dim);
TMatrix ParallelMultMatrixStrassen(TMatrix A, TMatrix B, const int dim);
void PrintMatrix(TMatrix matrix, const int dim);
bool VerEqual(const TMatrix a,const TMatrix b, const int dim);
TMatrix JoinMatrix(const TMatrix,const TMatrix,const TMatrix,const TMatrix, const int);
TMatrix * SplitMatrix(const TMatrix in, const int dim);

#endif