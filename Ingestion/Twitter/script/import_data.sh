#!/bin/bash
#

cd ~/redJester/Ingestion/Twitter/

filenow="twitter-$(date +'%d-%m-%Y-%H-%M-%S').json"

hadoop jar twitter.jar propFile.properties ~/redJester/ingestion/twitter/data/$filenow"

hash=$(sha256sum ~/redJester/ingestion/twitter/data/$filenow | awk '{print $1}')
size=$(wc -c ~/redJester/ingestion/twitter/data/$filenow | awk '{print $1}')

~/redJester/ingestion/ingestionChecker/script/ingestion_checker.sh twitter $filenow $size $hash

perl -pi -e 's/\r\n/\n/g' ~/redJester/ingestion/twitter/data/$filenow

hdfs dfs -put ~/redJester/ingestion/twitter/data/* /apps/hive/warehouse/twitter_update/
