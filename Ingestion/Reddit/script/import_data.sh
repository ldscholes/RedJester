#!/bin/bash
#
echo "file name in format: yyyy-mm-dd"
read file
echo $file

wget https://files.pushshift.io/reddit/comments/daily/"$file" -P ~/redJester/Ingestion/Reddit/data/

gunzip ~/redJester/Ingestion/Reddit/data/"$file"

sha256sum "$file"

hdfs dfs -put ~~/redJester/Ingestion/Reddit/data/* /apps/hive/warehouse/reddit_update/
