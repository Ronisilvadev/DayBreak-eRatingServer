DROP PROCEDURE logFirstLogin;
DROP PROCEDURE logLoginEx;
DROP PROCEDURE logLogout;
DROP PROCEDURE logItemOperation;
DROP PROCEDURE logLogoutAbnormal;
DROP PROCEDURE logOnlineCount;
DROP PROCEDURE logDailyFirstLogID;
DROP PROCEDURE logRoleFirstLogin;
DROP PROCEDURE logConsumePointOperation;

DELIMITER $$


/*
Function:               To record login information when first log in.
Parameters:
    n_User_ID:          Unique ID of user which is copied from ePassport.
    n_Gateway_ID:       Unique ID of gateway which is configured in SYS_GATEWAY.
    d_First_Login_Time: Timestamp of logging.
    n_First_Login_IP:   Client IP of user.
    n_First_Login_Port: Port of user.
Author:                 Zhaofine
Date:                   2007-07-18
Remarks:
    This function records the basic login information which is used to analysis
the characteristics of user who first logs in.
*/
CREATE PROCEDURE logFirstLogin(
    in    n_Game_ID          integer,
    in    n_User_ID          integer,
    in    s_User_Name        varchar(32),
    in    n_Gateway_ID       integer,
    in    d_Login_Time       datetime,
    in    n_Login_IP         integer unsigned,
    in    n_Login_Port       integer,
    in    s_MAC              varchar(16),
    out   n_Result           integer
)
BEGIN
    declare n_Tmp_Log_ID integer unsigned;
    declare n_RetCode integer;
    lable_proc:begin
        declare exit handler for 1062 begin end;/*Can't write, because of unique constraint*/
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null) or
            (s_User_Name  is null) or
            (n_Gateway_ID is null) or
            (d_Login_Time is null) or
            (n_Login_IP   is null) or
            (n_Login_Port is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into LOG_USER_FIRST_LOGIN_INFO(
            user_id,           gateway_id,
            first_login_time, first_login_ip,    first_login_port,
            stat_date,
            province_code,    city_code,         mac,
            user_name,        game_id
        )
        values(
            n_User_ID,         n_Gateway_ID,
            d_Login_Time,     n_Login_IP,        n_Login_Port,
            date(d_Login_Time),
            '--',             '--',              s_MAC,
            s_User_Name,      n_Game_ID
        );

        select last_insert_id() into n_Tmp_Log_ID;

        call logDailyFirstLogID(
            'LOG_USER_FIRST_LOGIN_INFO',
            d_Login_Time,
            n_Tmp_Log_ID,
            n_RetCode
        );
        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE logLoginEx(
    in    n_Game_ID       integer,
    in    n_User_ID       integer,
    in    n_Role_ID       integer,
    in    n_Gateway_ID    integer,
    in    n_Server_ID     integer,
    in    n_Role_Level    integer,
    in    d_Login_Time    datetime,
    in    n_Login_IP      integer unsigned,
    in    n_Login_Port    integer,
    in    s_MAC           varchar(16),
    in    s_Province_Code varchar(16),
    in    s_City_Code     varchar(16),
    in    s_Hardware_SN1  varchar(32),
    in    s_Hardware_SN2  varchar(32),
    in    n_Client_Type   integer,
    out   n_Ret_Login_ID  integer,
    out   n_Result        integer
)
BEGIN
    declare n_RetCode integer;
    lable_proc:begin
        declare exit handler for 1062 set n_Result = 0;/*Can't write, because of Unique constraint*/
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        if (
            (n_Game_ID       is null) or
            (n_User_ID       is null) or
            (n_Role_ID       is null) or
            (n_Gateway_ID    is null) or
            (n_Server_ID     is null) or
            (n_Role_Level    is null) or
            (d_Login_Time    is null) or
            (n_Login_IP      is null) or
            (n_Login_Port    is null) or
            (s_Province_Code is null) or
            (s_City_Code     is null) or
            (n_Client_Type   is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into LOG_RECORD_DETAIL(
            user_id,         role_id,
            role_level,         money1,          money2,      experience,
            gateway_id,         server_id,       login_time,
            logout_time,        login_ip,        login_port,
            stat_date,          province_code,   city_code,
            mac,                hardware_sn1,    hardware_sn2,
            game_id,            client_type
        )
        values(
            n_User_ID,       n_Role_ID,
            n_Role_Level,       0,               0,           0,
            n_Gateway_ID,       n_Server_ID,     d_Login_Time,
            null,               n_Login_IP,      n_Login_Port,
            date(d_Login_Time), s_Province_Code, s_City_Code,
            s_MAC,              upper(s_Hardware_SN1), upper(s_Hardware_SN2),
            n_Game_ID,          n_Client_Type
        );

        select
            last_insert_id()
        into
            n_Ret_Login_ID;

        -- 记录每日日志的LOG_ID范围
        call logDailyFirstLogID(
            'LOG_RECORD_DETAIL',
            d_Login_Time,
            n_Ret_Login_ID,
            n_RetCode
        );

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE logLogout(
    in    n_Login_ID          integer,
    in    n_Role_Level        integer,
    in    n_Money1            integer,
    in    n_Money2            integer,
    in    n_Experience        integer,

    out   n_Ret_Server_ID     integer,
    out   n_Ret_Online_Second integer,
    out   n_Ret_User_IP       integer unsigned,
    out   s_Ret_Province_Code varchar(16),
    out   s_Ret_City_Code     varchar(16),
    out   n_Result            integer
)
BEGIN
    declare    d_Current_Time    datetime;
    lable_proc:begin
        set d_Current_Time = now();
        if (
            (n_Login_ID   is null) or
            (n_Login_ID   =  0   ) or
            (n_Role_Level is null) or
            (n_Money1     is null) or
            (n_Money2     is null) or
            (n_Experience is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        update
            LOG_RECORD_DETAIL
        set
            logout_time = d_Current_Time,
            role_level  = n_Role_Level,
            money1      = n_Money1,
            money2      = n_Money2,
            experience  = n_Experience
        where
            login_id = n_Login_ID;

        select
            server_id,           unix_timestamp(d_Current_Time) - unix_timestamp(login_time),
            login_ip,
            province_code,       city_code
        into
            n_Ret_Server_ID,     n_Ret_Online_Second,
            n_Ret_User_IP,
            s_Ret_Province_Code, s_Ret_City_Code
        from
            LOG_RECORD_DETAIL
        where
            login_id = n_Login_ID;
        -- ignore `SQL%ROWCOUT = 0' situation.

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
        if (n_Ret_Online_Second is null) then
            set n_Ret_Online_Second = 0;
        end if;
END$$

CREATE PROCEDURE logItemOperation(
    in    n_Game_ID          integer,
    in    n_Gateway_ID       integer,
    in    n_Activity_ID      integer,
    in    n_User_ID          integer,
    in    n_Role_ID          integer,
    in    s_Item_Code        varchar(32),
    in    c_Operation_Code   char(1),
    in    n_Item_Num         integer,
    in    s_order_code       varchar(32),
    out   n_Result           integer
)
BEGIN
    declare n_RetCode    integer;
    declare n_log_date   datetime;
    declare n_Ret_Log_ID bigint;
    lable_proc:begin
        declare exit handler for 1062 set n_Result = 0;/*Can't write, because of unique constraint*/
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        set n_log_date = now();
        if (
            (n_Game_ID        is null) or
            (n_Gateway_ID     is null) or
            (n_Activity_ID    is null) or
            (n_User_ID        is null) or
            (n_Role_ID        is null) or
            (s_Item_Code      is null) or
            (c_Operation_Code is null) or
            (n_Item_Num       is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into LOG_USER_ITEM(
            log_time,        user_id,          role_id,
            gateway_id,      activity_id,      operation_code,      item_code,
            item_num,        send_order_code,  game_id
        )
        values(
            n_log_date,      n_User_ID,        n_Role_ID,
            n_Gateway_ID,    n_Activity_ID,    c_Operation_Code,    s_Item_Code,
            n_Item_Num,      s_order_code,     n_Game_ID
        );

        select
            last_insert_id()
        into
            n_Ret_Log_ID;

        call logDailyFirstLogID(
            'LOG_USER_ITEM',
            n_log_date,
            n_Ret_Log_ID,
            n_RetCode
        );

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

-- 由自治事务改为非自治事务
CREATE PROCEDURE logLogoutAbnormal(
    in    n_Game_ID          integer,
    in    n_Gateway_ID       integer,
    in    n_User_ID          integer,
    in    n_Role_ID          integer,
    in    n_Role_Level       integer,
    in    n_Money1           integer,
    in    n_Money2           integer,
    in    n_Experience       integer,
    out   n_Result           integer
)
BEGIN
    lable_proc:begin
        declare exit handler for 1062 set n_Result = 0;/*Can't write, because of unique constraint*/
        set n_Result = 0;
        if (
            (n_Game_ID    is null) or
            (n_Gateway_ID is null) or
            (n_User_ID    is null) or
            (n_Role_ID    is null) or
            (n_Role_Level is null) or
            (n_Money1     is null) or
            (n_Money2     is null) or
            (n_Experience is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into LOG_RECORD_DETAIL(
            user_id,       role_id,
            role_level,     money1,        money2,      experience,
            gateway_id,     server_id,     login_time,
            logout_time,    login_ip,      login_port,
            stat_date,      province_code, city_code,
            game_id,        client_type
        )
        values(
            n_User_ID,        n_Role_ID,
            n_Role_Level,     n_Money1,      n_Money2,    n_Experience,
            n_Gateway_ID,     0,             now(),
            now(),            0,             0,
            date(now()),      'other',       'other',
            n_Game_ID,        0
        );
        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE logOnlineCount(
    in    n_Game_ID            integer,
    in    n_Gateway_ID         integer,
    in    n_Server_ID          integer,
    in    n_Online_Count       integer,
    out   n_Result             integer
)
BEGIN
    lable_proc:begin
        declare continue handler for 1062 begin end; /*在insert主键冲突失败时什么都不作*/
        set n_Result = 0;
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (n_Server_ID     is null) or
            (n_Online_Count  is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        update
            LOG_USER_ONLINE_COUNT
        set
            user_online_count = n_Online_Count
        where
            (gateway_id = n_Gateway_ID) and
            (server_id  = n_Server_ID ) and
            (game_id    = n_Game_ID   );
        if (row_count() = 0) then
            insert into LOG_USER_ONLINE_COUNT(
                gateway_id,   server_id,   user_online_count, game_id
            )
            values(
                n_Gateway_ID, n_Server_ID, n_Online_Count,    n_Game_ID
            );
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

-- 记录每日日志的LOG_ID范围
CREATE PROCEDURE logDailyFirstLogID(
    in    s_table_name varchar(32),
    in    d_log_date   datetime,
    in    n_log_id     integer,
    out   n_Result     integer
)
BEGIN
    declare    d_Tmp_Log_Date  datetime;
    lable_proc:begin
        declare exit handler for 1062 set n_Result = 1;
        set n_Result = 1;/*S_SUCCESS*/

        select
           log_date
        into
           d_Tmp_Log_Date
        from
           LOG_DAILY_LOGID
        where
           (log_date   = date(d_log_date)    ) and
           (table_name = s_table_name);
        if (found_rows() = 0) then
            insert ignore into LOG_DAILY_LOGID(
                log_date,          table_name,   log_id
            )
            values(
                date(d_log_date), s_table_name, n_log_id
            );
        end if;
    end lable_proc;
END$$

CREATE PROCEDURE logRoleFirstLogin(
    in    n_Game_ID          integer,
    in    n_Role_ID          integer,
    in    n_User_ID          integer unsigned,
    in    n_Gateway_ID       integer,
    in    d_Login_Time       datetime,
    in    n_Login_IP         integer unsigned,
    in    s_Province_Code    varchar(16),
    in    s_City_Code        varchar(16),
    in    s_MAC              varchar(16),
    in    n_Client_Type      integer,
    out   n_Result           integer
)
BEGIN
    declare n_RetCode integer default 0;    /*PKG_UTIL.E_ERROR*/
    declare n_Temp_First_Role integer default 0;
    declare n_Temp_Counter integer default 0;

    declare n_Tmp_Log_ID bigint;
    lable_proc:begin
        declare continue handler for 1062 begin end;
        if (
            (n_Role_ID        is null) or
            (n_User_ID        is null) or
            (n_Gateway_ID     is null) or
            (d_Login_Time     is null) or
            (n_Login_IP       is null) or
            (s_Province_Code  is null) or
            (s_City_Code      is null) or
            (n_Client_Type    is null)
        ) then
            set n_Result = -100;   /*PKG_UTIL.E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        -- 是否所属账号的第一个角色的判断
        select count(role_id)
        into n_Temp_Counter
        from UMS_ROLE
        where game_id = n_Game_ID
        and user_id = n_User_ID
        and role_state in(1,2);

        if(n_Temp_Counter > 0) then
            set n_Temp_First_Role = 0;
        else
            set n_Temp_First_Role = 1;
        end if;

        insert into LOG_ROLE_FIRST_LOGIN(
            game_id,          role_id,          user_id,
            gateway_id,       first_login_time, first_login_ip,
            province_code,    city_code,        mac,
            first_role,       client_type
        )
        values(
            n_Game_ID,        n_Role_ID,        n_User_ID,
            n_Gateway_ID,     d_Login_Time ,    n_Login_IP,
            s_Province_Code,  s_City_Code,      s_MAC,
            n_Temp_First_Role, n_Client_Type
        );

        set n_Tmp_Log_ID = last_insert_id();
        -- if insert succeed, record daily first log_id.
        call logDailyFirstLogID(
             'LOG_ROLE_FIRST_LOGIN',
             d_Login_Time,
             n_Tmp_Log_ID,
             n_RetCode
        );

        set n_Result = 1;    /*PKG_UTIL.S_SUCCESS*/
    end lable_proc;
END$$

-- 记录消费（购物）积分的操作日志
CREATE PROCEDURE logConsumePointOperation
(
  in  n_Game_ID    integer,
  in  n_User_ID    integer,
  in  n_Amount     integer,
  out n_Result     integer
)
BEGIN
    declare n_RetCode    integer default 0;
    declare n_Tmp_Log_ID integer unsigned;
    declare d_Tmp_Date   datetime default now();

    label_proc:begin
        if(
           (n_Game_ID is null) or
           (n_User_ID is null) or
           (n_Amount  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        insert into LOG_USER_CONSUME_POINT(
            game_id, user_id, amount, log_time
        )
        values
        (
            n_Game_ID, n_User_ID, n_Amount, d_Tmp_Date
        );

        select last_insert_id() into n_Tmp_Log_ID;

        call logDailyFirstLogID(
            'LOG_USER_CONSUME_POINT',
            d_Tmp_Date,
            n_Tmp_Log_ID,
            n_RetCode
        );


        set n_Result = 1;    /*PKG_UTIL.S_SUCCESS*/
    end label_proc;
END$$

DELIMITER ;
