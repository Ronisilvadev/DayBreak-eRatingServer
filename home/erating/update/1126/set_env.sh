#!/bin/sh

ulimit -c unlimited

export NLS_LANG=American_America.utf8
# export NLS_LANG=American_America.zhs16gbk
export NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
export LD_LIBRARY_PATH=$UOS_THIRD_PARTY_PATH/occi_10_2/lib:$UOS_THIRD_PARTY_PATH/tinyxml/lib:$HOME/instantclient_10_2:$HOME/mysql_connector_cpp/lib:$UOS_BASE/uos_third_party/mysql_connector_cpp/lib:$LD_LIBRARY_PATH
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

unset ORACLE_HOME
export TNS_ADMIN=$PWD
