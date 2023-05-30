DROP PROCEDURE isExistZoneID;
DROP PROCEDURE getGatewayCharge;
DROP PROCEDURE getGatewayPay;
DROP PROCEDURE getZoneInfo;
DROP PROCEDURE getZoneName;
DROP PROCEDURE addGatewayInfo;
DROP PROCEDURE getGatewayInfo;
DROP PROCEDURE getGatewayDetail;
DROP PROCEDURE getGatewayResultByName;
DROP PROCEDURE modifyGatewayInfo;
DROP PROCEDURE modifyGatewayName;
DROP PROCEDURE disableGatewayInfo;
DROP PROCEDURE enableGatewayInfo;
DROP PROCEDURE addGatewaySetting;
DROP PROCEDURE getGatewaySetting;
DROP PROCEDURE getGatewaySettingByType;
DROP PROCEDURE modifyGatewaySetting;
DROP PROCEDURE disableGatewaySetting;
DROP PROCEDURE enableGatewaySetting;

DELIMITER $$

-- 检测zond_id有效性
CREATE PROCEDURE isExistZoneID (
    in    n_Zone_ID             integer,

    out   n_Result              integer
)
BEGIN
    declare    n_Zone_ID_Tmp   integer;
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_Zone_ID         is  null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        select   zone_id
        into     n_Zone_ID_Tmp
        from     SYS_ZONE
        where    zone_id      = n_Zone_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1101;/*E_ZONE_NOT_FOUND*/
            leave lable_proc;
        end if;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

