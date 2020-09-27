#!/bin/bash
#
echo "file name in format: yyyy-mm-dd"
read file
echo $file

wget https://files.pushshift.io/reddit/comments/daily/"$file" -P ~/redJester/data/

gunzip ~/redJester/data/"$file"

hdfs dfs -put ~/redJester/data/* /apps/hive/warehouse/reddit_update/
