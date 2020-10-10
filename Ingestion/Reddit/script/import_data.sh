#!/bin/bash
#
echo "file name in format: yyyy-mm-dd"
read file
echo $file

wget https://files.pushshift.io/reddit/comments/daily/"$file" -P ~/redJester/Ingestion/Reddit/data/

gunzip ~/redJester/Ingestion/Reddit/data/"$file"

hash=$(sha256sum ~/redJester/Ingestion/Reddit/data/"$file" | awk '{print $1}')
size=$(wc -c ~/redJester/Ingestion/Reddit/data/"$file" | awk '{print $1}')

~/redJester/Ingestion/IngestionChecker/script/ingestion_checker.sh reddit $file $size $hash

hdfs dfs -put ~~/redJester/Ingestion/Reddit/data/* /apps/hive/warehouse/reddit_update/
