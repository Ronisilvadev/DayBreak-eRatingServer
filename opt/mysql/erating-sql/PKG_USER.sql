DROP PROCEDURE isUserIDExisted;
DROP PROCEDURE isMingleUserIDExisted;
DROP PROCEDURE isUserRoleIDExisted;
DROP PROCEDURE verifyPassword;
DROP PROCEDURE userStateQuery;
DROP PROCEDURE verifyMAC;
DROP PROCEDURE isHardwareSNFreezed;
DROP PROCEDURE GetAccountInfo;
DROP PROCEDURE GetOnlineCount;
DROP PROCEDURE JointAuthenMySQL;
DROP PROCEDURE authenticateEx;
DROP PROCEDURE getNewUserCardFlag;
DROP PROCEDURE doFirstLogin;
DROP PROCEDURE SSOFromLKWeb;
DROP PROCEDURE getUserIdAndPwd;
DROP PROCEDURE getUserID;
DROP PROCEDURE getMingleUserID;
DROP PROCEDURE SignIn;
DROP PROCEDURE SignUp;
DROP PROCEDURE ChangeLoginPassword;
DROP PROCEDURE ResetLoginPasswordByGM;
DROP PROCEDURE UpdatePhoneLockState;
DROP PROCEDURE verifyGMTest;
DROP PROCEDURE getUserName;
DROP PROCEDURE getMingleUserName;
DELIMITER $$

