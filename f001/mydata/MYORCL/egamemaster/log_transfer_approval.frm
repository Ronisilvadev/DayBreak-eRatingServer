�
    0  i{         ! 	      !        i  S�           //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
       �    �PRIMARY�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       InnoDB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 �                                           转账审批日志表                                                                                                                                                                                              � �  {]         P    �   � )                                          log_id  
CHANGE_ID  APPROVAL_NUM  APPROVAL_TIME  APPROVAL_COMMENT 	 APPROVAL_RESULT 
 OPERATOR_NAME 

      !  


   @     	  @   1    `@    >    @   ! 	  @   � 
A`   @   ! �log_id�CHANGE_ID�APPROVAL_NUM�APPROVAL_TIME�APPROVAL_COMMENT�APPROVAL_RESULT�OPERATOR_NAME� 转账日志编号审批步骤,1-1次审批,2-2次审批,100-执行审批时间审批意见审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。审批人姓名