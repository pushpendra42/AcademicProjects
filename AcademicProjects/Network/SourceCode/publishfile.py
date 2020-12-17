from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

import SocketServer
import cgi
import os
import posixpath
import BaseHTTPServer
import urllib
import cgi
import shutil
import sqlite3
import mimetypes
import re
import base64
import json
import datetime

def reduceImageSize(imagePath,filename):
    from PIL import Image

    try:

        #import pdb; pdb.set_trace()
        imageFullPath=imagePath +'/'+filename
        smallImgName=imagePath +'/small'+filename
        mediumImgName=imagePath +'/medium'+filename
        originalImage = Image.open(imageFullPath)
        newImageHeigth=int(originalImage.height*0.5)
        newImageWidth=int(originalImage.width*0.5)
        
        smallImg = originalImage.resize((newImageWidth,newImageHeigth),Image.ANTIALIAS)
        smallImg.save(smallImgName,optimize=True,quality=50)

        newImageHeigth=int(originalImage.height*0.75)
        newImageWidth=int(originalImage.width*0.75)

        mediumImg = originalImage.resize((newImageWidth,newImageHeigth),Image.ANTIALIAS)
        mediumImg.save(mediumImgName,optimize=True,quality=75)
    except Exception, e:
        print 'Error while compressing file %s' % (str(e))

class PublishFile(BaseHTTPRequestHandler):
    
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):

        #import pdb; pdb.set_trace()
        rootdir = storageLocation
        print  self.path

        response = {'status': False, 'msg': 'Server Error! Unable to process request'}
        splitUrl=self.path.rsplit('/')
        filename=splitUrl[len(splitUrl)-1]

        #import pdb; pdb.set_trace()
        filenameLower=filename.lower()
        if filenameLower.endswith('.jpg') or filenameLower.endswith('.jpeg') or filenameLower.endswith('.png'):
            ctype,params=cgi.parse_header(self.headers.getheader('clientspeed'))
            clientspeed=int(ctype)

            if ctype>3 and ctype <5:
                filename= "medium"+filename
            if ctype>5:
                filename="small"+filename

        if dynamicScaling==1:
            reduceImageSize(rootdir,filename)

        absoluteFilePath=rootdir+'/'+filename
        print absoluteFilePath
        
        try:
            f = open(absoluteFilePath)
            response['status'] = True
            response['msg'] = ''            
            response['filecontent'] = base64.b64encode(f.read())
            f.close()
            self.send_response(200)
            self.send_header('Content-type','application/json')
            self.end_headers()
            self.wfile.write(json.dumps(response))
            return
          
        except IOError:
            self.send_error(404, 'Requested file not found')
            return


    def do_HEAD(self):
        self._set_headers()


def run(host,server_class=HTTPServer, handler_class=PublishFile, port=80):
    server_address = (host, int(port))
    httpd = server_class(server_address, handler_class)
    print 'Starting httpd... with Port %s' % (port)
    httpd.serve_forever()
        

if __name__ == "__main__":
    from sys import argv
    host=''
    dynamicScaling=0

    if len(argv) == 3:
        storageLocation=argv[2]
        #print 'dynamic : '+ str(dynamicScaling)
        run(host,port=int(argv[1]))
    if len(argv) == 4:
        dynamicScaling=1
        storageLocation=argv[2]
        #print 'dynamic : '+ str(dynamicScaling)
        run(host,port=int(argv[1]))
    else:
        print 'Cannot start server as all 3 parameters are not given.'
