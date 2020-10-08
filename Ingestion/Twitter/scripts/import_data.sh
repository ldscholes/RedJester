#!/bin/bash
#

cd ~/redJester/Ingestion/Twitter/

hadoop jar twitter.jar propFile.properties ~/redJester/Ingestion/Twitter/data/twitter.json

perl -pi -e 's/\r\n/\n/g' twitter.json

hdfs dfs -put ~/redJester/Ingestion/Twitter/data/* /apps/hive/warehouse/twitter_update/
