#!/usr/bin/python
import sys
import psycopg2
import pandas as pd
import datetime
import threading
import random

querySummary=[]
errorSummary=[]
connectionStrFileName="connectionstring.txt"

def PrintLogs(msg, printReq=False):
    if printReq:
        print(msg)

def selectinput():
    PrintLogs("select input")
    customerQuery="select customerid from customer order by random() limit 1;"
    customerId=ExecuteQuery(customerQuery,1,False)
    PrintLogs(customerId[0])

    flightTripQuery="select flighttripid, flightid from flighttrip order by random() limit 1;"
    flightTripId=ExecuteQuery(flightTripQuery, 1, False)
    PrintLogs(flightTripId[0],flightTripId[1])

    seatClassList=['seatB','seatE']
    seatClass=random.choice(seatClassList)
    flightInstanceQuery="select "+str(seatClass)+" from flightinstance where flightTripId="+str(flightTripId[0])+" and "+str(seatClass)+">1;"
    seatNum=ExecuteQuery(flightInstanceQuery, 1, False)
    PrintLogs(seatNum[0])

    if seatNum[0]>0:
        fareQuery = "select sum(fare+seatfare) from (select fare from flighttrip  join flightschedule on flighttrip.flightScheduleId=flightschedule.flightScheduleId where flighttrip.flighttripid=" + str(flightTripId[0]) + ") as a, seatclass where seatclassid=0;"
        tripfare = ExecuteQuery(fareQuery, 1, False)
        print(tripfare[0])

        paymethodQuery = "select payMethodID from payMethod order by random() limit 1 ;"
        paymentMethodId = ExecuteQuery(paymethodQuery, 1, False)
        print(paymentMethodId[0])

        try:
            s1 = "insert into payment(payMethodID, paydate,subtotal) values("+str(paymentMethodId[0])+", now(),"+str(tripfare[0])+") returning paymentID;"
            paymentId = ExecuteQuery(s1,1, False,True)
            print(paymentId)

            s2="insert into ticket(customerId, bookingDate,paymentID) values("+str(customerId[0])+",now(),"+str(paymentId[0])+") returning ticketid;"
            ticketid = ExecuteQuery(s2,1, False,True)
            print(ticketid[0])

            s3 = "insert into customertrip(ticketid,seatid,flightTripID,tripfare,customerid,flightid) values("+str(ticketid[0])+", "+str(seatNum[0])+","+str(flightTripId[0])+", "+str(tripfare[0])+","+str(customerId[0])+","+str(flightTripId[1])+") returning tripid;"
            customerTripId = ExecuteQuery(s3,1,False,True)
            print(customerTripId[0])

            s4 = "update flightinstance set "+str(seatClass)+"="+str(seatClass)+"-1 where flighttripid="+str(flightTripId[0])+";"
            flightIntsanceUpdate = ExecuteQuery(s4, 3, False,True)
            print(flightIntsanceUpdate)

            #Perform commit;
            print("selection done")
        except:
            #Perform Rollback
            print("No seat available")
    else:
        print("No seat available")


def worker():
    print(threading.current_thread().name, threading.get_ident())

def PrintLogs(msg, printReq=True):
    if printReq:
        print(msg)

def ExecuteQuery(query, returnType=0,isLogRequired=False,isCommitReq=False):
    PrintLogs("---Query execution Started---",True)
    conn = None
    connFileObj = open(connectionStrFileName, "r")
    connectionString = connFileObj.read()
    global querySummary

    #if isLogRequired:
    querySummary.append(query)
    PrintLogs(query,True)

    try:
        # conn = psycopg2.connect(host="localhost",database="dbms2019", user="postgres", password="dbms2019")
        conn = psycopg2.connect(connectionString)
        cur = conn.cursor()
        #print(cur.mogrify(query).decode('utf8'))
        cur.execute(query)

        if isCommitReq:
            conn.commit()
            PrintLogs("Commit done for query : "+ query)

        if returnType==1:
            record = cur.fetchone()
            return record
        elif returnType==2:
            record = cur.fetchall()
        elif returnType == 3:
            record = cur.rowcount
            PrintLogs("Record count= "+str(record))
        elif returnType == 4:
            record = cur.lastrowid

        cur.close()

        if returnType!=0:
            PrintLogs(record)
            return record
    except (Exception, psycopg2.DatabaseError) as error:
        PrintLogs(("Error ocurred while executing query. Error message: ",error),True)
        errorSummary.append("Error ocurred while executing query. Error message: "+str(error))
        return str(error)
    finally:
        if conn is not None:
            conn.close()
            PrintLogs("---Query Execution End---",True)


def CheckConnectDB():
    PrintLogs("---Check DBConnectivity Started---",True)
    conn = None
    connFileObj= open(connectionStrFileName, "r")
    connectionString=connFileObj.read()
    PrintLogs(connectionString)

    try:
        conn = psycopg2.connect(connectionString)
        cur = conn.cursor()
        cur.close()
        PrintLogs("Connection successful")
    except (Exception, psycopg2.DatabaseError) as error:
        PrintLogs(("Unable to connect to DB",error),True)
        errorSummary.append(("Unable to connect to DB",error))
        sys.exit(0)
    finally:
        if conn is not None:
            conn.close()
            PrintLogs('Database connection closed.')
            PrintLogs("\n---Check DBConnectivity End---",True)
		
def WriteFile(filename, text,header,footer):
    PrintLogs("----------Writing output to file Start---------", True)
    file = open(filename, "a")
    file.write(header)
    file.write("\n\n".join(text))
    file.write(footer)
    file.close()
    PrintLogs("----------Writing output to file End---------", True)
	
if __name__ == '__main__':
    PrintLogs("-----------Starting Application--------", True)
    if len(sys.argv) == 3:
        numOfCustomer = int(sys.argv[1])
        timeDiff = int(sys.argv[2])
        print(numOfCustomer)
        print(timeDiff)
    else:
        PrintLogs("Invalid number of parameters.", True)
        sys.exit(-1)

	#threads = []
	#for i in range(5):
	#	t = threading.Thread(target=worker)
	#	threads.append(t)
	#	t.start()
    CheckConnectDB()
    selectinput()
