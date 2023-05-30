DROP PROCEDURE createRole;
DROP PROCEDURE deleteRole;
DROP PROCEDURE resumeRole;
DROP PROCEDURE enterGameEx;
DROP PROCEDURE enterGameEx1;
DROP PROCEDURE leaveGame;
DROP PROCEDURE innerLeaveGame;
DROP PROCEDURE roleStateQuery;
DROP PROCEDURE renameRole;
DELIMITER $$

CREATE PROCEDURE createRole(
    in  n_Game_ID        integer,
    in  n_Gateway_ID     integer,
    in  n_Nationality_ID integer,
    in  n_User_ID        integer unsigned,
    in  s_Role_Name      varchar(32),
    in  n_Gender         integer,
    in  n_Occupation     integer,
    in  n_Initial_Level  integer,
    in  n_User_IP        integer unsigned,
    in  n_User_Port      integer,

    out n_Ret_Role_ID    integer,
    out n_Result         integer
)
BEGIN
    declare n_RetCode        integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Role_State     integer default  0; /* UMS_ROLE.role_state%TYPE */
    declare d_Role_Create_Time   datetime default  now();

    declare n_Ret_Gateway_ID     integer default  0; /* UMS_ROLE.gateway_id%TYPE */
    declare n_Ret_User_ID        integer; /* UMS_ROLE.user_id%TYPE */
    declare n_Tmp_AD_ID          bigint; /* UMS_ROLE.ad_id%type */
    declare n_Role_Existed       integer default  0;

    declare s_Tmp_Create_Role_Group    varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Mingle_Realm       varchar(32);
    declare n_Tmp_Game_ID         integer;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (n_Nationality_ID is null) or
            (n_User_ID       is null) or
            (s_Role_Name     is null) or
            (n_Gender        is null) or
            (
                (n_Gender <> 1) and      -- Male
                (n_Gender <> 2)          -- Female
            )                         or
            (n_Occupation    is null) or
            (n_Occupation    <  0   ) or
            (n_Initial_Level is null) or
            (n_Initial_Level <  0   )
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
        call getOptionValue(
                      n_Tmp_Game_ID,
                      'create_role_group',    /* PKG_OPTION.CREATE_ROLE_GROUP */
                      '1',    /* PKG_OPTION.R_OPENED */
                      s_Tmp_Create_Role_Group
                      );
        if (s_Tmp_Create_Role_Group       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Result = -2101; /* PKG_UTIL.E_DISABLE_ROLE_GROUP */
            leave label_proc;
        end if;

        -- We check whether gateway_id exists?
        call isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- We check whether user_id exists.
        select
            IFNULL(ad_id,0)
        into
            n_Tmp_AD_ID
        from
            UMS_USER
        where
            user_id = n_User_ID and
            game_id = n_Tmp_Game_ID;

        if (FOUND_ROWS() <> 1) then  /* NO_DATA_FOUND */
            set n_Result = -1406;    /* PKG_UTIL.E_USER_ACCOUNT_ERROR */
            leave label_proc;
        end if;

        select
            user_id,          role_id,
            gateway_id,       role_state
        into
            n_Ret_User_ID,    n_Ret_Role_ID,
            n_Ret_Gateway_ID, n_Tmp_Role_State
        from
            UMS_ROLE
        where
            role_name = lower(s_Role_Name) and
            game_id   = n_Tmp_Game_ID;

        if (FOUND_ROWS() = 1) then
            if (
                (n_Tmp_Role_State = 4) and    /* PKG_UTIL.DF_ROLE_STATE_VIRGIN */
                (n_Ret_Gateway_ID = n_Gateway_ID                 ) and
                (n_Ret_User_ID    = n_User_ID                    ) and
                (n_Tmp_Game_ID not in (7, 507)             )
            ) then
                set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
                leave label_proc;
            else
                set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
                leave label_proc;
            end if;
        end if;

        insert into UMS_ROLE(
            /* role_id,*/     user_id,          role_name,
            gateway_id,       nationality_id,   role_gender,
            role_occupation,  role_level,       role_state,
            create_time,      last_logout_time, total_online_second,
            login_id,         money1,           money2,
            experience,       ad_id,            game_id
        )
        values(
            /* n_Ret_Role_ID, */ n_User_ID,         lower(s_Role_Name),
            n_Gateway_ID,      n_Nationality_ID,  n_Gender,
            n_Occupation,      n_Initial_Level,   4,    /* PKG_UTIL.DF_ROLE_STATE_VIRGIN */
            d_Role_Create_Time,null,              0,
            0,                 0,                 0,
            0,                 n_Tmp_AD_ID,       n_Tmp_Game_ID
        );

        select LAST_INSERT_ID() into n_Ret_Role_ID;

        call logDailyFirstLogID(
            'UMS_ROLE',
            d_Role_Create_Time,
            n_Ret_Role_ID,
            n_RetCode
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    if (n_Ret_Role_ID is null) then
        set n_Ret_Role_ID = 0;
    end if;
END$$

CREATE PROCEDURE deleteRole(
    in  n_Game_ID        integer,
    in  n_User_ID        integer unsigned,
    in  n_Role_ID        integer,

    out n_Result         integer
)
BEGIN
    declare n_Role_State    integer default  0; /* UMS_ROLE.role_state%TYPE */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode        integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_Role_ID is null)
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

        select
            role_state
        into
            n_Role_State
        from
            UMS_ROLE
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Tmp_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        -- The role has been deleted.
        if (n_Role_State = 2) then    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        end if;

        update
            UMS_ROLE
        set
            role_state  = 2,      -- Deleted    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            delete_time = now()
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Tmp_Game_ID);

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE resumeRole(
    in  n_Game_ID        integer,
    in  n_User_ID        integer unsigned,
    in  n_Role_ID        integer,

    out n_Result         integer
)
BEGIN
    declare n_Role_State    integer default  0; /* UMS_ROLE.role_state%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_Role_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            role_state
        into
            n_Role_State
        from
            UMS_ROLE
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        -- The role state is normal.
        if (n_Role_State = 1) then    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */
            set n_Result = -1257;    /* PKG_UTIL.E_ROLE_STATE_NORMAL */
            leave label_proc;
        end if;

        update
            UMS_ROLE
        set
            role_state = 1,      -- 鎭㈠    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */
            delete_time = null
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Game_ID);

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE enterGameEx(
    in  n_Game_ID            integer,
    in  n_User_ID            integer,
    in  n_Role_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Server_ID          integer,
    in  n_Role_Level         integer,
    in  n_User_IP            integer unsigned,
    in  n_User_Port          integer,
    in  s_MAC                varchar(16),
    in  s_Province_Code      varchar(16),
    in  s_City_Code          varchar(16),
    in  s_Hardware_SN1       varchar(32),
    in  s_Hardware_SN2       varchar(32),
    in  n_Max_Balance_Count  integer,

    out n_Ret_Balance_Count  integer,
    out n_Ret_Balance_Type   integer,
    out n_Ret_Balance_Amount integer,
    out n_Result             integer
)
BEGIN
    call enterGameEx1(
        n_Game_ID,
        n_User_ID,
        n_Role_ID,
        n_Gateway_ID,
        n_Server_ID,
        n_Role_Level,
        n_User_IP,
        n_User_Port,
        s_MAC,
        s_Province_Code,
        s_City_Code,
        s_Hardware_SN1,
        s_Hardware_SN2,
        n_Max_Balance_Count,
        0,

        n_Ret_Balance_Count,
        n_Ret_Balance_Type,
        n_Ret_Balance_Amount,
        n_Result
    );
