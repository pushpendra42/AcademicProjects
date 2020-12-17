//Source reference: http://www.cse.iitd.ernet.in/~dheerajb/OpenMP/codes/C/Omp_Jacobi.c

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
#include <omp.h>
#include "papi.h"
#include <sys/time.h>
#include <math.h>

#define  MAX_ITERATIONS 100
#define NUM_EVENTS 1
int event[NUM_EVENTS]={PAPI_L1_DCM};//,PAPI_L1_ICM,PAPI_L2_DCM,PAPI_L2_ICM
//int event[NUM_EVENTS]={PAPI_L3_DCM,PAPI_L3_ICH,PAPI_LD_INS,PAPI_TOT_INS};
long long values[NUM_EVENTS];

double Distance(double *X_Old, double *X_New, int n_size);

double get_timestamp()
{
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec + tv.tv_usec*1e-6;
}

int parse_int(const char *str)
{
  char *next;
  int value = strtoul(str, &next, 10);
  return strlen(next) ? -1 : value;
}

main(int argc, char **argv)
{

	/* .......Variables Initialisation ...... */
	int             n_size, NoofRows_Bloc, NoofRows, NoofCols;
	int             Numprocs, MyRank, Root = 0;
	int             irow, jrow, icol, index, Iteration, GlobalRowNo;

	double        **Matrix_A, *Input_A, *Input_B;
	double         *X_New, *X_Old, *Bloc_X, tmp;

	//printf("%s %s %s",argv[0],argv[1],argv[2]);
	//int N=parse_int(argv[1]);
	//printf("%s",N);
	n_size=N;
	
	Matrix_A = malloc(N*N*sizeof(double));
	Input_B = malloc(N*sizeof(double));;
	
	  srand(time(NULL));
	  int row = 0;
	  for (row = 0; row < N; row++)
	  {
		double rowsum = 0.0;
		int col = 0;
		for (col = 0; col < N; col++)
		{
		  int value = rand()%10;
		  Matrix_A[row][col] = value;
		}
		int b_value = rand()%10;
		Input_B[row] = b_value;
	  }

	if (NoofRows != NoofCols) {
		printf("Input Matrix Should Be Square Matrix ..... \n");
		exit(-1);
	}
	
	double solve_start = get_timestamp();
	
	if (PAPI_start_counters(event, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_start_counters - FAILED\n");
    }

	X_New = (double *) malloc(n_size * sizeof(double));
	X_Old = (double *) malloc(n_size * sizeof(double));
	Bloc_X = (double *) malloc(n_size * sizeof(double));

	/* Initailize X[i] = B[i] */

	for (irow = 0; irow < n_size; irow++)
		Bloc_X[irow] = Input_B[irow];
	X_New[irow] = Input_B[irow];


	Iteration = 0;
	do {

		for (irow = 0; irow < n_size; irow++)
			X_Old[irow] = X_New[irow];

		// Start open mp
		#pragma omp parallel for private(icol) shared(Bloc_X,X_New,X_Old)
		for (irow = 0; irow < n_size; irow++) {
			Bloc_X[irow] = Input_B[irow];

			for (icol = 0; icol < irow; icol++) {
				Bloc_X[irow] -= X_Old[icol] * Matrix_A[irow][icol];
			}
			for (icol = irow + 1; icol < n_size; icol++) {
				Bloc_X[irow] -= X_Old[icol] * Matrix_A[irow][icol];
			}
			Bloc_X[irow] = Bloc_X[irow] / Matrix_A[irow][irow];
		}

		for (irow = 0; irow < n_size; irow++)
			X_New[irow] = Bloc_X[irow];
		Iteration++;
	} while ((Iteration < MAX_ITERATIONS) && (Distance(X_Old, X_New, n_size) >= 1.0E-24));

	double solve_end = get_timestamp();
	if (PAPI_read_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_read_counters - FAILED\n");
    }
	
	int eventCount=0;
	for(eventCount=0;eventCount<NUM_EVENTS;eventCount++)
    printf("Papi reading: %lld\n",values[eventCount]);
    
    Stop counting events 
    if (PAPI_stop_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_stoped_counters - FAILED\n");
    }

	printf("\n");
	printf(" ------------------------------------------- \n");
	printf("Results Of Jacobi Method \n");
	printf("\n");

	printf("Matrix Input_A \n");
	printf("\n");
	/*for (irow = 0; irow < n_size; irow++) {
		for (icol = 0; icol < n_size; icol++)
			printf("%.3lf  ", Matrix_A[irow][icol]);
		printf("\n");
	}*/
	//for (irow = 0; irow < n_size; irow++) {
		//printf("%.3lf\n", Input_B[irow]);
	//}
	
	printf("Number Of Iterations = %d\n", Iteration);
	printf("Solver runtime = %lf seconds\n", (solve_end-solve_start));
	
	printf("\n");
	//for (irow = 0; irow < n_size; irow++)
		//printf("%.12lf\n", X_New[irow]);
	//printf(" --------------------------------------------------- \n");

	/* Freeing Allocated Memory */

	free(X_New);
	free(X_Old);
	free(Matrix_A);
	free(Input_B);
	free(Bloc_X);
}


double Distance(double *X_Old, double *X_New, int n_size)
{
	int index;
	double Sum;

	Sum = 0.0;
	for (index = 0; index < n_size; index++)
		Sum += (X_New[index] - X_Old[index]) * (X_New[index] - X_Old[index]);

	return (Sum);
}
