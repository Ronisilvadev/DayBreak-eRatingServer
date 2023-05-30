#!/bin/sh

ulimit -c 20000

export LD_LIBRARY_PATH=/home/jboss/gmserver/lib

if [ $ORACLE_HOME ]
then
    unset ORACLE_HOME
fi

export NLS_LANG=American_America.utf8
export NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS"
