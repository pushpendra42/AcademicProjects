#!/usr/bin/python
import sys
import psycopg2
import pandas as pd
import datetime
import threading
import random
import time

querySummary=[]
errorSummary=[]
connectionStrFileName="connectionstring.txt"

def PrintLogs(msg, printReq=False):
    if printReq:
        print(msg)

def selectinput(repeationNum,threadCount):
    #PrintLogs("---Query execution Started --- " + threading.current_thread().name +" --- " + str(threading.get_ident()))
    PrintLogs("---Query execution Started for Repeatation: " +repeationNum+" and Thread num: "+threadCount,True)
    conn = None
    connFileObj = open(connectionStrFileName, "r")
    connectionString = connFileObj.read()

    try:
        #conn = psycopg2.connect (host="localhost", database="flight2019", user="postgres", password="dbms2019")
        conn = psycopg2.connect(connectionString)
        conn.autocommit = False
        cur = conn.cursor()

        PrintLogs("Transaction started")
        customerQuery="select customerid from customer order by random() limit 1;"
        customerId=ExecuteQuery(conn,cur,customerQuery,1,False)
        PrintLogs(customerId[0])

        flightTripQuery="select flighttripid, flightid from flighttrip order by random() limit 1;"
        flightTripId=ExecuteQuery(conn,cur,flightTripQuery, 1, False)
        PrintLogs(flightTripId[0],flightTripId[1])

        seatClassList=['seatB','seatE']
        seatClass=random.choice(seatClassList)
        seatClassIndex= "0" if seatClass=='seatB' else "1"
        #print(seatClassIndex+" ---  "+seatClass)
        flightInstanceQuery="select "+str(seatClass)+" from flightinstance where flightTripId="+str(flightTripId[0])+" and "+str(seatClass)+">1 for update;"
        seatNum=ExecuteQuery(conn,cur,flightInstanceQuery, 1, False)
        PrintLogs(seatNum)
        
        if seatNum[0]>0:
            fareQuery = "select sum(fare+seatfare) from (select fare from flighttrip  join flightschedule on flighttrip.flightScheduleId=flightschedule.flightScheduleId where flighttrip.flighttripid=" + str(flightTripId[0]) + ") as a, seatclass where seatclassid="+seatClassIndex+";"
            tripfare = ExecuteQuery(conn,cur,fareQuery, 1, False)
            PrintLogs(tripfare[0])

            paymethodQuery = "select payMethodID from payMethod order by random() limit 1 ;"
            paymentMethodId = ExecuteQuery(conn,cur,paymethodQuery, 1, False)
            PrintLogs(paymentMethodId[0])

            try:

                s1 = "insert into payment(payMethodID, paydate,subtotal) values("+str(paymentMethodId[0])+", now(),"+str(tripfare[0])+")  returning paymentID;"
                paymentId = ExecuteQuery(conn,cur,s1,1, False,True)
                PrintLogs(paymentId)

                s2="insert into ticket(customerId, bookingDate,paymentID) values("+str(customerId[0])+",now(),"+str(paymentId[0])+") returning ticketid;"
                ticketid = ExecuteQuery(conn,cur,s2,1, False,True)
                PrintLogs(ticketid[0])

                #if str(seatClass)=='seatB':
                seatid="select seatNo from flightSeat where seatClassId="+seatClassIndex+" order by random() limit 1;"
                seatid = ExecuteQuery(conn,cur,seatid,1, False,True)

                seat="select * from customertrip where flightTripid="+str(flightTripId[0])+" and seatid ="+str(seatid[0])+";"
                seat= ExecuteQuery(conn,cur,seat, 3, False,True)

                if seat==0:
                        s3 = "insert into customertrip(ticketid,seatid,flightTripID,tripfare,customerid,flightid) values("+str(ticketid[0])+", "+str(seatid[0])+","+str(flightTripId[0])+", "+str(tripfare[0])+","+str(customerId[0])+","+str(flightTripId[1])+") returning tripid;"
                        customerTripId = ExecuteQuery(conn,cur,s3,1,False,True)
                        PrintLogs(customerTripId[0])

                        s4 = "update flightinstance set "+str(seatClass)+"="+str(seatClass)+"-1 where flighttripid="+str(flightTripId[0])+";"
                        flightIntsanceUpdate = ExecuteQuery(conn,cur,s4, 0, False,True)
                        PrintLogs(flightIntsanceUpdate)

                        q1="delete from final;"
                        q1_result = ExecuteQuery(conn,cur,q1,1,False,True)

                        q2="insert into final(flighttripid,seatB,seatE,dollars) select flightinstance.flighttripid,totalseatB-seatB,totalseatE-seatE,a.sum from flightinstance join (select flighttripid,sum(tripfare) from customertrip group by flighttripid) as a  on a.flighttripid=flightinstance.flightTripid ;"
                        q2_result = ExecuteQuery(conn, cur, q2,0,False,True)

                        conn.commit()
                        PrintLogs("Transaction ends.",True)
                else:
                    conn.rollback()
                    PrintLogs("No seat available even after locking, rollback performed.", True)
            except:
                conn.rollback()
                PrintLogs("No seat available, roll back performed.",True)
        else:
            PrintLogs("No seat available",True)
    except:
        PrintLogs("Error ocurred while connecting to database.",True)
    finally:
        if conn is not None:
            conn.close()
            #PrintLogs("---Query execution End for --- " + threading.current_thread().name + " --- " + str(threading.get_ident()),True)
            PrintLogs("---Query execution completed for Repeatation: " + repeationNum + " and Thread num: " + threadCount,True)


def ExecuteQuery(conn,cur,query, returnType=0,isLogRequired=False,isCommitReq=False):
    PrintLogs("---Query execution Started---",True)

    global querySummary
    querySummary.append(query)
    PrintLogs(query, True)

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
        #conn = psycopg2.connect (host="localhost", database="postgres", user="postgres", password="123")
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
    if len(sys.argv) == 3 or len(sys.argv) == 4:
        numOfCustomer = int(sys.argv[1])
        interval = int(sys.argv[2])

        if len(sys.argv) == 3:
            repeatThread= 1
        else:
            repeatThread= int(sys.argv[3])

        print(numOfCustomer)
        print(interval)
        print(repeatThread)
		
        if CheckConnectDB():
            for repCount in range(repeatThread):
                threads = []
                for threadCount in range(numOfCustomer):
                    t = threading.Thread(target=selectinput,args=[str(repCount+1),str(threadCount+1)])
                    threads.append(t)
                    t.start()
                if repCount<repeatThread-1:
                    PrintLogs("Sleep Started for iteration "+str(repCount+1),True)
                    time.sleep(interval)
                    PrintLogs("Sleep Over for iteration " + str(repCount + 1), True)
    
    else:
        PrintLogs("Invalid number of parameters.", True)
        sys.exit(-1)
