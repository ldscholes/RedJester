#!/bin/bash
# monthly_ingstion_update_csv.sh
#
###############################################################################################################################
# Call Standard Profile

HIVE_CONNECTION="jdbc:hive2://DEVU0000763:10000/default;principal=hive/DEVU0000763.modeloffice.inrev.gov.uk@MODELOFFICE.INREV.GOV.UK"
BASEDIR="/home/users/cg14915/RedJester"
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


HQL_NAME="create_base_table_json.hql"
# beeline script create empty base table for population
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
beeline -u ${HIVE_CONNECTION} \
        -f ${HQL_DIR}/${HQL_NAME}

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi


./import_data.sh

HQL_NAME="update_main_table.hql"
# beeline script to update main table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
beeline -u ${HIVE_CONNECTION} \
        -f ${HQL_DIR}/${HQL_NAME} 

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

