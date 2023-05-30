DROP PROCEDURE jointPurchase;
DROP PROCEDURE deleteIBPay;
DROP PROCEDURE deleteIBPay6;
DROP PROCEDURE checkIBParam;
DROP PROCEDURE updateTotalPuschase;
DROP PROCEDURE getIBInfo;
DROP PROCEDURE getIBPayWarning;
DROP PROCEDURE purchaseDetail;
DROP PROCEDURE logPurchaseDetail;
DROP PROCEDURE doIBPay;
DROP PROCEDURE doIBPay4;
DROP PROCEDURE doIBPay5;
DROP PROCEDURE doIBPayMix;
DROP PROCEDURE userIBPay;
DROP PROCEDURE addJointPurchasePush;
DROP PROCEDURE getPurchasePushMsg;
DROP PROCEDURE preJointPurchase;
DROP PROCEDURE UpdatePurchasePushMsg;
DELIMITER $$

CREATE PROCEDURE deleteIBPay(
    in  n_Game_ID       integer,
    in  n_Purchase_ID   bigint,

    out n_Result        integer
)
BEGIN
    declare n_RetCode                 integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Cost_Amount         integer; /* UMS_USER_PURCHASE_DETAIL.cost_amount%TYPE */
    declare n_Tmp_User_ID             integer unsigned; /* UMS_USER_PURCHASE_DETAIL.user_id%TYPE */
    declare n_Tmp_Rating_ID           integer; /* UMS_USER_PURCHASE_DETAIL.rating_id%TYPE */
    declare n_Tmp_Subject_ID          integer; /* UMS_USER_PURCHASE_DETAIL.subject_id%TYPE */

    declare s_Tmp_Global_Recharge     varchar(32); /* SYS_OPTION.option_value%type */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID       is null) or
            (n_Purchase_ID   is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            d.cost_amount,     d.user_id,     d.rating_id,     d.subject_id
        into
            n_Tmp_Cost_Amount, n_Tmp_User_ID, n_Tmp_Rating_ID, n_Tmp_Subject_ID
        from
            UMS_USER_PURCHASE_DETAIL d
        where
            d.purchase_id = n_Purchase_ID and
            d.game_id     = n_Game_ID;

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
            set n_Result = -1281; /* PKG_UTIL.E_IB_PAY_DETAIL_NOT_EXIST; */
            leave label_proc;
        end if;

        /* 使用subject_id = 5 的游戏，不处理subject_id = 3 的撤单 */
        /* 使用subject_id = 3 的游戏，不处理subject_id = 5 的撤单 */
         call getOptionValue(
                     n_Game_ID,
                     'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
                     '1',    /* PKG_OPTION.R_OPENED */
                     s_Tmp_Global_Recharge
                     );

        if (
            (
                (s_Tmp_Global_Recharge  = '1') and    /* PKG_OPTION.R_OPENED */
                (n_Tmp_Subject_ID       = 3  )
            ) or
            (
                (s_Tmp_Global_Recharge  = '0') and    /* PKG_OPTION.R_CLOSED */
                (n_Tmp_Subject_ID       = 5  )
            )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        delete from
            UMS_USER_PURCHASE_DETAIL
        where
            purchase_id = n_Purchase_ID and
            game_id     = n_Game_ID;

        if (ROW_COUNT() = 0) then /* unreasonable exception. */
            leave label_proc;
        end if;

        if(4 = n_Tmp_Subject_ID) then
            set n_Result = 1;
            leave label_proc;
        end if;

        /* subject_id in (3, 5) */
        /* 回退消费总额 */
        update
            UMS_USER_FUND_SUMMARY
        set
            total_purchase = total_purchase - n_Tmp_Cost_Amount
        where
            user_id     = n_Tmp_User_ID   and
            rating_id   = n_Tmp_Rating_ID and
            subject_id  = n_Tmp_Subject_ID and
            game_id     = n_Game_ID;

        if (ROW_COUNT() = 0) then
            set n_Result = -1283;  /* PKG_UTIL.E_FUND_SUMMARY_NOT_EXIST; */
            leave label_proc;
        end if;

        call refund(
            n_Game_ID,
            n_Tmp_User_ID,
            n_Tmp_Rating_ID,
            n_Tmp_Subject_ID,
            n_Tmp_Cost_Amount,

            n_RetCode
        );

        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE deleteIBPay6(
    in  n_Game_ID       integer,
    in  n_Purchase_ID   bigint,
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Purchase_ID    is null) or
            (n_Game_ID        is null)
           ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        delete from
            LOG_USER_PURCHASE_DETAIL
        where
            game_id     = n_Game_ID and
            purchase_id = n_Purchase_ID;

        if (ROW_COUNT() = 0) then -- unreasonable exception.
            set n_Result = -1281; -- PKG_UTIL.E_IB_PAY_DETAIL_NOT_EXIST;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE checkIBParam(
    in  n_Game_ID          integer,
    in  n_Purchase_ID      bigint,
    in  n_User_ID          integer unsigned,
    in  n_Role_ID          integer,
    in  n_Role_Gender      integer,
    in  n_Role_Occupation  integer,
    in  n_Role_Level       integer,
    in  n_Rating_ID        integer,
    in  n_Gateway_ID       integer,
    in  s_IB_Code          varchar(32),
    in  n_IB_Flag          integer,
    in  n_IB_Count         integer,
    in  d_Trade_Time       datetime,
    in  n_User_IP          integer unsigned,
    in  n_Subject_ID       integer,
    in  n_Audit_Flag       integer,
    in  n_Price            integer,
    in  n_Discount_Price   integer,
    in  n_Max_IB_Count     integer,

    out n_Result           integer
)
BEGIN
    declare n_Tmp_Purchase_id  bigint; /* UMS_USER_PURCHASE_DETAIL.purchase_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null              ) or
            (n_Purchase_ID    is null              ) or
           /* (n_Purchase_ID  <= 4294967296) or */
            (n_User_ID        is null              ) or
            (n_Role_ID        is null              ) or
           /* (s_IB_Code        is null              ) or */
            (n_Subject_ID     is null              ) or
            (n_Subject_ID not in (3,4,5,6,8)       ) or
            (n_IB_Flag   is null                   ) or
            (
                (n_IB_Flag <> 1) and    /* PKG_UTIL.DF_IB_PRODUCT */
                (n_IB_Flag <> 2)    /* PKG_UTIL.DF_IB_PACKAGE */
            )                           or
            (n_IB_Count        is null             ) or
            (n_Rating_ID       is null             ) or
            (n_Gateway_ID      is null             ) or
            (n_Rating_ID       <> n_Gateway_ID     ) or
            (n_Rating_ID       <= 0                ) or
            (n_User_IP         is null             ) or
            (n_IB_Count        <= 0                ) or
            (n_Max_IB_Count    is null             ) or
            (n_Max_IB_Count    <= 0                ) or
            (n_Audit_Flag      is null             ) or
            (n_Audit_Flag      < 1                 ) or
            (n_Audit_Flag      > 4                 ) or
            (
                (n_Audit_Flag <> 4) and
                (s_IB_Code is null)
            )  or
            (n_Price           is null             ) or
            (n_Discount_Price  is null             ) or
            (d_trade_Time      is null             ) or
            (n_Role_Gender     is null             ) or
            (n_Role_Occupation is null             ) or
            (n_Role_Level      is null             ) or
            (n_IB_Flag     = 2)     /* PKG_UTIL.DF_IB_PACKAGE */
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            t.purchase_id
        into
            n_Tmp_Purchase_ID
        from
            UMS_USER_PURCHASE_DETAIL t
        where
            t.purchase_id = n_Purchase_ID and
            t.game_id     = n_Game_ID;

        if (
            (FOUND_ROWS() = 0) and
            (n_Audit_Flag > 3)
        ) then /* NO_DATA_FOUND */
            set n_Result = -1281; /* PKG_UTIL.E_IB_PAY_DETAIL_NOT_EXIST; */
            leave label_proc;
        elseif (
            (FOUND_ROWS() <> 0) and
            (n_Audit_Flag <= 3)
        ) then
            set n_Result = -1282;  /* PKG_UTIL.E_IB_PAY_DETAIL_DUPLICATE */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE updateTotalPuschase(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_Rating_ID        integer,
    in  n_Subject_ID       integer,
    in  n_Cost_Amount      integer,

    out n_Total_Purchase   integer,
    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        select
            total_purchase + n_Cost_Amount
        into
            n_Total_Purchase
        from
            UMS_USER_FUND_SUMMARY
        where
            user_id     = n_User_ID   and
            rating_id   = n_Rating_ID and
            subject_id  = n_Subject_ID and
            game_id     = n_Game_ID
        for update;

        if (FOUND_ROWS() = 0) then
            insert into UMS_USER_FUND_SUMMARY(
                user_id,      rating_id,        subject_id,
                total_charge, total_purchase,
                total_exchange_in,              total_exchange_out,
                delay_msg,    game_id
            )
            values(
                n_User_ID,    n_Rating_ID,      n_Subject_ID,
                0,            n_Cost_Amount,
                0,            0,
                0,            n_Game_ID
            );
            set n_Total_Purchase = n_Cost_Amount;
        else
            update
                UMS_USER_FUND_SUMMARY
            set
                total_purchase = n_Total_Purchase
            where
                user_id     = n_User_ID   and
                rating_id   = n_Rating_ID and
                subject_id  = n_Subject_ID and
                game_id     = n_Game_ID;

            if (ROW_COUNT() <> 1) then
                set n_Result = -1283;
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getIBInfo(
    in  n_Game_ID                integer,
    in  s_IB_Code                varchar(32),
    in  d_time                   datetime,

    out n_Ret_Product_ID         integer,
    out n_Ret_Product_Use_Type   integer,
    out n_Ret_Product_State      integer,
    out n_Ret_Product_Period     integer,
    out d_Ret_Expire_Time        datetime,
    out n_Result                 integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (s_IB_Code is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Ret_Product_ID       = 0;
        set n_Ret_Product_Use_Type = 0;
        set n_Ret_Product_State    = 0;
        set n_Ret_Product_Period   = 0;
        set d_Ret_Expire_Time      = d_time;

        select
            t.product_id,        t.product_use_type,
            t.product_state,     t.product_period,     t.expire_time
        into
            n_Ret_Product_ID,    n_Ret_Product_Use_Type,
            n_Ret_Product_State, n_Ret_Product_Period, d_Ret_Expire_Time
        from
            SYS_PRODUCT t
        where
            t.product_code = s_IB_Code and
            t.game_id      = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getIBPayWarning(
    in  n_Game_ID            integer,
    in  s_IB_Code            varchar(32),
    in  n_Subject_ID         integer,
    in  d_Trade_Time         datetime,
    in  n_IB_Flag            integer,
    in  n_Price              integer,
    in  n_Discount_Price     integer,
    in  n_Product_ID         integer,
    in  n_Product_State      integer,
    in  d_Expire_Time        datetime,

    out n_Result             integer
)
BEGIN
    declare n_Tmp_Origin_Price   integer; /* SYS_PRODUCT_PRICE.price_origin%type */
    declare n_Tmp_Discount_Price integer; /* SYS_PRODUCT_PRICE.price_discount%type */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null                 ) or
            (s_IB_Code        is null                 ) or
            (n_Subject_ID     is null                 ) or
            (n_Subject_ID     not in(3, 4, 5)         ) or
            (d_Trade_Time     is null                 ) or
            (n_IB_Flag        is null                 ) or
            (n_IB_Flag        = 2) or    /* PKG_UTIL.DF_IB_PACKAGE */
            (n_Price          is null                 ) or
            (n_Discount_Price is null                 ) or
            (n_Product_ID     is null                 ) or
            (n_Product_State  is null                 ) or
            (d_Expire_Time    is null                 )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        if (
             (n_Product_ID    = 0) and
             (n_Product_State = 0)
        ) then
            set n_Result = abs(-1451);    /* PKG_UTIL.E_USER_IB_ITEM_NOT_FOUND */
            leave label_proc;
        end if;

        if (
            (n_Product_State <> 1                ) or
            (d_trade_Time    >  d_Expire_Time)
        ) then
            set n_Result = abs(-1459);    /* PKG_UTIL.E_USER_IB_ITEM_EXPIRED */
            leave label_proc;
        end if;

        select
            price_discount,       price_origin
        into
            n_Tmp_Discount_Price, n_Tmp_Origin_Price
        from
            SYS_PRODUCT_PRICE P
        where
            (product_id  =  n_Product_ID) and
            (subject_id  =  n_Subject_ID) and
            (effect_time <= d_Trade_Time) and
            (expire_time >  d_Trade_Time) and
            game_id = n_Game_ID;

        if (FOUND_ROWS()  = 0) then /* NO_DATA_FOUND */
            set n_Result = abs(-1454);    /* PKG_UTIL.E_USER_IB_ITEM_PRICE_ERROR */
            leave label_proc;
        end if;

        /* 如果价格不一致，返回大于1的操作结果 */
        if (
            (n_Tmp_Origin_Price   <> n_Price         ) or
            (n_Tmp_Discount_Price <> n_Discount_Price)
        ) then
            set n_Result = abs(-1454);    /* PKG_UTIL.E_USER_IB_ITEM_PRICE_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE purchaseDetail(
    in  n_Game_ID              integer,
    in  n_Purchase_ID          bigint,
    in  n_User_ID              integer unsigned,
    in  n_Role_ID              integer,
    in  n_Role_Gender          integer,
    in  n_Role_Occupation      integer,
    in  n_Role_Level           integer,
    in  n_Rating_ID            integer,
    in  n_GateWay_ID           integer,
    in  s_IB_Code              varchar(32),
    in  n_IB_Count             integer,   /* 数量 */
    in  d_Trade_Time           datetime,      /* 交易时间 */
    in  n_User_IP              integer unsigned,
    in  n_Subject_ID           integer,
    in  n_Price                integer,
    in  n_Discount_Price       integer,   /* 折扣价格 */
    in  n_Product_ID           integer,
    in  n_Product_Use_Type     integer,
    in  n_Product_Period       integer,
    in  n_Promoter_ID          integer,
    in  n_Ad_ID                integer,
    in  n_log_time             datetime,

    out n_Result               integer
)
BEGIN
    declare n_RetCode          integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Log_ID       bigint; /* UMS_USER_PURCHASE_DETAIL.log_id%type */

    label_proc:begin
        declare exit handler for 1062 set n_Result = -1460;    /* PKG_UTIL.E_PAY_DUPLICATE */
        set n_Result = 0; /* E_ERROR */

        insert into UMS_USER_PURCHASE_DETAIL(
            purchase_id,                user_id,              role_id,
            role_gender,                role_occupation,      role_level,
            rating_id,                  gateway_id,

            package_id,                 product_id,           product_use_type,
            product_num,                purchase_ip,          purchase_time,
            subject_id,

            cost_amount,                promoter_id,          expire_time,
            use_user_id,                use_role_id,          use_time,
            province_code,              city_code,            ad_id,
            /* log_id, */               product_code,
            price_origin,               price_discount,       log_time,
            game_id
        )
        values(
            n_Purchase_ID,              n_User_ID,            n_Role_ID,
            n_Role_Gender,              n_Role_Occupation,    n_Role_Level,
            n_Rating_ID,                n_Gateway_ID,

            0,                          n_Product_ID,         n_Product_Use_Type,
            n_IB_Count,                 n_User_IP,            d_Trade_Time,
            n_Subject_ID,

            n_IB_Count*n_Discount_Price,n_Promoter_ID,        date_add(d_Trade_Time, interval n_Product_Period second),
            0,                          0,                    null,
            '--',                       '--',                 n_Ad_ID,
            /* n_Tmp_Log_ID, */         s_IB_Code,
            n_Price,                    n_Discount_Price,     n_log_time,
            n_Game_ID
        );

         /* 记录每日日志的LOG_ID范围 */
        call logDailyFirstLogID(
            'UMS_USER_PURCHASE_DETAIL',
            n_log_time,
            last_insert_id(),

            n_RetCode
        );

        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE logPurchaseDetail(
    in  n_Game_ID              integer,
    in  n_Purchase_ID          bigint,
    in  n_User_ID              integer unsigned,
    in  n_Role_ID              integer,
    in  n_Role_Gender          integer,
    in  n_Role_Occupation      integer,
    in  n_Role_Level           integer,
    in  n_Rating_ID            integer,
    in  n_GateWay_ID           integer,
    in  s_IB_Code              varchar(32),
    in  n_IB_Count             integer,   /* 数量 */
    in  d_Trade_Time           datetime,      /* 交易时间 */
    in  n_User_IP              integer unsigned,
    in  n_Subject_ID           integer,
    in  n_Price                integer,
    in  n_Discount_Price       integer,   /* 折扣价格 */
    in  n_Product_ID           integer,
    in  n_Product_Use_Type     integer,
    in  n_Product_Period       integer,
    in  n_Promoter_ID          integer,
    in  n_Ad_ID                integer,
    in  n_log_time             datetime,

    out n_Result               integer
)
BEGIN
    declare n_RetCode          integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Log_ID       bigint; /* UMS_USER_PURCHASE_DETAIL.log_id%type */

    label_proc:begin
        declare exit handler for 1062 set n_Result = -1460;    /* PKG_UTIL.E_PAY_DUPLICATE */
        set n_Result = 0; /* E_ERROR */

        insert into LOG_USER_PURCHASE_DETAIL(
            purchase_id,                user_id,              role_id,
            role_gender,                role_occupation,      role_level,
            rating_id,                  gateway_id,

            package_id,                 product_id,           product_use_type,
            product_num,                purchase_ip,          purchase_time,
            subject_id,

            cost_amount,                promoter_id,          expire_time,
            use_user_id,                use_role_id,          use_time,
            province_code,              city_code,            ad_id,
            /* log_id, */               product_code,
            price_origin,               price_discount,       log_time,
            game_id
        )
        values(
            n_Purchase_ID,              n_User_ID,            n_Role_ID,
            n_Role_Gender,              n_Role_Occupation,    n_Role_Level,
            n_Rating_ID,                n_Gateway_ID,

            0,                          n_Product_ID,         n_Product_Use_Type,
            n_IB_Count,                 n_User_IP,            d_Trade_Time,
            n_Subject_ID,

            n_IB_Count*n_Discount_Price,n_Promoter_ID,        date_add(d_Trade_Time, interval n_Product_Period second),
            0,                          0,                    null,
            '--',                       '--',                 n_Ad_ID,
            /* n_Tmp_Log_ID, */         s_IB_Code,
            n_Price,                    n_Discount_Price,     n_log_time,
            n_Game_ID
        );

         /* 记录每日日志的LOG_ID范围 */
        call logDailyFirstLogID(
            'LOG_USER_PURCHASE_DETAIL',
            n_log_time,
            last_insert_id(),

            n_RetCode
        );

        if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE doIBPay(
    in  n_Game_ID          integer,             /*  2 */
    in  n_Purchase_ID      bigint,              /*  3 */
    in  n_User_ID          integer unsigned,    /*  4 */
    in  n_Role_ID          integer unsigned,    /*  5 */
    in  n_Role_Gender      integer,             /*  6 */
    in  n_Role_Occupation  integer,             /*  7 */
    in  n_Role_Level       integer,             /*  8 */
    in  n_Rating_ID        integer,             /*  9 */
    in  n_GateWay_ID       integer,             /*  10 */
    in  s_IB_Code          varchar(32),         /*  11 */
    in  n_IB_Flag          integer,             /*  12 */
    in  n_IB_Count         integer,             /*  13  数量 */
    in  d_Trade_Time       datetime,            /*  14  交易时间 */
    in  n_User_IP          integer unsigned,    /*  15 */
    in  n_Subject_ID       integer,             /*  16 */
    in  n_Audit_Flag       integer,             /*  17 1: 首发消费信息；2：重发消费信息；3: 补单；4：撤单； */
    in  n_Price            integer,             /*  18 */
    in  n_Discount_Price   integer,             /*  19 折扣价格 */
    in  n_Max_IB_Count     integer,             /*  20 */

    out n_Total_purchase   integer,             /* 21 */
    out n_Result           integer              /* 22 */
)
BEGIN
    declare n_Tmp_Product_ID          integer; /* SYS_PRODUCT.product_id%type */
    declare n_Tmp_Product_Use_Type    integer; /* SYS_PRODUCT.product_use_type%type */
    declare n_Tmp_Product_State       integer; /* SYS_PRODUCT.product_state%type */
    declare n_Tmp_Product_Period      integer; /* SYS_PRODUCT.product_period%type */
    declare d_Tmp_Expire_Time         datetime; /* SYS_PRODUCT.expire_time%type */
    declare d_Tmp_Date                datetime default  now();
    declare s_Tmp_Major_Subject       varchar(32); /* SYS_OPTION.option_value%type */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        /* 撤单 */
        if(n_Audit_Flag = 4) then
            call deleteIBPay(n_Game_ID, n_Purchase_ID, n_Result);
            leave label_proc;
        end if;

        /* 首发、重发、补单 */
        call checkIBParam(
                        n_Game_ID,
                        n_Purchase_ID,
                        n_User_ID,
                        n_Role_ID,
                        n_Role_Gender,
                        n_Role_Occupation,
                        n_Role_Level,
                        n_Rating_ID,
                        n_GateWay_ID,
                        s_IB_Code,
                        n_IB_Flag,
                        n_IB_Count,
                        d_Trade_Time,
                        n_User_IP,
                        n_Subject_ID,
                        n_Audit_Flag,
                        n_Price,
                        n_Discount_Price,
                        n_Max_IB_Count,

                        n_Result
                        );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        /* 使用3的，不允许5的消费；使用5的，不允许3的消费； */
        call getOptionValue(
                         n_Game_ID,
                         'major_subject',
                         null,

                         s_Tmp_Major_Subject
                         );

        if (select s_Tmp_Major_Subject <> n_Subject_ID) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getIBInfo(
                    n_Game_ID,
                    s_IB_Code,
                    d_Tmp_Date,
                    n_Tmp_Product_ID,
                    n_Tmp_Product_Use_Type,
                    n_Tmp_Product_State,
                    n_Tmp_Product_Period,
                    d_Tmp_Expire_Time,

                    n_Result
                    );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call consume(
                  n_Game_ID,
                  n_User_ID,
                  n_Rating_ID,
                  n_Subject_ID,
                  n_Discount_Price*n_IB_Count,

                  n_Result
                  );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call purchaseDetail(
                n_Game_ID,
                n_Purchase_ID,
                n_User_ID,
                n_Role_ID,
                n_Role_Gender,
                n_Role_Occupation,
                n_Role_Level,
                n_Rating_ID,
                n_GateWay_ID,
                s_IB_Code,
                n_IB_Count,
                d_Trade_Time,
                n_User_IP,
                n_Subject_ID,
                n_Price,
                n_Discount_Price,
                n_Tmp_Product_ID,
                n_Tmp_Product_Use_Type,
                n_Tmp_Product_Period,
                0,          /* Promoter_ID */
                0,          /* Ad_ID */
                d_Tmp_Date,

                n_Result
                );
        if (1 <> n_Result) then /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call updateTotalPuschase(
                             n_Game_ID,
                             n_User_ID,
                             n_Rating_ID,
                             n_Subject_ID,
                             n_Discount_Price*n_IB_Count,
                             n_Total_purchase,

                             n_Result
                             );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call getIBPayWarning(
                        n_Game_ID,
                        s_IB_Code,
                        n_Subject_ID,
                        d_Trade_Time,
                        n_IB_Flag,
                        n_Price,
                        n_Discount_Price,
                        n_Tmp_Product_ID,
                        n_Tmp_Product_State,
                        d_Tmp_Expire_Time,

                        n_Result
                        );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if (
            (n_Tmp_Product_Use_Type <> 4) and    /* PKG_UTIL.IB_USE_TYPE_INSTANT */
            (n_IB_Count             >  1)
        ) then
            set n_Result = abs(-1452);    /* PKG_UTIL.E_USER_IB_ITEM_TYPE_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE doIBPay4(
    in  n_Game_ID          integer,             /*  2 */
    in  n_Purchase_ID      bigint,              /*  3 */
    in  n_User_ID          integer unsigned,    /*  4 */
    in  n_Role_ID          integer unsigned,    /*  5 */
    in  n_Role_Gender      integer,             /*  6 */
    in  n_Role_Occupation  integer,             /*  7 */
    in  n_Role_Level       integer,             /*  8 */
    in  n_Rating_ID        integer,             /*  9 */
    in  n_GateWay_ID       integer,             /*  10 */
    in  s_IB_Code          varchar(32),         /*  11 */
    in  n_IB_Flag          integer,             /*  12 */
    in  n_IB_Count         integer,             /*  13  数量 */
    in  d_Trade_Time       datetime,            /*  14  交易时间 */
    in  n_User_IP          integer unsigned,    /*  15 */
    in  n_Subject_ID       integer,             /*  16 */
    in  n_Audit_Flag       integer,             /*  17 1: 首发消费信息；2：重发消费信息；3: 补单；4：撤单； */
    in  n_Price            integer,             /*  18 */
    in  n_Discount_Price   integer,             /*  19 折扣价格 */
    in  n_Max_IB_Count     integer,             /*  20 */

    out n_Total_purchase   integer,             /* 21 */
    out n_Result           integer              /* 22 */
)
BEGIN
    declare n_Tmp_Product_ID          integer; /* SYS_PRODUCT.product_id%type */
    declare n_Tmp_Product_Use_Type    integer; /* SYS_PRODUCT.product_use_type%type */
    declare n_Tmp_Product_State       integer; /* SYS_PRODUCT.product_state%type */
    declare n_Tmp_Product_Period      integer; /* SYS_PRODUCT.product_period%type */
    declare d_Tmp_Expire_Time         datetime; /* SYS_PRODUCT.expire_time%type */
    declare d_Tmp_Date                datetime default  now();
    declare s_Tmp_Global_Recharge     varchar(32); /* SYS_OPTION.option_value%type */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        /* 撤单 */
        if(n_Audit_Flag = 4) then
            call deleteIBPay(n_Game_ID, n_Purchase_ID, n_Result);
            leave label_proc;
        end if;

        /* 首发、重发、补单 */
        call checkIBParam(
                        n_Game_ID,
                        n_Purchase_ID,
                        n_User_ID,
                        n_Role_ID,
                        n_Role_Gender,
                        n_Role_Occupation,
                        n_Role_Level,
                        n_Rating_ID,
                        n_GateWay_ID,
                        s_IB_Code,
                        n_IB_Flag,
                        n_IB_Count,
                        d_Trade_Time,
                        n_User_IP,
                        n_Subject_ID,
                        n_Audit_Flag,
                        n_Price,
                        n_Discount_Price,
                        n_Max_IB_Count,

                        n_Result
                        );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call getIBInfo(
                    n_Game_ID,
                    s_IB_Code,
                    d_Tmp_Date,
                    n_Tmp_Product_ID,
                    n_Tmp_Product_Use_Type,
                    n_Tmp_Product_State,
                    n_Tmp_Product_Period,
                    d_Tmp_Expire_Time,

                    n_Result
                    );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call purchaseDetail(
                n_Game_ID,
                n_Purchase_ID,
                n_User_ID,
                n_Role_ID,
                n_Role_Gender,
                n_Role_Occupation,
                n_Role_Level,
                n_Rating_ID,
                n_GateWay_ID,
                s_IB_Code,
                n_IB_Count,
                d_Trade_Time,
                n_User_IP,
                n_Subject_ID,
                n_Price,
                n_Discount_Price,
                n_Tmp_Product_ID,
                n_Tmp_Product_Use_Type,
                n_Tmp_Product_Period,
                0,          /* Promoter_ID */
                0,          /* Ad_ID */
                d_Tmp_Date,

                n_Result
                );
        if (1 <> n_Result) then /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE doIBPayMix(
    in  n_Game_ID          integer,             /*  2 */
    in  n_Purchase_ID      bigint,              /*  3 */
    in  n_User_ID          integer unsigned,    /*  4 */
    in  n_Role_ID          integer unsigned,    /*  5 */
    in  n_Role_Gender      integer,             /*  6 */
    in  n_Role_Occupation  integer,             /*  7 */
    in  n_Role_Level       integer,             /*  8 */
    in  n_Rating_ID        integer,             /*  9 */
    in  n_GateWay_ID       integer,             /*  10 */
    in  s_IB_Code          varchar(32),         /*  11 */
    in  n_IB_Flag          integer,             /*  12 */
    in  n_IB_Count         integer,             /*  13  数量 */
    in  d_Trade_Time       datetime,            /*  14  交易时间 */
    in  n_User_IP          integer unsigned,    /*  15 */
    in  n_Subject_ID       integer,             /*  16 */
    in  n_Audit_Flag       integer,             /*  17 1: 首发消费信息；2：重发消费信息；3: 补单；4：撤单； */
    in  n_Price            integer,             /*  18 */
    in  n_Discount_Price   integer,             /*  19 折扣价格 */
    in  n_Max_IB_Count     integer,             /*  20 */

    out n_Total_purchase   integer,             /* 21 */
    out n_Result           integer              /* 22 */
)
BEGIN
    declare n_Tmp_Product_ID          integer; /* SYS_PRODUCT.product_id%type */
    declare n_Tmp_Product_Use_Type    integer; /* SYS_PRODUCT.product_use_type%type */
    declare n_Tmp_Product_State       integer; /* SYS_PRODUCT.product_state%type */
    declare n_Tmp_Product_Period      integer; /* SYS_PRODUCT.product_period%type */
    declare d_Tmp_Expire_Time         datetime; /* SYS_PRODUCT.expire_time%type */
    declare d_Tmp_Date                datetime default  now();

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        /* 撤单 */
        if(n_Audit_Flag = 4) then
            call deleteIBPay6(n_Game_ID, n_Purchase_ID, n_Result);
            leave label_proc;
        end if;

        /* 首发、重发、补单 */
        call checkIBParam(
                        n_Game_ID,
                        n_Purchase_ID,
                        n_User_ID,
                        n_Role_ID,
                        n_Role_Gender,
                        n_Role_Occupation,
                        n_Role_Level,
                        n_Rating_ID,
                        n_GateWay_ID,
                        s_IB_Code,
                        n_IB_Flag,
                        n_IB_Count,
                        d_Trade_Time,
                        n_User_IP,
                        n_Subject_ID,
                        n_Audit_Flag,
                        n_Price,
                        n_Discount_Price,
                        n_Max_IB_Count,

                        n_Result
                        );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call getIBInfo(
                    n_Game_ID,
                    s_IB_Code,
                    d_Tmp_Date,
                    n_Tmp_Product_ID,
                    n_Tmp_Product_Use_Type,
                    n_Tmp_Product_State,
                    n_Tmp_Product_Period,
                    d_Tmp_Expire_Time,

                    n_Result
                    );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call logPurchaseDetail(
                n_Game_ID,
                n_Purchase_ID,
                n_User_ID,
                n_Role_ID,
                n_Role_Gender,
                n_Role_Occupation,
                n_Role_Level,
                n_Rating_ID,
                n_GateWay_ID,
                s_IB_Code,
                n_IB_Count,
                d_Trade_Time,
                n_User_IP,
                n_Subject_ID,
                n_Price,
                n_Discount_Price,
                n_Tmp_Product_ID,
                n_Tmp_Product_Use_Type,
                n_Tmp_Product_Period,
                0,          /* Promoter_ID */
                0,          /* Ad_ID */
                d_Tmp_Date,

                n_Result
                );
        if (1 <> n_Result) then /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE userIBPay(
    in  n_Game_ID          integer,             /*  2 */
    in  n_Purchase_ID      bigint,              /*  3 */
    in  n_User_ID          integer unsigned,    /*  4 */
    in  n_Role_ID          integer unsigned,    /*  5 */
    in  n_Role_Gender      integer,             /*  6 */
    in  n_Role_Occupation  integer,             /*  7 */
    in  n_Role_Level       integer,             /*  8 */
    in  n_Rating_ID        integer,             /*  9 */
    in  n_GateWay_ID       integer,             /*  10 */
    in  s_IB_Code          varchar(32),         /*  11 */
    in  n_IB_Flag          integer,             /*  12 */
    in  n_IB_Count         integer,             /*  13  数量 */
    in  d_Trade_Time       datetime,            /*  14  交易时间 */
    in  n_User_IP          integer unsigned,    /*  15 */
    in  n_Subject_ID       integer,             /*  16 */
    in  n_Audit_Flag       integer,             /*  17 1: 首发消费信息；2：重发消费信息；3: 补单；4：撤单； */
    in  n_Price            integer,             /*  18 */
    in  n_Discount_Price   integer,             /*  19 折扣价格 */
    in  n_Max_IB_Count     integer,             /*  20 */

    out n_Total_purchase   integer,             /* 21 */
    out n_Result           integer              /* 22 */
)
BEGIN
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        set n_Tmp_Game_ID = n_Game_ID;
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
        case n_Subject_ID
            when 3 then
                call doIBPay(
                            n_Tmp_Game_ID,
                            n_Purchase_ID,
                            n_User_ID,
                            n_Role_ID,
                            n_Role_Gender,
                            n_Role_Occupation,
                            n_Role_Level,
                            n_Rating_ID,
                            n_GateWay_ID,
                            s_IB_Code,
                            n_IB_Flag,
                            n_IB_Count,
                            d_Trade_Time,
                            n_User_IP,
                            n_Subject_ID,
                            n_Audit_Flag,
                            n_Price,
                            n_Discount_Price,
                            n_Max_IB_Count,
                            n_Total_purchase,

                            n_Result
                    );
            when 4 then
                call doIBPay4(
                            n_Tmp_Game_ID,
                            n_Purchase_ID,
                            n_User_ID,
                            n_Role_ID,
                            n_Role_Gender,
                            n_Role_Occupation,
                            n_Role_Level,
                            n_Rating_ID,
                            n_GateWay_ID,
                            s_IB_Code,
                            n_IB_Flag,
                            n_IB_Count,
                            d_Trade_Time,
                            n_User_IP,
                            n_Subject_ID,
                            n_Audit_Flag,
                            n_Price,
                            n_Discount_Price,
                            n_Max_IB_Count,
                            n_Total_purchase,

                            n_Result
                        );
            when 5 then
                call doIBPay(
                            n_Tmp_Game_ID,
                            n_Purchase_ID,
                            n_User_ID,
                            n_Role_ID,
                            n_Role_Gender,
                            n_Role_Occupation,
                            n_Role_Level,
                            n_Rating_ID,
                            n_GateWay_ID,
                            s_IB_Code,
                            n_IB_Flag,
                            n_IB_Count,
                            d_Trade_Time,
                            n_User_IP,
                            n_Subject_ID,
                            n_Audit_Flag,
                            n_Price,
                            n_Discount_Price,
                            n_Max_IB_Count,
                            n_Total_purchase,

                            n_Result
                        );
            when 6 then
                call doIBPayMix(
                            n_Tmp_Game_ID,
                            n_Purchase_ID,
                            n_User_ID,
                            n_Role_ID,
                            n_Role_Gender,
                            n_Role_Occupation,
                            n_Role_Level,
                            n_Rating_ID,
                            n_GateWay_ID,
                            s_IB_Code,
                            n_IB_Flag,
                            n_IB_Count,
                            d_Trade_Time,
                            n_User_IP,
                            n_Subject_ID,
                            n_Audit_Flag,
                            n_Price,
                            n_Discount_Price,
                            n_Max_IB_Count,
                            n_Total_purchase,

                            n_Result
                        );
            when 8 then
                call doIBPayMix(
                            n_Tmp_Game_ID,
                            n_Purchase_ID,
                            n_User_ID,
                            n_Role_ID,
                            n_Role_Gender,
                            n_Role_Occupation,
                            n_Role_Level,
                            n_Rating_ID,
                            n_GateWay_ID,
                            s_IB_Code,
                            n_IB_Flag,
                            n_IB_Count,
                            d_Trade_Time,
                            n_User_IP,
                            n_Subject_ID,
                            n_Audit_Flag,
                            n_Price,
                            n_Discount_Price,
                            n_Max_IB_Count,
                            n_Total_purchase,

                            n_Result
                        );
            else
                set n_Result= -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
        end case;
    end label_proc;
END$$

CREATE PROCEDURE jointPurchase(
    in    n_Game_ID              integer,
    in    n_Purchase_ID          bigint unsigned,
    in    n_User_ID              integer unsigned,
    in    n_Role_ID              integer,
    in    n_Role_Gender          integer,
    in    n_Role_Occupation      integer,
    in    n_Role_Level           integer,
    in    n_Rating_ID            integer,
    in    n_GateWay_ID           integer,
    in    s_IB_Code              varchar(32),
    in    n_IB_Flag              integer,
    in    n_IB_Count             integer,  -- 数量
    in    d_Trade_Time           datetime,    -- 交易时间
    in    n_User_IP              integer,
    in    n_Subject_ID           integer,
    in    n_Audit_Flag           integer,
    in    n_Price                integer,
    in    n_Discount_Price       integer, -- 折扣价格
    in    n_Max_IB_Count         integer,
    out   n_Total_purchase       integer,
    out   n_Result               integer
)
BEGIN
    declare n_RetCode    integer default 0;

    declare n_Charge_Amount integer default 0;
    declare n_Total_Charge_Amount integer default 0;
    declare n_Balance_3     integer default 0;
    declare n_Balance_5     integer default 0;
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID        is null              ) or
            (n_Purchase_ID    is null              ) or
            (n_User_ID        is null              ) or
            (n_Role_ID        is null              ) or
            (s_IB_Code        is null              ) or
            (n_Subject_ID     is null              ) or
            (n_Subject_ID     <> 5                 ) or
            (n_IB_Flag   is null                   ) or
            (n_IB_Flag        <> 1                 ) or
      
            (n_IB_Count        is null             ) or
            (n_IB_Count        <= 0                ) or
            (n_Rating_ID       is null             ) or
            (n_User_IP         is null             ) or
            (n_Max_IB_Count    is null             ) or
            (n_Max_IB_Count    <= 0                ) or
            (n_Audit_Flag      is null             ) or
            (n_Audit_Flag      < 1                 ) or
            (n_Audit_Flag      > 4                 ) or
            (
                (n_Audit_Flag <> 4) and
                (s_IB_Code is null)
            )  or
            (n_Price           is null             ) or
            (n_Discount_Price  is null             ) or
            (d_trade_Time      is null             ) or
            (n_Role_Gender     is null             ) or
            (n_Role_Occupation is null             ) or
            (n_Role_Level      is null             )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if (n_Game_ID not in (746, 753, 760, 761, 762, 763, 764, 911)) then
            set n_Result = -1120;
            leave label_proc;
        end if;

        set n_Charge_Amount = n_Discount_Price * n_IB_Count;

        call innerCharge(
            n_Game_ID,
            n_User_ID,
            0,
            n_Charge_Amount,
            3,
            10, -- 联运充值渠道为 10
            1,
            d_Trade_Time,
            0,
            n_Purchase_ID,
            cast(n_Purchase_ID as char),
            1,   -- 直充
            n_RetCode
        );
        if (1 <> n_RetCode) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call convert3to5(
            n_Game_ID,
            n_User_ID,
            0,
            n_Rating_ID,
            n_Charge_Amount,
            d_Trade_Time,
            ' ',

            n_Balance_3,
            n_Balance_5,
            n_RetCode
        );
        if (1 <> n_RetCode) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call innerPushChargeMsg(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Total_Charge_Amount,
            n_RetCode
        );
        if (1 <> n_RetCode) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call doIBPay5(
            n_Game_ID,
            n_Purchase_ID,
            n_User_ID,
            n_Role_ID,
            n_Role_Gender,
            n_Role_Occupation,
            n_Role_Level,
            n_Rating_ID,
            n_GateWay_ID,
            s_IB_Code,
            n_IB_Flag,
            n_IB_Count,
            d_Trade_Time,
            n_User_IP,
            n_Subject_ID,
            n_Audit_Flag,
            n_Price,
            n_Discount_Price,
            n_Max_IB_Count,
            n_Total_purchase,
            n_RetCode
        );
        -- doIBPay5()的返回值要特殊对待
        --     返回值小于等于0表示错误，大于0的表示成功。
        --     大于0非1的值表示告警信息，但是依然要按消费成功处理，
        --     不能goto ExitError;否则后续代码将得不到执行。
        if (n_RetCode <= 0) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Total_Charge_Amount <> n_Total_purchase) then
            set n_Result = -1440;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE doIBPay5(
    in  n_Game_ID            integer,    -- 2
    in  n_Purchase_ID        bigint unsigned,    -- 3
    in  n_User_ID            integer unsigned,    -- 4
    in  n_Role_ID            integer,    -- 5
    in  n_Role_Gender        integer,    -- 6
    in  n_Role_Occupation    integer,    -- 7
    in  n_Role_Level         integer,    -- 8
    in  n_Rating_ID          integer,    -- 9
    in  n_GateWay_ID         integer,    -- 10
    in  s_IB_Code            varchar(32),  -- 11
    in  n_IB_Flag            integer,    -- 12
    in  n_IB_Count           integer,    -- 13  -- 数量
    in  d_Trade_Time         datetime,      -- 14  -- 交易时间
    in  n_User_IP            integer,    -- 15
    in  n_Subject_ID         integer,    -- 16
    in  n_Audit_Flag         integer,    -- 17 -- 1: 首发消费信息；2：重发消费信息；3: 补单；4：撤单；
    in  n_Price              integer,    -- 18
    in  n_Discount_Price     integer,    -- 19 -- 折扣价格
    in  n_Max_IB_Count       integer,    -- 20
    out n_Total_purchase     integer,     -- 21
    out n_Result             integer
)
BEGIN
    declare n_RetCode              integer default 0;

    declare n_Tmp_Product_ID       integer;
    declare n_Tmp_Product_Use_Type integer;
    declare n_Tmp_Product_State    integer;
    declare n_Tmp_Product_Period   integer;
    declare d_Tmp_Expire_Time      datetime;

    declare n_Tmp_Promoter_ID      integer;
    declare n_Tmp_Ad_ID            bigint;
    declare d_Tmp_Date             datetime default now();
    label_proc:begin
         set n_Result = 0; /* E_ERROR */
        /* 撤单 */
        if(n_Audit_Flag = 4) then
            call deleteIBPay(n_Game_ID, n_Purchase_ID, n_Result);
            leave label_proc;
        end if;

        /* 首发、重发、补单 */
        call checkIBParam(
                        n_Game_ID,
                        n_Purchase_ID,
                        n_User_ID,
                        n_Role_ID,
                        n_Role_Gender,
                        n_Role_Occupation,
                        n_Role_Level,
                        n_Rating_ID,
                        n_GateWay_ID,
                        s_IB_Code,
                        n_IB_Flag,
                        n_IB_Count,
                        d_Trade_Time,
                        n_User_IP,
                        n_Subject_ID,
                        n_Audit_Flag,
                        n_Price,
                        n_Discount_Price,
                        n_Max_IB_Count,

                        n_Result
                        );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call getIBInfo(
                    n_Game_ID,
                    s_IB_Code,
                    d_Tmp_Date,
                    n_Tmp_Product_ID,
                    n_Tmp_Product_Use_Type,
                    n_Tmp_Product_State,
                    n_Tmp_Product_Period,
                    d_Tmp_Expire_Time,

                    n_Result
                    );
        if (1 <> n_Result) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call consume(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            5,
            n_Discount_Price*n_IB_Count,
            n_RetCode
            );
        if (1 <> n_RetCode) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call purchaseDetail(
                n_Game_ID,
                n_Purchase_ID,
                n_User_ID,
                n_Role_ID,
                n_Role_Gender,
                n_Role_Occupation,
                n_Role_Level,
                n_Rating_ID,
                n_GateWay_ID,
                s_IB_Code,
                n_IB_Count,
                d_Trade_Time,
                n_User_IP,
                n_Subject_ID,
                n_Price,
                n_Discount_Price,
                n_Tmp_Product_ID,
                n_Tmp_Product_Use_Type,
                n_Tmp_Product_Period,
                0,          /* Promoter_ID */
                0,          /* Ad_ID */
                d_Tmp_Date,

                n_Result
                );
        if (1 <> n_Result) then /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call updateTotalPuschase(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Discount_Price*n_IB_Count,
            n_Total_purchase,
            n_RetCode
        );
        if (1 <> n_RetCode) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Audit_Flag <> 4) then
            if (1 = n_Result) then
                call getIBPayWarning(
                    n_Game_ID,
                    s_IB_Code,
                    n_Subject_ID,
                    d_Trade_Time,
                    n_IB_Flag,
                    n_Price,
                    n_Discount_Price,
                    n_Tmp_Product_ID,
                    n_Tmp_Product_State,
                    d_Tmp_Expire_Time,
                    n_Result
                );
            end if;
            if(1 <> n_Result) then
                leave label_proc;
            elseif (
                (1           =  n_Result              ) and
                (4 <> n_Tmp_Product_Use_Type) and
                (n_IB_Count                   >  1                     )
            ) then
                set n_Result = 1452;  -- -- 非类型4物品多于一个时，报警：类型错误
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE addJointPurchasePush(
    IN  n_Game_ID        INTEGER, 
    IN  n_Detail_ID      bigint unsigned, 
    IN  n_Result_Code    INTEGER, 
    IN  n_User_ID        INTEGER unsigned, 
    IN  n_Rating_ID      INTEGER unsigned, 
    IN  s_IB_Code        VARCHAR(32), 
    IN  n_IB_Count       INTEGER, 
    IN  n_Subject_ID     INTEGER, 
    IN  n_Discount_Price INTEGER, 
    OUT n_Result         INTEGER
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if(
            ( n_Game_ID           is null )       or
            ( n_Detail_ID         is null )       or
            ( n_Result_Code       is null )       or
            ( n_User_ID           is null )       or
            ( n_Rating_ID         is null )       or
            ( s_IB_Code           is null )       or
            ( n_IB_Count          is null )       or
            ( n_Subject_ID        is null )       or
            ( n_Discount_Price    is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        insert ignore into SYS_JOINT_PURCHASE_PUSH(
            game_id,          detail_id,
            result_code,      user_id,
            rating_id,        ib_code,
            ib_count,         subject_id,
            discount_price,   send_times
        )
        values(
            n_Game_ID,        n_Detail_ID,
            n_Result_Code,    n_User_ID,
            n_Rating_ID,      s_IB_Code,
            n_IB_Count,       n_Subject_ID,
            n_Discount_Price, 0
       );
       if(row_count()=0) then
           set n_Result = -1460;
           leave label_proc;
       end if;

       set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getPurchasePushMsg(
    IN  n_Game_ID        INTEGER, 
    IN  n_Rating_ID      INTEGER, 
    IN  n_Max_Count      INTEGER, 
    OUT n_Result         INTEGER
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if(
            ( n_Game_ID           is null )       or
            ( n_Rating_ID         is null )       or
            ( n_Max_Count         is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set @g_Game_ID = n_Game_ID;
        set @g_Rating_ID = n_Rating_ID;
        set @g_Max_Count = n_Max_Count;

        prepare stmt1 from "
            select
                detail_id,        result_code,
                user_id,          rating_id,
                ib_code,          ib_count,
                subject_id,       discount_price,
                send_times
            from
                SYS_JOINT_PURCHASE_PUSH
            where
                game_id = ? and
                rating_id = ?
            limit ?
            ";
        execute stmt1 using @g_Game_ID, @g_Rating_ID, @g_Max_Count;
        deallocate prepare stmt1;

       set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE preJointPurchase(
    IN  n_Game_ID        INTEGER, 
    IN  n_Detail_ID      bigint unsigned, 
    IN  n_User_ID        INTEGER unsigned, 
    IN  n_Role_ID        INTEGER, 
    IN  s_IB_Code        VARCHAR(32),

    OUT s_Ret_User_Name  VARCHAR(32),
    OUT s_Ret_Role_Name  VARCHAR(32),
    OUT s_Ret_Item_Name  VARCHAR(256),
    OUT n_Result         INTEGER
)
BEGIN
    declare d_Purchase_Time datetime;
    label_proc:begin
        set n_Result = 0;
        if(
            ( n_Game_ID           is null )       or
            ( n_Detail_ID         is null )       or
            ( n_User_ID           is null )       or
            ( n_Role_ID           is null )       or
            ( s_IB_Code           is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            purchase_time
        into
            d_Purchase_Time
        from
            UMS_USER_PURCHASE_DETAIL
        where
            game_id = n_Game_ID and
            purchase_id = n_Detail_ID;
        if (FOUND_ROWS() = 1) then
            set n_Result = -1460;
            leave label_proc;
        end if;

        select
            user_name
        into
            s_Ret_User_Name
        from
            UMS_USER
        where
            user_id = n_User_ID and
            game_id = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1201;
            leave label_proc;
        end if;

        select
            role_name
        into
            s_Ret_Role_Name
        from
            UMS_ROLE
        where
            role_id = n_Role_ID and
            game_id = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1252;
            leave label_proc;
        end if;

        select
            product_name
        into
            s_Ret_Item_Name
        from
            SYS_PRODUCT
        where
            product_code = s_IB_Code and
            game_id      = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1451;
            leave label_proc;
        end if;

       set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE UpdatePurchasePushMsg(
    IN  n_Game_ID        INTEGER,
    IN  n_Detail_ID      bigint unsigned,
    IN  n_Return_Result  INTEGER,
    IN  n_Rating_ID      INTEGER,
    OUT n_Result         INTEGER
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if(
            ( n_Game_ID           is null )       or
            ( n_Detail_ID         is null )       or
            ( n_Return_Result     is null )       or
            ( n_Rating_ID         is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if (
            (n_Return_Result = 1) or
            (n_Return_Result = -1460)
        ) then
            delete from
                SYS_JOINT_PURCHASE_PUSH
            where
                game_id = n_Game_ID and
                detail_id = n_Detail_ID;
        else
            update
                SYS_JOINT_PURCHASE_PUSH
            set
                send_times = send_times + 1
            where
                game_id = n_Game_ID and
                detail_id = n_Detail_ID;
        end if;

       set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
