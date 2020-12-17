import socket
import json
import base64
import fileclass_pb2


def uploadFIle(host,port,fileName,isJson):
	serverAddress = (host, int(port))
	BUFSIZE = 4096

	try:

		fh=open(fileName, 'rb')
		fileContent = base64.b64encode(fh.read())
		fh.close()
		print fileName
		splitUrl=fileName.rsplit('/')
		fileIndex=len(splitUrl)-1
		newFileName=splitUrl[fileIndex]
		sendData=''
		headers=''

		if isJson=='1':
			print 'Uploading f1ile using json'
			data={"fileName": newFileName,'target':hostName,"replicate":1,"fileContent": fileContent}
			jsonData=json.JSONEncoder().encode(data)
			#headers = {'content-type': 'application/json'}
			#import pdb; pdb.set_trace()
			sendData=jsonData
			print 'Length of the file in bytes = ',len(jsonData)

		else:
			#import pdb; pdb.set_trace()
			print 'Uploading file using protobuf3'
			protoFile=fileclass_pb2.File()
			protoFile.name=newFileName
			protoFile.size=len(fileContent)
			protoFile.content=fileContent
			protoFile.target=hostName
			protoFile.replicate='1'
			serializedData=protoFile.SerializeToString()
			sendData=serializedData
			
		client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		client.connect(serverAddress)
		#import pdb; pdb.set_trace()
		client.send(sendData)
		client.close()
		print 'File uploaded to server successfully.'

	except Exception as e:
		#import pdb; pdb.set_trace()
		print 'Error while uploading file to server! %s' % (str(e))
		print 'Please try again later.'


if __name__ == "__main__":
    from sys import argv
    hostName=argv[1]
    portNo=argv[2]
    fileWithPath=argv[4]
    jsonSupport=argv[3]
    uploadFIle(hostName,portNo,fileWithPath,jsonSupport)


