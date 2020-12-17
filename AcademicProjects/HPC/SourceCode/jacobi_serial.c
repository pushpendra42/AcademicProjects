//Source refernce: https://en.wikipedia.org/wiki/Jacobi_eigenvalue_algorithm
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "papi.h"

static int N;
static int MAX_ITERATIONS;
static int SEED;

#define NUM_EVENTS 4
int event[NUM_EVENTS]={PAPI_L1_DCM,PAPI_L1_ICM,PAPI_L2_DCM,PAPI_L2_ICM};
//int event[NUM_EVENTS]={PAPI_L3_DCM,PAPI_L3_ICH,PAPI_LD_INS,PAPI_TOT_INS};
long long values[NUM_EVENTS];
//static double CONVERGENCE_THRESHOLD;

double Distance(double *X_Old, double *X_New, int n_size)
{
	int index;
	double Sum;

	Sum = 0.0;
	for (index = 0; index < n_size; index++)
		Sum += (X_New[index] - X_Old[index]) * (X_New[index] - X_Old[index]);

	return (Sum);
}

//Print matrices
void PrintMatrix(double *matrix, int rowSize,int colSize,char *message)
{
/*printf(message);
int row=0,col=0;
for (row = 0; row < rowSize; row++)
    {
	if(colSize!=0){
      for (col = 0; col < colSize; col++)
      {
	  printf("%f ",matrix[row + col*colSize]);
	  }
	  }
	  else
	  {
	  printf("%f ",matrix[row]);
	  }
	  printf("\n");
	  }
	  */
}
#define SEPARATOR "------------------------------------\n"

// Return the current time in seconds since the Epoch
double get_timestamp();

// Parse command line arguments to set solver parameters
void parse_arguments(int argc, char *argv[]);

// Run the Jacobi solver
// Returns the number of iterations performed
int run(double *A, double *b, double *x, double *xtmp)
{
  int itr;
  int row, col;
  double dot;
  double diff;
  double sqdiff;
  double *ptrtmp;

  // Loop until converged or maximum iterations reached
  itr = 0;
  do
  {
    // Perform Jacobi iteration
    for (row = 0; row < N; row++)
    {
      dot = 0.0;
      for (col = 0; col < N; col++)
      {
        if (row != col)
          dot += A[row + col*N] * x[col];
      }
      xtmp[row] = (b[row] - dot) / A[row + row*N];
    }

    // Swap pointers
    ptrtmp = x;
    x      = xtmp;
    xtmp   = ptrtmp;

    // Check for convergence
    sqdiff = 0.0;
    for (row = 0; row < N; row++)
    {
      diff = xtmp[row] - x[row];
      sqdiff += diff * diff;
    }

    itr++;
  } while ((itr < MAX_ITERATIONS) && (Distance(A, xtmp, N) >= 1.0E-24));
  
   PrintMatrix(x,N,0,"Print matrix X");
  return itr;
}

