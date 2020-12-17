import sys
from pyspark import SparkConf, SparkContext
from itertools import combinations
import HW3_Q3_SimilarityTable
from pyspark.sql.session import SparkSession
from pyspark.sql import SparkSession

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

TOP_WORD_PARTITION = 4
INVERTEDINDEX_PARTITION = 10

conf = SparkConf().setAppName('HW3_Q3_Parquet_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','3g')
conf.set('spark.executor.memory', '9g')
conf.set('spark.executor.instances', exeCount)
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

if __name__ == '__main__':

			if len(sys.argv) == 4:
				invertedTableInputPathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q2_parque_compressed/*"
				similarityMatrixOutputPathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_filescombinationParq__compressed"
			else:
				invertedTableInputPathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q2_parque_uncompressed/*"
				similarityMatrixOutputPathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_filescombinationParq__uncompressed"
				
			weightedMatrix= spark.read.parquet(invertedTableInputPathParq)
			rdd4=weightedMatrix.rdd.map(tuple).map(lambda x:(x[1].split(",")[0],x[0]+":"+x[1].split(",")[1])).reduceByKey(lambda x,y: x+"#;"+y,TOP_WORD_PARTITION).filter(lambda x: "#;" in str(x)).sortByKey()					
			HW3_Q3_SimilarityTable.CreateSimilarityTable(rdd4.values().collect(),similarityMatrixOutputPathParq)
			finaloutput=sc.textFile(similarityMatrixOutputPathParq+"/*",INVERTEDINDEX_PARTITION,False).map(lambda x: (x.split(":")[0],x.split(":")[1])).reduceByKey(lambda x,y: float(x)+float(y),TOP_WORD_PARTITION).sortBy(lambda a: -float(a[1]))			
			
			if len(sys.argv) == 4:
				finalCompressedSimilarityTablePathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_similaritymatrixParq_compressed"
				finaloutput.toDF().write.mode("overwrite").option("compression", "snappy").parquet(finalCompressedSimilarityTablePathParq)
			else:
				finalUncompressedSimilarityTablePathParq="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_similaritymatrixParq_uncompressed"
				finaloutput.toDF().write.mode("overwrite").option("compression", "none").parquet(finalUncompressedSimilarityTablePathParq)