from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

import SocketServer
import cgi
import os
import posixpath
import BaseHTTPServer
import urllib
import cgi
import sqlite3
import mimetypes
import re
import base64
import json


def getAllServer():
    
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute('''select * from Server''')

        data = []
        for row in c:
            data.append((row[0],row[1],row[2], row[3], row[4])) # [ [1,2,3], [1,2,3], ]
        return data

    except Exception, e:
        print 'Error while querying server table! %s' % (str(e))
    
    finally:
        conn.close()

def addNewServer(serverName, serverIP,serverCost,portNo):
    # import pdb; pdb.set_trace()

    addQuery="INSERT INTO Server values((select max(serial) +1 from Server),'{0}','{1}',{2},{3})".format(serverName,serverIP,serverCost,portNo)
    print addQuery
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute(addQuery)
        conn.commit()
        return "Server added successfully"
    except Exception as e:
        print 'Error while adding new server! %s' % (str(e))
        return 'Error while adding new server! %s' % (str(e))
    finally:
        conn.close()

def updateServer(serverId,serverName, serverIP,serverCost,portNo):
    
    # import pdb; pdb.set_trace()
    updateQuery=('update Server set Name="{0}",IP="{1}",Cost={2},Port={3} where Serial={4}').format(serverName,serverIP,serverCost,portNo,serverId)
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute(updateQuery)
        conn.commit()
        return "Server updated successfully"
    except Exception as e:
        print 'Error while updating server ! %s' % (str(e))
        return 'Error while updating server! %s' % (str(e))
    finally:
        conn.close()

def deleteServer(serverId):
    
    deleteQuery='delete from Server where Serial ={0}'.format(serverId)
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute(deleteQuery)
        conn.commit()
        return "Server deleted successfully. Please note if you try to delete non exisitng sever, it will return you successful message."
    except Exception as e:
        print 'Error while deleting server! %s' % (str(e))
        return 'Error while deleting server! %s' % (str(e))
    finally:
        conn.close()


class PriceInfo(BaseHTTPRequestHandler):
    
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()



    def do_GET(self):
        response = {'status': False, 'msg': 'Server Error! Unable to process request'}
        username = None
        # self.path
        #import pdb; pdb.set_trace()
        ctype, params = cgi.parse_header(self.headers.getheader('content-type'))

        if ctype and ctype.lower() == 'application/json':
            data = getAllServer()
            response['status'] = True
            response['msg'] = 'Server query successful!'
            response['data'] = data
            self.send_response(200)
        else:
            self.send_response(403)
                
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(response))
        return


    def do_HEAD(self):

        self._set_headers()

    def do_POST(self):
        response = {'status': False, 'msg': 'Server Error! Unable to process request'}
        username = None
        ctype, params = cgi.parse_header(self.headers.getheader('content-type'))
        urlPath=self.path

        # import pdb;  pdb.set_trace()
        
        if ctype and ctype.lower() == 'application/json':


            if urlPath.endswith("update"):
                content_length = int(self.headers['Content-Length'])
                post_data = self.rfile.read(content_length)
                jsonData=json.JSONDecoder().decode(post_data)
                serverNo=jsonData['serverno'];
                serverName=jsonData['servername'];
                serverIP=jsonData['serverip'];
                serverCost=jsonData['servercost'];
                serverPort=jsonData['serverport'];
                dbResponse=updateServer(serverNo,serverName,serverIP,serverCost,serverPort)
                response['status'] = True
                response['msg'] = dbResponse

            elif urlPath.endswith("create"):
                content_length = int(self.headers['Content-Length'])
                post_data = self.rfile.read(content_length)
                jsonData=json.JSONDecoder().decode(post_data)
                serverName=jsonData['servername'];
                serverIP=jsonData['serverip'];
                serverCost=jsonData['servercost'];
                serverPort=jsonData['serverport'];
                dbResponse=addNewServer(serverName,serverIP,serverCost,serverPort)
                response['status'] = True
                response['msg'] = dbResponse
                
            elif urlPath.endswith("delete"):
                content_length = int(self.headers['Content-Length'])
                post_data = self.rfile.read(content_length)
                jsonData=json.JSONDecoder().decode(post_data)
                serverNo=jsonData['serverno'];
                dbResponse=deleteServer(serverNo)
                response['status'] = True
                response['msg'] = dbResponse

            charset = params.get('charset', 'UTF-8')
            self.send_response(200)
        else:
            self.send_response(403)
            
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(response))        
        return


def run(hostname,port,server_class=HTTPServer, handler_class=PriceInfo):

    try:
        server_address = (hostname,port)
        httpd = server_class(server_address, handler_class)
        print 'Starting httpd... with Port %s' % (port)
        httpd.serve_forever()
    except Exception as e:
        print 'Unable to start server ! %s' % (str(e))
            

if __name__ == "__main__":
    from sys import argv
    hostname=''
    portno=int(argv[1])

    if(len(argv)==2):
        run(hostname,portno)
    else:
        print 'Cannot start server because all 3 parameters not given.'