int main(int argc, char *argv[])
{
  parse_arguments(argc, argv);

  double *A    = malloc(N*N*sizeof(double));
  double *b    = malloc(N*sizeof(double));
  double *x    = malloc(N*sizeof(double));
  double *xtmp = malloc(N*sizeof(double));
  int irow,icol;

  printf(SEPARATOR);
  printf("Matrix size:            %dx%d\n", N, N);
  printf("Maximum iterations:     %d\n", MAX_ITERATIONS);
  //printf("Convergence threshold:  %lf\n", CONVERGENCE_THRESHOLD);
  printf(SEPARATOR);

double total_start = get_timestamp();	

  // Initialize data
  srand(time(NULL));
  int row = 0;
  for (row = 0; row < N; row++)
  {
    double rowsum = 0.0;
	int col = 0;
    for (col = 0; col < N; col++)
    {
      int value = rand()%10;
      A[row + col*N] = value;
      rowsum += value;
    }
	int b_value = rand()%10;
    b[row] = b_value;
	//printf("mesaage from b %f--%d\n",b[row],b_value);
    x[row] = 0.0;
  }
  
  /*
  FILE           *fp;

	//Checking For Matrix Input File //

	if ((fp = fopen("mdatjac.inp", "r")) == NULL) {
		printf("Can't open input matrix file");
		exit(-1);
	}
	
	for (irow = 0; irow < N; irow++) {
		for (icol = 0; icol < N; icol++)
			fscanf(fp, "%lf", &A[irow][icol]);
	}
	fclose(fp);
  
  if ((fp = fopen("vdatjac.inp", "r")) == NULL) {
		printf("Can't open input vector file");
		exit(-1);
	}
	
	for (irow = 0; irow < N; irow++)
		fscanf(fp, "%lf", &Input_B[irow]);
	fclose(fp);
	*/
  PrintMatrix(A,N,N,"Print matrix A");
  PrintMatrix(b,N,0,"Print matrix b");
  
  if (PAPI_start_counters(event, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_start_counters - FAILED\n");
    }
  
  
  //
  // Run Jacobi solver
  double solve_start = get_timestamp();
  int itr = run(A, b, x, xtmp);
  double solve_end = get_timestamp();
  
  if (PAPI_read_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_read_counters - FAILED\n");
       
    }
	int eventCount=0;
	for(eventCount=0;eventCount<NUM_EVENTS;eventCount++)
    printf("Papi reading: %lld\n",values[eventCount]);
    


    /* Stop counting events */
    if (PAPI_stop_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf(stderr, "PAPI_stoped_counters - FAILED\n");
    }

  // Check error of final solution
  double err = 0.0;
  //int row;
  for (row = 0; row < N; row++)
  {
    double tmp = 0.0;
	int col = 0;
    for (col = 0; col < N; col++)
    {
      tmp += A[row + col*N] * x[col];
    }
    tmp = b[row] - tmp;
    err += tmp*tmp;
  }
  err = sqrt(err);

  double total_end = get_timestamp();

  printf("Solution error = %lf\n", err);
  printf("Iterations     = %d\n", itr);
  //printf("Total runtime  = %lf seconds\n", (total_end-total_start));
  printf("Solver runtime = %lf seconds\n", (solve_end-solve_start));
  //if (itr == MAX_ITERATIONS)
    //printf("WARNING: solution did not converge\n");
  printf(SEPARATOR);

  free(A);
  free(b);
  free(x);
  free(xtmp);

  return 0;
}

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

double parse_double(const char *str)
{
  char *next;
  double value = strtod(str, &next);
  return strlen(next) ? -1 : value;
}

void parse_arguments(int argc, char *argv[])
{
  // Set default values
  N = 1000;
  MAX_ITERATIONS = 20000;
  //CONVERGENCE_THRESHOLD = 0.0001;
  SEED = 0;
  int i = 1;
  for (i = 1; i < argc; i++)
  {
    /*if (!strcmp(argv[i], "--convergence") || !strcmp(argv[i], "-c"))
    {
      if (++i >= argc || (CONVERGENCE_THRESHOLD = parse_double(argv[i])) < 0)
      {
        printf("Invalid convergence threshold\n");
        exit(1);
      }
    }
    else*/
	if (!strcmp(argv[i], "--iterations") || !strcmp(argv[i], "-i"))
    {
      if (++i >= argc || (MAX_ITERATIONS = parse_int(argv[i])) < 0)
      {
        printf("Invalid number of iterations\n");
        exit(1);
      }
    }
    else if (!strcmp(argv[i], "--norder") || !strcmp(argv[i], "-n"))
    {
      if (++i >= argc || (N = parse_int(argv[i])) < 0)
      {
        printf("Invalid matrix order\n");
        exit(1);
      }
    }
    else if (!strcmp(argv[i], "--seed") || !strcmp(argv[i], "-s"))
    {
      if (++i >= argc || (SEED = parse_int(argv[i])) < 0)
      {
        printf("Invalid seed\n");
        exit(1);
      }
    }
    else if (!strcmp(argv[i], "--help") || !strcmp(argv[i], "-h"))
    {
      printf("\n");
      printf("Usage: ./jacobi [OPTIONS]\n\n");
      printf("Options:\n");
      printf("  -h  --help               Print this message\n");
      //printf("  -c  --convergence  C     Set convergence threshold\n");
      printf("  -i  --iterations   I     Set maximum number of iterations\n");
      printf("  -n  --norder       N     Set maxtrix order\n");
      printf("  -s  --seed         S     Set random number seed\n");
      printf("\n");
      exit(0);
    }
    else
    {
      printf("Unrecognized argument '%s' (try '--help')\n", argv[i]);
      exit(1);
    }
  }
}