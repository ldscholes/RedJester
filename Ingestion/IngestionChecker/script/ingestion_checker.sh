#!/bin/bash
# ingestion_checker.sh
#
###############################################################################################################################

if [ $# -eq 4 ] 
then
    echo $1 $2 $3 $4
else
    echo "invalid arguments, please pass four arguments in the form: source, filename, size, hash"
    #exit 1
fi


# Call Standard Profile
BASEDIR="~/redJester/Ingestion/IngestionChecker"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script


echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR


HQL_NAME="create_main_table.hql"
# create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
cd ${HQL_DIR}
hive -f ~/redJester/Ingestion/IngestionChecker/hql/create_main_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

HQL_NAME="check_for_previous_ingestion"
# check to see if file has been processed before
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -e "INSERT OVERWRITE DIRECTORY '/tmp/ingest' row format delimited FIELDS TERMINATED BY ',' select hash from ingestion_checker WHERE hash = '$4' limit 1;"

a=$(hdfs dfs -cat /tmp/ingest/000000_0)
echo $a

 if [[ $a == $4 ]]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} Duplicate file found - EXITING"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} SUCCESS"
		
 fi

HQL_NAME="insert_metadata_into_checker"
# to update main table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -e "INSERT into ingestion_checker VALUES ('$1','$2','$3','$4');"

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi