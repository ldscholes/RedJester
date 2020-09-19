#!/bin/bash
#
echo "type file name in format: yyyy-mm-dd"
read file
echo $file

wget https://files.pushshift.io/reddit/comments/daily/RC_"$file".gz -P /home/users/cg14915/RedJester/data/

gunzip /home/users/cg14915/RedJester/data/RC_$file".gz

hdfs dfs -put /home/users/cg14915/RedJester/data/* /user/hive/warehouse/reddit_update/
