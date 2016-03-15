#include "stdafx.h"
#include "MyMatrix.h"


using namespace System;

void FreeMatrix(TMatrix A,const int dim)
{
        for(int i = 0; i < dim; i++)
                delete [] A[i];
        delete [] A;    
}

TMatrix GenMatrix(const int power)
{       
        int dim = pow((double) 2,power);

        double **matrix = new double*[dim];
        for(int i = 0; i < dim; i++)
        matrix[i] = new double[dim];

        for (int i = 0; i < dim; i++)
        for (int j = 0; j < dim; j++)
        {
                matrix[i][j] = MAX * (   (double)rand() / ((double)(RAND_MAX)+(double)(1)) ); //Generate number [0,MAX)
                #ifdef FORCE_INT
                        matrix[i][j] = (int) matrix[i][j];
                #endif
        }

        return matrix;
}

void PrintMatrix(TMatrix matrix, const int dim)
{
        if (dim > MAX_PRINTABLE_MATRIX) 
        {
                Console :: WriteLine("Matrix is too big to print");
        } else
        {
                for (int i = 0; i < dim; i++)
                {
                        for (int j = 0; j < dim; j++)
                        {
                                printf("%.*f ", ACC, matrix[i][j]);
                        }
                        Console :: WriteLine();
                }
        }
}

TMatrix SumMatrix(TMatrix A, TMatrix B, const int dim)
{
        double **C = new double*[dim];
        for(int i = 0; i < dim; i++)
        C[i] = new double[dim];

        for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
        {
            C[i][j] = A[i][j] + B[i][j];            
        }

        return C;
}

TMatrix DiffMatrix(TMatrix A, TMatrix B, const int dim)
{
        double **C = new double*[dim];
        for(int i = 0; i < dim; i++)
        C[i] = new double[dim];

        for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
        {
            C[i][j] = A[i][j] - B[i][j];            
        }

        return C;

}

TMatrix MultMatrix(TMatrix A, TMatrix B, const int dim)
{
        double **C = new double*[dim];
        for(int i = 0; i < dim; i++)
        C[i] = new double[dim];

        
                
            for(int i = 0; i < dim; i++)
        for(int j = 0; j < dim; j++)
        {
            C[i][j] = 0;
            for(int k = 0; k < dim; k++)
                C[i][j] += (A[i][k] * B[k][j]);
        }

                return C;

}

void StrassenCThread(TMatrix P[], TMatrix C[], const int dim,const int num)
{
        TMatrix T;
        switch(num)
        {            
            case 1:
                                T = SumMatrix(SumMatrix(P[0],P[6],dim),DiffMatrix(P[3],P[4],dim),dim);
                                break;
                        case 2:
                                T = SumMatrix(P[2],P[4],dim);
                                break;
                        case 3:
                                T = SumMatrix(P[1],P[3],dim);
                                break;
                        case 4:
                                T = SumMatrix(SumMatrix(P[2],P[5],dim),DiffMatrix(P[0],P[1],dim),dim);
                                break;

        };

        for (int i=0;i<dim;i++)
                for (int j=0;j<dim;j++)
                        C[num-1][i][j] = T[i][j];

        FreeMatrix(T,dim);


        
}

