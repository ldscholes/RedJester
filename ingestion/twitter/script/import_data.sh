#!/bin/bash
#

cd ~/RedJester/ingestion/twitter/script

filenow="twitter-$(date +'%d-%m-%Y-%H-%M-%S').json"

hadoop jar twitter.jar propFile.properties ~/RedJester/ingestion/twitter/data/$filenow

hash=$(sha256sum ~/RedJester/ingestion/twitter/data/$filenow | awk '{print $1}')
size=$(wc -c ~/RedJester/ingestion/twitter/data/$filenow | awk '{print $1}')

~/RedJester/ingestion/IngestionChecker/script/ingestion_checker.sh twitter $filenow $size $hash

perl -pi -e 's/\r\n/\n/g' ~/RedJester/ingestion/twitter/data/$filenow

hdfs dfs -put ~/RedJester/ingestion/twitter/data/* /apps/hive/warehouse/twitter_update/

rm -rf ~/RedJester/ingestion/twitter/data/$filenow
