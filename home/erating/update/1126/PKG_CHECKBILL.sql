DROP PROCEDURE GetChargeMsg;
DROP PROCEDURE GetChargeMsgForAudit;
DROP PROCEDURE UpdateChargeMsg;
DROP PROCEDURE GetBeginAuditDetailID;
DROP PROCEDURE GetDailyChargeAmount;
DROP PROCEDURE innerPushChargeMsg;
DELIMITER $$

    -- ��ȡSYS_USER_CHARGE_INFO���еĳ�ֵ��Ϣ
CREATE PROCEDURE GetChargeMsg(
    in  n_Game_ID                integer,                  -- 2
    in  n_Rating_ID              integer,                  -- 3
    in  n_Subject_ID             integer,                  -- 4
    in  n_Max_Detail_ID          bigint,                   -- 5
    in  n_Info_Amount            integer,                  -- 6

    out n_Result                 integer
)
BEGIN

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- �����Ϸ��Լ���
        if (
            (n_Game_ID is null) or
            (n_Rating_ID is null) or
            (n_Rating_ID <= 0) or
            (n_Max_Detail_ID is null) or
            (n_Max_Detail_ID < 0) or
            (n_Max_Detail_ID > 999999999999999) or
            (n_Info_Amount is null) or
            (n_Info_Amount <= 0) or
            (n_Info_Amount > 2000)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set @n_Rating_ID = n_Rating_ID;
        set @n_Subject_ID = n_Subject_ID;
        set @n_Max_Detail_ID = n_Max_Detail_ID;
        set @n_Game_ID = n_Game_ID;
        set @n_Info_Amount = n_Info_Amount;
        prepare s_Sql_Text from '
            select
                fund_log_id as detail_id, user_id,       rating_id,
                subject_id,  charge_amount, unix_timestamp(charge_time),
                retry_times, game_id
            from
                SYS_USER_CHARGE_INFO
            where
                rating_id = ? and
                subject_id = ? and
                fund_log_id > ? and
                game_id = ?
            order by
                fund_log_id
            limit ?';
        execute s_Sql_Text using @n_Rating_ID, @n_Subject_ID, @n_Max_Detail_ID, @n_Game_ID, @n_Info_Amount;

        deallocate prepare s_Sql_Text;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ������ʼ������ˮ�Ż�ȡ��ֵ�굥�б������ڳ�ֵ�Ե�
CREATE PROCEDURE GetChargeMsgForAudit(
    in  n_Game_ID             integer,          -- 2
    in  n_User_ID             integer unsigned,          -- 3
    in  n_Rating_ID           integer,          -- 4
    in  n_Subject_ID          integer,          -- 5
    in  n_Begin_Detail_ID     bigint,           -- 6
    in  n_End_Detail_ID       bigint,           -- 7
    in  n_Max_Info_Count      integer,          -- 8

    out n_Result              integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- �����Ϸ��Լ���
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_Rating_ID is null) or
            (n_Subject_ID is null) or
            (n_Begin_Detail_ID is null) or
            (n_Begin_Detail_ID < 0) or
            (n_End_Detail_ID  is null) or
            (n_End_Detail_ID < 0) or
            (n_End_Detail_ID > 999999999999999) or
            (n_Begin_Detail_ID > n_End_Detail_ID) or
            (n_Max_Info_Count <= 0) or
            (n_Max_Info_Count > 64)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- ѡ�����������ĳ�ֵ�굥
        set @n_Game_ID = n_Game_ID;
        set @n_User_ID = n_User_ID;
        set @n_Rating_ID = n_Rating_ID;
        set @n_Subject_ID = n_Subject_ID;
        set @n_Begin_Detail_ID = n_Begin_Detail_ID;
        set @n_End_Detail_ID = n_End_Detail_ID;
        set @n_Max_Info_Count = n_Max_Info_Count;
        prepare s_Sql_Text from 'select
                log_id detail_id, user_id, rating_id,
                subject_id, charge_amount, unix_timestamp(charge_time), game_id
            from
                LOG_USER_FUND_DETAIL fd
            where
                (fd.user_id = ?) and
                (fd.rating_id = ?) and
                (fd.subject_id = ?) and
                (fd.log_id >= ?) and
                (fd.log_id < ?) and
                (fd.game_id = ?)
            order by
                fd.log_id desc
            limit
                ?';
        execute s_Sql_Text using @n_User_ID, @n_Rating_ID, @n_Subject_ID, @n_Begin_Detail_ID, @n_End_Detail_ID, @n_Game_ID, @n_Max_Info_Count;

        deallocate prepare s_Sql_Text;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    /*
    �������ݿ��г�ֵ��¼��ˢ�·��ʹ�����ˢ�³�ֵ�ܶ
    ���س�ֵ�ܶ�Ե���ʼ��ˮ�ţ�ɾ�����ͳɹ��ĳ�ֵ��¼��
     */
CREATE PROCEDURE UpdateChargeMsg(
    in  n_Game_ID               integer,       -- 2
    in  n_Detail_ID             bigint ,       -- 3
    in  n_Return_Result         integer,       -- 4
    in  n_Rating_ID             integer,       -- 5
    in  n_User_ID               integer unsigned,       -- 6
    in  n_Subject_ID            integer,       -- 7

    out n_Total_Charge_Amount   integer,       -- 8
    out n_Result                integer
)
BEGIN
    declare n_Result_Code           integer default  0;
    declare n_RetCode               integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Sent_Times            integer default  0;
    declare n_Charge_Amount         integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- ��������Ϸ���
        if (
            (n_Game_ID is null) or
            (n_Detail_ID is null) or
            (n_Detail_ID <= 0) or
            (n_Detail_ID > 999999999999999) or
            (n_Return_Result is null) or
            (n_Rating_ID is null) or
            (n_User_ID is null) or
            (n_Subject_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Result_Code = n_Return_Result;
        set n_Total_Charge_Amount = 0;

        -- ������Ϣretry_times��ÿһ������1��
        -- û�м�¼�򷵻�-1473(-1473)    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
        update
            SYS_USER_CHARGE_INFO
        set
            retry_times = retry_times + 1
        where
            fund_log_id = n_Detail_ID;
        if (row_count() = 0) then
           set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
           leave label_proc;
        end if;

        select
            retry_times, charge_amount
        into
            n_Sent_Times, n_Charge_Amount
        from
            SYS_USER_CHARGE_INFO
        where
            fund_log_id = n_Detail_ID;
        if (found_rows() = 0) then
           set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
           leave label_proc;
        end if;

        if (n_Result_Code = -1472) then    /* PKG_UTIL.E_CHARGE_DUPLICATE */
            set n_Result_Code = 1;    /* PKG_UTIL.S_SUCCESS */
        end if;

        -- ���³�ֵ�ܶ�������������ֵ��Ϣ�ͷ���ֵ��Ϣ
        if (n_Charge_Amount >= 0) then
            -- ֻ���״η���ʱˢ�³�ֵ�ܶ�
            -- *** �������ѷ��͹��ĳ�ֵ��Ϣ�ٴη���SYS_USER_CHARGE_INFO�ڣ�������eChargeSvr ***
            if (n_Sent_Times = 1) then
                update
                    UMS_USER_FUND_SUMMARY
                set
                    total_charge = total_charge + n_Charge_Amount
                where
                    (user_id = n_User_ID)and
                    (rating_id = n_Rating_ID)and
                    (subject_id = n_Subject_ID) and
                    (game_id = n_Game_ID);

                -- ����Ǹ��˺��ڸ�����������ֵ��Ϣ��
                -- ������µ��ܶ��¼
                if (row_count() = 0) then
                   set n_Total_Charge_Amount = n_Charge_Amount;

                   insert into UMS_USER_FUND_SUMMARY(
                       user_id,        rating_id,        subject_id,
                       total_charge,                     total_purchase,
                       total_exchange_in,                total_exchange_out,
                       delay_msg,      game_id)
                   values(
                       n_User_ID,      n_Rating_ID,      n_Subject_ID,
                       n_Total_Charge_Amount,            0,
                       0,                                0,
                       0,              n_Game_ID);
                end if;
            end if;
        else
            -- ����ֵ��Ϣ�����н���ˣ�������ؽӿڣ����·���ֵ��Ϣ
            if (
                (n_Result_Code = 1) or    /* PKG_UTIL.S_SUCCESS */
                (n_Result_Code = -312) or    /* PKG_UTIL.E_SYS_NET_OUT_OF_MAX_TIMES */
                (n_Result_Code = -1441)    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
                ) then
                call updateUnchargeInfo(n_Game_ID, n_Detail_ID, n_Result_Code, n_RetCode);

                if (1 <> n_RetCode) then    /* PKG_UTIL.S_SUCCESS */
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end if;

            -- ������ͷ���ֵ��Ϣ�ɹ� *�ҵ��ýӿڸ��·���ֵ��ϢҲ�ɹ�* ��
            -- ����³�ֵ�ܶ�
            if (
                (1 = n_Result_Code) and    /* PKG_UTIL.S_SUCCESS */
                (1 = n_RetCode)    /* PKG_UTIL.S_SUCCESS */
            ) then
                update
                    UMS_USER_FUND_SUMMARY
                set
                    total_charge = total_charge + n_Charge_Amount
                where
                    (user_id = n_User_ID)and
                    (rating_id = n_Rating_ID)and
                    (subject_id = n_Subject_ID) and
                    (game_id = n_Game_ID);

                -- ����Ǹ��˺��ڸ�������������ֵ��Ϣ��
                -- ������µ��ܶ��¼��ʵ���в�Ӧ�ó��ִ������
                if (row_count() = 0) then
                   set n_Total_Charge_Amount = n_Charge_Amount;

                   insert into UMS_USER_FUND_SUMMARY(
                       user_id,        rating_id,        subject_id,
                       total_charge,                     total_purchase,
                       total_exchange_in,                total_exchange_out,
                       delay_msg,      game_id)
                   values(
                       n_User_ID,      n_Rating_ID,      n_Subject_ID,
                       n_Total_Charge_Amount,            0,
                       0,                                0,
                       0,              n_Game_ID);
                end if;
            end if;
        end if;

        -- GS��ʱ������Ӧ���߷���ֵ��Ϣ���µ���ʧ�ܣ�����Ϣ��������վ
        if (n_Result_Code = -312) then    /* PKG_UTIL.E_SYS_NET_OUT_OF_MAX_TIMES */
            insert into
                SYS_USER_CHARGE_INFO_RECYCLE
            select
                *
            from
                SYS_USER_CHARGE_INFO
            where
                fund_log_id = n_Detail_ID;
        end if;

        -- ɾ���д���������Ϣ
        if (
            (n_Result_Code = 1) or    /* PKG_UTIL.S_SUCCESS */
            (n_Result_Code = -1472) or    /* PKG_UTIL.E_CHARGE_DUPLICATE */
            (n_Result_Code = -1441) or    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            (n_Result_Code = -312)    /* PKG_UTIL.E_SYS_NET_OUT_OF_MAX_TIMES */
        ) then
            delete from
                SYS_USER_CHARGE_INFO
            where
                 fund_log_id = n_Detail_ID;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
        -- ��ѯ��ֵ�ܶ�
        select
            total_charge
        into
            n_Total_Charge_Amount
        from
            UMS_USER_FUND_SUMMARY
        where
            (user_id = n_User_ID)and
            (rating_id = n_Rating_ID)and
            (subject_id = n_Subject_ID) and
            (game_id = n_Game_ID);

        if (found_rows() = 0) then
             set n_Total_Charge_Amount = 0;
        end if;

    end label_proc;
END$$

    -- ��ȡ��ֵ�Ե��õ���ʼ�Ե�ID
CREATE PROCEDURE GetBeginAuditDetailID(
    in  n_Game_ID            integer,            -- 2
    in  n_user_id            integer unsigned,            -- 3
    in  n_rating_id          integer,            -- 4
    in  n_subject_id         integer,            -- 5
    in  n_max_audit_count    integer,            -- 6
    in  n_end_detail_id      bigint,             -- 7

    out n_actual_count       integer,            -- 8
    out n_begin_detail_id    bigint,             -- 9
    out n_Result             integer
)
BEGIN
    declare n_remain_count       integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- ��������Ϸ���
        if (
            (n_Game_ID is null) or
            (n_user_ID is null) or
            (n_rating_ID is null) or
            (n_subject_ID is null) or
            (n_max_audit_count is null) or
            (n_max_audit_count <= 0)or
            (n_max_audit_count > 64) or
            (n_end_detail_id is null)or
            (n_end_detail_id <= 0) or
            (n_end_detail_id > 999999999999999)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_actual_count = 0;

        -- ��ѯn_end_detail_id֮ǰ���ж�������ֵ��Ϣ
        select
            count(log_id)
        into
            n_remain_count
        from
            LOG_USER_FUND_DETAIL fd
        where
            (fd.log_id < n_end_detail_id) and
            (fd.user_id = n_user_id) and
            (fd.rating_id = n_rating_id) and
            (fd.subject_id = n_subject_id) and
            (fd.game_id = n_Game_ID);

        if (found_rows() = 0) then
             set n_remain_count = 0;
        end if;

        -- ����Ѿ�û�е��ɶ��ˣ�����1
        if (n_remain_count = 0) then
             set n_begin_detail_id = 0;
             set n_result = 1;
             leave label_proc;
        end if;

        -- ��ȡ��ʵ�Ե�����
        if (n_remain_count <= n_max_audit_count) then
             set n_actual_count = n_remain_count;
        else
             set n_actual_count = n_max_audit_count;
        end if;

        -- ��ѯn_begin_detail_id
        select
            min(a.log_id)
        into
            n_begin_detail_id
        from (
            select
                log_id
            from
                LOG_USER_FUND_DETAIL
            where
                (log_id < n_end_detail_id) and
                (user_id = n_user_id) and
                (rating_id = n_rating_id) and
                (subject_id = n_subject_id) and
                (game_id = n_Game_ID)
            order by
                log_id desc
            ) a;

        if (found_rows() = 0) then
             set n_result = 1;
             set n_begin_detail_id = 0;
             leave label_proc;
        end if;

        set n_result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ��ȡָ�����ڵ����˷����ͳ�ֵ�ܶ�
CREATE PROCEDURE GetDailyChargeAmount(
    in  n_Game_ID           integer,            -- 2
    in  d_Current_Date      datetime,           -- 3

    out total_charge_amount integer,            -- 4
    out n_Result            integer
)
BEGIN
    declare n_result            integer default  0;    /* PKG_UTIL.E_ERROR */
    declare d_tmp_date          date;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- ��������Ϸ���
        if (
            (n_Game_ID    is null) or
            (current_date is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set d_tmp_date = trunc(d_Current_Date);
        set total_charge_amount   = 0;

        select
            sum(t.charge_amount)
        into
            total_charge_amount
        from
            log_user_fund_detail t
        where
            (t.channel_id = 10) and
            (trunc(t.charge_time) = d_tmp_date) and
            (t.game_id = n_Game_ID) and
            (t.user_id not in (
                select b.user_id
                from   SYS_BLACKLIST b
                where  b.user_type = 1    /* PKG_OPTION.TYPE_CHARGE */
                and    b.game_id = n_Game_ID
            ));

        if (total_charge_amount is null) then
            set total_charge_amount = 0;
        end if;

        set n_result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE innerPushChargeMsg(
    in  n_Game_ID              integer,             -- 2
    in  n_User_ID              integer unsigned,             -- 3
    in  n_Rating_ID            integer,             -- 4
    in  n_Subject_ID           integer,             -- 5

    out n_Total_Charge_Amount  integer,            -- 6
    out n_Result               integer
)
BEGIN
    declare n_Stop             integer;
    declare n_cur_Game_ID      integer;
    declare n_cur_Detail_ID    bigint;
    declare n_cur_Rating_ID    integer;
    declare n_cur_User_ID      integer unsigned;
    declare n_cur_Subject_ID   integer;

    declare cur_Charge_Msg_List cursor for
            select
                game_id, fund_log_id, rating_id, user_id, subject_id
            from
                SYS_USER_CHARGE_INFO
            where
                game_id = n_Game_ID and
                user_id = n_User_ID and
                rating_id = n_Rating_ID and
                subject_id = n_Subject_ID and
                fund_log_id > 0
            order by
                fund_log_id
            limit 100;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        -- �����Ϸ��Լ���
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Rating_ID is null) or
            (n_Rating_ID <= 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in (3, 5))
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Charge_Msg_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Charge_Msg_List
            into n_cur_Game_ID,n_cur_Detail_ID,n_cur_Rating_ID,n_cur_User_ID,n_cur_Subject_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            call UpdateChargeMsg(
                    n_cur_Game_ID,
                    n_cur_Detail_ID,
                    1,
                    n_cur_Rating_ID,
                    n_cur_User_ID,
                    n_cur_Subject_ID,
                    n_Total_Charge_Amount,
                    n_Result
            );
            if (n_Result <> 1) then
                leave label_proc;
            end if;     
        end loop label_loop;
        close cur_Charge_Msg_List;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ; 