-- 充值推送
CREATE PROCEDURE getGatewayCharge (
    in  n_Game_ID          integer,           -- 2
    in  n_Is_First         integer,           -- 3

    out n_Result           integer
)
BEGIN
    declare n_Tmp_Gateway_ID       integer;
    declare n_Tmp_Item_State       integer;
    declare n_Break_Flag           integer;         /* 用于跳出 loop */
    declare cur_First_Call cursor for
        select gateway_id, state
        from   SYS_GATEWAY_SETTING
        where  state            in (
               1,/*ITEM_STATE_NORMAL*/
               2,/*ITEM_STATE_ADD*/
               3/*ITEM_STATE_MODIFY*/
        )
        and    gateway_type     = 3  /*ITEM_TYPE_CHARGE 充值推送*/
        and    game_id          = n_Game_ID;

    declare cur_Not_First_Call cursor for
        select gateway_id, state
        from   SYS_GATEWAY_SETTING
        where  state            in (
               2, /*ITEM_STATE_ADD*/
               3, /*ITEM_STATE_MODIFY*/
               4  /*ITEM_STATE_DISABLE*/
        )
        and    gateway_type     = 3 /*ITEM_TYPE_CHARGE 充值推送*/
        and    game_id          = n_Game_ID;
    declare continue handler for not found set n_Break_Flag = 1;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- 首次调用
        if (n_Is_First = 1) then
            -- 首次调用，以状态2读取状态1,2,3的配置项
            select c.gateway_id,      c.gateway_code,     c.gateway_password,
                   c.gateway_ip,      c.gateway_port,
                   g.gateway_name,    g.gateway_mac,      g.zone_id,
                   c.gateway_type,    2 /*ITEM_STATE_ADD*/
            from   SYS_GATEWAY_SETTING c, SYS_GATEWAY g
            where  c.gateway_id       = g.gateway_id   and
                   c.state            in (
                       1, /*ITEM_STATE_NORMAL*/
                       2, /*ITEM_STATE_ADD*/
                       3  /*ITEM_STATE_MODIFY*/
            )
            and    c.gateway_type     = 3  /*ITEM_TYPE_CHARGE 充值推送*/
            and    c.game_id          = g.game_id
            and    g.game_id          = n_Game_ID
            for update;                -- 锁记录

            set n_Break_Flag = 0;
            open cur_First_Call;
            label_cur_first_call:loop
                fetch cur_First_Call into n_Tmp_Gateway_ID, n_Tmp_Item_State;
                if (n_Break_Flag = 1) then
                    leave label_cur_first_call;
                end if;

                if (n_Tmp_Item_State = 4 /*ITEM_STATE_DISABLE*/)
                then
                    -- 修改状态4修改为5
                    update SYS_GATEWAY_SETTING
                    set    state            = 5 /*ITEM_STATE_INVALID*/
                    where  state            = 4 /*ITEM_STATE_DISABLE*/
                    and    gateway_type     = 3 /*ITEM_TYPE_CHARGE 充值推送*/
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                elseif (n_Tmp_Item_State in (
                              2, /*ITEM_STATE_ADD*/
                              3  /*ITEM_STATE_MODIFY*/
                          )
                )
                then
                    -- 修改状态2、3修改为1
                    update SYS_GATEWAY_SETTING
                    set    state            = 1 /*ITEM_STATE_NORMAL*/
                    where  state            in (
                             2, /*ITEM_STATE_ADD*/
                             3  /*ITEM_STATE_MODIFY*/
                    )
                    and    gateway_type     = 3 /*ITEM_TYPE_CHARGE 充值推送*/
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                end if;
            end loop label_cur_first_call;
            close cur_First_Call;
        else
            -- 非首次调用，获取2,3,4的配置
            select  c.gateway_id,      c.gateway_code,     c.gateway_password,
                    c.gateway_ip,      c.gateway_port,
                    g.gateway_name,    g.gateway_mac,      g.zone_id,
                    c.gateway_type,    c.state
            from    SYS_GATEWAY_SETTING c, SYS_GATEWAY g
            where   c.gateway_id       = g.gateway_id   and
                    c.state            in (
                        2, /*ITEM_STATE_ADD*/
                        3, /*ITEM_STATE_MODIFY*/
                        4  /*ITEM_STATE_DISABLE*/
                    )
            and     c.gateway_type     = 3 /* ITEM_TYPE_CHARGE 充值推送 */
            and     c.game_id          = g.game_id
            and     g.game_id          = n_Game_ID
            for update;                -- 锁记录

            set n_Break_Flag = 0;
            open cur_Not_First_Call;
            label_cur_not_first_call:loop
                fetch cur_Not_First_Call into n_Tmp_Gateway_ID, n_Tmp_Item_State;
                if (n_Break_Flag = 1) then
                    leave label_cur_not_first_call;
                end if;

                if (n_Tmp_Item_State = 4 /*ITEM_STATE_DISABLE*/)
                then
                    -- 修改状态4修改为5
                    update SYS_GATEWAY_SETTING
                    set    state            = 5 /*ITEM_STATE_INVALID*/
                    where  state            = 4 /*ITEM_STATE_DISABLE*/
                    and    gateway_type     = 3 /*ITEM_TYPE_CHARGE 充值推送*/
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                elseif (n_Tmp_Item_State in (
                              2, /*ITEM_STATE_ADD*/
                              3  /*ITEM_STATE_MODIFY*/
                          )
                )
                then
                    -- 修改状态2、3修改为1
                    update SYS_GATEWAY_SETTING
                    set    state            = 1 /*ITEM_STATE_NORMAL*/
                    where  state            in (
                             2, /*ITEM_STATE_ADD*/
                             3  /*ITEM_STATE_MODIFY*/
                    )
                    and    gateway_type     = 3 /*ITEM_TYPE_CHARGE 充值推送*/
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                end if;
            end loop label_cur_not_first_call;
            close cur_Not_First_Call;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 消费对账+元宝流通
