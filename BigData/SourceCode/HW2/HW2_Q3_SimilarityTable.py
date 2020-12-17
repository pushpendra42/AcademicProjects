from itertools import combinations
import json
import pydoop.hdfs as hdfs
import time

def CreateSimilarityTable(input,outputFolder):
	input=str(input)
	input=input.replace("'","").replace("[","").replace("]","")
	result_dict = dict()
	res = 1
	combination_map_list = []
	timestr = time.strftime("_%Y_%m_%d_%H_%M_%S")
	filename = 'filescombination'+timestr+'.txt'

	f = open(filename,'w')

	for tup in input.split(","):
		res=1
		key = ''
		file_names = []
		file_to_value_dict = dict()
		for x in tup.split("#;"):
			y=x.split(":")
			key +=y[0]
			res *= float(y[1])
			file_to_value_dict[y[0].strip()] = float(y[1])
		#result_dict[key] = round(res,FLOAT_PREC)
		result_dict[key] = res
		sorted_keys =  list(file_to_value_dict.keys())
		sorted_keys.sort()
		
		combinations_list = list(combinations(sorted_keys,2))
		combinations_map = dict()
		for com in combinations_list:
			res1 = 1
			com_key = ''
			for val in com:
				res1 *= file_to_value_dict[val]
				com_key += val+"*"
			com_key = com_key[:-1]
			combinations_map[com_key] = res1
			sample_tuple = (com_key,str(res1))
			#print(sample_tuple, list(sample_tuple),':'.join(list(sample_tuple)))
			combination_map_list.append(':'.join(list(sample_tuple)))
			f.write(':'.join(list(sample_tuple)) + "\n")

	f.close()
	path =outputFolder+"/"+filename
	hdfs.put(filename, path)