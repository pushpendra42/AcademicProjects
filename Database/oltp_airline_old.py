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
    PrintLogs("---Query execution Started--- " + threading.current_thread().name +" --- " + str(threading.get_ident()), True)
    conn = None
    connFileObj = open(connectionStrFileName, "r")
    connectionString = connFileObj.read()

    try:
        # conn = psycopg2.connect(host="localhost",database="dbms2019", user="postgres", password="dbms2019")
        conn = psycopg2.connect(connectionString)
        conn.autocommit = False
        cur = conn.cursor()

        print("select input")
        customerQuery="select customerid from customer order by random() limit 1;"
        customerId=ExecuteQuery(conn,cur,customerQuery,1,False)
        print(customerId[0])

        # ftech trip id and flightid both
        flightTripQuery="select flighttripid, flightid from flighttrip order by random() limit 1;"
        flightTripId=ExecuteQuery(conn,cur,flightTripQuery, 1, False)
        print(flightTripId[0],flightTripId[1])

        seatClass=random.choice(['seatB','seatE'])
        flightInstanceQuery="select "+str(seatClass)+" from flightinstance where flightTripId="+str(flightTripId[0])+" and "+str(seatClass)+">1;"
        seatNum=ExecuteQuery(conn,cur,flightInstanceQuery, 1, False)
        print(seatNum[0])

        #getCurrentSeatStatusQuery="select * from flightinstance where flightTripid="+flightTripId[0]+" and "+seatClass+">0;"
        #getCurrentSeatStatus = ExecuteQuery(getCurrentSeatStatusQuery, 1, False)
        #print(getCurrentSeatStatus[0])

        if seatNum[0]>0:

            fareQuery = "select sum(fare+seatfare) from (select fare from flighttrip  join flightschedule on flighttrip.flightScheduleId=flightschedule.flightScheduleId where flighttrip.flighttripid=" + str(flightTripId[0]) + ") as a, seatclass where seatclassid=0;"
            tripfare = ExecuteQuery(conn,cur,fareQuery, 1, False)
            print(tripfare[0])
            # begin;
            # savepoint init;

            paymethodQuery = "select payMethodID from payMethod order by random() limit 1 ;"
            paymentMethodId = ExecuteQuery(conn,cur,paymethodQuery, 1, False)
            print(paymentMethodId[0])

            try:

                s1 = "insert into payment(payMethodID, paydate,subtotal) values("+str(paymentMethodId[0])+", now(),"+str(tripfare[0])+") returning paymentID;"
                paymentId = ExecuteQuery(conn,cur,s1,1, False,True)
                print(paymentId)

                s2="insert into ticket(customerId, bookingDate,paymentID) values("+str(customerId[0])+",now(),"+str(paymentId[0])+") returning ticketid;"
                ticketid = ExecuteQuery(conn,cur,s2,1, False,True)
                print(ticketid[0])

                s3 = "insert into customertrip(ticketid,seatid,flightTripID,tripfare,customerid,flightid) values("+str(ticketid[0])+", "+str(seatNum[0])+","+str(flightTripId[0])+", "+str(tripfare[0])+","+str(customerId[0])+","+str(flightTripId[1])+") returning tripid;"
                customerTripId = ExecuteQuery(conn,cur,s3,1,False,True)
                print(customerTripId[0])

                s4 = "update flightinstance set "+str(seatClass)+"="+str(seatClass)+"-1 where flighttripid="+str(flightTripId[0])+";"
                flightIntsanceUpdate = ExecuteQuery(conn,cur,s4, 3, False,True)
                print(flightIntsanceUpdate)

                conn.commit()
                print("selection done")

            except:
                conn.rollback()
                print("No seat available, roll back performed")
        else:
            print("No seat available")
    except:
        print("Error ocurred while connecting to database")
    finally:
        if conn is not None:
            conn.close()
            PrintLogs("---Query execution Started--- " + threading.current_thread().name + " --- " + str(threading.get_ident()),True)

def PrintLogs(msg, printReq=True):
    if printReq:
        print(msg)

def ExecuteQuery(conn,cur,query, returnType=0,isLogRequired=False,isCommitReq=False):
    PrintLogs("---Query execution Started---",True)
    global querySummary

    # if isLogRequired:
    querySummary.append(query)
    PrintLogs(query, True)

    #if isLogRequired:
    querySummary.append(query)
    PrintLogs(query,True)

    try:
        cur.execute(query)

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

        if returnType!=0:
            PrintLogs(record)
            return record
    except (Exception, psycopg2.DatabaseError) as error:
        PrintLogs(("Error ocurred while executing query. Error message: ",error),True)
        errorSummary.append("Error ocurred while executing query. Error message: "+str(error))
        return str(error)
    finally:
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
        return True
    except (Exception, psycopg2.DatabaseError) as error:
        PrintLogs(("Unable to connect to DB",error),True)
        errorSummary.append(("Unable to connect to DB",error))
        sys.exit(0)
        return False
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

        if CheckConnectDB():
            threads = []
            for i in range(numOfCustomer):
                t = threading.Thread(target=selectinput)
                threads.append(t)
                t.start()
    else:
        PrintLogs("Invalid number of parameters.", True)
        sys.exit(-1)
