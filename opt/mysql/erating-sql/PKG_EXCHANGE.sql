DROP PROCEDURE checksumCashExchange;
DROP PROCEDURE updateSrcFundSummary;
DROP PROCEDURE updateDstFundSummary;
DROP PROCEDURE userCashExchange;
DROP PROCEDURE userCashExchangeEx;
DROP PROCEDURE userCashExchangeEx1;
DROP PROCEDURE rollbackSrcFundSummary;
DROP PROCEDURE rollbackDstFundSummary;
DROP PROCEDURE cancelCashExchangeByDetailID;
DELIMITER $$

CREATE PROCEDURE checksumCashExchange(
    in  n_Gateway_ID          integer,
    in  n_Src_User_ID         integer unsigned,
    in  n_Dst_User_ID         integer unsigned,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    out n_Ret_Checksum        integer,
    out n_Result              integer
)
BEGIN

    declare v_CheckSum_Input    varchar(128);
    label_proc:begin
        set n_Result = 0; /* E_ERROR */

        if (
            (n_Gateway_ID    is null) or
            (n_Src_User_ID   is null) or
            (n_Dst_User_ID   is null) or
            (n_Subject_ID    is null) or
            (n_Amount        is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set v_CheckSum_Input = concat(n_Gateway_ID, ',', n_Src_User_ID, ',', n_Dst_User_ID, ',', n_Subject_ID, ',', n_Amount);

        call checkthesum(v_CheckSum_Input, n_Ret_CheckSum, n_Result);
    end label_proc;
END$$

CREATE PROCEDURE updateSrcFundSummary(
    in  n_Game_ID             integer,
    in  n_Src_User_ID         integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Amount              integer,
    out n_Result              integer
)
BEGIN
    declare n_Subject_ID          integer default  5; /* UMS_USER_FUND_SUMMARY.Subject_Id%TYPE */
    declare n_Tmp_GW_State        integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID             is null) or
            (n_Src_User_ID         is null) or
            (n_Rating_ID           is null) or
            (n_Amount              is null) or
            (n_Amount                 <= 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        update
            UMS_USER_FUND_SUMMARY
        set
            total_exchange_out = total_exchange_out + n_Amount
        where
            (game_id    = n_Game_ID    ) and
            (user_id    = n_Src_User_ID) and
            (rating_id  = n_Rating_ID)   and
            (subject_id = n_Subject_ID);

        if (row_count() = 0) then
            -- 报错，退出。流出元宝的账户必须存在。
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE updateDstFundSummary(
    in  n_Game_ID             integer,       -- 2
    in  n_Dst_User_ID         integer,       -- 3
    in  n_Rating_ID           integer,       -- 4
    in  n_Amount              integer,        -- 5
    out n_Result              integer
)
BEGIN
    declare n_Subject_ID          integer default  5; /* UMS_USER_FUND_SUMMARY.Subject_Id%TYPE */
    declare n_Tmp_GW_State        integer default  0;
    label_proc:begin
        declare continue handler for 1062 begin end;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID             is null) or
            (n_Dst_User_ID         is null) or
            (n_Rating_ID           is null) or
            (n_Amount              is null) or
            (n_Amount                 <= 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        label_loop:loop
            update
                UMS_USER_FUND_SUMMARY
            set
                total_exchange_in = total_exchange_in + n_Amount
            where
                (game_id    = n_Game_ID    ) and
                (user_id    = n_Dst_User_ID) and
                (rating_id  = n_Rating_ID)   and
                (subject_id = n_Subject_ID);

            if (row_count() = 1) then
                leave label_loop;
            end if;

            -- 流入元宝的账户可能还不存在账户总额记录，创建之。
            insert into UMS_USER_FUND_SUMMARY(
                user_id,           rating_id,          subject_id,
                total_charge,      total_purchase,
                total_exchange_in, total_exchange_out,
                delay_msg,         game_id
            )
            values (
                n_Dst_User_ID,     n_Rating_ID,        n_Subject_ID,
                0,                 0,
                0,                 0,
                0,                 n_Game_ID
            );
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$


CREATE PROCEDURE userCashExchange(
    in  n_Game_ID             integer,       -- 2
    in  n_Gateway_ID          integer,       -- 2
    in  n_Detail_ID           bigint,       -- 3
    in  n_Src_User_ID         integer unsigned,       -- 4
    in  n_Src_Role_ID         integer,       -- 5
    in  n_Dst_User_ID         integer unsigned,       -- 6
    in  n_Dst_Role_ID         integer,       -- 7
    in  n_Subject_ID          integer,       -- 8
    in  n_Amount              integer,       -- 9
    in  d_Exchange_Time       datetime,      -- 10
    in  n_Flag                integer,       -- 11 n_Flag = 1 首发 2 重发 3 补单

    out n_Ret_Total_Exchange  integer,       -- 12
    out n_Result              integer
)
BEGIN
    call userCashExchangeEx(
        n_Game_ID,
        n_Gateway_ID,
        n_Detail_ID,
        n_Src_User_ID,
        n_Src_Role_ID,
        n_Dst_User_ID,
        n_Dst_Role_ID,
        n_Subject_ID,
        n_Amount,
        d_Exchange_Time,
        n_Flag,
        1,

        n_Ret_Total_Exchange,
        n_Result
    );
END$$

CREATE PROCEDURE userCashExchangeEx(
    in  n_Game_ID             integer,       -- 2
    in  n_Gateway_ID          integer,       -- 3
    in  n_Detail_ID           bigint,        -- 4
    in  n_Src_User_ID         integer unsigned,       -- 5
    in  n_Src_Role_ID         integer,       -- 6
    in  n_Dst_User_ID         integer unsigned,       -- 7
    in  n_Dst_Role_ID         integer,       -- 8
    in  n_Subject_ID          integer,       -- 9
    in  n_Amount              integer,       -- 10
    in  d_Exchange_Time       datetime,      -- 12
    in  n_Flag                integer,       -- 13 n_Flag = 1 首发 2 重发 3 补单
    in  n_Exchange_Type       integer,       -- 14

    out n_Ret_Total_Exchange  integer,    -- 15
    out n_Result              integer
)
BEGIN
    declare n_RetCode  integer default  0;    /* PKG_UTIL.E_ERROR */

    declare d_log_time datetime default  now();
    declare n_log_id   bigint; /* LOG_USER_FUND_EXCHANGE.log_id%type */
    declare n_CheckSum integer; /* LOG_USER_FUND_EXCHANGE.checksum%type */
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1282;    /* PKG_UTIL.E_IB_PAY_DETAIL_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID         is null         ) or
            (n_Gateway_ID      is null         ) or
            (n_Gateway_ID      = 0             ) or
            (n_Detail_ID       is null         ) or
            (n_Src_User_ID     is null         ) or
            (n_Src_Role_ID     is null         ) or
            (n_Dst_User_ID     is null         ) or
            (n_Dst_Role_ID     is null         ) or
            (n_Subject_ID      is null         ) or
            (n_Subject_ID      <>    5         ) or
            (n_Amount          is null         ) or
            (n_Amount          <=    0         ) or
            (d_Exchange_Time   is null         ) or
            (n_Exchange_Type   is null         ) or
            (n_Exchange_Type   <=    0         ) or
            (n_Flag            is null         ) or
            (n_Flag            not in(1, 2, 3) )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call isUserIDExisted(n_Game_ID, n_Src_User_ID, n_RetCode);
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call isUserIDExisted(n_Game_ID, n_Dst_User_ID, n_RetCode);
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 计算checksum
        call checksumCashExchange(
             n_Gateway_ID,
             n_Src_User_ID,
             n_Dst_User_ID,
             n_Subject_ID,
             n_Amount,
             n_CheckSum,
             n_RetCode
             );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call updateSrcFundSummary(
            n_Game_ID,
            n_Src_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
            );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call updateDstFundSummary(
            n_Game_ID,
            n_Dst_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
            );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 入库 流水重复时报错返回
        insert into LOG_USER_FUND_EXCHANGE(
            detail_id,     src_user_id,
            src_role_id,     dst_user_id,   dst_role_id,
            rating_id,       subject_id,    amount,
            exchange_time,   checksum,      log_time,
            game_id,         src_game_id,   dst_game_id,
            exchange_type
        )values(
            n_Detail_ID,   n_Src_User_ID,
            n_Src_Role_ID,   n_Dst_User_ID, n_Dst_Role_ID,
            n_Gateway_ID,    n_Subject_ID,  n_Amount,
            d_Exchange_Time, n_CheckSum,    d_log_time,
            n_Game_ID,       n_Game_ID,     n_Game_ID,
            n_Exchange_Type
        );

        select last_insert_id() into n_log_id;

        -- 修改帐户余额
        -- 减掉来源账户金额
        call consume( n_Game_ID, n_Src_User_ID, n_Gateway_ID, 5, n_Amount, n_RetCode );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 增加目的账户金额
        call deposit5( n_Game_ID, n_Dst_User_ID,  n_Gateway_ID, n_Amount, n_RetCode );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 更新流通总额

        label_loop:loop
            update
                SYS_RATING_FUND_SUMMARY t
            set
                t.total_exchange = t.total_exchange + n_Amount
            where
                t.rating_id  = n_Gateway_ID and
                t.subject_id = n_Subject_ID and
                t.game_id    = n_Game_ID;
            if (row_count() = 1) then
                select
                    total_exchange
                into
                    n_Ret_Total_Exchange
                from
                    SYS_RATING_FUND_SUMMARY
                where
                    rating_id  = n_Gateway_ID and
                    subject_id = n_Subject_ID and
                    game_id    = n_Game_ID;
                leave label_loop;
            end if;

            insert into SYS_RATING_FUND_SUMMARY(
                rating_id,      subject_id,   total_charge,
                total_purchase, total_exchange, game_id
            ) values(
                n_Gateway_ID,   n_Subject_ID, 0,
                0,              n_Amount,     n_Game_ID
            );
            if (row_count() = 1) then
                select
                    total_exchange
                into
                    n_Ret_Total_Exchange
                from
                    SYS_RATING_FUND_SUMMARY
                where
                    rating_id  = n_Gateway_ID and
                    subject_id = n_Subject_ID and
                    game_id    = n_Game_ID;
                leave label_loop;
            end if;
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 跨game_id元宝流通
CREATE PROCEDURE userCashExchangeEx1(
    in  n_Game_ID             integer,       -- 2
    in  n_Gateway_ID          integer,       -- 3
    in  n_Detail_ID           bigint,        -- 4
    in  n_Src_User_ID         integer unsigned,       -- 5
    in  n_Src_Role_ID         integer,       -- 6
    in  n_Dst_User_ID         integer unsigned,       -- 7
    in  n_Dst_Role_ID         integer,       -- 8
    in  n_Subject_ID          integer,       -- 9
    in  n_Amount              integer,       -- 10
    in  d_Exchange_Time       datetime,      -- 11
    in  n_Flag                integer,       -- 12 n_Flag = 1 首发 2 重发 3 补单
    in  n_Exchange_Type       integer,       -- 13
    in  n_Src_Game_ID         integer,       -- 14
    in  n_Dst_Game_ID         integer,       -- 15

    out n_Ret_Total_Exchange  integer,    -- 16
    out n_Result              integer
)
BEGIN
    declare n_RetCode  integer default  0;    /* PKG_UTIL.E_ERROR */

    declare d_log_time datetime default  now();
    declare n_log_id   bigint; /* LOG_USER_FUND_EXCHANGE.log_id%type */
    declare n_CheckSum integer; /* LOG_USER_FUND_EXCHANGE.checksum%type */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Src_Game_ID           integer;
    declare n_Tmp_Dst_Game_ID           integer;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1282;    /* PKG_UTIL.E_IB_PAY_DETAIL_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Src_Game_ID = n_Src_Game_ID;
        set n_Tmp_Dst_Game_ID = n_Dst_Game_ID;
        if (
            (n_Game_ID         is null         ) or
            (n_Gateway_ID      is null         ) or
            (n_Gateway_ID      = 0             ) or
            (n_Detail_ID       is null         ) or
            (n_Src_User_ID     is null         ) or
            (n_Src_Role_ID     is null         ) or
            (n_Dst_User_ID     is null         ) or
            (n_Dst_Role_ID     is null         ) or
            (n_Subject_ID      is null         ) or
            (n_Subject_ID      <>    5         ) or
            (n_Amount          is null         ) or
            (n_Amount          <=    0         ) or
            (d_Exchange_Time   is null         ) or
            (n_Exchange_Type   is null         ) or
            (n_Exchange_Type   <=    0         ) or
            (n_Flag            is null         ) or
            (n_Flag            not in(1, 2, 3) ) or
            (n_Src_Game_ID     is null         ) or
            (n_Dst_Game_ID     is null         )
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
            call isMingleUserIDExisted(n_Tmp_Src_Game_ID, n_Src_User_ID, n_RetCode);
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;   
            end if;
            call isMingleUserIDExisted(n_Tmp_Dst_Game_ID, n_Dst_User_ID, n_RetCode);
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;   
            end if;
        else
            call isUserIDExisted(n_Src_Game_ID, n_Src_User_ID, n_RetCode);
            if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call isUserIDExisted(n_Dst_Game_ID, n_Dst_User_ID, n_RetCode);
            if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        -- 计算checksum
        call checksumCashExchange(
            n_Gateway_ID,
            n_Src_User_ID,
            n_Dst_User_ID,
            n_Subject_ID,
            n_Amount,
            n_CheckSum,
            n_RetCode
        );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call updateSrcFundSummary(
            n_Tmp_Src_Game_ID,
            n_Src_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
        );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call updateDstFundSummary(
            n_Tmp_Dst_Game_ID,
            n_Dst_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
        );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 入库 流水重复时报错返回
        insert into LOG_USER_FUND_EXCHANGE(
            log_id,          detail_id,     src_user_id,
            src_role_id,     dst_user_id,   dst_role_id,
            rating_id,       subject_id,    amount,
            exchange_time,   checksum,      log_time,
            game_id,         src_game_id,   dst_game_id,
            exchange_type
        )values(
            n_log_id,        n_Detail_ID,   n_Src_User_ID,
            n_Src_Role_ID,   n_Dst_User_ID, n_Dst_Role_ID,
            n_Gateway_ID,    n_Subject_ID,  n_Amount,
            d_Exchange_Time, n_CheckSum,    d_log_time,
            n_Game_ID,       n_Tmp_Src_Game_ID, n_Tmp_Dst_Game_ID,
            n_Exchange_Type
        );

        -- 修改帐户余额
        -- 减掉来源账户金额
        call consume( n_Tmp_Src_Game_ID, n_Src_User_ID, n_Gateway_ID, 5, n_Amount, n_RetCode );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 增加目的账户金额
        call deposit5( n_Tmp_Dst_Game_ID, n_Dst_User_ID,  n_Gateway_ID, n_Amount, n_RetCode );
        if ( 1 <> n_RetCode ) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 更新流通总额
        label_loop:loop
            update
                SYS_RATING_FUND_SUMMARY t
            set
                t.total_exchange = t.total_exchange + n_Amount
            where
                t.rating_id  = n_Gateway_ID and
                t.subject_id = n_Subject_ID and
                t.game_id    = n_Game_ID;
            if (row_count() = 1) then
                select
                    total_exchange
                into
                    n_Ret_Total_Exchange
                from
                    SYS_RATING_FUND_SUMMARY
                where
                    rating_id  = n_Gateway_ID and
                    subject_id = n_Subject_ID and
                    game_id    = n_Game_ID;
                leave label_loop;
            end if;

            insert into SYS_RATING_FUND_SUMMARY(
                rating_id,      subject_id,   total_charge,
                total_purchase, total_exchange, game_id
            ) values(
                n_Gateway_ID,   n_Subject_ID, 0,
                0,              n_Amount,     n_Game_ID
            );
            if (row_count() = 1) then
                select
                    total_exchange
                into
                    n_Ret_Total_Exchange
                from
                    SYS_RATING_FUND_SUMMARY
                where
                    rating_id  = n_Gateway_ID and
                    subject_id = n_Subject_ID and
                    game_id    = n_Game_ID;
                leave label_loop;
            end if;
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- 回退账户的元宝流通总额
    -- 流入、流出时n_Amount参数均为正数
    -- 撤销元宝流通记录时，n_Amount参数为负数
CREATE PROCEDURE rollbackSrcFundSummary(
    in  n_Src_Game_ID         integer,       -- 2
    in  n_Src_User_ID         integer unsigned,       -- 3
    in  n_Rating_ID           integer,       -- 4
    in  n_Amount              integer,        -- 5
    out n_Result              integer
)
BEGIN
    declare n_Subject_ID          integer default  5; /* UMS_USER_FUND_SUMMARY.Subject_Id%TYPE */
    declare n_Total_Exchange      integer; /* UMS_USER_FUND_SUMMARY.total_exchange_out%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Src_Game_ID         is null) or
            (n_Src_User_ID         is null) or
            (n_Rating_ID           is null) or
            (n_Amount              is null) or
            (n_Amount                 <= 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update
            UMS_USER_FUND_SUMMARY
        set
            total_exchange_out = total_exchange_out - n_Amount
        where
            (game_id    = n_Src_Game_ID) and
            (user_id    = n_Src_User_ID) and
            (rating_id  = n_Rating_ID)   and
            (subject_id = n_Subject_ID);
        if (row_count() = 0) then
            -- 原流出元宝的账户必须存在。
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        select
            total_exchange_out
        into
            n_Total_Exchange
        from
            UMS_USER_FUND_SUMMARY
        where
            (game_id    = n_Src_Game_ID) and
            (user_id    = n_Src_User_ID) and
            (rating_id  = n_Rating_ID)   and
            (subject_id = n_Subject_ID);
        if (FOUND_ROWS() = 0) then
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        if (n_Total_Exchange < 0) then
            set n_Result = -505;    /* PKG_UTIL.E_SYS_DATABASE_DATA_INVALID */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE rollbackDstFundSummary(
    in  n_Dst_Game_ID         integer,       -- 2
    in  n_Dst_User_ID         integer unsigned,       -- 3
    in  n_Rating_ID           integer,       -- 4
    in  n_Amount              integer,        -- 5
    out n_Result              integer
)
BEGIN
    declare n_Subject_ID          integer default  5; /* UMS_USER_FUND_SUMMARY.Subject_Id%TYPE */
    declare n_Total_Exchange      integer; /* UMS_USER_FUND_SUMMARY.total_exchange_out%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Dst_Game_ID         is null) or
            (n_Dst_User_ID         is null) or
            (n_Rating_ID           is null) or
            (n_Amount              is null) or
            (n_Amount                 <= 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update
            UMS_USER_FUND_SUMMARY
        set
            total_exchange_in = total_exchange_in - n_Amount
        where
            (game_id    = n_Dst_Game_ID) and
            (user_id    = n_Dst_User_ID) and
            (rating_id  = n_Rating_ID)   and
            (subject_id = n_Subject_ID);
        if (row_count() = 0) then
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        select
            total_exchange_in
        into
            n_Total_Exchange
        from
            UMS_USER_FUND_SUMMARY
        where
            (game_id    = n_Dst_Game_ID) and
            (user_id    = n_Dst_User_ID) and
            (rating_id  = n_Rating_ID)   and
            (subject_id = n_Subject_ID);
        if (FOUND_ROWS() = 0) then
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        if (n_Total_Exchange < 0) then
            set n_Result = -505;    /* PKG_UTIL.E_SYS_DATABASE_DATA_INVALID */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE cancelCashExchangeByDetailID(
    in  n_Detail_ID           bigint,        -- 2
    out n_Result              integer
)
BEGIN
    declare n_RetCode  integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Gateway_ID integer default  0; /* LOG_USER_FUND_EXCHANGE.rating_id%type */
    declare n_Src_User_ID integer unsigned default  0; /* LOG_USER_FUND_EXCHANGE.src_user_id%type */
    declare n_Dst_User_ID integer unsigned default  0; /* LOG_USER_FUND_EXCHANGE.dst_user_id%type */
    declare n_Subject_ID integer default  0; /* LOG_USER_FUND_EXCHANGE.subject_id%type */
    declare n_Amount integer default  0; /* LOG_USER_FUND_EXCHANGE.amount%type */
    declare n_Game_ID integer default  0; /* LOG_USER_FUND_EXCHANGE.game_id%type */
    declare n_Src_Game_ID integer default  0; /* LOG_USER_FUND_EXCHANGE.src_game_id%type */
    declare n_Dst_Game_ID integer default  0; /* LOG_USER_FUND_EXCHANGE.dst_game_id%type */
    declare s_Tmp_Game_Name varchar(20);
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Detail_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- 查询流水信息
        select
            rating_id,     subject_id,    amount,
            src_user_id,   dst_user_id,   game_id,
            src_game_id,   dst_game_id
        into
            n_Gateway_ID,  n_Subject_ID,  n_Amount,
            n_Src_User_ID, n_Dst_User_ID, n_Game_ID,
            n_Src_Game_ID, n_Dst_Game_ID
        from
            LOG_USER_FUND_EXCHANGE
        where
            detail_id = n_Detail_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
            leave label_proc;
        end if;

        -- 对源game_id与目标game_id合法性作判断,此处判断在一般情况下不应出错
        select
            slave_game_name
        into
            s_Tmp_Game_Name
        from
            SYS_SLAVE_GAMES
        where
            game_id = n_Game_ID and
            slave_game_id = n_Src_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1122;
            leave label_proc;
        end if;

        select
            slave_game_name
        into
            s_Tmp_Game_Name
        from
            SYS_SLAVE_GAMES
        where
            game_id = n_Game_ID and
            slave_game_id = n_Dst_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1122;    /* PKG_UTIL.E_GAME_ID_NOT_EXIST */
            leave label_proc;
        end if;

        -- 回退原元宝流入账户的帐户余额
        call consume(n_Dst_Game_ID, n_Dst_User_ID, n_Gateway_ID, 5, n_Amount, n_RetCode);
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 回退原元宝流出账户的账户余额
        call deposit5(n_Src_Game_ID, n_Src_User_ID,  n_Gateway_ID, n_Amount, n_RetCode);
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 回退目标账户元宝流通总额
        call rollbackDstFundSummary(
            n_Dst_Game_ID,
            n_Dst_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
            );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 回退源账户元宝流通总额
        call rollbackSrcFundSummary(
            n_Src_Game_ID,
            n_Src_User_ID,
            n_Gateway_ID,
            n_Amount,
            n_RetCode
            );
        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- 回退网关元宝流通总额
        update
            SYS_RATING_FUND_SUMMARY t
        set
            t.total_exchange = t.total_exchange - n_Amount
        where
            t.rating_id  = n_Gateway_ID and
            t.subject_id = n_Subject_ID and
            t.game_id    = n_Game_ID;

        if (row_count() <> 1) then
            set n_Result = -1446;    /* PKG_UTIL.E_FUND_NOT_FOUND */
            leave label_proc;
        end if;

        -- 删除元宝流通日志记录
        delete from
            LOG_USER_FUND_EXCHANGE
        where
            detail_id = n_Detail_ID;

        if (row_count() <> 1) then
            set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$
DELIMITER ;
