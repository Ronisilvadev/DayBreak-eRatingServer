-- create table 
/*Table structure for table `bas_core_data_gw` */

DROP TABLE IF EXISTS `bas_core_data_gw`;

CREATE TABLE `bas_core_data_gw` (
  `stat_date` date NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL DEFAULT '0',
  `charge_money` decimal(12,2) DEFAULT '0.00',
  `peak_value_amount` decimal(10,0) DEFAULT '0',
  `avg_amount` decimal(10,0) DEFAULT '0',
  `login_role_amount` decimal(10,0) DEFAULT '0',
  `login_passport_amount` decimal(10,0) DEFAULT '0',
  `charge_players_amount` decimal(10,0) DEFAULT '0',
  `consume_money` decimal(12,2) DEFAULT '0.00',
  `avg_seconds` decimal(10,0) DEFAULT '0',
  `peak_value_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `new_role_amount` decimal(10,0) DEFAULT '0',
  `new_user_amount` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`stat_date`,`gateway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bas_core_data_gw` */

DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`statCoreDataGw`$$

CREATE PROCEDURE `statCoreDataGw`(in dt_stat_date date)
BEGIN
     declare n_done          int        default 0;
     declare n_gateway        int(12);
     declare d_stat_date date;
     declare gateCursor cursor for select gateway_id from sys_gateway;
     /***change not found exception state***/
     declare CONTINUE HANDLER for not found set  n_done=1;
     /**charge time**/
     set d_stat_date=date(dt_stat_date);
     /***delete the day data***/
     delete from bas_core_data_gw where stat_date = d_stat_date;
     /***loop the cousor***/
     open gateCursor;
     gatewayLoop:loop
     FETCH gateCursor into n_gateway;
        if(n_done = 1) then
		set n_done = 2    ;  /*change the not found exception state*/
		leave gatewayLoop ;
	end if ;
	/****init gateway***/
	insert into bas_core_data_gw(stat_date,gateway_id) values(d_stat_date,n_gateway);
        commit;
     end loop gatewayLoop;  
     close gateCursor;
     
     /***get loginAmount、roleAmount****/
     call getLoginAmountGw(d_stat_date);
	
     /***get ChargeAmount***/
     call getChargeGw(d_stat_date);
     /**get ConsumeMoney**/
     call getConsumeMoneyGw(d_stat_date);
     /***get avgSeconds***/
     call getAVGOnlineSecondsGw(d_stat_date);
     /**get peakValue**/
     call getPeakValueInvolvedGw(d_stat_date);
     /****get avguser***/
     call getAVGUserCountGw(d_stat_date);
     
     /***get new user、new role***/
     call getNewComerGw(d_stat_date);
     
END$$

DELIMITER ;

DELIMITER $$


/*******stat gateway avgSeconds***********/
DROP PROCEDURE IF EXISTS `ebi`.`getAVGOnlineSecondsGw`$$

CREATE PROCEDURE `getAVGOnlineSecondsGw`(in dt_stat_date date)
BEGIN
  declare n_min_log_id   bigint(20);
  declare n_max_log_id   bigint(20);
  declare n_avg_seconds  int(60);
  declare n_gateway        int(12);  
  declare s_table_name   varchar(64) default 'LOG_RECORD_DETAIL';
  declare n_done         int  default 0 ;
  declare n_ret          int       ;    
label_getAVGOnlineSeconds:begin
  declare continue handler for not found set n_done = 1 ;
  /***get log id***/
  call  getLogIdRange(dt_stat_date,
                      dt_stat_date,
                      s_table_name,
                      n_min_log_id,
                      n_max_log_id,
                      n_ret
                      );
  /***log_id is boolean?***/
  if(n_min_log_id > 0 and n_max_log_id > 0 and n_max_log_id > n_min_log_id)then
      label_avgOnlineSeconds:begin 
        declare avgSecondsCursor cursor for select  ifnull(gateway_id,0) as gateway_id,
		sum(timestampdiff(second,login_time,logout_time)) / count(distinct role_id) as  avg_seconds
		from log_record_detail d where
		(d.login_id between n_min_log_id and n_max_log_id) and
		(d.logout_time is not null     )
		group by gateway_id with rollup ;
	
        open  avgSecondsCursor;
          
        avgSecondsLoop:loop
	     FETCH avgSecondsCursor into n_gateway,n_avg_seconds;
	     if (n_done = 1) then
		 set n_done=2;
		 leave avgSecondsLoop ;
	     end if;
    	     
             update bas_core_data_gw set avg_seconds=n_avg_seconds
             where  gateway_id=n_gateway and stat_date=dt_stat_date;
             commit;
        end loop avgSecondsLoop;
	close avgSecondsCursor;
      end label_avgOnlineSeconds;  
  end if;
  
end label_getAVGOnlineSeconds;
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getAVGUserCountGw`$$

CREATE PROCEDURE `getAVGUserCountGw`(in dt_stat_date date)
BEGIN
     declare n_done int default 0 ;
     declare n_gateway        int(12);   
     declare n_online_count   numeric(10,0);
     declare avgUserCountCur cursor for  select  ifnull(gateway_id,0) as  gateway_id,sum(online_count) as online_count
     from
        (
          select
             ifnull(gateway_id,0) as  gateway_id, ifnull(avg(user_online_count),0) online_count
          from
             stat_user_online
          where
             (stat_time >= date(dt_stat_date)           ) and
             (stat_time <  adddate(date(dt_stat_date),1))
          group by gateway_id 
        )  t group by gateway_id with rollup;
    
     declare continue handler for not found set n_done = 1 ;
    
     open avgUserCountCur;
     avgUserCountLoop:loop
	  FETCH avgUserCountCur into n_gateway,n_online_count;
	  if n_done=1 then
		set n_done=2;
		leave avgUserCountLoop;
	  end if;
         
          update bas_core_data_gw set avg_amount=n_online_count
          where  gateway_id=n_gateway and stat_date=dt_stat_date;
          commit;
     end loop avgUserCountLoop;
     
     close avgUserCountCur;
END$$

DELIMITER ;
/******stat gateway charge*******/
DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getChargeGw`$$

CREATE PROCEDURE `getChargeGw`(in dt_stat_date date)
BEGIN
    declare n_done         tinyint default 0 ;  
    declare n_gateway        int(12);
    declare d_charge_money  decimal(12,2)       ;
    declare n_charge_player decimal(10,0)       ;
       
    declare chargeAmountCursor cursor for select   ifnull(rating_id,0) as gateway_id,sum(charge_amount)*250 charge_amount,count(distinct user_id) user_amount
    from 
        log_user_fund_detail
    where 
        (charge_type   =   1    )               and 
        (subject_id    =   3    )               and 
        (charge_time >= date(dt_stat_date))      and 
        (charge_time <  adddate(date(dt_stat_date),1))
    group by rating_id with rollup;
    declare continue handler for not found set n_done = 1 ;
    open chargeAmountCursor;
  
    chargeAmountLoop:loop
	FETCH chargeAmountCursor into n_gateway,d_charge_money,n_charge_player;
	if(n_done=1)then
	    set n_done=2;
	    leave chargeAmountLoop;
	end if;
        
        update bas_core_data_gw set charge_players_amount=n_charge_player,charge_money=d_charge_money
        where  gateway_id=n_gateway and stat_date=dt_stat_date;
       commit;
    end loop chargeAmountLoop;    
    
    close chargeAmountCursor; 
  
END$$

DELIMITER ;

/***stat consume Money***/
DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getConsumeMoneyGw`$$

CREATE PROCEDURE `getConsumeMoneyGw`(in dt_stat_date date)
BEGIN
  declare n_min_log_id   bigint(20);
  declare n_max_log_id   bigint(20);
  declare n_gateway        int(12);
  declare d_cost_amount  decimal(12,2)       ;
  declare s_table_name   varchar(64) default 'UMS_USER_PURCHASE_DETAIL';
  declare n_done         tinyint default 0 ;
  declare n_ret          int       ;
  declare continue handler for not found set n_done = 1 ;
  call getLogIdRange(
                   dt_stat_date ,
                   dt_stat_date ,
                   s_table_name,
                   n_min_log_id,
                   n_max_log_id,
                   n_ret
                   );
label_getConsumeMoney:begin
   declare consumeCursor cursor for select
       ifnull(gateway_id,0) gateway_id,sum(cost_amount)*250 cost_amount 
   from 
       vw_ums_user_product
   where 
       purchase_id between n_min_log_id and n_max_log_id   and 
       subject_id=3
   group by gateway_id with rollup;
   open consumeCursor;
   label_consumeLoop:loop
	   FETCH consumeCursor into n_gateway,d_cost_amount;
	   if n_done = 1 then
	      set n_done = 2;
	      leave label_consumeLoop;
	   end if ;
           update bas_core_data_gw set consume_money=d_cost_amount
           where  gateway_id=n_gateway and stat_date=dt_stat_date;
           commit;
   end loop label_consumeLoop;
   close consumeCursor;
end label_getConsumeMoney ;
END$$

DELIMITER ;

/***stat gateway loginAmount***/
DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getLoginAmountGw`$$

CREATE PROCEDURE `getLoginAmountGw`(in dt_stat_date date)
BEGIN
   declare n_min_log_id   bigint(20);
   declare n_max_log_id   bigint(20);
   declare n_ret          int(10);
   declare s_table_name   varchar(64) default 'LOG_RECORD_DETAIL';  
   declare n_gateway        int(12);
   declare n_done         tinyint default 0 ;
   declare n_role_count	  int(18);
   declare n_user_count   int (18);
   declare continue handler for not found set n_done = 1 ;
   /***get erating max_log_id and min_log_id***/
   call getLogIdRange(dt_stat_date , 
                      dt_stat_date ,
                      s_table_name,
                      n_min_log_id,
                      n_max_log_id,
                      n_ret
                      );
   label_getLoginAmount:begin
	   /**get userAmount、roleAmount**/
	      declare loginAmountCursor cursor for  
	      select  ifnull(gateway_id,0) as gateway_id,count(distinct role_id) role_count,count(distinct user_id) user_count
	      from 
	       LOG_RECORD_DETAIL 
	      where 
	       login_id between n_min_log_id and n_max_log_id
	      group by gateway_id with rollup;
	  
	   /**open cursor**/ 
	   open loginAmountCursor;
	   /**loop cursor**/
	   loginAmountLoop:loop
		FETCH loginAmountCursor into n_gateway,n_role_count,n_user_count;
		if(n_done = 1) then
			set n_done = 2    ;  /*change the not found exception state*/
			leave loginAmountLoop ;
		end if ;
		/***update gateway loginAmount***/
		update bas_core_data_gw set login_role_amount=n_role_count,login_passport_amount=n_user_count
		where  gateway_id=n_gateway and stat_date=dt_stat_date;
	        commit;
	   end loop loginAmountLoop;  
	   /**close cursor**/
	   close loginAmountCursor;
   end label_getLoginAmount;
END$$

DELIMITER ;

/****stat new user 、new role*****/
DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getNewComerGw`$$

CREATE PROCEDURE `getNewComerGw`(in dt_stat_date date)
BEGIN
       declare n_done int default 0 ;
       declare n_gateway int(12);
       declare n_new_user_amount             numeric(10,0);       -- 当日新增登录人数
       declare n_new_role_amount             numeric(10,0);       -- 当日新增登录角色
       declare newComerCursor cursor for select 
	 gateway_id,ifnull(sum(role_count),0) role_amount,ifnull(sum(user_count),0) user_amount
       from    stat_new_user
       where        
       stat_date  = date(dt_stat_date) group by gateway_id;
       
       declare continue handler for not found set n_done = 1 ;    
       open newComerCursor;
       newComerLoop:loop
	  FETCH newComerCursor into  n_gateway,n_new_role_amount,n_new_user_amount;
	  if (n_done=1) then
		set n_done=2;
		leave newComerLoop;
	  end if;
         
          update bas_core_data_gw set new_user_amount=n_new_user_amount,new_role_amount=n_new_role_amount
          where  gateway_id=n_gateway and stat_date=dt_stat_date;
          commit;
      end loop newComerLoop;
     
     close newComerCursor;
END$$

DELIMITER ;

/*****stat peak value*****/
DELIMITER $$

DROP PROCEDURE IF EXISTS `ebi`.`getPeakValueInvolvedGw`$$

CREATE PROCEDURE `getPeakValueInvolvedGw`(in dt_stat_date date)
BEGIN
     declare n_done int default 0;
     declare n_gateway        int(12);  
     declare n_max_count        numeric(10,0); 	-- 当日峰值人数
     declare n_max_count_time            TIMESTAMP;        -- 当日峰值时刻
     declare peakValCur cursor for select gateway_id,
	     max_count ,max_count_time
	  from 
	     stat_ceo_info
	  where  stat_date  = date(dt_stat_date);
     
     declare continue handler for not found set n_done = 1 ;
     open peakValCur;
     peakValLoop:loop
	   FETCH peakValCur into  n_gateway,n_max_count,n_max_count_time;
	   if n_done=1 then
		set n_done=2;
		leave peakValLoop;
	   end if;
   
           update bas_core_data_gw set peak_value_amount=n_max_count,peak_value_time=n_max_count_time
           where  gateway_id=n_gateway and stat_date=dt_stat_date;
           commit;
     end loop peakValLoop;
   
     close peakValCur;
END$$

DELIMITER ;



/*****create event*******/
-- ----------------------------
-- Event structure for `event_coreDataGwDailyTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_coreDataGwDailyTask`;

CREATE  EVENT `event_coreDataGwDailyTask` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 03:00:00' ENABLE DO call statCoreDataGw(adddate(now(),-1))
;


-- ----------------------------
-- Event structure for `event_coreDataGwQuarterTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_coreDataGwQuarterTask`;

CREATE  EVENT `event_coreDataGwQuarterTask` ON SCHEDULE EVERY 15 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statCoreDataGw(now())
;