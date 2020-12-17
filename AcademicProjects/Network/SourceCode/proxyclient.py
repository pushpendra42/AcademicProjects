import requests
import json
import time
import base64
import datetime

def getInternetSpeed(server,port):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
    a = datetime.datetime.now()
    s.bind((host,port))
    conn, addr = s.accept()
    data = 'conn.recv(1024)'
    conn.sendall(data)
    b = datetime.datetime.now()
    c = b - a
    conn.close()
    return c.seconds

from sys import argv

imageUrl = argv[1]
headers = {'content-type': 'application/json'}

try:
    a = datetime.datetime.now()
    print imageUrl
    strategy=0

    if len(argv)==3:
        strategy=argv[2]

    #mySpeed=getInternetSpeed(imageUrl)
    headers = {'content-type': 'application/json',"strategy": strategy}#; charset: utf-8
    resp = requests.get(imageUrl,headers=headers)

    splitUrl=imageUrl.rsplit('/')
    fileIndex=len(splitUrl)-1
    filename='downloaded_'+time.strftime("%Y%-m%-d-%H-%M-%S")+ splitUrl[fileIndex]

    jsonData=json.JSONDecoder().decode(resp.content)
    fileContent =base64.b64decode(jsonData['filecontent'])
    
    with open(filename, 'wb') as fobj:
        fobj.write(fileContent)
    fobj.close()
    print 'File downloaded successfully'
    b = datetime.datetime.now()
    c = b - a
    print '\nTotal time taken in milliseconds = '+ str(c.microseconds/1000) +'\n'

except Exception as e:
        print 'Error while downloading file! %s' % (str(e))
    
