#!/bin/bash
#
echo "file name in format: yyyy-mm-dd"
read file
echo $file

wget https://files.pushshift.io/reddit/comments/daily/"$file" -P ~/redJester/ingestion/reddit/data/

gunzip ~/redJester/ingestion/reddit/data/"$file"

hash=$(sha256sum ~/redJester/ingestion/reddit/data/"$file" | awk '{print $1}')
size=$(wc -c ~/redJester/ingestion/reddit/data/"$file" | awk '{print $1}')

~/redJester/ingestion/ingestionChecker/script/ingestion_checker.sh reddit $file $size $hash

hdfs dfs -put ~/redJester/ingestion/reddit/data/* /apps/hive/warehouse/reddit_update/
