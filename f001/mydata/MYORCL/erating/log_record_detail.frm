�
    0  t�         � 	      !        t  S�  0        //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                K       �  C       �  @ �  @      �  @ �  @      �  @ �B  @ �PRIMARY�LOG_RECORD_DETAIL_IX�LOG_RECORD_DETAIL_IX1�LOG_RECORD_DETAIL_IX2�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            InnoDB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       "                                           �玩家的登入登出详单信息表，该表可追踪玩家的登入登出行为。该表的压力非常大，需要考虑分区。                                                                               �  ��         P  	   !)                                          	login_id  user_id  role_id  game_id  gateway_id 	 
server_id 
 role_level  money1  money2  experience  login_time  logout_time  	login_ip  login_port  
stat_date  province_code  
city_code  country_code  mac g )                                          hardware_sn1  hardware_sn2  client_type  uddi 	   C    

   @       @        @       @   3 	
   �   K 
		   K@   	   "  @     &  @     *  C@     2  `@     :  `�    	

 B  @   & 		 F  K@   	  
 I  `�   c 00 Q   �   !	 
00 �   �   !	 00 �   @   ! 00 �   �   ! B`   �   ! B` v  �   !  � @     J� �  �   ! �login_id�user_id�role_id�game_id�gateway_id�server_id�role_level�money1�money2�experience�login_time�logout_time�login_ip�login_port�stat_date�province_code�city_code�country_code�mac�hardware_sn1�hardware_sn2�client_type�uddi� 详单编号。玩家的帐号ID。游戏ID表示玩家当前登录时所在的网关编号。记录是哪个服务器进程上来的。命名规则为gateway_id + xx。当前下线时的金钱数1。当前下线时的金钱数2。当前经验值。本次登入时间。本次登出时间。表示玩家当前登录的IP地址。与login_time相同，但填入的是经圆整的yyyymmdd值，便于按日统计和建立索引。省代码市代码国家代码用户主机MAC。硬件序列号1硬件序列号2移动设备编号