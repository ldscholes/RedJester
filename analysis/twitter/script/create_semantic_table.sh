#!/bin/bash
# create_semantic_table.sh
#
###############################################################################################################################

# Call Standard Profile
BASEDIR="~/redJester/analysis/twitter"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script


echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR


HQL_NAME="create_semantic_table.hql"
# create empty main table if not existing
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
cd ${HQL_DIR}
hive -f ~/redJester/analysis/twitter/hql/create_semantic_table.hql

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
hive -f ~/redJester/analysis/twitter/hql/update_delta_semantic_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

QL_NAME="download_semantic_table.hql"
# download semantic table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/twitter/hql/download_semantic_table.hql | sed 's/[\t]/,/g'  > ~/redJester/analysis/semanticAnalysis/src/inputfile.txt

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

# semantic analysis
cd ~/redJester/analysis/semanticAnalysis/src/

javac Checker.java

java Checker

HQL_NAME="create_update_semantic_table.hql"
# create update table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/twitter/hql/ceate_update_semantic_table.hql

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

HQL_NAME="load_update_semantic_table.hql"
# load update table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/twitter/hql/load_update_semantic_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

HQL_NAME="update_semantic_table.hql"
# load update table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/twitter/hql/update_semantic_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

drop 

HQL_NAME="drop_update_semantic_table.hql"
# drop update table
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
hive -f ~/redJester/analysis/twitter/hql/drop_update_semantic_table.hql


 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                #exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

drop 


