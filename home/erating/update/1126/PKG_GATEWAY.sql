DROP PROCEDURE addGame;
DROP PROCEDURE changeGameName;
DROP PROCEDURE getGatewayID;
DROP PROCEDURE getUniteGateway;
DROP PROCEDURE getGatewayState;
DROP PROCEDURE isGatewayIDExisted;
DROP PROCEDURE initGatewayState;
DROP PROCEDURE bind;
DROP PROCEDURE unbind;
DROP PROCEDURE getConnectID;
DROP PROCEDURE GWDataReport;
DROP PROCEDURE GWState;
DROP PROCEDURE gwLeaveGame;
DELIMITER $$

CREATE PROCEDURE addGame(
    in  n_Game_ID       integer,
    in  s_Game_Name     varchar(20),

    out n_Result        integer
)
BEGIN
    lable_proc:begin
        declare exit handler for 1062 set n_Result = -1121;/*Can't write, because of unique constraint*/
        set n_Result = 0;/*E_ERROR*/
        if (
                (n_Game_ID      is null) or
                (s_Game_Name      is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into SYS_GAME_ID(
            game_id,       game_name
        )
        values(
            n_Game_ID,     s_Game_Name
        );

        insert into SYS_GATEWAY (
            game_id,            gateway_id,          zone_id,
            gateway_code,       gateway_password,    gateway_name,
            gateway_ip,         gateway_mac,         gateway_state
        ) values (
            n_Game_ID,          0,                   0,
            'sys_gateway',      '0',                 'System Gateway',
            2130706433,         '00-00-00-00-00-00', 1
        );
        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE changeGameName(
    in  n_Game_ID            integer,
    in  s_Game_Name          varchar(20),

    out n_Result             integer
)
BEGIN
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Game_ID   is null) or
            (s_Game_Name is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        update
            SYS_GAME_ID
        set
            game_name = s_Game_Name
        where
            game_id = n_Game_ID;
        if (ROW_COUNT() = 0) then
            set n_Result = -1122;/*E_GAME_ID_NOT_EXIST*/
            leave lable_proc;
        end if;

        set n_Result = 1/*S_SUCCESS*/;
    end lable_proc;
END$$

CREATE PROCEDURE getGatewayID(
    in  n_Game_ID        integer,
    in  s_Gateway_Code   varchar(20),

    out n_Ret_Gateway_ID integer,
    out n_Result         integer
)
BEGIN
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        -- Paramters validation.
        if (
            (s_Gateway_Code is null) or
            (n_Game_ID      is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        -- Query gateway info from SYS_GATEWAY...
        select
            gateway_id
        into
            n_Ret_Gateway_ID
        from
            SYS_GATEWAY
        where
            gateway_code = s_Gateway_Code and
            game_id      = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;/*E_GATEWAY_NOT_FOUND*/
            leave lable_proc;
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE getUniteGateway(
   in  n_Game_ID           integer,
   in  n_Gateway_ID        integer,

   out n_Ret_Gateway_ID    integer,
   out n_Result            integer
)
BEGIN
    lable_proc:begin
        if (
            (n_Game_ID      is null) or
            (n_Gateway_ID   is null)
        ) then
            set n_Result=-100;
            leave lable_proc;
        end if;

        select
            dest_gateway_id
        into
            n_Ret_Gateway_ID
        from
            SYS_GATEWAY_UNITE
        where
            game_id = n_Game_ID and
            src_gateway_id = n_Gateway_ID;
        if (n_Ret_Gateway_ID is null) then
            set n_Ret_Gateway_ID = n_Gateway_ID;
        end if;
        set n_Result = 1;
    end lable_proc;
END $$

CREATE PROCEDURE getGatewayState(
   in  n_Game_ID           integer,
   in  n_Gateway_ID        integer,

   out n_Ret_Gateway_State integer,
   out n_Result            integer
)
BEGIN
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Gateway_ID is null) or
            (n_Game_ID    is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
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
        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;/*E_GATEWAY_NOT_FOUND*/
            leave lable_proc;
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE isGatewayIDExisted(
    in    n_Game_ID    integer,
    in    n_Gateway_ID integer,

    out   n_Result     integer
)
BEGIN
    declare    n_Ret_Gateway_ID integer default 0;
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
    -- Parameters validation.
        if (
            (n_Gateway_ID is null) or
            (n_Game_ID    is null)
        ) then
            set n_Result = -100;/*PKG_UTIL.E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        select
            gateway_id
        into
            n_Ret_Gateway_ID
        from
            SYS_GATEWAY
        where
            gateway_id = n_Gateway_ID and
            game_id    = n_Game_ID;

        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;/*PKG_UTIL.E_GATEWAY_NOT_FOUND*/
            leave lable_proc;
        end if;

        set n_Result = 1;/*PKG_UTIL.S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE initGatewayState(
    in    n_Game_ID             integer,
    in    n_Gateway_ID          integer,

    out   n_Result              integer
)
BEGIN
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Gateway_ID is null) or
            (n_Game_ID    is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into SYS_GATEWAY_STATE
            (gateway_id, last_active_time, last_logout_time, connect_id, game_id)
        values
            (n_Gateway_ID, now(), null, 0, n_Game_ID);

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

/*
comment: Record and validation when gateway login..
param:
    str_Gateway_Code: Unique gateway code.
    str_Password    : Password of login.
    n_IP_Address    : Decimal IP Address.
    str_MAC         : MAC Address of gateway. Format: XX-XX-XX-XX-XX-XX
    n_Reconnect_Flag: Set to 1 if gateway reconnects to eRating-Server.

    n_Ret_Zone_ID   : Returned logic zone id gateway belongs to.
    n_Ret_Gateway_ID: Returned cooresponding unique ID of gateway.
returning:
    S_SUCCESS if operation successful.
Remark:
    In normal situation, if n_Reconnect_Flag is 1, we just do binding with
the given gateway, and remain player state untouched.
    But when Paramter n_Reconnect_Flag is 0, we can determine that the
given gateway is logining firstly or reconnecting timeout. At the moment,
we must logout all players registered on this gateway by force..
    In this function, we haven't realize the player-logout operation temporarily.
*/
CREATE PROCEDURE bind(
    in    n_Game_ID            integer,
    in    str_Gateway_Code     varchar(32),
    in    str_Password         varchar(32),
    in    n_IP_Address         integer unsigned,
    in    str_MAC              varchar(18),
    in    n_ReconnectFlag      integer,

    out   n_Ret_Zone_ID        integer,
    out   n_Ret_Gateway_ID     integer,
    out   n_Result             integer
)
BEGIN
    -- locale varibies
    declare n_RetCode            integer;
    declare n_Ret_Connect_ID     integer;
    declare n_Ret_Gateway_State  tinyint;
    lable_proc:begin
        set n_RetCode = 0;/*E_ERROR*/
        set n_Result = 0;
        if (
            (n_Game_ID is null) or
            (str_Gateway_Code is null) or
            (str_Password is null) or
            -- (n_IP_Address is null) or
            -- (str_MAC is null) or
            (n_ReconnectFlag is null) or
            (
                (n_ReconnectFlag <> 0) and
                (n_ReconnectFlag <> 1)
            )
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        -- 1. To verify gateway if it exists...
        select
            gateway_id,       zone_id,       gateway_state
        into
            n_Ret_Gateway_ID, n_Ret_Zone_ID, n_Ret_Gateway_State
        from
            SYS_GATEWAY
        where
            (gateway_code = str_Gateway_Code) and
            (gateway_password = str_Password) and
            (game_id = n_Game_ID);
            -- and (gateway_ip = n_IP_Address)
            -- and (gateway_mac = str_MAC);
        if (FOUND_ROWS() = 0) then
            set n_Result = -1002;/*E_GATEWAY_UID_PWD_ERROR*/
            leave lable_proc;
        end if;

        if (
            (n_Ret_Gateway_State <> 0) and
            (n_Ret_Gateway_State <> 1) and
            (n_Ret_Gateway_State <> 3) and
            (n_Ret_Gateway_State <> 4)
        ) then
            set n_Result = -1010;/*E_GATEWAY_STATE_ERROR*/
            leave lable_proc;
        end if;
        -- 2. Query current state of this gateway. Offile/Online/Other.
        loop_bind:loop
            select
                CONNECT_ID
            into
                n_Ret_Connect_ID
            from
                SYS_GATEWAY_STATE
            where
                gateway_id = n_Ret_Gateway_ID and
                game_id    = n_Game_ID;

            if (FOUND_ROWS() = 0) then
                call initGatewayState(n_Game_ID, n_Ret_Gateway_ID, n_RetCode);

                if (n_RetCode <> 1/*S_SUCCESS*/) then
                    set n_Result = n_RetCode;
                    leave lable_proc;
                end if;
            end if;

            if (n_Ret_Connect_ID is not null) then
                leave loop_bind;
            end if;
        end loop loop_bind;

        -- add connect_id directly.
        if (n_ReconnectFlag = 0) then
            update
                SYS_GATEWAY_STATE
            set
                connect_id = n_Ret_Connect_ID + 1 -- Online.
            where
                gateway_id = n_Ret_Gateway_ID and
                game_id    = n_Game_ID;

        end if;
        -- If gateway is already online, do nothing.

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
    if (n_Ret_Zone_ID is null) then
        set n_Ret_Zone_ID = 0;
    end if;
    if (n_Ret_Gateway_ID is null) then
        set n_Ret_Gateway_ID = 0;
    end if;
END$$

/*
comment: Unbind a gateway which is online.
param:
    n_Gateway_ID: Unique ID of gateway.
returning:
    S_SUCCESS if operation successful.
*/
CREATE PROCEDURE unbind(
    in    n_Game_ID            integer,
    in    n_Gateway_ID         integer,

    out   n_Ret_Connect_ID     integer,
    out   n_Result             integer
)
BEGIN
    declare n_RetCode          integer;
    declare n_ConnectID        integer;
    lable_proc:begin
        set n_ConnectID = 0;
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        -- Paramters validation.
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        --  retrieve current state of this gateway.
        select
            connect_id
        into
            n_ConnectID
        from
            SYS_GATEWAY_STATE
        where
            gateway_id = n_Gateway_ID and
            game_id    = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Ret_Connect_ID = n_ConnectID;
            set n_Result = -1001;/*E_GATEWAY_NOT_FOUND*/
            leave lable_proc;
        end if;

        -- If gateway is not online, returning error.
        if (n_ConnectID = 0) then
        -- Offline
            set n_Result         = -1012;/*E_GATEWAY_STATE_IS_OFFLINE*/
            set n_Ret_Connect_ID = n_ConnectID;
            leave lable_proc;
        end if;
        if (n_ConnectID >= 1) then
            -- connect_id minus 1
            update
                SYS_GATEWAY_STATE
            set
                connect_id = n_ConnectID - 1
            where
                gateway_id = n_Gateway_ID and
                game_id    = n_Game_ID;

            set n_ConnectID      = n_ConnectID - 1;
            set n_Ret_Connect_ID = n_ConnectID;
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

/*
comment: get Connection Count..
param:
  str_Gateway_Code: Unique Code of gateway.
returning:
  n_Ret_Connect_ID: Connection Count
  S_SUCCESS if operation successful.
*/
CREATE PROCEDURE getConnectID(
    in    n_Game_ID         integer,
    in    str_Gateway_Code  varchar(32),

    out   n_Ret_Connect_ID  integer,
    out   n_Result          integer
)
BEGIN
    declare  n_RetCode      integer;
    declare  n_ConnectCount integer;
    declare  n_Gateway_ID   integer;
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        set n_ConnectCount = 0;
        set n_Gateway_ID = 0;
        -- check parameters validation
        if (
            (str_Gateway_Code is null) or
            (n_Game_ID        is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        call getGatewayID(n_Game_ID, str_Gateway_Code, n_Gateway_ID, n_RetCode);

        if (n_RetCode <> 1/*S_SUCCESS*/) then
            set n_Result = n_RetCode;
            set n_Ret_Connect_ID = n_ConnectCount;
            leave lable_proc;
        end if;
        -- select the number
        select
            connect_id
        into
            n_ConnectCount
        from
            SYS_GATEWAY_STATE
        where
            gateway_id = n_Gateway_ID and
            game_id    = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;/*E_GATEWAY_NOT_FOUND*/
            set n_Ret_Connect_ID = n_ConnectCount;
            leave lable_proc;
        end if;

        set n_Ret_Connect_ID = n_ConnectCount;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

-- 由于没有数组,GWDataReport改为一次调用传入一次data_type与data_value,循环控制放入c++
CREATE PROCEDURE GWDataReport(
    in    n_Game_ID            integer,
    in    n_Gateway_ID         integer,
    in    n_Server_ID          integer,
    in    n_Data_Count         integer,
    in    n_Data_Type          integer,
    in    n_Data_Value         integer,

    out   n_Result             integer
)
BEGIN
    declare n_RetCode  integer;
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        if (
            (n_Game_ID    is null) or
            (n_Gateway_ID is null) or
            (n_Server_ID  is null) or
            (n_Data_Count is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        if (n_Data_Type = 1) then -- Online-Count
            call logOnlineCount(
                n_Game_ID,
                n_Gateway_ID,
                n_Server_ID,
                n_Data_Value,
                n_RetCode
            );
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE GWState(
    in    n_Game_ID            integer,
    in    n_Gateway_ID         integer,

    out   n_Result             integer
)
BEGIN
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Game_ID    is null) or
            (n_Gateway_ID is null)
        ) then
            set n_Result = -100; /*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        begin
            select
                gateway_state
            into
                n_Result
            from
                SYS_GATEWAY
            where
                gateway_id = n_Gateway_ID and
                game_id    = n_Game_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1001;/*E_GATEWAY_NOT_FOUND*/
                leave lable_proc;
            end if;
        end;
    end lable_proc;
END$$

-- gwLeaveGame 改为在调用bind之后调用,在函数里判断option
CREATE PROCEDURE gwLeaveGame(
    in    n_Game_ID           integer,
    in    n_Gateway_ID        integer,
    in    n_Leave_flag        integer, -- 1 - normal, 2 - only clear login_id.

    out   n_Result            integer
)
BEGIN
    declare d_Tmp_Current_Time datetime;
    declare s_Gw_Leave_Game varchar(32);
    declare n_Tmp_Role_ID integer;
    declare n_Tmp_Login_ID integer;
    declare n_Break_Flag           integer;         /* 用于跳出 loop */
    declare curOnlineRole cursor for
        select
            role_id, login_id
        from
            UMS_ROLE
        where
            gateway_id = n_Gateway_ID and
            login_id   > 0       and
            role_state = 1       and
            game_id    = n_Game_ID;
    declare continue handler for not found set n_Break_Flag = 1;
    lable_proc:begin
        set d_Tmp_Current_Time = now();
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Game_ID    is null) or
            (n_Gateway_ID is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'gw_leave_game',/*PKG_OPTION.GW_LEAVE_GAME*/
            '1',/*PKG_OPTION.R_OPENED*/
            s_Gw_Leave_Game
        );
        if (s_Gw_Leave_Game <> '1'/*PKG_OPTION.R_OPENED*/) then
            set n_Result = 1;/*S_SUCCESS*/
            leave lable_proc;
        end if;

        set n_Break_Flag = 0;
        open curOnlineRole;
        label_curOnlineRole:loop
            fetch curOnlineRole into n_Tmp_Role_ID, n_Tmp_Login_ID;
            if (n_Break_Flag = 1) then
                leave label_curOnlineRole;
            end if;

            if (n_Leave_flag = 1) then
                update
                    LOG_RECORD_DETAIL
                set
                    logout_time = d_Tmp_Current_Time,
                    role_level  = 0,
                    money1      = 0,
                    money2      = 0,
                    experience  = 0
                where
                    login_id = n_Tmp_Login_ID;
            end if;

            update
                UMS_ROLE
            set
                login_id = 0
            where
                role_id = n_Tmp_Role_ID and
                game_id = n_Game_ID;
        end loop label_curOnlineRole;
        close curOnlineRole;

        update
            LOG_RT_USER_ONLINE_COUNT t
        set
            t.user_online_count = 0
        where
            t.gateway_id = n_Gateway_ID and
            t.game_id    = n_Game_ID;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

DELIMITER ;
