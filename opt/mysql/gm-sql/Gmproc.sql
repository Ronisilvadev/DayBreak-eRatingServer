
DROP PROCEDURE IF EXISTS  `createSecretKey`;
DROP PROCEDURE IF EXISTS  `deleteSecretkey`;
DROP PROCEDURE IF EXISTS  `getActivityCode`;
DROP PROCEDURE IF EXISTS  `getActivityCodeFilePath`;
DROP PROCEDURE IF EXISTS  `getSerialCodeLog`;
DROP PROCEDURE IF EXISTS  `logActivityCode`;
DROP PROCEDURE IF EXISTS  `setSerialCodeLog`;

DELIMITER $$
CREATE  PROCEDURE `createSecretKey`(
OUT n_session_id INTEGER, 
OUT s_sk_content VARCHAR(20)
)
BEGIN
  DECLARE num INT DEFAULT 0;
  
  SET n_session_id = ROUND(ROUND(RAND(),9)*1000000000);	
  
  SET s_sk_content = CONCAT(
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0')
	); 
  
  SELECT COUNT(*) INTO num FROM sys_secretkey WHERE session_id = n_session_id;
  IF (num = 0) THEN
	INSERT INTO sys_secretkey(session_id, sk_content) VALUES (n_session_id, s_sk_content);
  END IF;
END $$

CREATE PROCEDURE `deleteSecretkey`(n_session_id INTEGER, OUT ret_code INTEGER)
BEGIN
  SET ret_code = 1;
  DELETE FROM sys_secretkey WHERE session_id = n_session_id; 
  IF (ROW_COUNT() = 0) THEN
    SET ret_code = -1821;
  END IF;
END $$


CREATE PROCEDURE `getActivityCode`(
						       in     n_gameId   integer,
						       in     n_gatewayType  integer,
						       in     n_pageSize     integer,
                                                       in     n_pageIndex    integer,
                                                       out     n_itemCount    integer,
						       out    n_pageCount    integer,
		                                       out    n_ret          integer
                                                       )
BEGIN
    label_proc:begin
         DECLARE n_pageNum INTEGER;
         DECLARE n_err   INTEGER default -200;
         DECLARE CONTINUE HANDLER for SQLEXCEPTION set n_err = 100;
         set n_pageNum = (n_pageSize*n_pageIndex);
         /*查询出总记录数*/ 
         select ifnull(count(*),0)
           into n_itemCount
           from log_activity_code
          where game_id = n_gameId
            and gateway_type = n_gatewayType; 
	/*计算总的页数*/
	if(n_pageSize=0)then
	    set n_ret = 0;
	    leave label_proc;
	end if;
	if(n_itemCount%n_pageSize=0) then
	     set n_pageCount=n_itemCount/n_pageSize;
	else
	     set n_pageCount=floor(n_itemCount/n_pageSize)+1;
	end if;	
        /*返回对应的数据*/
         select *
           from log_activity_code
          where game_id = n_gameId
            and gateway_type = n_gatewayType
            limit n_pageNum,n_pageSize;
         if(n_err=100) then 
             set n_ret = 0;
             leave label_proc;
         end if;
         set n_ret=1;
    end label_proc;
END $$

CREATE PROCEDURE `getActivityCodeFilePath`(in    n_logId    int,
							       out   s_filePath  varchar(100),
							       out   n_ret      int
							       )
BEGIN
     lable_proc:begin
          DECLARE  n_err  int default -200;
          DECLARE  CONTINUE  HANDLER for not found set n_err = 100;
          
             select file_path
	       into s_filePath
               from log_activity_code
              where log_id = n_logId;
          if(n_err=100)then
              set n_ret = 0;
          end if;
          set n_ret =1;  
               
     end lable_proc;
END  $$


CREATE PROCEDURE `getSerialCodeLog`(in    n_gameId      INT,
							in    n_activityID  BIGINT,
							OUT   n_ret         int
							)
BEGIN
      lable_proc:begin
           DECLARE n_err int default -200;
           DECLARE CONTINUE HANDLER for SQLEXCEPTION set n_err = 100;
           
           select * from LOG_SERIALCODE t 
             where t.GAME_ID = n_gameId
               and t.ACTIVITY_ID = n_activityID;
           
           if(n_err=100)then
              set n_ret = 0;
              leave lable_proc;
           end if;
           
           set n_ret = 1;       
               
      end lable_proc;
END $$


CREATE PROCEDURE `logActivityCode`(
						in     n_game_id        integer,
                                                in     n_gateway_type   integer,
                                                in     n_plan_gen_no    integer,
                                                in     n_success_gen_no integer,
                                                in     s_file_path      varchar(2048),
                                                in     s_operator_name  varchar(32),					
						out    n_ret            integer
						)
BEGIN
	label_proc:begin
	   DECLARE  n_err int default -200;
	   DECLARE CONTINUE HANDLER for SQLEXCEPTION set n_err = 100;
	   
	   insert into log_activity_code
	      (
		log_id,
		game_id,
                gateway_type,
	       plan_gen_no,
	       success_gen_no,
	       file_path,
	       insert_time,
	       operator_name)	    
	    (
	      select
	        ifnull(max(log_id),0)+1,
	       n_game_id,
               n_gateway_type,
               n_plan_gen_no,
               n_success_gen_no,
               s_file_path,
		sysdate(),
               s_operator_name
	      from log_activity_code
	    );
	  if(n_err = 100) then
	    set n_ret = 0;
	    leave label_proc;
	  end if;
	  set n_ret = 1;  
	end label_proc;
    END $$


CREATE PROCEDURE `setSerialCodeLog`(
						in     n_game_id        integer,
						in     n_activity_id    integer,
						in     s_media_name     varchar(200),
                                                in     n_use_limit      integer,
						in     n_serial_num     integer,
                                                in     s_passport_name  varchar(200),
                                                in     d_oper_time      datetime,
						in     s_file_path      varchar(200),						
						out    n_ret   int
						)
BEGIN
	label_proc:begin
	   DECLARE  n_err int default -200;
	   DECLARE CONTINUE HANDLER for SQLEXCEPTION set n_err = 100;
	   
	   insert into log_serialcode
	      (
		log_id,
		game_id,
                activity_id,
                media_name,
                use_limit,
                serial_num,
                passport_name,
                oper_time,
                file_path)	    
	    (
	      select
	        ifnull(max(log_id),0)+1,
	        n_game_id,
	        n_activity_id,
		s_media_name,
                n_use_limit,
		n_serial_num,
                s_passport_name,
                d_oper_time,
		s_file_path
	      from log_serialcode
	    );
	  if(n_err = 100) then
	    set n_ret = 0;
	    leave label_proc;
	  end if;
	  set n_ret = 1;  
	end label_proc;
    END $$
DELIMITER ;