CREATE PROCEDURE isUserIDExisted(
    in  n_Game_ID       integer,
    in  n_User_ID       integer unsigned,

    out n_Result        integer
)
BEGIN
    declare n_Ret_User_ID   integer unsigned; /* UMS_USER.user_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Validate Parameters.
        if (
            (n_User_ID is null) or
            (n_Game_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- Select user information from UMS_USER.
        select
            user_id
        into
            n_Ret_User_ID
        from
            UMS_USER
        where
            user_id = n_User_ID and
            game_id = n_Game_ID;

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1201;    /* PKG_UTIL.E_ACCOUNT_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE isMingleUserIDExisted(
    INOUT n_Game_ID INTEGER, 
    IN n_User_ID INTEGER, 
    OUT n_Result INTEGER
)
BEGIN
    declare n_Ret_User_ID   integer unsigned; /* UMS_USER.user_id%TYPE */
    declare n_Tmp_Game_ID           integer;
    declare n_Tmp_Master_Game_ID     integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        -- Validate Parameters.
        if (
            (n_User_ID is null) or
            (n_Game_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            t.game_id
        into
            n_Tmp_Game_ID
        from
            ums_user t
        where
            t.user_id = n_User_ID
        and
            t.game_id in (
            select
                game_id
            from
                sys_slave_games
            where
                game_id = n_Game_ID or
                slave_game_id = n_Game_ID
        	union
        	select
            	slave_game_id
        	from
            	sys_slave_games
        	where
            	game_id in (
                	select
                    	ifnull(game_id, 0)
                	from
                    	sys_slave_games
                	where
                    	game_id = n_Game_ID or
                    	slave_game_id = n_Game_ID
            	)
            union
            select
                n_Game_ID
        );
        if(found_rows()=0) then
            set n_Result = -1201;
            leave label_proc;
        elseif( n_Tmp_Game_ID <> n_Game_ID ) then
            select
                t.game_id
            into
                n_Tmp_Master_Game_ID
            from
                sys_slave_games t
            where
                t.slave_game_id = n_Tmp_Game_ID;
            if(found_rows()=0) then
                set n_Result = -1201;
                leave label_proc;
            elseif( n_Tmp_Master_Game_ID <> n_Game_ID ) then
                set n_Result = -1201;
                leave label_proc;
            end if;
        end if;
        
        set n_Game_ID = n_Tmp_Game_ID;
        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE isUserRoleIDExisted(
    in  n_Game_ID       integer,
    in  n_User_ID       integer unsigned,
    in  n_Role_ID       integer unsigned,

    out n_Result        integer
)
BEGIN
    declare n_RetCode       integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Ret_Role_State   integer; /* UMS_ROLE.role_state%TYPE */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters Validation.
        if (n_User_ID is null) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- To determine whether the user ID exists.
        call isUserIDExisted(n_Game_ID, n_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- To select role information from UMS_ROLE.
        select
            role_state
        into
            n_Ret_Role_State
        from
            UMS_ROLE
        where
            (user_id    = n_User_ID) and
            (role_id    = n_Role_ID) and
            (game_id    = n_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        if (n_Ret_Role_State = 2) then -- Have been deleted.
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE verifyPassword(
    in  n_Game_ID       integer,
    in  n_User_ID       integer unsigned,
    in  s_Password      varchar(32),
    in  n_Password_Type integer,

    out n_Result        integer
)
BEGIN
    declare s_Tmp_Password   varchar(32); /* UMS_USER.password%TYPE */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        -- Parameters Validation.
        if (
            (n_Game_ID           is null) or
            (n_User_ID           is null) or
            (s_Password          is null) or
            (n_Password_Type     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'allow_mingle_realm',
            '',
            s_Tmp_Mingle_Realm
            );
        if (s_Tmp_Mingle_Realm = '1') then
            call isMingleUserIDExisted(n_Tmp_Game_ID, n_User_ID, n_RetCode);
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;   
            end if;
        end if;
        -- Verify Authentication password from local database..
        if (n_Password_Type = 1) then
            select
                password
            into
                s_Tmp_Password
            from
                UMS_USER
            where
                user_id = n_User_ID and
                game_id = n_Tmp_Game_ID;

            if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
                set n_Result = -1406;    /* PKG_UTIL.E_USER_ACCOUNT_ERROR */
                leave label_proc;
            end if;

            if (s_Tmp_Password <> s_Password) then
                set n_Result = -1402;    /* PKG_UTIL.E_USER_PASSWORD_ERROR */
                leave label_proc;
            end if;
        else
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE userStateQuery(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  s_User_Name        varchar(32),

    out n_Ret_User_State   integer,
    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (n_User_ID        is null) or
            (s_User_Name      is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        if (n_User_ID > 0) then
            select
                user_state
            into
                n_Ret_User_State
            from
                UMS_USER
            where
                user_id = n_User_ID and
                game_id = n_Game_ID;
        else
            select
                user_state
            into
                n_Ret_User_State
            from
                UMS_USER
            where
                user_name = s_User_Name and
                game_id   = n_Game_ID;
        end if;

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1201;    /* PKG_UTIL.E_ACCOUNT_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
        set n_Ret_User_State = IFNULL(n_Ret_User_State, 0);
END$$

-- 验证MAC地址是否被封停
-- 如没有被封停返回 S_SUCCESS 1
-- 如被封停返回     E_USER_MAC_ILLEGAL -1431
CREATE PROCEDURE verifyMAC(
    in  n_Game_ID          integer,
    in  s_MAC              varchar(16),

    out n_Result           integer
)
BEGIN
    declare s_Tmp_MAC        varchar(16); /* SYS_FILTER_MAC.MAC%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        select
            mac
        into
            s_Tmp_MAC
        from
            SYS_FILTER_MAC
        where
            mac     = s_MAC and
            game_id = n_Game_ID;

        if (FOUND_ROWS() = 1) then
            set n_Result = -1431; -- -1431;    /* PKG_UTIL.E_USER_MAC_ILLEGAL */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 功能：
--       查询硬件序列号是否被冻结
-- 返回结果：
--       S_SUCCESS 1 已被冻结
--       其它（非 1） 未被冻结
CREATE PROCEDURE isHardwareSNFreezed(
    in  n_Game_ID          integer,
    in  s_Hardware_SN      varchar(32),

    out n_Result           integer
)
BEGIN
    declare s_Tmp_SN         varchar(32); /* SYS_FILTER_HARDWARE_SN.Serial_No%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        select
            serial_no
        into
            s_Tmp_SN
        from
            SYS_FILTER_HARDWARE_SN
        where
            serial_no = upper(s_Hardware_SN) and
            game_id   = n_Game_ID;

        if (FOUND_ROWS() = 1) then
            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        else
            set n_Result = 0;    /* PKG_UTIL.E_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 根据网关ID和帐号ID取得帐号信息
CREATE PROCEDURE GetAccountInfo(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,

    out n_Result             integer
)
BEGIN
    declare n_Ret_User_ID            integer default  0;    /* PKG_UTIL.E_ERROR */
    declare s_Tmp_Special_UserName   varchar(32); /* SYS_OPTION.option_value%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- 检验参数合法性
        if (
            (n_User_ID is null) or
            (n_Game_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- 判断帐号ID是否存在
        select
            user_id
        into
            n_Ret_User_ID
        from
            UMS_USER
        where
            user_id = n_User_ID and
            game_id = n_Game_ID;

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1201/*-1201*/;    /* PKG_UTIL.E_ACCOUNT_NOT_FOUND */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'special_username',    /* PKG_OPTION.SPECIAL_USERNAME */
            '0',    /* PKG_OPTION.R_CLOSED */

            s_Tmp_Special_UserName
        );

        -- 返回特定形式帐号
        if (s_Tmp_Special_UserName = '1') then    /* PKG_OPTION.R_OPENED */
            select
                concat('lk-', user_id) as user_name, password, user_type, user_class,
                user_point, promoter_id, user_flag, game_id
            from
                UMS_USER
            where
               user_id = n_User_ID and
               game_id = n_Game_ID;
        else
            select
                user_name, password, user_type, user_class,
                user_point, promoter_id, user_flag, game_id
            from
                UMS_USER
            where
               user_id = n_User_ID and
               game_id = n_Game_ID;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE GetOnlineCount(
    in  n_Game_ID            integer,
    in  n_Gateway_ID         integer,

    out n_Online_Count       integer,
    out n_Result             integer
)
BEGIN
    declare n_Tmp_GW_State  integer default  -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (n_Gateway_ID is null) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- validate gateway state
        call getGatewayState(n_Game_ID, n_Gateway_ID, n_Tmp_GW_State, n_Result);
        if (
            (n_Result <> 1) or
            (n_Tmp_GW_State <> 1)
        ) then
            leave label_proc;
        end if;

        if (n_Gateway_ID = 0) then
            select
                IFNULL(sum(t.user_online_count), 0)
            into
                n_Online_Count
            from
                LOG_USER_ONLINE_COUNT t
            where
                t.gateway_id > 0 and
                t.server_id  > 0 and
                t.game_id    = n_Game_ID;
        else
            select
                IFNULL(sum(t.user_online_count), 0)
            into
                n_Online_Count
            from
                LOG_USER_ONLINE_COUNT t
            where
                t.gateway_id = n_Gateway_ID and
                t.server_id  > 0            and
                t.game_id    = n_Game_ID;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE JointAuthenMySQL(
    in  n_Game_ID            integer,
    in  s_User_Name          varchar(32),
    in  s_User_Password      varchar(32),
    in  n_Gateway_ID         integer,
    in  n_User_IP            integer unsigned,
    in  n_User_Port          integer,
    in  s_MAC                varchar(16),
    in  n_Adult_State        integer,
    in  s_ID_Card            varchar(32),
    in  s_Ad_id              varchar(20),
    in  s_Hardware_SN1       varchar(32),
    in  s_Hardware_SN2       varchar(32),

    out n_Ret_User_ID        integer unsigned,
    out n_Ret_User_Type      integer,
    out n_Ret_Adult_Flag     integer,
    out n_Ret_User_Class     integer,
    out n_Ret_User_Point     integer,
    out n_Ret_Promoter_ID    integer,
    out n_Ret_User_Flag      integer,
    out n_Ret_Exp_Bonus      integer,
    out n_Ret_Tao_Bonus      integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Gateway_State          integer; /* SYS_GATEWAY.gateway_state%TYPE */
    declare n_Tmp_ID_Verify_Flag integer default  0; /* UMS_USER.id_verify_flag%TYPE */
    declare n_Tmp_User_ID         integer unsigned;

    declare n_Tmp_User_State     integer default  0; /* UMS_USER.user_state%TYPE */
    declare d_Tmp_Birthday               datetime;
    declare n_Tmp_Online_State           bigint;            /* UMS_ROLE.login_id%TYPE */

    declare s_Tmp_Default_Adult  varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Online_Check   varchar(32); /* SYS_OPTION.option_value%type */

    declare s_Tmp_Op_Type         varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_IP             varchar(32);
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1406;    /* PKG_UTIL.E_USER_ACCOUNT_ERROR */

        set n_Result = 0; /* E_ERROR */
        -- Paramters intialization.
        set n_Ret_User_Type       = 0;
        set n_Ret_Adult_Flag      = 0;
        set n_Ret_User_Class      = 0;
        set n_Ret_User_Point      = 0;
        set n_Ret_Promoter_ID     = 0;
        set n_Ret_User_Flag       = 0;
        set n_Ret_Exp_Bonus       = 0;
        set n_Ret_Tao_Bonus       = 0;

        -- Paramters validation.
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (s_User_Name     is null) or
            (n_User_IP       is null) or
            (n_User_Port     is null) or
            (n_Adult_State   is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
              n_Game_ID,
              'op_type',    /* PKG_OPTION.OP_TYPE */
              'auto',    /* PKG_OPTION.T_AUTO */
              s_Tmp_Op_Type
              );
        -- 海外运营
        if (s_Tmp_Op_Type <> 'oversea') then    /* PKG_OPTION.T_OVER_SEA */
            set n_Result =  -2103;    /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
        end if;

        call verifyMAC(n_Game_ID, s_MAC, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call isHardwareSNFreezed(n_Game_ID, s_Hardware_SN1, n_RetCode);
        if (n_RetCode = 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = -1432;   /* E_USER_HARDWARE_SN_ILLEGAL */
            leave label_proc;
        end if;

        call isHardwareSNFreezed(n_Game_ID, s_Hardware_SN2, n_RetCode);
        if (n_RetCode = 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = -1432;   /* E_USER_HARDWARE_SN_ILLEGAL */
            leave label_proc;
        end if;

        select
            gateway_state
        into
            n_Tmp_Gateway_State    -- 0 - uncharged; 1 - charged; 2 - forbidden; 3 - need active code,
        from
            SYS_GATEWAY
        where
            gateway_id = n_Gateway_ID and
            game_id    = n_Game_ID;

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1001;    /* PKG_UTIL.E_GATEWAY_NOT_FOUND */
            leave label_proc;
        end if;

        -- We query information from local database.
        select
            user_id,              user_type,            birthday,
            user_point,           user_class,
            user_flag,            user_state
        into
            n_Ret_User_ID,        n_Ret_User_Type,      d_Tmp_Birthday,
            n_Ret_User_Point,     n_Ret_User_Class,
            n_Ret_User_Flag,      n_Tmp_User_State
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;

        if (FOUND_ROWS() <> 0) then
            -- judge whether the user is adult.
            call getOptionValue(
                                n_Game_ID,
                                'default_adult',    /* PKG_OPTION.DEFAULT_ADULT */
                                '0',    /* PKG_OPTION.R_CLOSED */
                                s_Tmp_Default_Adult
                                );

            if (
                 (s_Tmp_Default_Adult = '1') or    /* PKG_OPTION.R_OPENED */
                 (n_Adult_State       = 0  )  -- 0 - 成年人；其它 - 未成年人
            ) then
                set n_Tmp_User_State =  n_Tmp_User_State | 8;
            else
                set n_Tmp_User_State =  n_Tmp_User_State & ~8 ;
            end if;

            update
                UMS_USER
            set
                password   = IFNULL(s_User_Password, '0'),
                id_code    = IFNULL(s_ID_Card, n_Ret_User_ID),
                user_state = n_Tmp_User_State
            where
                user_id = n_Ret_User_ID and
                game_id = n_Game_ID;
        else
            insert into sys_user_id values();
            select last_insert_id() into n_Tmp_User_ID;
            insert into UMS_USER(
                user_id, user_name,      password,
                user_type,      gateway_id,
                user_point,     user_class,         promoter_id,
                birthday,       id_verify_flag,
                user_flag,      user_state,         ad_id,
                id_code,                            game_id
            )
            values(
                n_Tmp_User_ID, s_User_Name,    IFNULL(s_User_Password, '0'),
                0,              0,
                0,              0,                  0,
                d_Tmp_Birthday, n_Tmp_ID_Verify_Flag,
                0,              40,                 cast(s_Ad_id AS SIGNED),
                IFNULL(s_ID_Card, n_Ret_User_ID),   n_Game_ID
            );

            set n_Tmp_User_State = 40;
            set n_Ret_User_ID = n_Tmp_User_ID;
        end if;

        -- 未登录过的玩家状态。
        if (n_Tmp_User_State & 32  > 0) then /* bitand(n_Tmp_User_State, 32) */
            call logFirstLogin(
                n_Game_ID,
                n_Ret_User_ID,
                s_User_Name,
                n_Gateway_ID,
                now(),
                n_User_IP,
                n_User_Port,
                s_MAC,
                n_RetCode
            );

            set n_Tmp_User_State = n_Tmp_User_State & ~32 ;

            update
                UMS_USER
            set
                user_state = n_Tmp_User_State
            where
                user_id    = n_Ret_User_ID and
                game_id    = n_Game_ID;
        end if;

        -- If user account is freezed, deny.
        if (n_Tmp_User_State & 1  > 0) then /* bitand(n_Tmp_User_State, 1) */
            set n_Result = -1411;    /* PKG_UTIL.E_USER_STATE_FREEZED */
            leave label_proc;
        end if;

        -- judge whether some roles of `user_id' are online.
        call getOptionValue(
                      n_Game_ID,
                      'online_check',    /* PKG_OPTION.ONLINE_CHECK */
                      '1',    /* PKG_OPTION.R_OPENED */
                      s_Tmp_Online_Check
                      );
        if (s_Tmp_Online_Check = '1') then    /* PKG_OPTION.R_OPENED */
            select
                IFNULL( max(gateway_id), 0 )
            into
                n_Tmp_Online_State
            from
                UMS_ROLE
            where
                (login_id   > 0            ) and
                (user_id    = n_Ret_User_ID) and
                (role_state = 1            ) and
                (game_id    = n_Game_ID    );

            if(
                (n_Tmp_Online_State > 0) and
                (n_Tmp_Online_State <> n_Gateway_ID)
            ) then
                set n_Result = -1430;    /* PKG_UTIL.E_USER_IN_OTHER_GATEWAY */
                leave label_proc;
            end if;

            if (n_Tmp_User_State & 8  = 0) then /* bitand(n_Tmp_User_State, 8) */
                set n_Ret_Adult_Flag = 0;
            else
                set n_Ret_Adult_Flag = 1;
            end if;
        end if;

        if (n_Ret_User_Flag is null) then
            set n_Ret_User_Flag = 0;
        end if;

        call Number2IP(n_User_IP, s_Tmp_IP, n_Result);

        select
            exp_bonus,       tao_bonus
        into
            n_Ret_Exp_Bonus, n_Ret_Tao_Bonus
        from
            SYS_IP_BONUS
        where
            user_ip = s_Tmp_IP;
        if (FOUND_ROWS() = 0) then
            set n_Ret_Exp_Bonus = 0;
            set n_Ret_Tao_Bonus = 0;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    if (n_Ret_User_Type is null) then
        set n_Ret_User_Type = 0;
    end if;
END$$

CREATE PROCEDURE getUserIdAndPwd(
    in  n_Game_ID       integer,
    in  s_User_Name     varchar(32),

    out n_User_ID       integer,
    out n_Result        integer,
    out s_Password      varchar(32)
)
BEGIN
    declare s_Tmp_Op_Type     varchar(32);
    declare n_Tmp_User_ID     integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if(
          (n_Game_ID    is null) or
          (s_User_Name  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getOptionValue( n_Game_ID, 'op_type', null, s_Tmp_Op_Type);

       if (s_Tmp_Op_Type is null) then
            set n_Result =  -2103;    /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
       end if;


        select
            user_id,
            password
        into
            n_User_ID,
            s_Password
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;

        if( found_rows() = 0 and s_Tmp_Op_Type <> 'auto') then
            insert into sys_user_id values();
            select last_insert_id() into n_Tmp_User_ID;
            insert ignore into UMS_USER(
                user_id, game_id,     user_name,    password,
                user_type,   gateway_id,   server_id,
                user_point,  user_class,   promoter_id,
                birthday,    id_code,      id_verify_flag,
                user_flag,   user_state,   ad_id)
            values(
                n_Tmp_User_ID, n_Game_ID,   s_User_Name,  '0',
                0,           0,            null,
                0,           0,            0,
                null,        '0',         0,
                0,           0,            null);

            if( row_count() = 0) then
                set n_Result = -1406;
                leave label_proc;
            end if;

            select user_id,password
            into n_User_ID,s_Password
            from ums_user
            where
                user_name = s_User_Name
            and
                game_id   = n_Game_ID;
        elseif(found_rows() = 0 and s_Tmp_Op_Type = 'auto') then
            set n_Result = -1201;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

/*海外用户自主认证*/
CREATE PROCEDURE authenticateEx(
 IN  n_Game_ID              INTEGER, 
 IN  n_Gateway_ID           VARCHAR(255),
 IN  s_User_Name            VARCHAR(255),
 IN  s_Password             VARCHAR(255),
 IN  n_Password_Type        INTEGER, 
 IN  n_User_IP              INTEGER UNSIGNED, 
 IN  n_User_Port            INTEGER, 
 IN  s_MAC                  VARCHAR(255), 
 IN  s_Matrix_Password      VARCHAR(255), 
 IN  s_Matrix_Coord         VARCHAR(255),
 IN  s_AD_ID                VARCHAR(255), 
 IN  s_Hardware_SN1         VARCHAR(255), 
 IN  s_Hardware_SN2         VARCHAR(255), 
 OUT n_Ret_User_ID          INTEGER UNSIGNED,
 OUT n_Ret_User_Type        INTEGER, 
 OUT n_Ret_Adult_Flag       INTEGER, 
 OUT n_Ret_User_Class       INTEGER, 
 OUT n_Ret_User_Role_Count  INTEGER,
 OUT n_Ret_User_Point       INTEGER, 
 OUT n_Ret_Promoter_ID      INTEGER,
 OUT n_Ret_User_Flag        INTEGER, 
 OUT n_Result               INTEGER
 )
BEGIN
    declare           n_RetCode                       integer   default 0;
    declare           n_Ret_Gateway_State             integer;
    declare           s_Tmp_Password                  varchar(32);
    declare           n_Tmp_User_State                integer;
    declare           n_Tmp_ID_Verify_Flag            integer   default 0;
    declare           n_User_Gateway_State            integer   default 0;
    declare           d_Tmp_Login_Time                datetime  default now();
    declare           FIRST_LOGIN_GATEWAY_ID          integer default 1024;
    declare           USER_FIRST_LOGIN                integer default  2048;
    declare           n_Tmp_First_Login_Gateway_ID    integer;
    declare           n_Is_New_User                   integer default 0;
    declare           s_Tmp_Open_Auth                 varchar(32);
    declare           s_Tmp_Online_Check              varchar(32);
    declare           s_Tmp_Op_Type                   varchar(32);
    declare           s_Tmp_Game_Type                 varchar(32);
    label_proc:begin
        set n_Result = 0;
        set n_Ret_User_ID = 0;
        set n_Ret_User_Type = 0;
        set n_Ret_Adult_Flag = 0;
        set n_Ret_User_Class = 0;
        set n_Ret_User_Role_Count = 0;
        set n_Ret_User_Point = 0;
        set n_Ret_Promoter_ID = 0;
        set n_Ret_User_Flag = 0;
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (s_User_Name     is null) or
            (s_Password      is null) or
            (n_Password_Type is null) or
            (n_User_IP       is null) or
            (n_User_Port     is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call verifyMAC(n_Game_ID, s_MAC, n_RetCode);
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        
        call isHardwareSNFreezed(
            n_Game_ID,
            s_Hardware_SN1,
            n_RetCode
        );
        if (n_RetCode = 1) then
            set n_Result = -1432;
            leave label_proc;
        end if;

        call isHardwareSNFreezed(
            n_Game_ID,
            s_Hardware_SN2,
            n_RetCode
        );
        if (n_RetCode = 1) then
            set n_Result = -1432;
            leave label_proc;
        end if;

        call getOptionValue(
                n_Game_ID,
                'op_type',
                'auto',
                s_Tmp_Op_Type
                );
        if( s_Tmp_Op_Type <> 'auto' ) then
            set n_Result = -2103;
            leave label_proc;
        end if;

        select
            gateway_state
        into
            n_Ret_Gateway_State
        from
            SYS_GATEWAY
        where
            gateway_id = n_Gateway_ID and
            game_id    = n_Game_ID;
        if(found_rows() = 0 ) then
            set n_Result = -1001;
            leave label_proc;
        end if;

        select
            user_id,              password,            user_type,
            user_point,           user_class,          promoter_id,
            id_verify_flag,       user_flag,           user_state
        into
            n_Ret_User_ID,        s_Tmp_Password,      n_Ret_User_Type,
            n_Ret_User_Point,     n_Ret_User_Class,    n_Ret_Promoter_ID,
            n_Tmp_ID_Verify_Flag, n_Ret_User_Flag,     n_Tmp_User_State
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;
        if(found_rows() = 0 ) then
            call getOptionValue(
                n_Game_ID,
                'open_auth',
                '1',
                s_Tmp_Open_Auth
            );
            if (s_Tmp_Open_Auth = '0') then
                set n_Result = -1201;
                leave label_proc;
            end if;
            set n_Result = -10000;
            leave label_proc;
        end if;
         
        if (s_Password <> s_Tmp_Password) then
            set n_Result = -1402;
            leave label_proc;
        end if;

        if ( (n_Tmp_User_State & 32) > 0) then
            call logFirstLogin(
                n_Game_ID,
                n_Ret_User_ID,
                s_User_Name,
                n_Gateway_ID,
                d_Tmp_Login_Time,
                n_User_IP,
                n_User_Port,
                s_MAC,
                n_RetCode
            );
            set n_Tmp_User_State = n_Tmp_User_State - (n_Tmp_User_State & 32);
            set n_Ret_User_Flag = n_Ret_User_Flag + USER_FIRST_LOGIN - (n_Ret_User_Flag & USER_FIRST_LOGIN);

            update
                UMS_USER
            set
                user_state = n_Tmp_User_State
            where
                user_id = n_Ret_User_ID and
                game_id = n_Game_ID;
            set n_Is_New_User = 1;
        else
            set n_Is_New_User = 2;
        end if;

        if ( (n_Tmp_User_State & 1) > 0) then
            set n_Result = -1411;
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'online_check',
            '1',
            s_Tmp_Online_Check
            );

        if (s_Tmp_Online_Check = '1') then
            select
                IFNULL( max(gateway_id), 0 )
            into
                n_User_Gateway_State
            from
                ums_role
            where
                (login_id > 0            ) and
                (user_id  = n_Ret_User_ID) and
                (role_state = 1)           and
                (game_id  = n_Game_ID);

            if(
                (n_User_Gateway_State > 0) and
                (n_User_Gateway_State <> n_Gateway_ID)
            ) then
                set n_Result = -1430;
                leave label_proc;
            end if;
        end if;

        if (
            ( n_Tmp_User_State & 8 = 0)
        ) then
            set n_Ret_Adult_Flag = 0;
        else
            set n_Ret_Adult_Flag = 1;
        end if;

        if (n_Ret_User_Flag is null) then
            set n_Ret_User_Flag = 0;
        end if;

        set n_Result = 1;
    end label_proc;
    if (n_Ret_User_ID is null) then
        set n_Ret_User_ID = 0;
    end if;
    if (n_Ret_User_Type is null) then
        set n_Ret_User_Type = 0;
    end if;
END$$

CREATE PROCEDURE getNewUserCardFlag(
    in  n_User_Type                 integer,
    out n_Ret_New_User_Card_Flag    integer,
    out n_Result                    integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        set n_Ret_New_User_Card_Flag = 0;

        if ( (n_User_Type & 2) > 0 ) then
            set n_Ret_New_User_Card_Flag = 1;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

/*首登 往USER_USER做记录*/
CREATE PROCEDURE doFirstLogin(
    IN  n_Game_ID           INTEGER,
    IN  s_User_Name         VARCHAR(32),
    IN  s_Password          VARCHAR(32), 
    IN  n_User_IP           INTEGER, 
    IN  n_Promoter_ID       INTEGER,
    IN  n_Gateway_ID        INTEGER, 
    IN  s_AD_ID             VARCHAR(32), 
    IN  n_User_ID           INTEGER, 
    IN  n_User_Type         INTEGER, 
    IN  n_ID_Verify_Flag    INTEGER,  
    OUT n_Ret_User_State    INTEGER,
    OUT n_Result            INTEGER
)
BEGIN
    declare         n_RetCode                   integer     default 0;

    declare         n_Tmp_New_User_Card_Flag    integer;
    declare         d_Tmp_Birthday              datetime    default now();
    declare         s_Tmp_ID_Code               varchar(32) default '0';
    declare         s_Tmp_Op_Type               varchar(32);
    label_proc:begin
    declare exit handler for 1062 set n_Result = 1;
    call getOptionValue(
        n_Game_ID,
        'op_type',
        'auto',
        s_Tmp_Op_Type
        );
    if (s_Tmp_Op_Type <> 'auto') then
        set n_Result = -2103;
        leave label_proc;
    end if;

    set n_Ret_User_State = 32;

    call getNewUserCardFlag(n_User_Type, n_Tmp_New_User_Card_Flag, n_RetCode );

    if (
            (DATEDIFF(now(), d_Tmp_Birthday) >= 18 * 12) or
            (
                (n_Tmp_New_User_Card_Flag                =  1 ) and
                ((n_User_Type & 1)               =  0 )
            )
       ) then
        set n_Ret_User_State = (n_Ret_User_State + 8 - (n_Ret_User_State & 8));
    end if;

    insert into UMS_USER(
                game_id,             user_id,             user_name,            password,
                user_type,           gateway_id,          server_id,
                user_point,          user_class,          promoter_id,
                birthday,            id_code,             id_verify_flag,
                user_flag,           user_state,          ad_id
                            
            )
    values(
                n_Game_ID,          n_User_ID,       s_User_Name,           s_Password,
                n_User_Type,        0,               0,                  
                0,                  0,               n_Promoter_ID,    
                null,               n_User_ID,       n_ID_Verify_Flag,
                0,                  n_Ret_User_State,     CAST(s_AD_ID AS SIGNED)              
            );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE SSOFromLKWeb(
    IN  n_Game_ID                INTEGER, 
    IN  n_Gateway_ID             VARCHAR(32), 
    IN  s_User_Name              VARCHAR(32), 
    IN  n_User_IP                INTEGER, 
    IN  n_User_Port              INTEGER, 
    IN  s_MAC                    VARCHAR(32), 
    IN  s_AD_ID                  VARCHAR(32),
    IN  s_Hardware_SN1           VARCHAR(32),
    IN  s_Hardware_SN2           VARCHAR(32), 
    OUT n_Ret_User_ID            INTEGER,
    OUT n_Ret_User_Type          INTEGER, 
    OUT n_Ret_Adult_Flag         INTEGER,
    OUT n_Ret_User_Class         INTEGER,
    OUT n_Ret_User_Role_Count    INTEGER, 
    OUT n_Ret_User_Point         INTEGER, 
    OUT n_Ret_Promoter_ID        INTEGER,
    OUT n_Ret_User_Flag          INTEGER, 
    OUT n_Result                 INTEGER
 )
BEGIN
    declare         n_RetCode                   integer     default 0;
    declare         n_Tmp_User_ID               integer     default 0;
    declare         s_Tmp_User_Name             varchar(32) default '';
    declare         s_Tmp_Password              varchar(32) default '';
    declare         s_Tmp_ID_Code               varchar(32) default '';
    declare         d_Tmp_Birthday              datetime    default now();
    declare         n_Tmp_ID_Verify_Flag        integer     default 0;
    declare         n_Tmp_User_Type             integer     default 0;
    declare         s_Tmp_Open_Auth             varchar(32) default '1';
    label_proc:begin
        select
            password
        into
            s_Tmp_Password
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;
        if(found_rows() = 0 ) then
            call getOptionValue(
                n_Game_ID,
                'open_auth',
                '1',
                s_Tmp_Open_Auth
                );
            if (s_Tmp_Open_Auth = '0') then
                set n_Result = -1201;
                leave label_proc;
            end if;

            set n_Result = -10000;
            leave label_proc;
        end if;

        call authenticateEx(
            n_Game_ID,
            n_Gateway_ID,
            s_User_Name,
            s_Tmp_Password,
            1,
            n_User_IP,
            n_User_Port,
            s_MAC,
            '',  -- 密保卡密码
            '',  -- 密保卡坐标
            s_AD_ID,
            s_Hardware_SN1,
            s_Hardware_SN2,

            n_Ret_User_ID,
            n_Ret_User_Type,
            n_Ret_Adult_Flag,
            n_Ret_User_Class,
            n_Ret_User_Role_Count,
            n_Ret_User_Point,
            n_Ret_Promoter_ID,
            n_Ret_User_Flag,
            n_RetCode
            );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserID(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),

    out  n_Ret_User_ID      integer,
    out  n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            t.user_id
        into
            n_Ret_User_ID
        from
            UMS_USER t
        where
            t.user_name = s_User_Name and
            t.game_id   = n_Game_ID;
        if(found_rows() <> 1 ) then
            set n_Result = -1201;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getMingleUserID(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),

    out  n_Ret_User_ID      integer,
    out  n_Result           integer
)
BEGIN
     declare n_Tmp_Count     integer;
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            count(*)
        into
            n_Tmp_Count
        from
            UMS_USER t
        where
            t.user_name = s_User_Name and
            t.game_id   in
            (
                select
            		game_id
        		from
            		sys_slave_games
        		where
            		game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            		)
        		union
        		select
            		n_Game_ID
            );
        if(n_Tmp_Count <> 1 ) then
            set n_Result = -1406;
            set n_Ret_User_ID = 0;
            leave label_proc;
        end if;

        select
            t.user_id
        into
            n_Ret_User_ID
        from
            UMS_USER t
        where
            t.user_name = s_User_Name and
            t.game_id   in
            (
                select
            		game_id
        		from
            		sys_slave_games
        		where
            		game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            		)
        		union
        		select
            		n_Game_ID
            );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE SignIn(
    in  n_Game_ID              integer,
    in  s_User_Name            varchar(32),
    in  s_User_Password        varchar(32),
    in  n_Password_Type        integer,
    in  n_Gateway_ID           integer,
    in  n_User_IP              integer unsigned,
    in  n_User_Port            integer,
    in  s_MAC                  varchar(16),
    in  s_Ad_id                varchar(20),
    in  s_Hardware_SN1         varchar(32),
    in  s_Hardware_SN2         varchar(32),

    out n_Ret_User_ID          integer unsigned,
    out n_Ret_User_Type        integer,
    out n_Ret_Adult_Flag       integer,
    out n_Ret_User_Class       integer,
    out n_Ret_User_Role_count  integer,
    out n_Ret_User_Point       integer,
    out n_Ret_Promoter_ID      integer,
    out n_Ret_User_Flag        integer,
    out n_Result               integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Gateway_State  integer; /* SYS_GATEWAY.gateway_state%TYPE */

    declare n_Tmp_User_State     integer default  0; /* UMS_USER.user_state%TYPE */
    declare d_Tmp_Birthday       datetime;
    declare n_Tmp_Online_State   bigint;            /* UMS_ROLE.login_id%TYPE */
    declare s_Tmp_Password       varchar(32);

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Paramters intialization.
        set n_Ret_User_Type       = 0;
        set n_Ret_Adult_Flag      = 0;
        set n_Ret_User_Class      = 0;
        set n_Ret_User_Point      = 0;
        set n_Ret_Promoter_ID     = 0;
        set n_Ret_User_Flag       = 0;

        -- Paramters validation.
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (s_User_Name     is null) or
            (s_User_Password is null) or
            (n_Password_Type is null) or
            (n_User_IP       is null) or
            (n_User_Port     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call verifyMAC(n_Game_ID, s_MAC, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call isHardwareSNFreezed(n_Game_ID, s_Hardware_SN1, n_RetCode);
        if (n_RetCode = 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = -1432;   /* E_USER_HARDWARE_SN_ILLEGAL */
            leave label_proc;
        end if;

        call isHardwareSNFreezed(n_Game_ID, s_Hardware_SN2, n_RetCode);
        if (n_RetCode = 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = -1432;   /* E_USER_HARDWARE_SN_ILLEGAL */
            leave label_proc;
        end if;

        select
            user_id,              password,             user_type,
            birthday,             user_point,           user_class,
            promoter_id,          user_flag,            user_state
        into
            n_Ret_User_ID,        s_Tmp_Password,       n_Ret_User_Type,
            d_Tmp_Birthday,       n_Ret_User_Point,     n_Ret_User_Class,
            n_Ret_Promoter_ID,    n_Ret_User_Flag,      n_Tmp_User_State
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;

        if (FOUND_ROWS() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        -- If user account is freezed, deny.
        if (n_Tmp_User_State & 1  > 0) then /* bitand(n_Tmp_User_State, 1) */
            set n_Result = -1411;    /* PKG_UTIL.E_USER_STATE_FREEZED */
            leave label_proc;
        end if;

        select
            IFNULL( max(gateway_id), 0 ),
            count(role_id)
        into
            n_Tmp_Online_State,
            n_Ret_User_Role_Count
        from
            UMS_ROLE
        where
            (login_id   > 0            ) and
            (user_id    = n_Ret_User_ID) and
            (role_state = 1            ) and
            (game_id    = n_Game_ID    );

        if(
            (n_Tmp_Online_State > 0) and
            (n_Tmp_Online_State <> n_Gateway_ID)
        ) then
            set n_Result = -1430;    /* PKG_UTIL.E_USER_IN_OTHER_GATEWAY */
            leave label_proc;
        end if;

        if (n_Tmp_User_State & 2 > 0) then
        	call verifyGMTest(n_Game_ID, n_Ret_User_ID, s_User_Password, n_User_IP, n_RetCode);
        	if(n_RetCode <> 1) then
        		set n_Result = n_RetCode;
            leave label_proc;
            end if;
        else
        	if (s_User_Password <> s_Tmp_Password) then
        		set n_Result = -1402; /* PKG_UTIL.E_USER_PASSWORD_ERROR */
        		leave label_proc;
        	end if;

            if(n_Tmp_User_State & 64 >0) then
            	if(n_Password_Type <> 5 ) then
            		set n_Result = -1423;  /* PKG_UTIL.E_USER_PHONE_LOCK_PSW_REQUIRED */
            		leave label_proc;
                end if;
            else
            	if(n_Password_Type = 3 ) then
            		set n_Result = -1534; /* PKG_UTIL.E_USER_NO_PASSCARD_BIND */
            		leave label_proc;
				      elseif( n_Password_Type = 4) then
                	set n_Result = -1539;  /* PKG_UTIL.E_USER_NO_DYNAMIC_PSW_BIND*/
            		leave label_proc;
				      elseif( n_Password_Type = 5 ) then
                	set n_Result = -1530;  /* PKG_UTIL.E_USER_NO_PHONE_LOCK */
            		leave label_proc;
            	end if;
            end if;
        end if;


      if (n_Tmp_User_State & 8  = 0) then /* bitand(n_Tmp_User_State, 8) */
          set n_Ret_Adult_Flag = 0;
	    else
	        set n_Ret_Adult_Flag = 1;
	    end if;

        if (n_Tmp_User_State & 32  > 0) then /* bitand(n_Tmp_User_State, 32) */
            call logFirstLogin(
                n_Game_ID,
                n_Ret_User_ID,
                s_User_Name,
                n_Gateway_ID,
                now(),
                n_User_IP,
                n_User_Port,
                s_MAC,
                n_RetCode
            );
            if (FOUND_ROWS() = 0) then
                set n_Result = -1400;  /* PKG_UTIL.E_USER_ERROR */
                leave label_proc;
			end if;

            set n_Tmp_User_State = n_Tmp_User_State & ~32 ;

            update
                UMS_USER
            set
                user_state = n_Tmp_User_State
            where
                user_id    = n_Ret_User_ID and
                game_id    = n_Game_ID;
        end if;
        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE SignUp(
    in  n_Game_ID                integer,
    in  s_User_Name              varchar(32),
    in  s_Login_Password         varchar(32),
    in  n_Account_State	         integer,

	out n_Ret_Account_ID         integer,
    out n_Result                 integer
)
BEGIN
    declare n_Tmp_Account_State  integer default 0;
    declare n_Tmp_User_ID        integer unsigned default 0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
        	(n_Game_ID        is null) or
        	(s_User_Name      is null) or
        	(s_Login_Password is null) or
        	(n_Account_State  is null)
        )then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Tmp_Account_State = n_Account_State + 32 - (n_Account_State & 32);

            insert into sys_user_id values();
            select last_insert_id() into n_Tmp_User_ID;

        insert into UMS_USER(
        	game_id,         user_name,    password,
        	user_type,       gateway_id,   user_point,
        	user_class,      promoter_id,  birthday,
        	id_verify_flag,  user_flag,    user_state,
        	ad_id,           id_code,      user_id
        )values(
            n_Game_ID,       s_User_Name,  s_Login_Password,
            0,               0,            0,
            0,               0,            now(),
            1,               0,            n_Account_State,
            0,               0,            n_Tmp_User_ID
        );

       	select user_id
       	  into n_Ret_Account_ID
       	  from ums_user
       	 where game_id = n_Game_ID
       	   and user_name = s_User_Name;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE ChangeLoginPassword(
    in  n_Game_ID                integer,
    in  n_User_ID                integer,
    in  s_Old_Password           varchar(32),
    in  s_New_Password	         varchar(32),

    out n_Result                 integer
)
BEGIN
    declare s_Origin_Password  integer default '';
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID        is null) or
            (n_User_ID        is null) or
            (s_Old_Password   is null) or
            (s_New_Password   is null)
        )then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            password
        into
            s_Origin_Password
        from
            UMS_USER
        where
            game_id = n_Game_ID and
            user_id = n_User_ID;

       	if (FOUND_ROWS() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        if (s_Old_Password <> s_Origin_Password) then
            set n_Result = -1402;  /*PKG_UTIL.E_USER_PASSWORD_ERROR*/
            leave label_proc;
        end if;

        update
            UMS_USER
        set
            password = s_New_Password
        where
            game_id = n_Game_ID and
            user_id = n_User_ID;

        if (row_count() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE ResetLoginPasswordByGM(
    in  n_Game_ID                integer,
    in  n_User_ID                integer,
    in  s_New_Password	         varchar(32),

    out n_Result                 integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID        is null) or
            (n_User_ID        is null) or
            (s_New_Password   is null)
        )then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update
            UMS_USER
        set
            password = s_New_Password
        where
            game_id = n_Game_ID and
            user_id = n_User_ID;

        if (row_count() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE UpdatePhoneLockState(
    in  n_Game_ID                integer,
    in  n_User_ID                integer,
    in  n_State	                 integer,

    out n_Result                 integer
)
BEGIN
    declare n_Target_State  integer default '';
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID         is null) or
            (n_User_ID         is null) or
            (n_State           is null) or
            (
                (n_State          <> 0) and
                (n_State          <> 1)
            )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        if (n_State = 0) then
            set n_Target_State = 0;
        else
            set n_Target_State = 64;
        end if;

        update
            UMS_USER
        set
            user_state = user_state + n_Target_State - (user_state & 64)
        where
            game_id = n_Game_ID and
            user_id = n_User_ID;

        if (row_count() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE verifyGMTest(
    in  n_Game_ID                integer,
    in  n_User_ID                integer,
    in  s_Temp_Password	         varchar(32),
    in  n_User_IP_Address        integer,

    out n_Result                 integer
)
BEGIN
    declare s_Ret_Temp_Password  integer;
    declare s_Ret_Temp_IP        integer;

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID         is null) or
            (n_User_ID         is null) or
            (s_Temp_Password   is null) or
            (n_User_IP_Address is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- To Check IP
        select
            security_code
        into
            s_Ret_Temp_IP
        from
            UMS_USER_SECURITY_CODE
        where
            (user_id       = n_User_ID) and
            (security_type = 1        ) and
            (game_id       = n_Game_ID);

        if (FOUND_ROWS() = 0) then
            set n_Result = -1411;  /*PKG_UTIL.E_USER_STATE_FREEZED*/
            leave label_proc;
        end if;

        if (
            (s_Ret_Temp_IP <> char(n_User_IP_Address))
        ) then
            set n_Result = -1411;  /*PKG_UTIL.E_USER_STATE_FREEZED*/
            leave label_proc;
        end if;

        -- To Check Password
        select
            security_code
        into
            s_Ret_Temp_Password
        from
            UMS_USER_SECURITY_CODE
        where
            (user_id       = n_User_ID) and
            (security_type = 2)         and
            (game_id       = n_Game_ID);

        if (FOUND_ROWS() = 0) then
            set n_Result = -1402;  /*PKG_UTIL.E_USER_PASSWORD_ERROR*/
            leave label_proc;
        end if;

        if (
            (s_Ret_Temp_Password <> s_Temp_Password)
        ) then
            set n_Result = -1402;  /*PKG_UTIL.E_USER_PASSWORD_ERROR*/
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getUserName(
    in   n_Game_ID          integer,
    in   n_User_ID          integer unsigned,

    out  s_Ret_User_Name    varchar(32),
    out  n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            t.user_name
        into
            s_Ret_User_Name
        from
            UMS_USER t
        where
            t.user_id   = n_User_ID and
            t.game_id   = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1201;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getMingleUserName(
    in   n_Game_ID          integer,
    in   n_User_ID          integer unsigned,

    out  s_Ret_User_Name    varchar(32),
    out  n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            t.user_name
        into
            s_Ret_User_Name
        from
            UMS_USER t
        where
            t.user_id   = n_User_ID and
            t.game_id   in
            (
                select
                    game_id
        		from
            		sys_slave_games
        		where
            		game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                	    select
                    	    ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            	)
        		union
        		select
            		n_Game_ID
            );
        if (FOUND_ROWS() = 0) then
            set n_Result = -1201;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
