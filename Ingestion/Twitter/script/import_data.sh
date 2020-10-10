#!/bin/bash
#

cd ~/redJester/Ingestion/Twitter/

filenow="twitter-$(date +'%d-%m-%Y-%H-%M-%S').json"

hadoop jar twitter.jar propFile.properties ~/redJester/Ingestion/Twitter/data/$filenow"

hash=$(sha256sum ~/redJester/Ingestion/Twitter/data/$filenow | awk '{print $1}')
size=$(wc -c ~/redJester/Ingestion/Twitter/data/$filenow | awk '{print $1}')

~/redJester/Ingestion/IngestionChecker/script/ingestion_checker.sh twitter $filenow $size $hash

perl -pi -e 's/\r\n/\n/g' ~/redJester/Ingestion/Twitter/data/$filenow

hdfs dfs -put ~/redJester/Ingestion/Twitter/data/* /apps/hive/warehouse/twitter_update/
