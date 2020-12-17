/*=============================================================================================================
Copyright (c) Pushpendra, shared intellectual property with Dr. Jehan-Francois Paris, University of Houston. All rights reserved.
===============================================================================================================
* Filename           :   postoffice.c
* Version             :   1.0.0.0
* Created by         :   Pushpendra
* Created On        :   19-Dec-2018
* Class Desription  :   This file contains definitions to simulate the behavior of customers in a post office using POSIX threads, POSIX mutexes and POSIX condition variables
* =============================================================================================================
Running the Program:
Compilation: gcc -pthread postoffice.c -o postoffice
Execution: ./postoffice [#Clerk] < [customer input file name]
Example: ./postoffice 2 < 2.txt
* =============================================================================================================
* Revision/Change History
* -------------------------------------------------------------------------------------------------------------
* Change ID        | Description     | Last Modified By           | Last Modified On
* -------------------------------------------------------------------------------------------------------------
* #0001            |
* =============================================================================================================*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define BUFFERSIZE 20
//# define DEBUG

//Global declarations start
int TOTAL_CUSTOMER;
static int N_FREECLERKS;
static int N_CUSTOMERWAITING;
pthread_mutex_t GLOBAL_CLERK_MUTEX=PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t  COND_FREE_CLERK=PTHREAD_COND_INITIALIZER;
//Global declarations ends

//Customer struct
struct Customer
{
    int customerID;
    int arrivalTime;
    int serviceTime;
};

// Method to execute the customer service in Post office
// Takes as input the customer struct
static void *CustomerThread(void *customerStuct)
{
    struct Customer customerInfo=*(struct Customer*)customerStuct;
    int customerID= customerInfo.customerID;
    int custServiceTime=customerInfo.serviceTime;

    pthread_mutex_lock(&GLOBAL_CLERK_MUTEX);

    while(N_FREECLERKS==0)
    {
        N_CUSTOMERWAITING++;
        pthread_cond_wait(&COND_FREE_CLERK, &GLOBAL_CLERK_MUTEX);
    }
	
    printf("Customer # %i starts getting help.\n",customerID);
    N_FREECLERKS--;
	pthread_mutex_unlock(&GLOBAL_CLERK_MUTEX);
    
	#ifdef DEBUG
	printf("Service started for customer # %i, available clerk = %d.\n",customerID,N_FREECLERKS);
	#endif
	
    sleep(custServiceTime);
	
	#ifdef DEBUG
    printf("Service done for customer # %i\n",customerID);
	#endif
	
	pthread_mutex_lock(&GLOBAL_CLERK_MUTEX);
    N_FREECLERKS++;
	
	#ifdef DEBUG
    printf("Customer # %i incremented FreeClerk count to %d. \n",customerID,N_FREECLERKS);
	#endif	
    
    printf("Customer # %i leaves the post office.\n",customerID);
	pthread_cond_signal(&COND_FREE_CLERK);
	pthread_mutex_unlock(&GLOBAL_CLERK_MUTEX);   
}


struct Customer* readFile()
{
	int customerCount=0,id,arrivalTime,serviceTime;
    char buffer[BUFFERSIZE];
	#ifdef DEBUG
	printf("\nStart reading the input file.\n");
	#endif
    struct Customer *customerColl=(struct Customer*)malloc(sizeof(struct Customer)*10);
	
    while(feof(stdin)==0) {
        fgets(buffer, BUFFERSIZE , stdin);
        sscanf(buffer, "%d %d %d" , &id,&arrivalTime,&serviceTime);
        customerColl[customerCount].customerID=id;
        customerColl[customerCount].arrivalTime=arrivalTime;
        customerColl[customerCount].serviceTime=serviceTime;
		
		#ifdef DEBUG
		printf("Client info  ID = %d, Stored array ID = %d.\n",id,customerColl[customerCount].customerID);
		#endif
		
        customerCount++;
    }
	
	// This is a hack because above loop repeats the last row twice
    TOTAL_CUSTOMER=customerCount-1;
    return customerColl;
}


int main(int argc, char *argv[])
{
    int arrivalTime,custid,FreeClerks,customerCounter;
	N_FREECLERKS=atoi(argv[1]);
	
    struct Customer *customerColl=readFile();
        
    printf("\nTotal clerk=%d and customer = %d\n\n",N_FREECLERKS,TOTAL_CUSTOMER);
	
    pthread_t customer[TOTAL_CUSTOMER];
   
    for (customerCounter = 0; customerCounter < TOTAL_CUSTOMER; customerCounter++)
    {
        custid=customerColl[customerCounter].customerID;
        arrivalTime=customerColl[customerCounter].arrivalTime;
        printf("Customer # %i will arrive in %i sec\n",custid,arrivalTime);
        sleep(arrivalTime);
        printf("Customer # %i arrives at the post office.\n",custid);
        pthread_create(customer + customerCounter, NULL, &CustomerThread, &customerColl[customerCounter]);
    }

    for (customerCounter = 0; customerCounter < TOTAL_CUSTOMER; customerCounter++)
    {
        pthread_join(customer[customerCounter], NULL);
    }

    printf("\nTotal customers servered=%d\n",TOTAL_CUSTOMER);
    printf("Total customers with no waiting =%d\n",TOTAL_CUSTOMER-N_CUSTOMERWAITING);
    printf("Total customers waited=%d\n\n",N_CUSTOMERWAITING);

}