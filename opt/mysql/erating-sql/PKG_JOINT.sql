DROP PROCEDURE PfCharge1;
DROP PROCEDURE PfCharge2;
DROP PROCEDURE PfItemSend;
DROP PROCEDURE PfBalanceQuery;
DROP PROCEDURE PfOrderQuery;
DROP PROCEDURE addUnionOrder;
DROP PROCEDURE pfUncharge;
DROP PROCEDURE transferBalanceForPF;
DROP PROCEDURE VerifyLoginPassword;
DELIMITER $$

    -- 适用情况:帐号在erating中不存在
    -- 先判断帐号,不存在的话创建新用户,再调用innerCharge
CREATE PROCEDURE PfCharge1(
    in  n_Game_ID            integer,      -- 2
    in  s_User_Name          varchar(32),  -- 3
    in  n_Rating_ID          integer,      -- 5
    in  n_Charge_Money       integer,      -- 6
    in  n_Charge_Amount      integer,      -- 7
    in  d_Charge_Time        datetime,     -- 8
    in  s_Server_IP          varchar(32),  -- 9
    in  s_Client_IP          varchar(32),  -- 10
    in  n_Charge_Detail_ID   bigint,       -- 11
    in  s_Order_Code         varchar(32),  -- 12
    out n_Result             integer
)
BEGIN
    declare n_RetCode             integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Rating_ID       integer default  0; /* UMS_USER_FUND.rating_id%TYPE */
    declare n_Tmp_Subject_ID      integer default  3; /* UMS_USER_FUND.subject_id%TYPE */
    declare n_Tmp_User_ID         integer unsigned; /* UMS_USER.user_id%TYPE */
    declare s_Tmp_User_Name       varchar(32); /* UMS_USER.user_name%TYPE */
    declare n_Tmp_GW_State        integer default  0;

    declare s_Tmp_Op_Type         varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Allow_Charge    varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Global_Recharge varchar(32); /* SYS_OPTION.option_value%type */
    label_proc:begin
        declare continue handler for 1062 begin end;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (s_User_Name        is null) or
            (n_Rating_ID        is null) or
            (n_Charge_Money     is null) or
            (d_Charge_Time      is null) or
            (n_Charge_Amount    is null) or
            (n_Charge_Amount    <= 0   ) or
            (s_Server_IP        is null) or
            (s_Client_IP        is null) or
            (n_Charge_Detail_ID is null) or
            (s_Order_Code       is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'op_type',    /* PKG_OPTION.OP_TYPE */
            'auto',   /* PKG_OPTION.T_AUTO */
            s_Tmp_Op_Type
            );
        -- 自主运营 禁止访问
        if (s_Tmp_Op_Type = 'auto') then    /* PKG_OPTION.T_AUTO */
            set n_Result =  -2103;    /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
        end if;

        -- 是否允许充值
        call getOptionValue(
            n_Game_ID,
            'allow_charge',    /* PKG_OPTION.ALLOW_CHARGE */
            '1',   /* PKG_OPTION.R_OPENED */
            s_Tmp_Allow_Charge
            );
        if (s_Tmp_Allow_Charge       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Result =  -2103;    /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
        end if;


        call getOptionValue(
            n_Game_ID,
            'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
            '1',   /* PKG_OPTION.R_OPENED */
            s_Tmp_Global_Recharge
            );
        if (s_Tmp_Global_Recharge       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Tmp_Rating_ID = n_Rating_ID;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Tmp_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- We query information from local database.
        label_loop:loop
            select
                user_id,       user_name
            into
                n_Tmp_User_ID, s_Tmp_User_Name
            from
                UMS_USER
            where
                (user_name = s_User_Name) and
                (game_id   = n_Game_ID  );
            -- verify user info consistency
            if (
                (s_Tmp_User_Name <> s_User_Name)
            ) then
                set n_Result = -1406;    /* PKG_UTIL.E_USER_ACCOUNT_ERROR */
                leave label_proc;
            end if;
            -- exit loop when no exception.
            if (found_rows() = 1) then
                leave label_loop;
            end if;
            
            insert into sys_user_id values();
            select last_insert_id() into n_Tmp_User_ID;
            -- create user account record.
            insert into UMS_USER(
                user_id, user_name,      password,
                user_type,      gateway_id,     user_point,
                user_class,     promoter_id,    birthday,
                id_verify_flag, user_flag,      user_state,
                ad_id,          id_code,        game_id
            )
            values(
                n_Tmp_User_ID, s_User_Name,    '0',
                0,              0,              0,
                0,              0,              null,
                0,              0,              40, -- adult
                0,              '0',            n_Game_ID
            );
        end loop label_loop;

        call innerCharge(
            n_Game_ID,
            n_Tmp_User_ID,
            n_Tmp_Rating_ID,
            n_Charge_Amount,
            n_Tmp_Subject_ID,
            10,   -- channel_id
            1,    -- discount
            d_Charge_Time,
            0,    -- promoter_id
            n_Charge_Detail_ID, -- charge_detail_id
            s_Order_Code,
            1,    -- charge_type, 1-直充
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE transferBalanceForPF(
    in    n_Game_ID              integer,
    in    s_User_Name            varchar(32),
    in    n_Src_Rating_ID        integer,
    in    n_Dst_Rating_ID        integer,
    in    n_Subject_ID           integer,
    in    charge_Order_Code      varchar(32),
    out   n_Result               integer
)
BEGIN
    declare n_RetCode               integer default  0;
    declare n_Tmp_User_ID           integer unsigned;
    declare n_Tmp_Count             integer default 0;
    declare s_Tmp_Auto_Draw_Type    varchar(32);
    declare n_Charge_Amount         integer;
    declare d_Tmp_Charge_Time       datetime;
    declare n_Tmp_Charge_Detail_ID  bigint;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID          is null) or
            (s_User_Name        is null) or
            (n_Src_Rating_ID    is null) or
            (n_Dst_Rating_ID    is null) or
            (n_Subject_ID       is null) or
            (charge_Order_Code  is null)
        )then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getUserID(n_Game_ID, s_User_Name, n_Tmp_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        select
            t.charge_detail_id, ifnull(sum(t.charge_amount), 0), max(t.charge_time)
        into
            n_Tmp_Charge_Detail_ID, n_Charge_Amount, d_Tmp_Charge_Time
        from
            LOG_USER_FUND_DETAIL t
        where
            t.charge_order_code = charge_Order_Code
        and
            t.charge_type = 1
        and
            t.game_id = n_Game_ID
        and
            t.user_id = n_Tmp_User_ID;
        if(found_rows() = 0 ) then
            set n_Result = -1448;
            leave label_proc;
        end if;

        if( 0 <> n_Src_Rating_ID ) then
            select
                count(*)
            into
                n_Tmp_Count
            from
                ums_user_purchase_detail t
            where
                t.game_id = n_Game_ID
            and
                t.user_id = n_Tmp_User_ID
            and
                t.gateway_id = n_Src_Rating_ID
            and
                t.purchase_time >= d_Tmp_Charge_Time;
            if(n_Tmp_Count >= 1) then
                set n_Result = -2011;
                leave label_proc;
            end if;
            -- 是否是自动领用
            call getOptionValue(
                n_Game_ID,
                'auto_draw_balance',
                null,
                s_Tmp_Auto_Draw_Type
            );
            if(s_Tmp_Auto_Draw_Type = '1') then
                call rollback5to3(
                    n_Game_ID,
                    n_Tmp_User_ID,
                    n_Src_Rating_ID,
                    n_Charge_Amount,
                    n_Result
                    );
                if(n_Result <> 1) then
                    leave label_proc;
                end if;
            end if;
        else
            select
                count(*)
            into
                n_Tmp_Count
            from
                LOG_USER_FUND_DETAIL t
            where
                t.game_id = n_Game_ID
            and
                t.charge_type = 2
            and
                t.user_id = n_Tmp_User_ID
            and
                t.charge_time >= d_Tmp_Charge_Time;
            if(n_Tmp_Count > 0 ) then
                set n_Result = -2011;
                leave label_proc;
            end if;
        end if;
        call transferBalance(
            n_Game_ID,
            n_Tmp_User_ID,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_Subject_ID,
            n_Tmp_Charge_Detail_ID,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE pfUncharge(
IN  n_Game_ID             INTEGER,
IN  s_User_Name           varchar(32),
IN  n_Gateway_ID          INTEGER, 
IN  charge_Order_Code     varchar(32), 
IN  uncharge_Order_Code   varchar(32), 
IN  n_Uncharge_Detail_ID  BIGINT, 
IN  n_Uncharge_Amount     INTEGER, 
OUT n_Result              INTEGER
)
BEGIN
    declare           n_RetCode                      integer   default 0;
    declare           s_Tmp_Auto_Draw_Type           varchar(32);
    declare           n_Tmp_Count                    integer;
    declare           n_Charge_Amount                integer;
    declare           d_Tmp_Charge_Time              datetime;
    declare           n_Tmp_User_ID                  integer unsigned;
    declare           n_Tmp_Charge_Detail_ID         bigint;

    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID             is null) or
            (s_User_Name           is null) or
            (n_Gateway_ID          is null) or
            (charge_Order_Code    is null) or
            (uncharge_Order_Code  is null) or
            (n_Uncharge_Detail_ID     is null) or            
            (n_Uncharge_Amount          is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getUserID(n_Game_ID, s_User_Name, n_Tmp_User_ID, n_RetCode);
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        select
            t.charge_detail_id, ifnull(t.charge_amount, 0), t.charge_time
        into
            n_Tmp_Charge_Detail_ID, n_Charge_Amount, d_Tmp_Charge_Time
        from
            LOG_USER_FUND_DETAIL t
        where
            t.game_id = n_Game_ID
        and
            t.charge_type = 1
        and
            t.charge_order_code = charge_Order_Code
        and
            t.user_id = n_Tmp_User_ID;
        if(found_rows() = 0 ) then
            set n_Result = -1448;
            leave label_proc;
        end if;
        if( n_Charge_Amount <> n_Uncharge_Amount ) then
            set n_Result = -2012;
            leave label_proc;
        end if;
        if( 0 <> n_Gateway_ID ) then
            select
                count(*)
            into
                n_Tmp_Count
            from
                ums_user_purchase_detail t
            where
                t.game_id = n_Game_ID
            and
                t.user_id = n_Tmp_User_ID
            and
                t.gateway_id = n_Gateway_ID
            and
                t.purchase_time >= d_Tmp_Charge_Time;
            if(n_Tmp_Count >= 1) then
                set n_Result = -2011;
                leave label_proc;
            end if;
            -- 是否是自动领用
            call getOptionValue(
                n_Game_ID,
                'auto_draw_balance',
                null,
                s_Tmp_Auto_Draw_Type
            );
            if(s_Tmp_Auto_Draw_Type = '1') then
                call rollback5to3(
                    n_Game_ID,
                    n_Tmp_User_ID,
                    n_Gateway_ID,
                    n_Uncharge_Amount,
                    n_Result
                    );
                if(n_Result <> 1) then
                    leave label_proc;
                end if;
            end if;
        else
            select
                count(*)
            into
                n_Tmp_Count
            from
                LOG_USER_FUND_DETAIL t
            where
                t.game_id = n_Game_ID
            and
                t.charge_type = 2
            and
                t.user_id = n_Tmp_User_ID
            and
                t.charge_time >= d_Tmp_Charge_Time;
            if(n_Tmp_Count > 0 ) then
                set n_Result = -2011;
                leave label_proc;
            end if;
        end if;
        -- 自主运营正式区做此调用
        call unchargeInfo(
            n_Game_ID,
        	n_Tmp_Charge_Detail_ID,
        	n_Uncharge_Detail_ID,
        	n_Uncharge_Amount,
        	3,
        	1,
        	n_Tmp_User_ID,
        	n_Gateway_ID,
        	null,
        	uncharge_Order_Code,
        	n_Result
        );
    end label_proc;
END$$

    -- 适用情况:帐号在erating中已存在
    -- 不判断帐号情况,直接调用innerCharge
CREATE PROCEDURE PfCharge2(
    in  n_Game_ID            integer,      -- 2
    in  n_User_ID            integer unsigned,   -- 3
    in  n_Rating_ID          integer,      -- 4
    in  n_Charge_Money       integer,      -- 5
    in  n_Charge_Amount      integer,      -- 6
    in  d_Charge_Time        datetime,     -- 7
    in  n_Charge_Detail_ID   bigint,       -- 8
    in  s_Order_Code         varchar(32),  -- 9
    out n_Result             integer
)
BEGIN
    declare n_RetCode             integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Rating_ID       integer default  0; /* UMS_USER_FUND.rating_id%TYPE */
    declare n_Tmp_Subject_ID      integer default  3; /* UMS_USER_FUND.subject_id%TYPE */
    declare n_Tmp_GW_State        integer default  0;

    declare s_Tmp_Op_Type         varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Allow_Charge    varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Global_Recharge varchar(32); /* SYS_OPTION.option_value%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_User_ID          is null) or
            (n_Rating_ID        is null) or
            (n_Charge_Money     is null) or
            (n_Charge_Money     <= 0   ) or
            (d_Charge_Time      is null) or
            (n_Charge_Amount    is null) or
            (n_Charge_Amount    <= 0   ) or
            (n_Charge_Detail_ID is null) or
            (s_Order_Code       is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'op_type',    /* PKG_OPTION.OP_TYPE */
            'auto',   /* PKG_OPTION.T_AUTO */
            s_Tmp_Op_Type
            );
        -- 自主运营 禁止访问
        if (s_Tmp_Op_Type = 'auto') then    /* PKG_OPTION.T_AUTO */
            set n_Result =  -2103;    /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
        end if;

        -- 是否允许充值
        call getOptionValue(
            n_Game_ID,
            'allow_charge',    /* PKG_OPTION.ALLOW_CHARGE */
            '1',  /* PKG_OPTION.R_OPENED */
            s_Tmp_Allow_Charge
            );
        if (s_Tmp_Allow_Charge       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Result = -2103;   /*PKG_UTIL.E_DISABLE_ACCESS*/
        end if;


        call getOptionValue(
            n_Game_ID,
            'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
            '1',   /* PKG_OPTION.R_OPENED */
            s_Tmp_Global_Recharge
            );
        if (s_Tmp_Global_Recharge       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Tmp_Rating_ID = n_Rating_ID;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Tmp_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call innerCharge(
            n_Game_ID,
            n_User_ID,
            n_Tmp_Rating_ID,
            n_Charge_Amount,
            n_Tmp_Subject_ID,
            10,   -- channel_id
            1,    -- discount
            d_Charge_Time,
            0,    -- promoter_id
            n_Charge_Detail_ID,
            s_Order_Code,
            1,    -- charge_type, 1-直充
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE PfItemSend(
    in    n_Game_ID             integer,      -- 2
    in    n_Gateway_ID          integer,      -- 3
    in    n_Activity_ID         integer,      -- 4
    in    s_User_Name           varchar(32),  -- 5
    in    s_Order_Code          varchar(32),  -- 6
    in    d_Send_Time           datetime,     -- 7
    in    s_Item_Detail         varchar(4000),-- 8
    in    d_Begin_Time          datetime,     -- 9
    in    d_End_Time            datetime,     -- 10
    in    s_Appendix            varchar(32),  -- 12
    out   n_Result              integer
)
BEGIN
    declare n_RetCode          integer default 0; /*PKG_UTIL.E_ERROR*/

    declare n_Tmp_User_ID      integer unsigned;  /*UMS_USER.user_id%TYPE*/
    declare n_Tmp_GW_State     integer default 0;

    declare s_Tmp_Op_Type      varchar(32);  /* SYS_OPTION.optiodeclare n_value%type */
    declare n_Inset_Exception  integer default 0;
    declare n_Item_Count       integer;
    declare s_One_Item_Info    varchar(100);
    declare s_Item_Code        varchar(32);
    declare n_Item_Num         integer;
    label_proc:begin
        declare continue handler for 1062 set n_Inset_Exception = 1;
        if (
            (n_Game_ID     is null             ) or
            (n_Gateway_ID  is null             ) or
            (n_Activity_ID is null             ) or
            (n_Activity_ID <  1000000000       ) or
            (s_User_Name   is null             ) or
            (s_Order_Code  is null             ) or
            (s_Item_Detail is null             ) or
            (d_Begin_Time  is null             ) or
            (d_End_Time    is null             ) or
            (d_Begin_Time  >= d_End_Time       ) or
            (s_Appendix    is null             )
        ) then
            set n_Result = -100;  /*PKG_UTIL.E_PARAMETER_ERROR*/
            leave label_proc;
        end if;

        if (length(s_Item_Detail) = 0) then
            set n_Result = -100;  /*PKG_UTIL.E_PARAMETER_ERROR*/
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'op_type',    /* PKG_OPTION.OP_TYPE */
            'oversea',   /* PKG_OPTION.T_OVER_SEA */
            s_Tmp_Op_Type
            );
        -- 海外运营
        if (s_Tmp_Op_Type <> 'oversea') then   /* PKG_OPTION.T_OVER_SEA */
            set n_Result = -2103; /* PKG_UTIL.E_DISABLE_ACCESS */
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Gateway_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -100;  /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- We query information from local database.
        label_loop:loop
            select
                user_id
            into
                n_Tmp_User_ID
            from
                UMS_USER
            where
                user_name = s_User_Name and
                game_id   = n_Game_ID;
            -- exit loop when no exception.
            if (found_rows() = 1) then
                leave label_loop;
            end if;

            set n_Inset_Exception = 0;
            -- create user account record.
            insert into sys_user_id values();
            select last_insert_id() into n_Tmp_User_ID;
            insert into UMS_USER(
                user_id, user_name,      password,
                user_type,      gateway_id,     user_point,
                user_class,     promoter_id,    birthday,
                id_verify_flag, user_flag,      user_state,
                ad_id,          id_code,        game_id
            )
            values(
                n_Tmp_User_ID, s_User_Name,    '0',
                0,              0,              0,
                0,              0,              null,
                0,              0,              40, -- adult
                0,              '0',            n_Game_ID
            );
        end loop label_loop;

        set n_Inset_Exception = 0;
        insert into LOG_ITEM_SEND(
            order_code,    send_time,    activity_id,
            user_name,     gateway_id,   game_id
        )
        values(
            s_Order_Code,  d_Send_Time,  n_Activity_ID,
            s_User_Name,   n_Gateway_ID, n_Game_ID
        );
        if (n_Inset_Exception = 1) then
            set n_Result = -1463;   /* PKG_UTIL.E_ITEM_ORDER_CODE_DUPLICATE */
            leave label_proc;
        end if;

        label_loop:loop
            set n_Item_Count = 0;
            set s_One_Item_Info = '';
            set s_Item_Code = '';
            set n_Item_Num = 0;

            set n_Item_Count = length(s_Item_Detail) - length(replace(s_Item_Detail, '$', ''));

            -- 格式应为 item1,100$item2,200$item3,300 ......
            set s_One_Item_Info = substring_index(s_Item_Detail, '$', -1);

            -- 每个物品的格式: item1,100
            set s_Item_Code = substring_index(s_One_Item_Info, ',', 1);
            set n_Item_Num = cast(substring_index(s_One_Item_Info, ',', -1) as unsigned integer);

            call itemAdd(
                n_Game_ID,
                n_Gateway_ID,
                n_Gateway_ID,
                n_Activity_ID,
                n_Tmp_User_ID,
                0,
                s_Item_Code,
                n_Item_Num,
                d_Begin_Time,
                d_End_Time,
                s_Order_Code,

                n_RetCode
            );
            if (n_RetCode <> 1) then   /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            if (n_Item_Count = 0) then
                leave label_loop;
            end if;

            set s_Item_Detail = substring_index(s_Item_Detail, '$', n_Item_Count);
        end loop;

        set n_Result = 1;   /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE PfBalanceQuery(
    in  n_Game_ID            integer,        -- 2
    in  n_Rating_ID          integer,        -- 3
    in  s_User_Name          varchar(32),    -- 4
    in  n_Max_Subject_Count  integer,        -- 5

    out n_Result             integer
)
BEGIN

    declare n_Tmp_User_ID           integer unsigned; /* UMS_USER.user_id%TYPE */
    declare n_Tmp_GW_State          integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID           is null) or
            (n_Rating_ID         is null) or
            (n_Max_Subject_Count is null) or
            (n_Max_Subject_Count < 1    ) or
            (s_User_Name         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- 查询User_ID
        select
            user_id
        into
            n_Tmp_User_ID
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id   = n_Game_ID;
        if (found_rows() = 0) then
            set n_Result = -1201;    /* PKG_UTIL.E_ACCOUNT_NOT_FOUND */
            leave label_proc;
        end if;

        -- query balance.
        if (n_Rating_ID = 0) then
            prepare s_Sql_Text from 'select subject_id, sum(amount)
                from UMS_USER_FUND
                where user_id = ?
                and game_id = ?
                group by subject_id
                limit ?';
            set @param1 = n_Tmp_User_ID;
            set @param2 = n_Game_ID;
            set @param3 = n_Max_Subject_Count;
            execute s_Sql_Text using @param1, @param2, @param3;
            deallocate prepare s_Sql_Text;
        else
            prepare s_Sql_Text from 'select subject_id, amount
                from UMS_USER_FUND
                where user_id   = ?
                and rating_id = ?
                and game_id   = ?
                limit ?';
            set @param1 = n_Tmp_User_ID;
            set @param2 = n_Rating_ID;
            set @param3 = n_Game_ID;
            set @param4 = n_Max_Subject_Count;
            execute s_Sql_Text using @param1, @param2, @param3, @param4;
            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE PfOrderQuery(
    in  n_Game_ID            integer,          -- 2
    in  s_Order_Code         varchar(32),      -- 3
    in  n_Order_Type         integer,          -- 4
    out n_Result             integer
)
BEGIN

    declare n_Tmp_Fund_Detail_ID  bigint; /* LOG_USER_FUND_DETAIL.fund_detail_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID            is null) or
            (s_Order_Code         is null) or
            (n_Order_Type         is null) or
            (n_Order_Type         < 1    )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- query charge order.
        if (n_Order_Type = 1) then
            select
                t.fund_detail_id
            into
                n_Tmp_Fund_Detail_ID
            from
                LOG_USER_FUND_DETAIL t
            where
                t.charge_order_code = s_Order_Code and
                t.charge_type = 1                  and
                t.game_id = n_Game_ID;
            if (found_rows() = 0) then
                set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
                leave label_proc;
            end if;
        -- query item send order.
        elseif (n_Order_Type = 2) then
            select
                t.activity_id
            into
                n_Tmp_Fund_Detail_ID -- no use!!
            from
                LOG_ITEM_SEND t
            where
                t.order_code = s_Order_Code and
                t.game_id    = n_Game_ID;
            if (found_rows() = 0) then
                set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
                leave label_proc;
            end if;
        else
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE addUnionOrder(
IN  n_Game_ID       INTEGER, 
IN  s_lk_order      VARCHAR(32), 
IN  s_union_order   VARCHAR(150), 
IN  d_create_time   DATETIME,
OUT n_Result        integer
)
BEGIN
    lable_proc:begin
        declare exit handler for 1062 set n_Result = 0;/*Can't write, because of unique constraint*/
        set n_Result = 0;/*E_ERROR*/
        if (
                (n_Game_ID      is null) or
                (s_lk_order      is null) or
                (s_union_order      is null) or
                (d_create_time      is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        insert into sys_union_order (
            game_id,            lk_order,          union_order,
            create_time
        ) values (
            n_Game_ID,          s_lk_order,                   s_union_order,
            d_create_time
        );

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE VerifyLoginPassword(
    in  n_Game_ID               integer,
    in  s_User_Name             varchar(32),
    in  s_Password              varchar(32),

    out n_Ret_User_ID           integer,
    out n_Result                integer
)
BEGIN
    declare s_Tmp_Pwd  varchar(32);
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (s_User_Name      is null) or
            (s_Password       is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            user_id, password
        into
            n_Ret_User_ID, s_Tmp_Pwd
        from
            UMS_USER
        where
            game_id = n_Game_ID and
            user_name = s_User_Name;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1201;  /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            leave label_proc;
        end if;

        if (s_Password <> s_Tmp_Pwd) then
            set n_Result = -1402;  /*PKG_UTIL.E_USER_PASSWORD_ERROR*/
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
