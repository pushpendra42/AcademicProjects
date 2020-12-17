//Source reference: https://github.com/zjevik/QR-decomposition

#include <iostream>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h> 
#include <time.h>
#include <sys/time.h>      
#include <math.h>
#include "cTimer.h"
#include "papi.h"

#define NUM_EVENTS 4
int event[NUM_EVENTS]={PAPI_L1_DCM,PAPI_L1_ICM,PAPI_L2_DCM,PAPI_L2_ICM};
//int event[NUM_EVENTS]={PAPI_L3_DCM,PAPI_L3_ICH,PAPI_LD_INS,PAPI_TOT_INS};
long long values[NUM_EVENTS];

//Create matrix
double** create_matrix( int numrows, int numcols, bool verbose){
	double *buffer=new double[numrows*numcols];
	double **data=new double*[numrows];
	for(int i=0;i<numrows;++i) 
	data[i]=buffer+i*numcols;
	
	return *&data;
}

int main(int argc, char* argv[])
{ 
  bool verbose = false, definition = true, root = false;   
  int i,j,rank=0,size,lines;
  FILE *file;
  double **matrixA,**matrixQ,**mat,**p;
  double *vec, coef;
  arg::cTimer timer;

    for(i = 0; i < argc; i++){
      if(strcmp(argv[i],"-silent") == 0) verbose = false;
      if(strcmp(argv[i],"-file") == 0){
        if((file=fopen(argv[++i], "r")) == NULL) {
          printf("Cannot open file.\n");
          return(0);
        }
        else{
          definition = false;
        }
      }
   }
   
    
    //scanning file for number of lines
    fscanf(file,"%d,\n",&lines);
    
  matrixA = create_matrix(lines,lines, verbose);
  matrixQ = create_matrix(lines,lines, verbose);
  for(int i = 0; i < lines; i++){
    matrixQ[i][i] = 1;
  }
  
    for(i = 0; i < lines; i++){
      for(j = 0; j < lines; j++){
        fscanf(file,"%f,",&matrixA[i][j]);
      }
    }
    
    //record time  
    timer.CpuStart();
	
	if (PAPI_start_counters(event, NUM_EVENTS) != PAPI_OK) {
        printf("PAPI_start_counters - FAILED\n");
    }
  
  int k,l,m;
  
  //tmp matrixA for parallel computing
  mat = create_matrix(lines,lines, false);
   
  for(i = 0; i < lines; i++){
    
    double x = 0;
    vec = new double[lines-i]; 
    for(j = i; j < lines; j++){
      vec[j-i] = -matrixA[j][i];
      x += vec[j-i]*vec[j-i];
    }
    x = sqrt(x);
     
    if(vec[0] > 0) x = -x; 
    vec[0] = vec[0] + x;
    x = 0;
    for(j = 0; j < lines-i; j++){
      x += vec[j]*vec[j];
    }
    x = sqrt(x);     
    
    if(x > 0){
      //normalizovat vec  
      for(j = 0; j < lines-i; j++){
        vec[j] /= x;
      }   
            
      //sestavit matici P
      p = create_matrix(lines-i,lines-i, false);
      for(k = 0; k < lines-i; k++){
        for(l = 0; l < lines-i; l++){
          if(k == l) p[k][k] = 1 - 2*vec[k]*vec[l];
          else p[k][l] = -2*vec[k]*vec[l];
        }
      }     
      
      //nasobeni matic (paralelizace)
      //R      
      for(k = i; k < lines; k++){
        for(l = i; l < lines; l++){
          double tm = 0;
          for(m = i; m < lines; m++){
            tm += p[k-i][m-i]*matrixA[m][l];
          }
          mat[k][l] = tm;
        }
      }          
      for(k = i; k < lines; k++){
        for(l = i; l < lines; l++){
          matrixA[k][l] = mat[k][l];
        }
      }        
      
      //Q
      for(k = 0; k < lines; k++){
        for(l = i; l < lines; l++){
          double tm = 0;
          for(m = i; m < lines; m++){
            tm += matrixQ[k][m]*p[m-i][l-i];
          }
          mat[k][l] = tm;
        }
      }
      for(k = 0; k < lines; k++){
        for(l = i; l < lines; l++){
          matrixQ[k][l] = mat[k][l];
        }
      }
    }  
}	
    double time;
    time = timer.CpuStop().CpuSeconds();//end time
	
	if (PAPI_read_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf("PAPI_read_counters - FAILED\n");
       
    }
	int eventCount=0;
	for(eventCount=0;eventCount<NUM_EVENTS;eventCount++)
    printf("Papi reading: %lld\n",values[eventCount]);
    


    /* Stop counting events */
    if (PAPI_stop_counters(values, NUM_EVENTS) != PAPI_OK) {
        printf("PAPI_stoped_counters - FAILED\n");
    }
    
    
    if(verbose){
      printf("\nSolution is:\n");
      if(verbose) printf("Matrix Q.\n");
      for(k = 0; k < lines; k++){
        for(j = 0; j < lines; j++){
          if(verbose) printf("%f ",matrixQ[k][j]);
        }
        if(verbose) printf("\n");
      } 
      printf("\n");    
      if(verbose) printf("Matrix R.\n");
      for(k = 0; k < lines; k++){
        for(j = 0; j < lines; j++){
          if(verbose) printf("%f ",matrixA[k][j]);
        }
        if(verbose) printf("\n");
      }   
    }
    printf("Time: ");
    printf("%f\n",time);   
                                
  return(0);                                                                                                
}