//Function to culculate P matrixes
void StrassenPThread(TMatrix As[], TMatrix Bs[], const int dim, TMatrix &C, int num)
{

        int dim2 = dim / 2;

        TMatrix P,S1,S2;
        
        switch(num)
        {            
            case 1:
                                S1 = SumMatrix(As[0],As[3],dim2);
                                S2 = SumMatrix(Bs[0],Bs[3],dim2);
                                P = ParallelMultMatrixStrassen(S1,S2,dim2);  
                                FreeMatrix(S1,dim2);
                                FreeMatrix(S2,dim2);
                                break;
                        case 2:
                                S1 = SumMatrix(As[1],As[3],dim2);
                                P = ParallelMultMatrixStrassen(S1,Bs[0],dim2);
                                FreeMatrix(S1,dim2);
                                break;
                        case 3:
                                S1 = DiffMatrix(Bs[2],Bs[3],dim2);
                                P = ParallelMultMatrixStrassen(As[0],S1,dim2);
                                FreeMatrix(S1,dim2);
                                break;
                        case 4:
                                S1 = DiffMatrix(Bs[1],Bs[0],dim2);
                                P = ParallelMultMatrixStrassen(As[3],S1,dim2);
                                FreeMatrix(S1,dim2);
                                break;
                        case 5:
                                S1 = SumMatrix(As[0],As[2],dim2);
                                P = ParallelMultMatrixStrassen(S1,Bs[3],dim2);
                                FreeMatrix(S1,dim2);
                                break;
                        case 6:
                                S1 = DiffMatrix(As[1],As[0],dim2);
                                S2 = SumMatrix(Bs[0],Bs[2],dim2);
                                P = ParallelMultMatrixStrassen(S1,S2,dim2);
                                FreeMatrix(S1,dim2);
                                FreeMatrix(S2,dim2);
                                break;
                        case 7:
                                S1 = DiffMatrix(As[2],As[3],dim2);
                                S2 = SumMatrix(Bs[1],Bs[3],dim2);
                                P = ParallelMultMatrixStrassen(S1,S2,dim2);
                                FreeMatrix(S1,dim2);
                                FreeMatrix(S2,dim2);
                                break;

        };


        for (int i=0;i<dim2;i++)
                for (int j=0;j<dim2;j++)
                        C[i][j] = P[i][j];

        FreeMatrix(P,dim2);
}


TMatrix ParallelMultMatrixStrassen(TMatrix A, TMatrix B, const int dim)
{
        int dim2 = dim / 2;
        int i;

        //Console::WriteLine("Strassen");

        if (dim < MIN_STRASS_DIM)
        {
                //Console::WriteLine("return");
                return MultMatrix(A,B,dim);
        }
        //Console::WriteLine("parallel");

        TMatrix * As = SplitMatrix(A,dim);
        TMatrix * Bs = SplitMatrix(B,dim);
        TMatrix * P = new TMatrix[7];
        TMatrix * C = new TMatrix[4];

        //Allocate result matrixes
        for (int n = 0; n < 7; n++)
        {
                P[n] = new double*[dim2];
                for(int i = 0; i < dim2; i++)
                        P[n][i] = new double[dim2];             
        }

        //Allocate result matrixes
        for (int n = 0; n < 4; n++)
        {
                C[n] = new double*[dim2];
                for(int i = 0; i < dim2; i++)
                        C[n][i] = new double[dim2];             
        }

        
        #pragma omp parallel for
        for (i=0; i<7; i++) 
    {
        StrassenPThread(As,Bs,dim,P[i],i+1);    
    }


        #pragma omp parallel for
        for (int i=0; i<4; i++) 
    {
           StrassenCThread(P,C,dim2,i+1);                                       
    }



        //Free As and Bs
        for (int i=0; i<4; i++) 
    {
            FreeMatrix(As[i],dim2);
                        FreeMatrix(Bs[i],dim2);
    }

        //Free P
        for (int i=0; i<7; i++) 
    {
            FreeMatrix(P[i],dim2);
    }

        TMatrix res = JoinMatrix(C[0],C[2],C[1],C[3],dim2);

        FreeMatrix(C[0], dim2);
        FreeMatrix(C[1], dim2);
        FreeMatrix(C[2], dim2);
        FreeMatrix(C[3], dim2);

        return res;
}