CREATE PROCEDURE getGatewayPay (
    in  n_Game_ID             integer,
    in  n_Is_First            integer,
    out n_Result              integer
)
BEGIN
    declare n_Tmp_Gateway_ID       integer;
    declare n_Tmp_Item_State       integer;
    declare n_Break_Flag           integer;         /* 用于跳出 loop */
    declare cur_First_Call cursor for
        select gateway_id, state
        from   SYS_GATEWAY_SETTING
        where  state            in (
               1, /*ITEM_STATE_NORMAL*/
               2, /*ITEM_STATE_ADD*/
               3  /*ITEM_STATE_MODIFY*/
        )
        and    gateway_type     in (
               1, /*ITEM_TYPE_PAY*/
               2  /*ITEM_TYPE_CASH_EXCHANGE*/
        )
        and    game_id          = n_Game_ID;

    declare cur_Not_First_Call cursor for
        select  gateway_id, state
        from    SYS_GATEWAY_SETTING
        where   state            in (
                2, /*ITEM_STATE_ADD*/
                3, /*ITEM_STATE_MODIFY*/
                4  /*ITEM_STATE_DISABLE*/
        )
        and     gateway_type     in (
                1, /*ITEM_TYPE_PAY*/
                2  /*ITEM_TYPE_CASH_EXCHANGE*/
        )
        and game_id          = n_Game_ID;
    declare continue handler for not found set n_Break_Flag = 1;

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- 首次调用
        if (n_Is_First = 1) then
            -- 首次调用，以状态2读取状态1,2,3的配置项
            select  c.gateway_id,      c.gateway_code,     c.gateway_password,
                    c.gateway_ip,      c.gateway_port,
                    g.gateway_name,    g.gateway_mac,      g.zone_id,
                    c.gateway_type,    2 /*ITEM_STATE_ADD*/
            from    SYS_GATEWAY_SETTING c, SYS_GATEWAY g
            where   c.gateway_id       = g.gateway_id
            and     c.state            in (
                        1, /*ITEM_STATE_NORMAL*/
                        2, /*ITEM_STATE_ADD*/
                        3  /*ITEM_STATE_MODIFY*/
            )
            and     c.gateway_type     in (
                        1, /*ITEM_TYPE_PAY*/
                        2  /*ITEM_TYPE_CASH_EXCHANGE*/
            )
            and     c.game_id          = g.game_id
            and     g.game_id          = n_Game_ID
            for update;                -- 锁记录

            set n_Break_Flag = 0;
            open cur_First_Call;
            label_cur_first_call:loop
                fetch cur_First_Call into n_Tmp_Gateway_ID, n_Tmp_Item_State;
                if (n_Break_Flag = 1) then
                    leave label_cur_first_call;
                end if;

                if (n_Tmp_Item_State = 4 /*ITEM_STATE_DISABLE*/)
                then
                    -- 修改状态4修改为5
                    update SYS_GATEWAY_SETTING
                    set    state            = 5  /*ITEM_STATE_INVALID*/
                    where  state            = 4 /*ITEM_STATE_DISABLE*/
                    and    gateway_type     in (
                               1, /*ITEM_TYPE_PAY*/
                               2  /*ITEM_TYPE_CASH_EXCHANGE*/
                    )
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                elseif (n_Tmp_Item_State in (
                              2, /*ITEM_STATE_ADD*/
                              3  /*ITEM_STATE_MODIFY*/
                          )
                )
                then
                    -- 修改状态2、3修改为1
                    update SYS_GATEWAY_SETTING
                    set    state            = 1 /*ITEM_STATE_NORMAL*/
                    where  state            in (
                             2, /*ITEM_STATE_ADD*/
                             3  /*ITEM_STATE_MODIFY*/
                    )
                    and    gateway_type     in (
                               1, /*ITEM_TYPE_PAY*/
                               2  /*ITEM_TYPE_CASH_EXCHANGE*/
                    )
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                end if;
            end loop label_cur_first_call;
            close cur_First_Call;
        else
            -- 非首次调用，获取2,3,4的配置
            select c.gateway_id,      c.gateway_code,     c.gateway_password,
                   c.gateway_ip,      c.gateway_port,
                   g.gateway_name,    g.gateway_mac,      g.zone_id,
                   c.gateway_type,    c.state
            from   SYS_GATEWAY_SETTING c, SYS_GATEWAY g
            where  c.gateway_id       = g.gateway_id
            and    c.state            in (
                       2, /*ITEM_STATE_ADD*/
                       3, /*ITEM_STATE_MODIFY*/
                       4  /*ITEM_STATE_DISABLE*/
            )
            and    c.gateway_type     in (
                       1, /*ITEM_TYPE_PAY*/
                       2  /*ITEM_TYPE_CASH_EXCHANGE*/
            )
            and    c.game_id          = g.game_id
            and    g.game_id          = n_Game_ID
            for update;                -- 锁记录

            set n_Break_Flag = 0;
            open cur_Not_First_Call;
            label_cur_not_first_call:loop
                fetch cur_Not_First_Call into n_Tmp_Gateway_ID, n_Tmp_Item_State;
                if (n_Break_Flag = 1) then
                    leave label_cur_not_first_call;
                end if;

                if (n_Tmp_Item_State = 4 /*ITEM_STATE_DISABLE*/)
                then
                    -- 修改状态4修改为5
                    update SYS_GATEWAY_SETTING
                    set    state            = 5  /*ITEM_STATE_INVALID*/
                    where  state            = 4 /*ITEM_STATE_DISABLE*/
                    and    gateway_type     in (
                               1, /*ITEM_TYPE_PAY*/
                               2  /*ITEM_TYPE_CASH_EXCHANGE*/
                    )
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                elseif (n_Tmp_Item_State in (
                              2, /*ITEM_STATE_ADD*/
                              3  /*ITEM_STATE_MODIFY*/
                          )
                )
                then
                    -- 修改状态2、3修改为1
                    update SYS_GATEWAY_SETTING
                    set    state            = 1 /*ITEM_STATE_NORMAL*/
                    where  state            in (
                             2, /*ITEM_STATE_ADD*/
                             3  /*ITEM_STATE_MODIFY*/
                    )
                    and    gateway_type     in (
                               1, /*ITEM_TYPE_PAY*/
                               2  /*ITEM_TYPE_CASH_EXCHANGE*/
                    )
                    and    gateway_id       = n_Tmp_Gateway_ID
                    and    game_id          = n_Game_ID;
                end if;
            end loop label_cur_not_first_call;
            close cur_Not_First_Call;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 获取zond信息
