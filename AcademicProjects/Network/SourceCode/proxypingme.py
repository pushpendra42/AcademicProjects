
import socket               

LATENCY_PROXY_PING_PORT=22125
s = socket.socket()         
print "Socket successfully created"
from sys import argv
port = LATENCY_PROXY_PING_PORT
s.bind(('', port))        
print "socket binded to %s" %(port)

s.listen(5)     
print "socket is listening"            

while True:
   c, addr = s.accept()     
   print 'Got connection from', addr
   c.send('Thank you for connecting')
   c.close()