END$$

CREATE PROCEDURE enterGameEx1(
    in  n_Game_ID            integer,
    in  n_User_ID            integer,
    in  n_Role_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Server_ID          integer,
    in  n_Role_Level         integer,
    in  n_User_IP            integer unsigned,
    in  n_User_Port          integer,
    in  s_MAC                varchar(16),
    in  s_Province_Code      varchar(16),
    in  s_City_Code          varchar(16),
    in  s_Hardware_SN1       varchar(32),
    in  s_Hardware_SN2       varchar(32),
    in  n_Max_Balance_Count  integer,
    in  n_Client_Type        integer,

    out n_Ret_Balance_Count  integer,
    out n_Ret_Balance_Type   integer,
    out n_Ret_Balance_Amount integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode       integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_User_ID          integer unsigned; /* UMS_ROLE.user_id%TYPE */
    declare n_Tmp_Role_State       integer; /* UMS_ROLE.role_state%TYPE */
    declare n_Tmp_Enter_Time       datetime default  now();
    declare n_Tmp_Log_ID           integer; /* LOG_ROLE_FIRST_LOGIN.log_id%TYPE */
    declare n_Tmp_Login_ID         bigint; /* LOG_RECORD_DETAIL.login_id%TYPE */

    declare n_Tmp_Adult_Flag       integer default  1;
    declare n_Tmp_Remain_Seconds   integer default  3600 * 5;    /* PKG_UTIL.DF_MAX_VALUABLE_SECONDS */
    declare s_Role_GW_Check        varchar(32); /* SYS_OPTION.option_value%type */
    declare n_Last_Log_err         integer default  0;
    declare n_Last_Gateway_ID      integer default  0; /* LOG_RECORD_DETAIL.gateway_id%TYPE */
    declare n_Last_Server_ID       integer default  0; /* LOG_RECORD_DETAIL.server_id%TYPE */
    declare s_Last_Province_Code   varchar(16) default  'other';
    declare s_Last_City_Code       varchar(16) default  'other';
    declare s_Tmp_Mingle_Realm        varchar(32);
    declare n_Tmp_Game_ID          integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        -- Parameter Validation.
        if (
            (n_Game_ID           is null) or
            (n_Role_ID           is null) or
            (n_Gateway_ID        is null) or
            (n_Server_ID         is null) or
            (n_Role_Level        is null) or
            (n_User_IP           is null) or
            (n_User_Port         is null) or
            (s_Province_Code     is null) or
            (s_City_Code         is null) or
            (n_Client_Type       is null)
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
        -- check whether the MSG_ENTER_GAME is legal.
        call getOptionValue(
            n_Tmp_Game_ID,
            'role_gw_check',    /*PKG_OPTION.ROLE_GW_CHECK*/
            '1',    /* PKG_OPTION.R_OPENED */
            s_Role_GW_Check
            );
        if (s_Role_GW_Check = '1') then    /* PKG_OPTION.R_OPENED */
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                gateway_id = n_Gateway_ID and
                role_id    = n_Role_ID    and
                game_id    = n_Tmp_Game_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;
        else
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                role_id    = n_Role_ID and
                game_id    = n_Tmp_Game_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;

            -- 角色可能不在其本身的网关登录，需要检测目标网关是否存在
            -- n_RetCode *= PKG_GATEWAY.isGatewayIDExisted(n_Gateway_ID)
            call isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
            if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        set n_Ret_Balance_Count = 0;

        -- check whether the role has been deleted.
        if (n_Tmp_Role_State = 2) then    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        -- check whether first login.
        elseif (n_Tmp_Role_State = 4) then    /* PKG_UTIL.DF_ROLE_STATE_VIRGIN */
            call logRoleFirstLogin(
                n_Tmp_Game_ID,
                n_Role_ID,
                n_Tmp_User_ID,
                n_Gateway_ID,
                n_Tmp_Enter_Time,
                n_User_IP,
                s_Province_Code,
                s_City_Code,
                s_MAC,
                n_Client_Type,
                n_RetCode
            );
            -- if log recorded, update role_state to `normal'.
            if (n_RetCode = 1) then    /* PKG_UTIL.S_SUCCESS */
                update
                    UMS_ROLE
                set
                    role_state = 1    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */
                where
                    role_id = n_Role_ID;
                -- ignore (ROW_COUNT() = 0) situation.
            end if;
        end if;

        -- Do inner leaveGame.
        if (n_Tmp_Login_ID > 0) then
            update
                LOG_RECORD_DETAIL
            set
                logout_time = n_Tmp_Enter_Time,
                role_level  = n_Role_Level,
                money1      = 0,
                money2      = 0,
                experience  = 0
            where
                login_id = n_Tmp_Login_ID;

            select
                gateway_id,             server_id,
                province_code,          city_code
            into
                n_Last_Gateway_ID,      n_Last_Server_ID,
                s_Last_Province_Code,   s_Last_City_Code
            from
                LOG_RECORD_DETAIL
            where
                login_id = n_Tmp_Login_ID;

            -- set login_id to zero.
            set n_Tmp_Login_ID = 0;
            set n_Last_Log_err = 1;
        end if;

        -- calculate indulgence time.
        call onEnter(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Tmp_Adult_Flag,
            n_Tmp_Remain_Seconds,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Tmp_Adult_Flag = 0) then
            set n_Ret_Balance_Type = 100; -- 100    /* PKG_UTIL.DF_SUBJECT_ID_VALUABLE_TIME */
            set n_Ret_Balance_Amount = n_Tmp_Remain_Seconds;
            set n_Ret_Balance_Count = 1;
        end if;

        call logLoginEx(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Role_ID,
            n_Gateway_ID,
            n_Server_ID,
            n_Role_Level,
            n_Tmp_Enter_Time,
            n_User_IP,
            n_User_Port,
            s_MAC,
            s_Province_Code,
            s_City_Code,
            s_Hardware_SN1,
            s_Hardware_SN2,
            n_Client_Type,

            n_Tmp_Login_ID, -- out
            n_RetCode
        );

        if (n_Tmp_Login_ID is null) then
            set n_Tmp_Login_ID = 0;
        end if;

        -- update log_id record.
        update
            UMS_ROLE
        set
            login_id = n_Tmp_Login_ID
        where
            role_id = n_Role_ID and
            game_id = n_Tmp_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE leaveGame(
    in  n_Game_ID            integer,
    in  n_User_ID            integer,
    in  n_Role_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Logout_Flag        integer,
    in  n_Role_Level         integer,
    in  n_Community_ID       integer,
    in  n_Occupation         integer,
    in  n_Money1             integer,
    in  n_Money2             integer,
    in  n_Experience         integer,
    in  n_Max_Balance_Count  integer,

    out n_Ret_Balance_Count  integer,
    out n_Ret_Balance_Type   integer,
    out n_Ret_Balance_Amount integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Adult_Flag     integer default  0;
    declare n_Tmp_Remain_Seconds integer default  3600 * 5;    /* PKG_UTIL.DF_MAX_VALUABLE_SECONDS */

    declare n_Tmp_User_ID        integer unsigned; /* UMS_ROLE.user_id%TYPE */
    declare n_Tmp_Role_State     integer; /* UMS_ROLE.role_state%TYPE */
    declare n_Tmp_Login_ID       bigint;  /* UMS_ROLE.login_id%TYPE */
    declare n_Tmp_Server_ID      integer; /* LOG_RECORD_DETAIL.server_id%TYPE */
    declare n_Tmp_Online_Second  integer default  0; /* UMS_ROLE.total_online_second%TYPE */

    declare n_Tmp_User_IP        integer unsigned; /* LOG_RECORD_DETAIL.login_ip%TYPE */
    declare s_Tmp_Province_Code  varchar(16) default  'other'; /* LOG_RECORD_DETAIL.province_code%TYPE */
    declare s_Tmp_City_Code      varchar(16) default  'other'; /* LOG_RECORD_DETAIL.city_code%TYPE */

    declare d_Tmp_Leave_Time     datetime  default now();
    declare s_Role_GW_Check      varchar(32);
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        -- Parameters validation.
        if (
            (n_Game_ID     is null) or
            (n_Role_ID     is null) or
            (n_Logout_Flag is null) or
            ( n_Logout_Flag not in (1,2,3) ) or -- 1-normal, 2-payment, 3-abnormal.
            (n_Role_Level  is null) or
            (n_Occupation  is null) or
            (n_Money1      is null) or
            (n_Money2      is null) or
            (n_Experience  is null)
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
        set n_Ret_Balance_Count = 0;
        -- check whether the MSG_LEAVE_GAME is legal.
        call getOptionValue(
            n_Tmp_Game_ID,
            'role_gw_check',    /* PKG_OPTION.ROLE_GW_CHECK */
            '1',    /* PKG_OPTION.R_OPENED */
            s_Role_GW_Check
        );
        if (s_Role_GW_Check = '1') then    /* PKG_OPTION.R_OPENED */
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                gateway_id = n_Gateway_ID and
                role_id    = n_Role_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;
        else
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                role_id    = n_Role_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;

            -- 角色可能不在其本身的网关登录，需要检测目标网关是否存在
            -- n_RetCode = PKG_GATEWAY.isGatewayIDExisted(n_Gateway_ID)
            call isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
            if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        -- check whether the role has been deleted.
        if (n_Tmp_Role_State = 2) then    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        end if;

        -- calculate indulgence time.
        call onLeave(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Logout_Flag,
            n_Tmp_Adult_Flag,
            n_Tmp_Remain_Seconds,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Tmp_Adult_Flag = 0) then
            set n_Ret_Balance_Type = 100; -- 100    /* PKG_UTIL.DF_SUBJECT_ID_VALUABLE_TIME */
            set n_Ret_Balance_Amount = n_Tmp_Remain_Seconds;
            set n_Ret_Balance_Count = 1;
        end if;

        if (n_Logout_Flag = 2) then
            -- update role's attributes.
            update
                UMS_ROLE
            set
                role_level          = n_Role_Level,
                nationality_id      = n_Community_ID,
                role_occupation     = n_Occupation,
                money1              = n_Money1,
                money2              = n_Money2,
                experience          = n_Experience
            where
                role_id = n_Role_ID and
                game_id = n_Tmp_Game_ID;
        elseif ( n_Logout_Flag in (1,3) ) then
            if (n_Tmp_Login_ID = 0) then
                -- if not find loginId, so can't update, insert a new record.
                call logLogoutAbnormal(
                    n_Tmp_Game_ID,
                    n_Gateway_ID,
                    n_Tmp_User_ID,
                    n_Role_ID,
                    n_Role_Level,
                    n_Money1,
                    n_Money2,
                    n_Experience,
                    n_RetCode
                );
            else
                -- We must record logout information in LOG_RECORD_DETAIL.
                call logLogout(
                    n_Tmp_Login_ID,
                    n_Role_Level,
                    n_Money1,
                    n_Money2,
                    n_Experience,
                    n_Tmp_Server_ID,
                    n_Tmp_Online_Second,
                    n_Tmp_User_IP,
                    s_Tmp_Province_Code,
                    s_Tmp_City_Code,
                    n_RetCode
                );
            end if;

            if (n_Logout_Flag <> 3) then
                -- update role's rich attributes.
                update
                    UMS_ROLE
                set
                    role_level          = n_Role_Level,
                    nationality_id      = n_Community_ID,
                    role_occupation     = n_Occupation,
                    login_id            = 0,
                    last_logout_time    = d_Tmp_Leave_Time,
                    total_online_second = total_online_second + n_Tmp_Online_Second,
                    money1              = n_Money1,
                    money2              = n_Money2,
                    experience          = n_Experience
                where
                    role_id = n_Role_ID and
                    game_id = n_Tmp_Game_ID;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- call this CREATE PROCEDURE while role is still online at enterGame.
CREATE PROCEDURE innerLeaveGame(
    in  n_Game_ID           integer,
    in  n_Role_ID           integer,
    in  n_Gateway_ID        integer,
    in  n_Role_Level        integer,
    in  n_Login_ID          integer,

    out n_Result            integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Online_Second  integer default  0;  /* UMS_ROLE.total_online_second%TYPE */
    declare n_Tmp_Server_ID      integer default  0; /* LOG_RECORD_DETAIL.server_id%TYPE */
    declare n_Tmp_User_IP        integer unsigned default  0; /* LOG_RECORD_DETAIL.login_ip%TYPE */
    declare s_Tmp_Province_Code  varchar(16) default  'other'; /* LOG_RECORD_DETAIL.province_code%TYPE */
    declare s_Tmp_City_Code      varchar(16) default  'other'; /* LOG_RECORD_DETAIL.city_code%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID     is null) or
            (n_Role_ID     is null) or
            (n_Role_Level  is null) or
            (n_Login_ID    is null) or
            (n_Login_ID    <= 0   )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- update to offline status.
        update
            UMS_ROLE
        set
            login_id = 0
        where
            role_id = n_Role_ID and
            game_id = n_Game_ID;
        -- ignore ROW_COUNT() = 0.

        -- record LOG_RECORD_DETAIL
        call logLogout(
            n_Login_ID,
            n_Role_Level,
            0, -- money1
            0, -- money2
            0, -- exp
            n_Tmp_Server_ID,
            n_Tmp_Online_Second,
            n_Tmp_User_IP,
            s_Tmp_Province_Code,
            s_Tmp_City_Code,
            n_RetCode
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- @Purpose: just judge whether n_Role_Name is already exists at present.
CREATE PROCEDURE roleStateQuery(
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_User_ID          integer unsigned,
    in  n_Role_Name        varchar(32),

    out n_Ret_Role_State   integer,
    out n_Result           integer
)
BEGIN
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID        is null) or
            (n_Gateway_ID     is null) or
--            (n_User_ID        is null) or
            (n_Role_Name      is null)
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

        select
            role_state
        into
            n_Ret_Role_State
        from
            UMS_ROLE
        where
            role_name  = lower(n_Role_Name) and
            game_id    = n_Tmp_Game_ID;
        if (FOUND_ROWS() <> 1) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE renameRole(
    in  n_Game_ID         integer,
    in  n_User_ID         integer,
    in  n_Role_ID         integer,
    in  s_Role_Name       varchar(32),

    out n_Result          integer
)
BEGIN
    declare s_Old_Role_Name         varchar(32); /* UMS_ROLE.role_name%TYPE */
    declare s_Tmp_Role_Name         varchar(32); /* UMS_ROLE.role_name%TYPE */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID         is null) or
            (n_Role_ID         is null) or
            (s_Role_Name       is null)
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

        set s_Tmp_Role_Name = lower(s_Role_Name);
        select
            role_name
        into
            s_Old_Role_Name
        from
            UMS_ROLE t
        where
            (t.role_id = n_Role_ID)       and
            (t.role_state in (1, 4)) and    /* PKG_UTIL.DF_ROLE_STATE_NORMAL , PKG_UTIL.DF_ROLE_STATE_VIRGIN */
            (t.game_id = n_Tmp_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        if (s_Tmp_Role_Name = s_Old_Role_Name) then
            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        update
            UMS_ROLE t
        set
            t.role_name = s_Tmp_Role_Name
        where
            t.role_id    = n_Role_ID and
            t.game_id    = n_Tmp_Game_ID;

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
