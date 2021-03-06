import socket
import time

HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()
print 'Connected by', addr
while 1:
    print 'I am alive\n'

    data = 'IP:'+socket.gethostbyname(socket.gethostname())

    if not data:
        break

    conn.sendall(data)
    time.sleep(5)
conn.close()