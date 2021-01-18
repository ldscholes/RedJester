#!/bin/bash
# ingstion_update_json.sh
#
###############################################################################################################################
# Call Standard Profile

BASEDIR="~/RedJester/ingestion/twitter"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script
DATA_DIR=${BASEDIR}/data

echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR
echo "DATA_DIR="$DATA_DIR

HQL_NAME="create_main_table.hql"
# create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/twitter/hql/create_main_table.hql

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


HQL_NAME="create_base_table_json.hql"
# create empty base table for population
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/twitter/hql/create_base_table.hql

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


~/RedJester/ingestion/twitter/script/import_data.sh

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ~/RedJester/ingestion/twitter/script/import_data.sh FAILED"
                exit 1
        else
                echo "--INFO-- Script ~/RedJester/ingestion/twitter/script/import_data.sh Completed Successfully"
 fi

HQL_NAME="update_main_table.hql"
# update main table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/twitter/hql/update_main_table.hql 

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

HQL_NAME="drop_base_table.hql"
# drop base table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/twitter/hql/drop_base_table.hql 

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi