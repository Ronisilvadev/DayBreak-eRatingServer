#!/bin/sh

ulimit -c unlimited

export NLS_LANG=American_America.utf8
# export NLS_LANG=American_America.zhs16gbk
export NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
export LD_LIBRARY_PATH=/home/erating/lib
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

unset ORACLE_HOME
export TNS_ADMIN=$PWD
