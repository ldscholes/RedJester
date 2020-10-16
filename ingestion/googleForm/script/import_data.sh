#!/bin/bash
#
echo "enter google form ID e.g.1QJzZfb8iUqYhBU_m3ptzoFPHcASZvpSonDYkKP_Mzic"
read file
echo $file

cd ~/redJester/ingestion/googleForm/data/

#download google form results
wget --output-file="logs.csv" "https://docs.google.com/spreadsheets/d/1X34fwa922IMzlKKB_yRjU3Asn12zANjwv2CA8zqdC8o/export?format=csv&gid=1579668535" -O "downloaded_content.csv"

#Remove first line of file
perl -pi -e '$_ = "" if ( $. == 1 );' downloaded_content.csv

hdfs dfs -put ~~/redJester/ingestion/googleForm/data/downloaded_content.csv /apps/hive/warehouse/google_form_update/
