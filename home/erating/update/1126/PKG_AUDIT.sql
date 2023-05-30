DROP PROCEDURE getBgnDetailID;
DROP PROCEDURE getDetailIDList;
DROP PROCEDURE updateNextBgnDetailID;
DROP PROCEDURE getCashExDetailIDList;
DELIMITER $$

 /*  消费对账 */
 /*  获取起始ID */
CREATE PROCEDURE getBgnDetailID (
    in  n_Game_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Subject_ID         integer,
    in  n_Detail_Type        integer,

    out n_Ret_Bgn_Detail_ID  bigint,
    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID           is null) or
            (n_Gateway_ID        is null) or
            (n_Subject_ID        is null) or
            (n_Detail_Type       is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select begin_purchase_id
        into   n_Ret_Bgn_Detail_ID
        from   SYS_PAY_DETAIL_AUDIT
        where  (gateway_id    = n_Gateway_ID) and
               (subject_id    = n_Subject_ID)  and
               (audit_type    = n_Detail_Type) and
               (game_id       = n_Game_ID);

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
            set n_Ret_Bgn_Detail_ID = 0;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

 /*  获取消费ID列表 */
CREATE PROCEDURE getDetailIDList (
    in  n_Game_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Subject_ID         integer,
    in  n_Bgn_Detail_ID      bigint,
    in  n_End_Detail_ID      bigint,

    out n_Total_Amount       integer,          /* 总额 */
    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (n_Subject_ID       is null) or
            (n_Bgn_Detail_ID    is null) or
            (n_End_Detail_ID    is null) or
            (n_Bgn_Detail_ID    > n_End_Detail_ID)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select IFNULL(sum(cost_amount), 0)
        into   n_Total_Amount
        from   UMS_USER_PURCHASE_DETAIL d
        where  (gateway_id      = n_Gateway_ID) and
               (subject_id      = n_Subject_ID) and
               (product_code    != '5')         and
               (purchase_id     >= n_Bgn_Detail_ID) and
               (purchase_id     <= n_End_Detail_ID) and
               (game_id         =  n_Game_ID);

        select purchase_id
        from   UMS_USER_PURCHASE_DETAIL
        where  (gateway_id      = n_Gateway_ID) and
               (subject_id      = n_Subject_ID) and
               (product_code    != '5')         and
               (purchase_id     >= n_Bgn_Detail_ID) and
               (purchase_id     <= n_End_Detail_ID) and
               (game_id         =  n_Game_ID)
        order by purchase_id
        limit 100;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

 /* 记录下一次对账起始ID */
CREATE PROCEDURE updateNextBgnDetailID (
    in  n_Game_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Subject_ID         integer,
    in  n_Detail_ID          bigint,
    in  n_Detail_Type        integer,

    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID      is null) or
            (n_Gateway_ID   is null) or
            (n_Subject_ID   is null) or
            (n_Detail_ID    is null) or
            (n_Detail_Type  is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update SYS_PAY_DETAIL_AUDIT
        set    begin_purchase_id   = n_Detail_ID,
               audit_time    = now()
        where  (gateway_id    = n_Gateway_ID) and
               (subject_id   = n_Subject_ID)  and
               (audit_type   = n_Detail_Type) and
               (game_id      = n_Game_ID);

        if (ROW_COUNT() = 0) then
            insert into SYS_PAY_DETAIL_AUDIT (
                gateway_id,         audit_type,        subject_id,
                begin_purchase_id,  audit_time,        game_id
            )
            values (
                n_Gateway_ID,       n_Detail_Type,     n_Subject_ID,
                n_Detail_ID,        now(),         n_Game_ID
            );
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

 /* 获取消费ID列表 */
CREATE PROCEDURE getCashExDetailIDList (
    in  n_Game_ID            integer,
    in  n_Rating_ID          integer,
    in  n_Subject_ID         integer,
    in  n_Bgn_Detail_ID      bigint,
    in  n_End_Detail_ID      bigint,

    out n_Total_Amount       integer,        -- 总额
    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Rating_ID        is null) or
            (n_Subject_ID       is null) or
            (n_Bgn_Detail_ID    is null) or
            (n_End_Detail_ID    is null) or
            (n_Bgn_Detail_ID    > n_End_Detail_ID)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select IFNULL(sum(AMOUNT), 0)
        into   n_Total_Amount
        from   LOG_USER_FUND_EXCHANGE e
        where  (rating_id       = n_Rating_ID)  and
               (subject_id      = n_Subject_ID) and
               (detail_id       >= n_Bgn_Detail_ID) and
               (detail_id       <= n_End_Detail_ID) and
               (game_id         =  n_Game_ID);

        select detail_id
        from   LOG_USER_FUND_EXCHANGE
        where  (rating_id       = n_Rating_ID)  and
               (subject_id      = n_Subject_ID) and
               (detail_id       >= n_Bgn_Detail_ID) and
               (detail_id       <= n_End_Detail_ID) and
               (game_id         =  n_Game_ID)
        order by detail_id
        limit 64;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
