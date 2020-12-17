import re
import sys
from pyspark import SparkConf, SparkContext
from pyspark.sql.session import SparkSession
from pyspark.sql import SparkSession

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

stemmedWordsPath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q1_alltrimmedwords/*"
top1000wordsPath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q1_top1000words/*"
invertedUncompressedParquetFilePath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q2_parque_uncompressed"
invertedCompressedParquetFilePath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q2_parque_compressed"

STEMMEDWORD_NUM_PARTITION = 10

conf = SparkConf().setAppName('HW3_Q2_Parquet_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','2g')
conf.set('spark.executor.memory', '10g')
conf.set('spark.executor.instances', exeCount)
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

if __name__ == '__main__':

		getAllTop1000Words = sc.textFile(top1000wordsPath,use_unicode=False)
		topWordsOnly=getAllTop1000Words.map(lambda x:(str(x).split("#;")[0],int(str(x).split("#;")[1])))
		getAllStemmedWords = sc.textFile(stemmedWordsPath,STEMMEDWORD_NUM_PARTITION,False)	
		
		# Get the total num of words in each file
		totalWordsInFile=getAllStemmedWords.map(lambda word: (word.split("#;")[1],1)).reduceByKey(lambda count1, count2: count1 + count2,STEMMEDWORD_NUM_PARTITION).sortByKey()
		
		# Filter only top words from stemmedwords
		allStemmedWordsNew=getAllStemmedWords.map(lambda word: (word.split("#;")[0],word.split("#;")[1])).join(topWordsOnly.map(lambda x:x)).mapValues(lambda x:(x[0]))
		
		fileInWordCount= allStemmedWordsNew.map(lambda word: (((word[0]+"#;"+word[1]),1))).reduceByKey(lambda count1, count2: count1 + count2,STEMMEDWORD_NUM_PARTITION).sortByKey()		
		invertedTable = fileInWordCount.map(lambda (a,b): (a.split("#;")[1],(b, a.split("#;")[0]))).join(totalWordsInFile).mapValues(lambda (x,y):  x[1]+","+str(float(x[0])/y))		
		
		if len(sys.argv) == 4:
			invertedTable.toDF().write.option("compression", "snappy").parquet(invertedCompressedParquetFilePath)
		else:
			invertedTable.toDF().write.option("compression", "none").parquet(invertedUncompressedParquetFilePath)
			
		

		
		
		
		
