#!/bin/bash
# download_semantic_app_data.sh
#
###############################################################################################################################

# Call Standard Profile
BASEDIR="~/redJester/analysis/reddit"
HQL_DIR=${BASEDIR}/hql
SCRIPT_DIR=${BASEDIR}/script


echo "BASEDIR="$BASEDIR
echo "HQL_DIR="$HQL_DIR
echo "SCRIPT="$SCRIPT_DIR


HQL_NAME="download_semantic_app_data.hql"
# download_semantic_app_data
echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Running..."
cd ${HQL_DIR}
hive -f ~/redJester/analysis/reddit/hql/download_semantic_app_data.hql | sed 's/[\t]/,/g'  > ~/redJester/analysis/semanticAnalysis/app/inputfile.txt

 if [ $? -ne 0 ]
        then
                echo "--ERROR-- Script ${HQL_DIR}/${HQL_NAME} FAILED"
                exit 1
        else
                echo "--INFO-- Script ${HQL_DIR}/${HQL_NAME} Completed Successfully"
 fi

