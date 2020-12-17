import re
import sys
from operator import add
from pyspark import SparkConf, SparkContext
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.stem.porter import PorterStemmer
from nltk.corpus import stopwords
from string import punctuation

exeCount=sys.argv[1]
rootOutputFolder=sys.argv[2]

datasetPath="/cosc6339_hw2/gutenberg-500/"
truncatePath="/gutenberg-500/"

allstemmedwordsPath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q1_alltrimmedwords"
top1000wordsPath="/bigd41/HW3/HW2/guten500/"+rootOutputFolder+"/Q1_top1000words"
stopWordPath="/bigd41/HW3/GoogleStopWords.txt"

NUM_PARTITION = 20
TOPWORD_COUNT=1000
NUM_PARTITION_REDUCE = 50

conf = SparkConf().setAppName('HW3_HW2_Q1_V1_Guten500')
conf.set('spark.shuffle.service.enabled', 'false')
conf.set('spark.dynamicAllocation.enabled', 'false')
conf.set('spark.driver.memory','2g');
conf.set("spark.executor.memory", '10g')
conf.set("spark.executor.instances", exeCount)
sc = SparkContext(conf=conf)


if __name__ == '__main__':	
		porter = PorterStemmer()
		stopWordsInput = sc.textFile(stopWordPath)
		customStopWords = set(stopWordsInput.collect()+stopwords.words('english')+list(punctuation))

		#get all file data
		rawWordsinLower=sc.wholeTextFiles(datasetPath,NUM_PARTITION,False).flatMap(lambda (name, content): map(lambda word: (word.lower(), name.split(truncatePath)[1]), re.findall(r'\w+', content)))

		#first do the puncuation removal
		filteredWords=rawWordsinLower.filter(lambda (word, name): word not in customStopWords)	
		stemmedWords=filteredWords.map(lambda  (word, name):(porter.stem(word),name))
		stemmedWords.map(lambda (word,name):word+"#;"+name).saveAsTextFile(allstemmedwordsPath)

		#count the words and sort it
		sortedStemmedWords = stemmedWords.map(lambda (word,name): (word, 1)).reduceByKey(lambda a, b: a + b,NUM_PARTITION_REDUCE).sortBy(lambda a: -int(a[1])).top(TOPWORD_COUNT, key=lambda x: x[1])
		sc.parallelize(sortedStemmedWords,NUM_PARTITION).map(lambda (word,count):word+"#;"+str(count)).saveAsTextFile(top1000wordsPath)