CREATE PROCEDURE getZoneInfo(
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
            select z.zone_id, z.zone_name
            from   SYS_ZONE z
            where  z.zone_id    <> 0;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 获取指定zone_id的zone_name
CREATE PROCEDURE getZoneName(
    in  n_Zone_ID       integer,

    out s_Zone_Name     varchar(32),
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (n_Zone_ID      is null)
        then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select zone_name
        into   s_Zone_name
        from   SYS_ZONE
        where  zone_id = n_Zone_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1101;    /* PKG_UTIL.E_ZONE_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- GMTools添加网关信息
CREATE PROCEDURE addGatewayInfo(
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_Zone_ID          integer,
    in  s_Gateway_Code     varchar(32),
    in  s_Gateway_Password varchar(32),
    in  s_Gateway_Name     varchar(32),
    in  n_Gateway_IP       integer,
    in  s_Gateway_Mac      varchar(32),
    in  n_Gateway_State    integer,

    out n_Result           integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
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
            n_Game_ID;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1000;
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (s_Gateway_Code     is null) or
            (s_Gateway_Password is null) or
            (s_Gateway_Name     is null) or
            (n_Gateway_IP       is null) or
            (n_Zone_ID          is null) or
            (s_Gateway_Mac      is null) or
            (n_Gateway_State    is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        open cur_Game_ID_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            insert  into SYS_GATEWAY (
                GATEWAY_ID,         ZONE_ID,           GATEWAY_CODE,
                GATEWAY_PASSWORD,   GATEWAY_NAME,      GATEWAY_IP,
                GATEWAY_MAC,        GATEWAY_STATE,     game_id
            )
            values (
               n_Gateway_ID,        n_Zone_ID,         s_Gateway_Code,
               s_Gateway_Password,  s_Gateway_Name,    n_Gateway_IP,
               s_Gateway_Mac,       n_Gateway_State,   n_cur_Game_ID
            );
        end loop label_loop;
        close cur_Game_ID_List;

        -- set n_Result = abs(isExistZoneID(n_Zone_ID))
        call isExistZoneID(n_Zone_ID, n_Result);         -- 检测　zone　信息，只报警
        set n_Result = abs(n_Result);
    end label_proc;
END$$

CREATE PROCEDURE getGatewayInfo(
    in  n_Game_ID       integer,

    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select g.gateway_id,       g.zone_id,         g.gateway_code,
               g.gateway_password, g.gateway_name,    g.gateway_ip,
               g.gateway_mac,      g.gateway_state
        from   SYS_GATEWAY g
        where  g.game_id = n_Game_ID
        and    g.gateway_id <> 0
        order by gateway_id;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getGatewayResultByName(
    in  n_Game_ID          integer,
    in  s_Gateway_Name     varchar(32),

    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (s_Gateway_Name       is null) or
            (n_Game_ID            is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select g.gateway_id,       g.zone_id,         g.gateway_code,
               g.gateway_password, g.gateway_name,    g.gateway_ip,
               g.gateway_mac,      g.gateway_state
        from   SYS_GATEWAY g
        where  g.gateway_name = s_Gateway_Name and
               g.game_id      = n_Game_ID
        order by gateway_id;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 获取网关信息
CREATE PROCEDURE getGatewayDetail(
    in  n_Game_ID              integer,
    in  n_Gateway_ID           integer,         -- 2 网关的唯一序列号,长度6,

    out n_Ret_Zone_ID          integer,
    out s_Ret_Gateway_Code     varchar(32),
    out s_Ret_Gateway_Password varchar(32),
    out s_Ret_Gateway_Name     varchar(32),
    out n_Ret_Gateway_IP       integer,
    out s_Ret_Gateway_Mac      varchar(32),
    out n_Ret_Gateway_State    integer,
    out n_Result               integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Gateway_ID       is null) or
            (n_Game_ID          is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select g.zone_id,               g.gateway_code,
               g.gateway_password,      g.gateway_name,       g.gateway_ip,
               g.gateway_mac,           g.gateway_state
        into   n_Ret_Zone_ID,           s_Ret_Gateway_Code,
               s_Ret_Gateway_Password,  s_Ret_Gateway_Name,   n_Ret_Gateway_IP,
               s_Ret_Gateway_Mac,       n_Ret_Gateway_State
        from   SYS_GATEWAY g
        where  gateway_id = n_Gateway_ID and
               game_id    = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;    /* PKG_UTIL.E_GATEWAY_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 修改网关信息
CREATE PROCEDURE modifyGatewayInfo(
    in  n_Game_ID          integer,         -- 2 游戏ID,
    in  n_Gateway_ID       integer,         -- 3 网关的唯一序列号,长度6,
    in  n_Zone_ID          integer,         -- 4 网关所在逻辑区,,
                                            --   201:电信一区 101: 联通一区, 601: 双线一区
    in  s_Gateway_Code     varchar(32),     -- 5 网关的登录接入码,
    in  s_Gateway_Password varchar(32),     -- 6 网关的登录密码,
    in  s_Gateway_Name     varchar(32),     -- 7 网关名称,
    in  n_Gateway_IP       integer,         -- 8 网关的IP地址 (转换为数字格式),
    in  s_Gateway_Mac      varchar(32),     -- 9 网关的mac地址 格式: 00,-00-00-00-00-00
    out n_Result           integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
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
            n_Game_ID;

    label_proc:begin
        declare exit handler for 1169 set n_Result = -1000;
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (s_Gateway_Code     is null) or
            (s_Gateway_Password is null) or
            (s_Gateway_Name     is null) or
            (n_Gateway_IP       is null) or
            (n_Zone_ID          is null) or
            (s_Gateway_Mac      is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
             
            update SYS_GATEWAY g
            set    g.zone_id           = n_Zone_ID,
                   g.gateway_code      = s_Gateway_Code,
                   g.gateway_password  = s_Gateway_Password,
                   g.gateway_name      = s_Gateway_Name,
                   g.gateway_ip        = n_Gateway_IP,
                   g.gateway_mac       = s_Gateway_Mac,
                   g.gateway_state     = 1
            where  g.gateway_id        = n_Gateway_ID and
                   g.game_id           = n_cur_Game_ID;

            if (FOUND_ROWS() = 0)
            then
                set n_Result = -1002;    /* PKG_UTIL.E_GATEWAY_UID_PWD_ERROR */
                leave label_proc;
            end if;
        end loop label_loop;

        -- set n_Result = abs(isExistZoneID(n_Zone_ID))
        call isExistZoneID(n_Zone_ID, n_Result);         -- 检测　zone　信息，只报警
        set n_Result = abs(n_Result);
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE modifyGatewayName(
    in  n_Game_ID          integer,         -- 2 游戏ID,
    in  n_Gateway_ID       integer,         -- 3 网关的唯一序列号,长度6,

    in  s_Gateway_Name     varchar(32),     -- 7 网关名称,
    out n_Result           integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
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
            n_Game_ID;

    label_proc:begin
        declare exit handler for 1169 set n_Result = -1000;
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (s_Gateway_Name     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
             
            update SYS_GATEWAY g
            set    g.gateway_name      = s_Gateway_Name
            where  g.gateway_id        = n_Gateway_ID
            and     g.game_id           = n_cur_Game_ID;

            if (FOUND_ROWS() = 0)
            then
                set n_Result = -1002;    /* PKG_UTIL.E_GATEWAY_UID_PWD_ERROR */
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

-- 禁用网关
CREATE PROCEDURE disableGatewayInfo(
    in  n_Game_ID      integer,
    in  n_Gateway_ID   integer,

    out n_Result       integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
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
            n_Game_ID;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Gateway_ID       is null) or
            (n_Game_ID          is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            update SYS_GATEWAY
            set    gateway_state    = 2
            where  gateway_id       = n_Gateway_ID and
                   game_id          = n_cur_Game_ID;

            if (found_rows() = 0)
            then
                set n_Result = -1002;    /* PKG_UTIL.E_GATEWAY_UID_PWD_ERROR */
                leave label_proc;
            end if;
            
            update SYS_GATEWAY_SETTING
        	set    state            = 4             /* ITEM_STATE_DISABLE */
        	where  gateway_id       = n_Gateway_Id     and
               state            <> 5 and    /* ITEM_STATE_INVALID */
               game_id          = n_cur_Game_ID;
        end loop label_loop; 

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    close cur_Game_ID_List;
END$$

-- 开启网关
CREATE PROCEDURE enableGatewayInfo(
    in  n_Game_ID      integer,
    in  n_Gateway_ID   integer,

    out n_Result       integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
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
            n_Game_ID;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Gateway_ID       is null) or
            (n_Game_ID          is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;


        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            update SYS_GATEWAY
            set    gateway_state    = 1
            where  gateway_id       = n_Gateway_ID and
                   game_id          = n_cur_Game_ID and
                   gateway_state = 0;

            if (ROW_COUNT() = 0)
            then
                set n_Result = -1002;    /* PKG_UTIL.E_GATEWAY_UID_PWD_ERROR */
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE addGatewaySetting (
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  s_Ch_Gateway_Code  varchar(32),
    in  s_Ch_Gateway_Pwd   varchar(32),
    in  s_Ch_Gateway_IP    varchar(32),
    in  n_Ch_Gateway_Port  integer,
    in  n_Gateway_Type     integer,

    out n_Result           integer
)
BEGIN
    declare n_Gateway_ID_Tmp   integer;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1000;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (s_Ch_Gateway_Code  is null) or
            (s_Ch_Gateway_Pwd   is null) or
            (s_Ch_Gateway_IP    is null) or
            (n_Ch_Gateway_Port  is null) or
            (n_Gateway_Type     is null) or
            (n_Gateway_Type     not in (
                 3,  /*ITEM_TYPE_CHARGE*/
                 1,  /*ITEM_TYPE_PAY*/
                 2   /*ITEM_TYPE_CASH_EXCHANGE*/
            ))
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select gateway_id
        into   n_Gateway_ID_Tmp
        from   SYS_GATEWAY
        where  gateway_id = n_Gateway_ID and
               gateway_state = 1         and
               game_id = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1001;    /* PKG_UTIL.E_GATEWAY_NOT_FOUND */
            leave label_proc;
        end if;

        insert  into SYS_GATEWAY_SETTING (
                GATEWAY_ID,        GATEWAY_TYPE,     GATEWAY_CODE,
                GATEWAY_PASSWORD,  GATEWAY_IP,       GATEWAY_PORT,
                state,             game_id
        )
        values (
               n_Gateway_ID,        n_Gateway_Type,  s_Ch_Gateway_Code,
               s_Ch_Gateway_Pwd,    s_Ch_Gateway_IP, n_Ch_Gateway_Port,
               2,/*ITEM_STATE_ADD*/ n_Game_ID
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 获取配置信息
CREATE PROCEDURE getGatewaySetting (
    in  n_Game_ID       integer,
    in  n_Gateway_ID    integer,

    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (n_Gateway_ID        is null) or
           (n_Game_ID           is null)
        then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select  c.gateway_id,      c.gateway_code,     c.gateway_password,
                c.gateway_ip,      c.gateway_port,
                c.gateway_type,    c.state
        from    SYS_GATEWAY_SETTING c
        where   c.gateway_id        = n_Gateway_ID and
                c.game_id           = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 获取指定的配置信息
CREATE PROCEDURE getGatewaySettingByType(
    in  n_Game_ID      integer,
    in  n_Gateway_ID   integer,
    in  n_Gateway_Type integer,
    -- out c_Ret_Gateway_List sys_refcursor,  -- gateway_id gateway_code, gateway_password,
                                          -- gateway_ip gateway_port,
                                          -- gateway_type(1.消费对账 2.元宝流通对账 3.充值推送)
                                          -- state(1、2、3.启用，4、5.禁用)
    out n_Result       integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
           (n_Gateway_ID        is null)      or
           (n_Gateway_Type      is null)      or
           (n_Game_ID           is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select  c.gateway_id,      c.gateway_code,     c.gateway_password,
                c.gateway_ip,      c.gateway_port,
                c.gateway_type,    c.state
        from    SYS_GATEWAY_SETTING c
        where   c.gateway_id        = n_Gateway_ID     and
                c.gateway_type      = n_Gateway_Type   and
                c.game_id           = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE modifyGatewaySetting (
    in  n_Game_ID       integer,
    in  n_Gateway_ID    integer,
    in  n_Gateway_Type  integer,

    in  s_Gateway_Code  varchar(32),
    in  s_Gateway_Pwd   varchar(32),
    in  s_Gateway_IP    varchar(32),
    in  n_Gateway_Port  integer,

    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (s_Gateway_Code  is null) or
            (s_Gateway_Pwd   is null) or
            (s_Gateway_IP    is null) or
            (n_Gateway_Port  is null) or
            (n_Gateway_Type  is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update SYS_GATEWAY_SETTING c
        set    c.gateway_code      = s_Gateway_Code,
               c.gateway_password  = s_Gateway_Pwd,
               c.gateway_ip        = s_Gateway_IP,
               c.gateway_port      = n_Gateway_Port,
               c.state             = 3    /*ITEM_STATE_MODIFY*/
        where  c.gateway_id        = n_Gateway_ID        and
               c.gateway_type      = n_Gateway_Type      and
               c.game_id           = n_Game_ID;

        if (ROW_COUNT() = 0) then
            set n_Result = -1000;    /* PKG_UTIL.E_GATEWAY_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE disableGatewaySetting (
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_Gateway_Type     integer,

    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Gateway_ID       is null)        or
            (n_Gateway_Type     is null)        or
            (n_Game_ID          is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update   SYS_GATEWAY_SETTING
        set      state = 4              /* ITEM_STATE_DISABLE */
        where    gateway_id     = n_Gateway_ID   and
                 gateway_type   = n_Gateway_Type and
                 state          <> 5 and   /*ITEM_STATE_INVALID*/
                 game_id        = n_Game_ID;

        if (ROW_COUNT() = 0)
        then
            set n_Result = -1000;    /* PKG_UTIL.E_GATEWAY_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE enableGatewaySetting (
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_Gateway_Type     integer,

    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null)  or
            (n_Gateway_ID       is null)  or
            (n_Gateway_Type     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update   SYS_GATEWAY_SETTING
        set      state = 2   /*ITEM_STATE_ADD*/
        where    gateway_id     = n_Gateway_ID   and
                 gateway_type   = n_Gateway_Type and
                 state          in (
                     4,      /*ITEM_STATE_DISABLE*/
                     5       /*ITEM_STATE_INVALID*/
                 )                               and
                 game_id        = n_Game_ID;

        if (ROW_COUNT() = 0)
        then
            set n_Result = -1000;    /* PKG_UTIL.E_GATEWAY_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
