#!/bin/sh
# Inicia todos os serviços essenciais do erating server.
# Author @ Thiago Bocchile

echo "Iniciando ./erating_mysql"
su - erating -c "cd ~/eRating_Mysql.1.9/9999/ && . set_env.sh && ./erating_mysql force-kill-all && ./erating_mysql start > /dev/null"
echo "Iniciando ./eStatServer"
su - erating -c "cd ~/estatServer/ && . set_env.sh && ./eStatServer > /dev/null"
echo "Iniciando ./eChargeServer2_mysql"
su - erating -c "cd ~/echargeServer/ && . set_env.sh && ./eChargeServer2_mysql > /dev/null"
echo "Iniciando ./GMSvr2.50"
su - jboss -c "cd ~/gmserver/gmserver/ && . set_env.sh && ./GMSvr2.50 > /dev/null"
echo "Iniciando ./run.sh"
su - jboss -c "cd ~/jboss-4.0.2/bin/ && ./run.sh & > /dev/null"
echo "Servidor do erating pronto para ser utilizado."
