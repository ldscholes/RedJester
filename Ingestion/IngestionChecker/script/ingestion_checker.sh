#!/bin/bash
# ingestion_checker.sh
#
###############################################################################################################################

if [ $# -eq 4 ] 
then
    echo $1 $2 $3 $4
else
    echo "invalid arguments, please pass four arguments in the form: source, filename, size, hash"
fi


# Call Standard Profile
HIVE_CONNECTION="jdbc:hive2://DEVU0000763:10000/default;principal=hive/DEVU0000763.modeloffice.inrev.gov.uk@MODELOFFICE.INREV.GOV.UK"
BASEDIR="~/redJester"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script
DATA_DIR=${BASEDIR}/data
echo "HIVE_CONNECTION="$HIVE_CONNECTION
echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR
echo "DATA_DIR="$DATA_DIR


HQL_NAME="create_main_table.hql"
# beeline script to create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
beeline -u 'jdbc:hive2://DEVU0000763:10000/default;principal=hive/DEVU0000763.modeloffice.inrev.gov.uk@MODELOFFICE.INREV.GOV.UK' -f ${HQL_DIR}/${HQL_NAME}\


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


# beeline script to check to see if file has been processed before
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -e "INSERT OVERWRITE DIRECTORY '/tmp/ingest' row format delimited FIELDS TERMINATED BY ',' select * from ingestion_checker WHERE hash = '$4' limit 1;"

a=$(hdfs dfs -cat /tmp/ingest/000000_0)
echo $a

 if [[ $a == "0" ]]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} Duplicate file found - EXITING"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} SUCCESS"
		
 fi


# beeline script to update main table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -e "INSERT into ingestion_checker VALUES ('$1','$2','$3','$4');"

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi