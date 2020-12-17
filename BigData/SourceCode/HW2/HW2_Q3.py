import sys
from pyspark import SparkConf, SparkContext
from itertools import combinations
import HW2_Q3_SimilarityTable

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

invertedTableInputPath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q2_invertedtable/*"
similarityMatrixOutputPath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q3_filescombination"
finalSimilarityTablePath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q3_similaritymatrix"
TOP_WORD_PARTITION = 10
INVERTEDINDEX_PARTITION = 200

conf = SparkConf().setAppName('HW3_HW2_Q3_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','3g');
conf.set("spark.executor.memory", '9g')
conf.set("spark.executor.instances", exeCount)
sc = SparkContext(conf=conf)

if __name__ == '__main__':
			weightedMatrix = sc.textFile(invertedTableInputPath,TOP_WORD_PARTITION,False)
			rdd4=weightedMatrix.map(lambda x:(x.split("#;")[0],x.split("#;")[1]+ ":"+x.split("#;")[2])).reduceByKey(lambda x,y: x+"#;"+y,TOP_WORD_PARTITION).filter(lambda x: "#;" in str(x)).sortByKey()		
			HW2_Q3_SimilarityTable.CreateSimilarityTable(rdd4.values().collect(),similarityMatrixOutputPath)
			#finaloutput=sc.textFile(similarityMatrixOutputPath+"/*",INVERTEDINDEX_PARTITION,False).map(lambda x: (x.split(":")[0],x.split(":")[1])).reduceByKey(lambda x,y: round(float(x)+float(y),FLOAT_PREC),TOP_WORD_PARTITION).sortBy(lambda a: -float(a[1]))
			finaloutput=sc.textFile(similarityMatrixOutputPath+"/*",INVERTEDINDEX_PARTITION,False).map(lambda x: (x.split(":")[0],x.split(":")[1])).reduceByKey(lambda x,y: float(x)+float(y),TOP_WORD_PARTITION).sortBy(lambda a: -float(a[1]))
			finaloutput.saveAsTextFile(finalSimilarityTablePath)