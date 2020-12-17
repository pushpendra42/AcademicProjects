import requests
import json
import base64


from sys import argv
url = argv[1]
headers = {'content-type': 'application/json'}

try:
	
	if url.endswith("list"):
		print "Below is the list of Servers:"

	serverList = requests.get(url,headers=headers)
	print "Serial, Server Name, IP Address, Server Cost"
	serverListData=json.loads(serverList.content)['data']

	if serverListData:
		for info in serverListData:
			print ', '.join(map(lambda x: str(x), info))
	else:
		print "There are no server present in our database."

	if url.endswith("create"):
		serverName=raw_input("Enter new server name:")
		serverIP=raw_input("Enter new IP address:")
		serverCost=raw_input("Enter server cost:")
		serverPort=raw_input("Enter server port no:")

		data={"servername": serverName,"serverip":serverIP,"servercost":serverCost,"serverport":serverPort}
		jsonData=json.JSONEncoder().encode(data)
		
		if serverName or serverIP or serverCost:
			reponse=requests.post(url,headers=headers,data=jsonData)
			print json.loads(reponse.content)['msg']

	if url.endswith("update"):
		
		if serverListData:
			serverNo=raw_input("Enter the server serial number you want to update:")
			serverName=raw_input("Enter new server name:")
			serverIP=raw_input("Enter new IP address:")
			serverCost=raw_input("Enter server cost:")
			serverPort=raw_input("Enter server port no:")

			data={"serverno": serverNo, "servername": serverName,"serverip":serverIP,"servercost":serverCost,"serverport":serverPort}
			jsonData=json.JSONEncoder().encode(data)
			
			if serverNo or serverName or serverIP or serverCost:
				reponse=requests.post(url,headers=headers,data=jsonData)
				print json.loads(reponse.content)['msg']
		else:
			print 'There is nothing to update. Program will terminate. Please create new server.'

	elif url.endswith("delete"):

		if serverListData:
			serverNo=raw_input("Enter the server serial number you want to delete:")
			data={"serverno": serverNo}
			jsonData=json.JSONEncoder().encode(data)
			if serverNo:
				serverreponse=requests.post(url,headers=headers,data=jsonData)
				print json.loads(serverreponse.content)['msg']
		else:
			print 'There is nothing to delete. Program will terminate. Please create new server.'

except Exception, e:
        print 'Error while processing your request! %s' % (str(e))
