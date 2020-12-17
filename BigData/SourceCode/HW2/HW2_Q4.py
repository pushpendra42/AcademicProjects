import os
import sys
from pyspark import SparkConf, SparkContext

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

TOP_WORD_PARTITION = 100

finalSimilarityTablePath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q3_similaritymatrix/*"
top10SimilarFiles="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q4_top10_similarFiles"

conf = SparkConf().setAppName('HW3_HW2_Q4_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','2g');
conf.set("spark.executor.memory", '10g')
conf.set("spark.executor.instances", exeCount)
sc = SparkContext(conf=conf)

if __name__ == '__main__':
			similarityMatrix = sc.textFile(finalSimilarityTablePath,TOP_WORD_PARTITION,False)
			sc.parallelize(similarityMatrix.take(10)).coalesce(1).saveAsTextFile(top10SimilarFiles)