//Single-threaded Strassen muliplication
TMatrix MultMatrixStrassen(TMatrix A, TMatrix B, const int dim)
{
        int dim2 = dim / 2;

        if (dim < MIN_STRASS_DIM)
        {
                return MultMatrix(A,B,dim);
        }

        TMatrix * As = SplitMatrix(A,dim);
        TMatrix * Bs = SplitMatrix(B,dim);

        TMatrix P1 = MultMatrixStrassen(SumMatrix(As[0],As[3],dim2),SumMatrix(Bs[0],Bs[3],dim2),dim2);
        TMatrix P2 = MultMatrixStrassen(SumMatrix(As[1],As[3],dim2),Bs[0],dim2);
        TMatrix P3 = MultMatrixStrassen(As[0],DiffMatrix(Bs[2],Bs[3],dim2),dim2);
        TMatrix P4 = MultMatrixStrassen(As[3],DiffMatrix(Bs[1],Bs[0],dim2),dim2);
        TMatrix P5 = MultMatrixStrassen(SumMatrix(As[0],As[2],dim2),Bs[3],dim2);        
        TMatrix P6 = MultMatrixStrassen(DiffMatrix(As[1],As[0],dim2),SumMatrix(Bs[0],Bs[2],dim2),dim2);
        TMatrix P7 = MultMatrixStrassen(DiffMatrix(As[2],As[3],dim2),SumMatrix(Bs[1],Bs[3],dim2),dim2);

        TMatrix C1 = SumMatrix(SumMatrix(P1,P7,dim2),DiffMatrix(P4,P5,dim2),dim2);
        TMatrix C2 = SumMatrix(P3,P5,dim2);
        TMatrix C3 = SumMatrix(P2,P4,dim2);
        TMatrix C4 = SumMatrix(SumMatrix(P3,P6,dim2),DiffMatrix(P1,P2,dim2),dim2);

        return JoinMatrix(C1,C3,C2,C4,dim2);
}


TMatrix * SplitMatrix(const TMatrix in, const int dim)
{
        //Allocate result array
        TMatrix * res = new TMatrix[4];

        //Allocate result matrixes
        for (int n = 0; n < 4; n++)
        {
                res[n] = new double*[dim/2];
                for(int i = 0; i < dim/2; i++)
                res[n][i] = new double[dim/2];
        }

        //Fill result matrixes
        //First
        for (int i = 0; i < dim/2; i++)
        for (int j = 0; j < dim/2; j++)
        {
                res[0][i][j] = in[i][j];                
        }

        //Second
        for (int i = 0; i < dim/2; i++)
        for (int j = 0; j < dim/2; j++)
        {
                res[1][i][j] = in[i+dim/2][j];          
        }

        //Third
        for (int i = 0; i < dim/2; i++)
        for (int j = 0; j < dim/2; j++)
        {
                res[2][i][j] = in[i][j+dim/2];          
        }

        //Forth
        for (int i = 0; i < dim/2; i++)
        for (int j = 0; j < dim/2; j++)
        {
                res[3][i][j] = in[i+dim/2][j+dim/2];    
        }

        return res;

}

bool VerEqual(const TMatrix a,const TMatrix b, const int dim)
{
        for (int i = 0; i < dim; i++)
        for (int j = 0; j < dim; j++)
        {
                if (a[i][j] != b[i][j])
                {
                        return false;
                }
        }

        return true;

}


TMatrix JoinMatrix(const TMatrix a,const TMatrix b,const TMatrix c,const TMatrix d, const int dim)
{
        double **C = new double*[dim*2];
        for(int i = 0; i < dim*2; i++)
        C[i] = new double[dim*2];

        //Fill result matrix
        //First
        for (int i = 0; i < dim; i++)
        for (int j = 0; j < dim; j++)
        {
                C[i][j] = a[i][j];              
        }
        //Second
        for (int i = dim; i < dim*2; i++)
        for (int j = 0; j < dim; j++)
        {
                C[i][j] = b[i-dim][j];          
        }
        //Second
        for (int i = 0; i < dim; i++)
        for (int j = dim; j < dim*2; j++)
        {
                C[i][j] = c[i][j-dim];          
        }
        //Forth
        for (int i = dim; i < dim*2; i++)
        for (int j = dim; j < dim*2; j++)
        {
                C[i][j] = d[i-dim][j-dim];              
        }

        return C;
}
Hide details
Change log
r647 by dilandau11 on Jan 30, 2010   Diff
DONE! Lab 3 OpenMP, Strassen algorithm. VS
project
Go to: 	
Older revisions
All revisions of this file
File info
Size: 8408 bytes, 395 lines
View raw file
