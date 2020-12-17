import os
import sys
from pyspark import SparkConf, SparkContext
from pyspark.sql.session import SparkSession
from pyspark.sql import SparkSession

from pyspark.sql.types import StructType
from pyspark.sql.types import StructField
from pyspark.sql.types import StringType


exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

TOP_WORD_PARTITION = 100

conf = SparkConf().setAppName('HW3_Q4_Parquet_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','2g');
conf.set('spark.executor.memory', '6g')
conf.set('spark.executor.instances', exeCount)
sc = SparkContext(conf=conf)
spark = SparkSession(sc)

if __name__ == '__main__':
			if len(sys.argv) == 4:
				finalSimilarityTablePath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_similaritymatrixParq_compressed/*"
				top10SimilarFiles="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q4_top10_similarFilesParq_compressed"
			else:
				finalSimilarityTablePath="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q3_similaritymatrixParq_uncompressed/*"
				top10SimilarFiles="/bigd41/HW3/guten500/"+rootOutputFolder+"/Q4_top10_similarFilesParq_uncompressed"
			
			# sorting needs to be implemented
			similarityMatrix= spark.read.parquet(finalSimilarityTablePath).rdd.map(tuple)
			sc.parallelize(similarityMatrix.take(10)).coalesce(1).saveAsTextFile(top10SimilarFiles)