from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SocketServer

import socket
import cgi
import BaseHTTPServer
import hashlib
import os
import json
import urllib2
import requests
import datetime

LATENCY_PROXY_PING_PORT=22125
headers = {'content-type': 'application/json'}#; charset: utf-8
latencyValue=10;

def getDownloadServer(criteria=0):
        downloadStrategy=int(criteria)
        getServerList=getAllServer()

        #import pdb; pdb.set_trace()
        if downloadStrategy==0:    
            return str(getServerList[0][2]) +':'+ str(getServerList[0][4])
        elif downloadStrategy==1:
            serverSpeed=getServerLatency(getServerList)
            latencyValue=serverSpeed[0][5]
            return str(serverSpeed[0][2]) +':'+ str(getServerList[0][4])
        else:
            serverSpeed=getServerLatency(getServerList)
            latencyValue=serverSpeed[1][5]
            return str(getServerList[1][2])+':'+str(getServerList[1][4])


def getAllServer():
    try:
        
        response = requests.get(priceInfoServer, headers=headers)
        #import pdb; pdb.set_trace()
        if response.status_code == 200:
            serverInfo=json.JSONDecoder().decode(response.content)['data']
            sortedServerInfo=sorted(serverInfo, key=lambda x: x[3])
            return sortedServerInfo
        else:
            print 'Error ocurred while quering priceinfo server'
            return 
    except Exception as e:
        print 'Error while quering priceinfo server! %s' % (str(e))
        return

def getServerLatency(allServerList):
    
    #import pdb; pdb.set_trace() 
    latencyList=[]
    sortedLatencyList=[]
    latency=0

    for server in allServerList:
        try:
            s = socket.socket()
            serverIP=server[2]
            serverPort=server[4]
            a = datetime.datetime.now()
            s.settimeout(10)
            s.connect((str(serverIP), LATENCY_PROXY_PING_PORT))
            b = datetime.datetime.now()
            latency=(b-a).microseconds
            latencyList.append((server[0],server[1],server[2], server[3], server[4],latency))
            print 'latency= ',latency
        except Exception as e:
            print 'Error while quering priceinfo server! %s' % (str(e))
            latencyList.append((server[0],server[1],server[2], server[3], server[4],latency))
            print 'latency= ',latency
        finally:
            s.close()

    if latencyList:
        sortedLatencyList=sorted(latencyList, key=lambda x: x[5])
        return sortedLatencyList
    return



class ThreadedHTTPServer(SocketServer.ThreadingMixIn, HTTPServer):
    """Handle requests in a separate thread."""

class ProxyHandler(BaseHTTPRequestHandler):

    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        
        response = {'status': False, 'msg': 'Server Error! Unable to process request'}
        username = None

        ctype, params = cgi.parse_header(self.headers.getheader('content-type'))
        criteria,criteriaParams=cgi.parse_header(self.headers.getheader('strategy'))

        if ctype and ctype.lower() == 'application/json':
            
            #import pdb; pdb.set_trace()

            cdnServerIP=getDownloadServer(criteria)
            getRequestUrl=self.path
            splitUrl=getRequestUrl.rsplit('/')
            filename=splitUrl[len(splitUrl)-1]
            downloadUrl='http://'+cdnServerIP+'/'+filename

            print 'Download url : ',downloadUrl
            headers = {'content-type': 'application/json',"strategy": criteria,"clientspeed":str(latencyValue)}
            response = requests.get(downloadUrl,headers=headers)
            self.send_response(200)
        else:
            response['msg'] = 'Unable to fetch server list.'
                
        if 'filecontent' not in response.content:
            self.send_response(403)
                
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(response.content)
        return


    def do_HEAD(self):
        self._set_headers()

    
def run(host,port, handler_class=ProxyHandler):
    server_address = (host, int(port))
    httpd = ThreadedHTTPServer(server_address, handler_class)
    print 'Starting httpd... with Port %s' % (port)
    httpd.serve_forever()        

if __name__ == "__main__":
    from sys import argv
    #hostName=argv[1]
    hostName=''
    port=int(argv[1])
    priceInfoServer=argv[2]
    
    if len(argv) == 3:
        run(hostName,port)
    else:
        print 'Cannot start server as all 4 parameters are not given.'
        