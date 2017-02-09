# -*- coding:utf-8 -*-
from pyspark import SparkContext, SparkConf
from pyspark.streaming import StreamingContext
import math
appName ="hui" #你的应用程序名称
master = "mesos://zk://192.168.1.140:2181,192.168.1.141:2181,192.168.1.142:2181/mesos" #设置集群
conf = SparkConf().setAppName(appName).setMaster(master) #配置SparkContext
sc = SparkContext(conf=conf)

def my_add(parameter):
    result = False
    if parameter < 26:
        result = True
    return result
data = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
distData = sc.parallelize(data) # parallelize：并行化数据，转化为RDD
result = distData.filter(my_add)
print (result.collect())  # 返回一个分布数据集
