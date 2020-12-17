import socket
import json
import base64
import sqlite3
import os
import fileclass_pb2
import ssl,pprint
import datetime

BUFSIZE = 4096
folderPath=''

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


def getAllServers():
    try:
        conn = sqlite3.connect('serverlist.db')
        c = conn.cursor()
        c.execute('''select * from Server''')

        serverData = []

        for row in c:
            serverData.append((row[0],row[1],row[2], row[3], row[4]))
        return serverData

    except Exception, e:
        print 'Error while querying server table! %s' % (str(e))
    
    finally:
        conn.close()

    
def replicateStreaming(dataStream,targetName,sslTrue):
    serverdata=getAllServers()
    #import pdb; pdb.set_trace()
    for server in serverdata:
        try:
            #import pdb; pdb.set_trace()
            if targetName==str(server[2]):
                
                print 'This is repliacte call'

                if sslTrue=='1':
                    serverAddress = (str(server[2]), 4000)
                    serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    ssl_sock = ssl.wrap_socket(serv,ca_certs="cosc.getcertificate.crt",cert_reqs=ssl.CERT_REQUIRED)
                    ssl_sock.connect(serverAddress)
                    ssl_sock.send(dataStream)
                    ssl_sock.close()
                else:
                    serverAddress = (str(server[2]), 22110)
                    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    #import pdb; pdb.set_trace()
                    client.connect(serverAddress)
                    client.send(dataStream)
                    client.close()
        except Exception, e:
            print 'Error while replicating files! %s' % (str(e))            


def saveFile(host,port,sslSupport):
    ADDR = (host, int(port))
    serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serv.bind(ADDR)
    serv.listen(5)

    print 'listening ...'
    print 'To upload your file, use the command "python serverclient.py {1} {0} <filepath>"'.format(port,sourceIP)

    data = ''
    jsonData=''
    replicate=0
    fobj=''

    while True:
        
        conn, addr = serv.accept()
        print 'client connected ... ', addr
        #import pdb; pdb.set_trace()
        #ctype, params = cgi.parse_header(self.headers.getheader('content-type'))

        a = datetime.datetime.now()
        while True:
            chunk_data = conn.recv(BUFSIZE)
            if not chunk_data:
                break

            data += chunk_data

        try:
            #import pdb; pdb.set_trace()
            clientdata='proto'
            fileclass=fileclass_pb2.File()
            fileclass.ParseFromString(data)
            print 'Its protobuf3 data'
        except Exception as e:

            getClientData=json.JSONDecoder().decode(data)
            clientdata='json'
            print 'Its json data'

        try:
            #import pdb; pdb.set_trace()
            if clientdata=='json':
                jsonData=json.JSONDecoder().decode(data)
                fileName = jsonData['fileName']

                if jsonData.get('replicate'):
                    replicate=  str(jsonData['replicate'])

                if jsonData.get('target'):
                    target=  str(jsonData['target'])
                fileContent =base64.b64decode(jsonData['fileContent'])
            else:
                fileContent=base64.b64decode(fileclass.content)
                fileName = fileclass.name

                if fileclass.replicate:
                    replicate=  str(fileclass.replicate)

                if fileclass.target:
                    target=  str(fileclass.target)


            storageloc=folderPath+'/'+fileName
            #storageloc='/home/Network/Server/CDN/downloaded/'+fileName
            print storageloc

            with open(storageloc, 'wb') as fobj:
                fobj.write(fileContent)
                fobj.flush()
                #os.fsync(fobj)

            #fobj.flush()
            #os.fsync(fobj.fileno())            
            conn.close()

            filenameLower=fileName.lower()
            if filenameLower.endswith('.jpg') or filenameLower.endswith('.jpeg') or filenameLower.endswith('.png'):
            	reduceImageSize(folderPath,fileName)

            print 'finished writing file'
            print 'client disconnected'

            #import pdb; pdb.set_trace()
            if replicate=='1':
                print 'Moving the files to other server'
                newData={"fileName": fileName, "fileContent": jsonData['fileContent']}
                newJsonData=json.JSONEncoder().encode(newData)
                #import pdb; pdb.set_trace()
                replicateStreaming(newJsonData,target,sslSupport)

        except Exception, e:
            print 'Error ocurred while saving file.! %s' % (str(e))
        finally:
            print 'Finally called'
        b = datetime.datetime.now()
        c = b - a
        print '\nTotal time taken in milliseconds = '+ str(c.microseconds/1000) +'\n'
            

if __name__ == "__main__":
    from sys import argv
    
    #hostName=argv[1]
    sourceIP=argv[1]
    hostName=''
    portNo=argv[2]
    folderPath=argv[3]
    isSsl=argv[4]
    
    if len(argv) == 5:
        saveFile(hostName,portNo,isSsl)
    else:
        print 'Cannot start server as all 4 parameters are not given.'