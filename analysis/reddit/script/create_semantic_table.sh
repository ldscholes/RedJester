#!/bin/bash
# create_semantic_table.sh
#
###############################################################################################################################

# Call Standard Profile
BASEDIR="~/redJester/analysis/reddit"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script


echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR


HQL_NAME="create_semantic_table.hql"
# create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
cd ${HQL_DIR}
hive -f ~/redJester/analysis/reddit/hql/create_semantic_table.hql

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

HQL_NAME="update_delta_semantic_table.hql"
# update table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/reddit/hql/update_delta_semantic_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


# semantic analysis
hive -e "select body from reddit_comments' | sed 's/[\t]/,/g'  > ~/redJester/analysis/semanticAnalysis/src/inputfile.txt"

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

cd ~/redJester/analysis/semanticAnalysis/src/

javac Checker.java

java Checker

hive -e "CREATE TABLE reddit_semantic_update (semantic_score int, body string) row format delimited fields terminated by ','"

hive -e "LOAD DATA LOCAL INPATH '~/redJester/analysis/semanticAnalysis/src/outputfile.txt' OVERWRITE INTO TABLE reddit_semantic_score_update"

hive -f "UPDATE reddit_semantic SET reddit_semantic.semantic_score = reddit_semantic_update.semantic_score FROM reddit_semantic INNER JOIN reddit_semantic_update.body = reddit_semantic.body"






