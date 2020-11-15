#!/bin/bash
# ingstion.sh
#
###############################################################################################################################
# Call Standard Profile


BASEDIR="~/RedJester/ingestion/googleForm"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script
DATA_DIR=${BASEDIR}/data

echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR
echo "DATA_DIR="$DATA_DIR


HQL_NAME="create_main_table.hql"
# script to create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/googleForm/hql/create_main_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


HQL_NAME="create_base_table.hql"
# create empty base table for population
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/googleForm/hql/create_base_table.hql

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


~/RedJester/ingestion/googleForm/script/import_data.sh

HQL_NAME="update_main_table.hql"
# update main table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/RedJester/ingestion/googleForm/hql/update_main_table.hql 

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

