�
    0  i�         ! 	      !        i  S�  !        //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
       �  @ �PRIMARY�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     InnoDB                                                                                                                                                                                                                                                                                              修改绑定邮箱日志表                                                                                                                                                                                        � �  �[         P    y  � 	)                                          
CHANGE_ID  PASSPORT_NAME  
NEW_EMAIL  STATE  APPROVAL_RESULT 	 REASON 
 OPERATOR_NAME  INSERT_TIME 


   @   ! A`    @   ! 
E� f   @   !  ' @   !�  + @   !� 	H /  @   ! 
A` 1  @   !  � `@    �CHANGE_ID�PASSPORT_NAME�NEW_EMAIL�STATE�APPROVAL_RESULT�REASON�OPERATOR_NAME�INSERT_TIME� 日志id绑定帐号名新邮箱地址状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。修改原因操作员名称记录插入时间