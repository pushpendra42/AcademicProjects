import sys
from pyspark import SparkConf, SparkContext
from pyspark.sql.session import SparkSession
from itertools import combinations
import HW3_Q3_SimilarityTable

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

invertedTableInputPathAvro="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q2_avro/*"
similarityMatrixOutputPathAvro="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_filescombinationAvro"
finalSimilarityTablePathAvro="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_similaritymatrixAvro"
TOP_WORD_PARTITION = 4
INVERTEDINDEX_PARTITION = 10

conf = SparkConf().setAppName('HW3_Q3_Avro_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','3g');
conf.set("spark.executor.memory", '9g')
conf.set("spark.executor.instances", exeCount)
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

if __name__ == '__main__':		
			weightedMatrix = spark.read.format("com.databricks.spark.avro").load(invertedTableInputPathAvro)	
			rdd4=weightedMatrix.rdd.map(tuple).map(lambda x:(x[1].split(",")[0],x[0]+":"+x[1].split(",")[1])).reduceByKey(lambda x,y: x+"#;"+y,TOP_WORD_PARTITION).filter(lambda x: "#;" in str(x)).sortByKey()			
			HW3_Q3_SimilarityTable.CreateSimilarityTable(rdd4.values().collect(),similarityMatrixOutputPathAvro)
			finaloutput=sc.textFile(similarityMatrixOutputPathAvro+"/*",INVERTEDINDEX_PARTITION,False).map(lambda x: (x.split(":")[0],x.split(":")[1])).reduceByKey(lambda x,y: float(x)+float(y),TOP_WORD_PARTITION).sortBy(lambda a: -float(a[1]))
			finaloutput.toDF().write.format("com.databricks.spark.avro").option("com.databricks.spark.avro","uncompressed").save(finalSimilarityTablePathAvro)