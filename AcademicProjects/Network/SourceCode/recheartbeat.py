import socket
import time
import sqlite3

def updateServer(serverIP):
    
    # import pdb; pdb.set_trace()
    updateQuery=('update Server set Cost=10 where IP="{0}"').format(serverIP)
    print updateQuery
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute(updateQuery)
        conn.commit()
        print "Server updated successfully"
    except Exception as e:
        print 'Error while updating server ! %s' % (str(e))
    finally:
        conn.close()

# creates socket object
s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

host = '' # or just use (host = '')
port = 50007

s.connect((host, port))

while 1:
		tm = s.recv(1024) # msg can only be 1024 bytes long
		print("Getting heartbeat from server  %s" % tm.decode('ascii'))
		getServerIp=tm.decode('ascii').split(':')[1];
		print getServerIp
		updateServer(getServerIp)
		print '\n sleeping for 5 sec'
		time.sleep(5)

s.close()