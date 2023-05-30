DROP PROCEDURE checkthesum;
DROP PROCEDURE checksum;
DROP PROCEDURE getUserFundInfoAndLocked;
DROP PROCEDURE updateUserFundAmount;
DROP PROCEDURE increaseUserFundAmount;
DROP PROCEDURE getBalanceInfo;
DROP PROCEDURE getBalance;
DROP PROCEDURE unchargeInfo;
DROP PROCEDURE recharge5;
DROP PROCEDURE recharge5NoPush;
DROP PROCEDURE refund;
DROP PROCEDURE deposit5;
DROP PROCEDURE consume;
DROP PROCEDURE convert3to5;
DROP PROCEDURE rollback5to3;
DROP PROCEDURE drawBalance;
DROP PROCEDURE drawBalanceEx;
DROP PROCEDURE transferBalance;
DROP PROCEDURE updateUnchargeInfo;
DROP PROCEDURE getUnchargeState;
DROP PROCEDURE validateChargeDetailID;
DROP PROCEDURE getChargeDetailTotal;
DROP PROCEDURE getAccountBalance;
DROP PROCEDURE validateChecksum;
DROP PROCEDURE validateChecksumForDetail;
DROP PROCEDURE createUnchargeLog;
DROP PROCEDURE pushChargeInfoToGS;
DROP PROCEDURE reduceBalanceByChargeDetailID;
DROP PROCEDURE updateUnchargeLog;
DROP PROCEDURE getUnchargeInfo;
DROP PROCEDURE logUserFundDetail;
DROP PROCEDURE innerCharge;
DROP PROCEDURE doTransferBalanceByFundLogID;
DROP PROCEDURE doUnchargeByFundLogID;
DROP PROCEDURE chargeForTransfer;
DROP PROCEDURE getOperationTypeForUncharge;
DROP PROCEDURE getChargeTypeByChargeDetailID;
DROP PROCEDURE logBalanceFromGS;
DELIMITER $$

CREATE PROCEDURE checkthesum(
    in  x               varchar(128),
    out y               integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode      integer;

    declare n_Seg_Start    integer;
    declare n_Seg_End      integer;
    declare n_Seg_Number   integer unsigned;
    declare s_Seg_Number   varchar(20);
    declare s_Sub_Int      varchar(4);
    declare n_Seg_Length   integer;

    declare i              integer;

    declare n_Int_Length   integer;
    declare n_Int_Pos      integer;
    declare n_Ascii        integer;
    declare n_Begin        integer;
    label_proc:begin
        declare exit handler for sqlexception set n_Result = 1;
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        set n_Seg_Start = 0;
        set n_Seg_End = 0;
        set n_Seg_Number = 0;
        set n_Seg_Length = 0;
        set i = 0;
        set n_Int_Length = 4;
        set n_Int_Pos = 1;
        set n_Ascii = 0;
        set n_Begin = 1;
        if (
            (x is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave label_proc;
        end if;

        set x = concat(x, ',');

        set n_Seg_Start      = 1;
        set y = 200703;    /* PKG_UTIL.D_CHECKSUM_INITIAL_VALUE */
        label_loop:loop
            set n_Begin = 1;
            select locate(',', x, n_Seg_Start) into n_Seg_End;
            if (n_Seg_End = 0) then
                leave label_loop;
            end if;
            set n_Seg_Length = n_Seg_End - n_Seg_Start;
            set s_Seg_Number = substring(x, n_Seg_Start, n_Seg_Length);
            label_loop2:loop
                set n_Int_Pos = 1;
                set n_Seg_Number = 0;
                set s_Sub_Int = '';
                set s_Sub_Int = substring(s_Seg_Number, n_Begin, n_Begin + n_Int_Length - 1);

                if (s_Sub_Int = '') then
                    leave label_loop2;
                end if;
                label_loop3:loop
                    set n_Ascii = 0;
                    if (n_Int_Pos > 4) then
                        leave label_loop3;
                    end if;
                    set n_Ascii = ascii(substring(s_Sub_Int, n_Int_Pos, 1));
                    set n_Seg_Number = n_Seg_Number << 8;
                    set n_Seg_Number = n_Seg_Number + n_Ascii;
                    set n_Int_Pos = n_Int_Pos + 1;
                end loop label_loop3;
                set y = (n_Seg_Number + y) - (n_Seg_Number & y) * 2;
                set n_Begin = n_Begin + 4;
            end loop label_loop2;
            set n_Seg_Start = n_Seg_End + 1;
            set i = i + 1;
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */

    end label_proc;
END$$

CREATE PROCEDURE checksum(
    in  n_User_ID       integer unsigned,
    in  n_Rating_ID     integer,
    in  n_Subject_ID    integer,
    in  n_Amount        integer,
    out n_Ret_Checksum  integer,
    out n_Result        integer
)
BEGIN

    declare v_CheckSum_Input    varchar(128);
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_User_ID    is null) or
            (n_Rating_ID  is null) or
            (n_Subject_ID is null) or
            (n_Amount     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set v_CheckSum_Input = concat(n_User_ID, ',', n_Rating_ID, ',', n_Subject_ID, ',', n_Amount);

        call checkthesum(v_CheckSum_Input, n_Ret_CheckSum, n_Result);
    end label_proc;
END$$

    -- ��ȡ�û��˻���Ϣ����������¼
CREATE PROCEDURE getUserFundInfoAndLocked(
    in  n_Game_ID           integer,
    in  n_User_ID           integer unsigned,
    in  n_Rating_ID         integer,
    in  n_Subject_ID        integer,

    out n_Ret_Amount        integer,
    out n_Result            integer
)
BEGIN

    declare n_Tmp_GW_State      integer default  0;
    declare n_Tmp_Checksum      integer default  0; /* UMS_USER_FUND.checksum%TYPE */
    label_proc:begin
        declare continue handler for 1062 begin end;
        declare exit handler for 1216 set n_Result = -1406;/*���Լ��ʧ��handler*/
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null) or
            (n_Rating_ID  is null) or
            (n_Rating_ID  < 0    ) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in(3,5))
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        --  �������״̬
        call GWState(n_Game_ID, n_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        -- ��ѯ��������¼
        label_loop:loop
            select
                t.amount,            t.checksum
            into
                n_Ret_Amount,        n_Tmp_Checksum
            from
                UMS_USER_FUND t
            where
                (t.game_id    = n_Game_ID   ) and
                (t.user_id    = n_User_ID   ) and
                (t.rating_id  = n_Rating_ID ) and
                (t.subject_id = n_Subject_ID)
            for update;
            -- exit loop when no exception.
            if (FOUND_ROWS() = 1) then
                leave label_loop;
            end if;

            -- create record for first charge.
            call checksum(n_User_ID, n_Rating_ID, n_Subject_ID, 0, n_Tmp_Checksum, n_Result);
            insert into UMS_USER_FUND(
                game_id,       user_id,       rating_id,
                subject_id,    amount,        checksum
            )
            values(
                n_Game_ID,     n_User_ID,     n_Rating_ID,
                n_Subject_ID,  0,             n_Tmp_Checksum
            );
        end loop label_loop;

        -- ��� checksum
        call validateChecksum(
                n_User_ID,
                n_Rating_ID,
                n_Subject_ID,
                n_Ret_Amount,
                n_Tmp_Checksum,
                n_Result
        );
    end label_proc;
END$$

    -- �޸��˻����
CREATE PROCEDURE updateUserFundAmount(
    in  n_Game_ID           integer,
    in  n_User_ID           integer unsigned,
    in  n_Rating_ID         integer,
    in  n_Subject_ID        integer,
    in  n_Amount            integer,
    out n_Result            integer
)
BEGIN

    declare n_Tmp_Checksum      integer; /* UMS_USER_FUND.checksum%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null    ) or
            (n_User_ID    is null    ) or
            (n_Rating_ID  is null    ) or
            (n_Rating_ID  < 0        ) or
            (n_Subject_ID is null    ) or
            (n_Subject_ID not in(3,5)) or
            (n_Amount     is null    ) or
            (n_Amount     < 0        )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call checksum(n_User_ID, n_Rating_ID, n_Subject_ID, n_Amount, n_Tmp_Checksum, n_Result);
        update
            UMS_USER_FUND t
        set
            t.amount   = n_Amount,
            t.checksum = n_Tmp_Checksum
        where
            (t.game_id    = n_Game_ID   ) and
            (t.user_id    = n_User_ID   ) and
            (t.rating_id  = n_Rating_ID ) and
            (t.subject_id = n_Subject_ID);

        if (row_count() = 0) then
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- �����û��˻����
CREATE PROCEDURE increaseUserFundAmount(
    in  n_Game_ID           integer,
    in  n_User_ID           integer unsigned,
    in  n_Rating_ID         integer,
    in  n_Subject_ID        integer,
    in  n_Amount            integer,

    out n_Ret_Amount        integer,
    out n_Result            integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null    ) or
            (n_User_ID    is null    ) or
            (n_Rating_ID  is null    ) or
            (n_Rating_ID  < 0        ) or
            (n_Subject_ID is null    ) or
            (n_Subject_ID not in(3,5)) or
            (n_Amount     is null    ) or
            (n_Amount     < 0        )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- ����û��˻�״̬�������˻��������������Ϣ
        call getUserFundInfoAndLocked(
                 n_Game_ID,
                 n_User_ID,
                 n_Rating_ID,
                 n_Subject_ID,

                 n_Ret_Amount,
                 n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- �������
        set n_Ret_Amount = n_Ret_Amount + n_Amount;

        -- �޸��˻����
        call updateUserFundAmount(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Ret_Amount,
            n_Result
        );
    end label_proc;
END$$

CREATE PROCEDURE getBalanceInfo(
    in  n_Game_ID                integer,
    in  n_User_ID                integer unsigned,
    in  n_Rating_ID              integer,
    in  n_Max_Balance_Count      integer,

    out n_Ret_Balance_Count      integer,
    out n_Ret_Subject_ID         integer,
    out n_Ret_GW_Amount          integer,
    out n_Ret_Amount             integer,
    out n_Result                 integer
)
BEGIN

    declare s_Tmp_Global_Recharge   varchar(32);
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Ret_Balance_Count = 0;
        set n_Ret_Subject_ID = 3;
        set n_Ret_GW_Amount = 0;
        set n_Ret_Amount = 0;
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID           is null) or
            (n_User_ID           is null) or
            (n_Rating_ID         is null) or
            (n_Max_Balance_Count is null) or
            (n_Max_Balance_Count <= 0)
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
        -- �Ƿ������ֵ��ȫ��ȫ����Ĭ����
        call getOptionValue(
            n_Tmp_Game_ID,
            'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
            '1',   /* PKG_OPTION.R_OPENED */
            s_Tmp_Global_Recharge
        );

        if (s_Tmp_Global_Recharge <> '1') then    /* PKG_OPTION.R_OPENED */
            select
                subject_id,         amount,             0
            into
                n_Ret_Subject_ID,   n_Ret_GW_Amount,    n_Ret_Amount
            from
                UMS_USER_FUND
            where
                rating_id  = n_Rating_ID and
                user_id    = n_User_ID   and
                game_id    = n_Tmp_Game_ID   and
                subject_id = 3;
        else
            select
                subject_id,         0,                  amount
            into
                n_Ret_Subject_ID,   n_Ret_GW_Amount,    n_Ret_Amount
            from
                UMS_USER_FUND
            where
                rating_id  = 0           and
                user_id    = n_User_ID   and
                game_id    = n_Tmp_Game_ID   and
                subject_id = 3;
        end if;
        if (FOUND_ROWS() = 0) then
            set n_Result = 1;
            leave label_proc;
        end if;

        set n_Ret_Balance_Count = 1;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getBalance(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_Rating_ID        integer,
    in  n_Subject_ID       integer,

    out n_Ret_Amount       integer,
    out n_Ret_Amount_Point integer,
    out n_Result           integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null) or
            (n_Rating_ID  is null) or
            (n_Subject_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            amount
        into
            n_Ret_Amount_Point
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID) and
            (rating_id  = 0) and
            (subject_id = n_Subject_ID) and
            (game_id    = n_Game_ID);
        if (FOUND_ROWS() = 0) then
            set n_Ret_Amount_Point = 0;
        end if;

        if (n_Rating_ID = 0) then
            set n_Ret_Amount = n_Ret_Amount_Point;
            set n_Result = 1;
            leave label_proc;
        end if;

        select
            amount
        into
            n_Ret_Amount
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID) and
            (rating_id  = n_Rating_ID) and
            (subject_id = n_Subject_ID) and
            (game_id    = n_Game_ID);
        if (FOUND_ROWS() = 0) then
            set n_Ret_Amount = 0;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE unchargeInfo(
    in  n_Game_ID              integer,
    in  n_Charge_Detail_ID     bigint,
    in  n_Uncharge_Detail_ID   bigint,
    in  n_Uncharge_Amount      integer,
    in  n_Subject_ID           integer,
    in  n_Operation_Type       integer,
    in  n_User_ID              integer unsigned,
    in  n_Src_Rating_ID        integer,
    in  n_Dst_Rating_ID        integer,
    in  s_unCharge_Order_Code  varchar(32),
    out n_Result               integer
)
BEGIN
    declare n_RetCode               integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Fund_Log_ID       bigint; /* LOG_USER_FUND_DETAIL.Log_Id%type */
    declare n_Tmp_Fund_Log_ID_3     bigint;
    declare n_Tmp_Fund_Log_ID_5     bigint;
    declare n_Tmp_Log_ID       bigint;
    declare n_Charge_Type           integer default  0; /* LOG_USER_FUND_DETAIL.charge_type%type */
    declare s_Tmp_Auto_Draw_Type    varchar(32);
    declare s_Charge_Order_Code     varchar(32);
    declare n_Channel_ID            integer;
    declare n_Discount              integer;
    declare n_Tmp_Subject_ID        integer default 3;
    declare n_Detail_Count          integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID            is null) or
            (n_Charge_Detail_ID   is null) or
            (n_Uncharge_Amount    <= 0   ) or
            (n_User_ID            is null) or
            (n_Src_Rating_ID      is null) or
            (n_Subject_ID         is null) or
            (s_unCharge_Order_Code is null) or
            (n_Operation_Type     is null) or
            (
              (n_Operation_Type = 2   ) and
              (n_Dst_Rating_ID is null)
             )
        ) then
            set n_Result = -100;    
            leave label_proc;
        end if;


        -- ��ȡ��ֵ����
        call getChargeTypeByChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,

            n_Charge_Type,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- ֻ����ֱ�䳷��
        if (n_Charge_Type <> 1) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- ����ֵ��ˮ��Ϣ���ж��Ƿ�������ֵ
        call validateChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Uncharge_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        select
            ifnull(max(t.discount), 0),        max(channel_id),
            max(charge_order_code),             count(*)
        into
            n_Discount,                         n_Channel_ID,
            s_Charge_Order_Code,                n_Detail_Count
        from
            LOG_USER_FUND_DETAIL t
        where
            t.game_id          = n_Game_ID         and
            t.charge_detail_id = n_Charge_Detail_ID;

        if (n_Detail_Count > 1) then
            set n_Discount       = 0;
        end if;

        call getOptionValue(
            n_Game_ID,
            'auto_draw_balance',
            null,
            s_Tmp_Auto_Draw_Type
        );
        if(s_Tmp_Auto_Draw_Type = '1') then
            call logUserFundDetail(
                n_Game_ID,
                n_User_ID,
                n_Src_Rating_ID,
                5,
                (-1) * n_Uncharge_Amount,        
                0,
                1,     
                now(),
                0,
                ' ',
                6,
                0,
                now(),

                n_Tmp_Fund_Log_ID_5,
                n_Result
                );
            if (n_Result <> 1) then
                leave label_proc;
            end if;
            update
                UMS_USER_FUND_SUMMARY
            set
                total_charge = total_charge - n_Uncharge_Amount
            where
                (user_id = n_User_ID)and
                (rating_id = n_Src_Rating_ID)and
                (subject_id = 3) and
                (game_id = n_Game_ID);
            set n_Tmp_Subject_ID = 5;
        end if;

        call logUserFundDetail(
            n_Game_ID,
            n_User_ID,
            n_Src_Rating_ID,
            3,
            (-1) * n_Uncharge_Amount,
            n_Channel_ID,
            n_Discount,
            now(),
            n_Uncharge_Detail_ID,
            s_Charge_Order_Code,
            6,
            0,
            now(),
            n_Tmp_Fund_Log_ID_3,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;
        
        if(s_Tmp_Auto_Draw_Type = '1') then
            set n_Tmp_Fund_Log_ID = n_Tmp_Fund_Log_ID_5;
        else
            set n_Tmp_Fund_Log_ID = n_Tmp_Fund_Log_ID_3;
        end if;
        -- ����һ������ֵ��־
        call createUnchargeLog(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_Uncharge_Detail_ID,
            n_Operation_Type,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_User_ID,
            n_Subject_ID,
            n_Uncharge_Amount,
            n_Tmp_Fund_Log_ID,
            s_unCharge_Order_Code,

            n_Result
        );
        if (n_Result <> 1) then    
            leave label_proc;
        end if;

        if (n_Src_Rating_ID <> 0) then
            -- �� 0 ���ص�eSales����
            -- ������Ҫ�Ƚ�����ֵ�ɹ�������GS���ٵ���
            -- updateUnchargeInfo ��������
            call pushChargeInfoToGS(
                n_Game_ID,
                n_Tmp_Fund_Log_ID,
                n_User_ID,
                n_Src_Rating_ID,
                n_Tmp_Subject_ID,
                (-1) * n_Uncharge_Amount,
                now(),
                n_Result
            );
            if (n_Result <> 1) then
                leave label_proc;
            end if;
        else
            -- 0 ���ص�eSales�����������ͣ�
            -- ֱ�ӵ��� updateUnchargeInfo ��������
            call updateUnchargeInfo(
                n_Game_ID,
                n_Tmp_Fund_Log_ID_3,
                1,
                n_RetCode
            );
            if (n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE rollback5to3(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Rating_ID          integer,
    in  n_Amount             integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode              integer default  0;

    declare n_Tmp_Fund_Log_ID      bigint default  0;
    declare n_Balance              integer default  0;
    declare n_Checksum             integer default  0;
    declare n_Tmp_Cost_Amount      integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (n_User_ID    is null) or
            (n_Rating_ID    is null) or
            (n_Amount    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;


        select
            amount,            checksum
        into
            n_Balance,         n_Checksum
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID   ) and
            (rating_id  = n_Rating_ID ) and
            (subject_id = 5) and
            (game_id    = n_Game_ID   )
        for update;
        if(found_rows() = 0 ) then
            set n_Result = -1441;
            leave label_proc;
        end if;

        -- ��� checksum
        call validateChecksum(
            n_User_ID,
            n_Rating_ID,
            5,
            n_Balance,
            n_Checksum,
            n_Result
        );
        if (n_Result <> 1) then
            leave label_proc;
        end if;

        -- �������
        if (n_Balance < n_Amount) then
            set n_Result = -1441;
            leave label_proc;
        end if;
        set n_Balance = n_Balance - n_Amount;
        
        -- �޸��˻����
        call updateUserFundAmount(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            5,
            n_Balance,
            n_Result
        );
        if (n_Result <> 1) then
            leave label_proc;
        end if;

        call refund(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            3,
            n_Amount,

            n_RetCode
        );
        if (n_RetCode <> 1) then    
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- charge_order_codeδ�Ͻ���
CREATE PROCEDURE recharge5(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Rating_ID          integer,
    in  n_Amount             integer,
    in  d_Time               datetime,
    in  s_Order_Code         varchar(32),
    out n_Ret_Amount         integer,
    out n_Result             integer
)
BEGIN

    declare n_Tmp_Fund_Log_ID    bigint; /* LOG_USER_FUND_DETAIL.log_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null) or
            (n_User_ID    is null) or
            (n_Rating_ID  is null) or
            (n_Amount     is null) or
            (n_Amount     <= 0   ) or
            (d_Time       is null) or
            (s_Order_Code is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- �����˻����
        call increaseUserFundAmount(
            n_Game_ID,                  -- game_id
            n_User_ID,                  -- user_id
            n_Rating_ID,                -- rating_id
            5,                          -- subject_id
            n_Amount,                   -- amount
            n_Ret_Amount,               -- ret_amount
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- ��¼��־

        call logUserFundDetail(
            n_Game_ID,                                -- game_id
            n_User_ID,                                -- user_id
            n_Rating_ID,                              -- rating_id
            5,                                        -- subject_id
            n_Amount,                                 -- amount
            0,                                        -- channel_id
            1,                                        -- discount
            d_Time,                                   -- charge_time
            0,                                        -- charge_detail_id
            s_Order_Code,                                      -- order_code
            2,                                        -- charge_type 2 ����
            0,                                        -- promoter_id
            d_Time,                                   -- union_charge_time

            n_Tmp_Fund_Log_ID,                        -- log_id
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- ���͵� GS
        call pushChargeInfoToGS(
            n_Game_ID,                                -- game_id
            n_Tmp_Fund_Log_ID,                        -- fund_log_id
            n_User_ID,                                -- user_id
            n_Rating_ID,                              -- rating_id
            5,                                        -- subject_id
            n_Amount,                                 -- amount
            d_Time,                                   -- charge_time
            n_Result
        );

    end label_proc;
END$$

CREATE PROCEDURE recharge5NoPush(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Rating_ID          integer,
    in  n_Amount             integer,
    in  d_Time               datetime,
    out n_Ret_Amount         integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode       integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Fund_Log_ID     bigint; /* LOG_USER_FUND_DETAIL.log_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID   is null) or
            (n_User_ID   is null) or
            (n_Rating_ID is null) or
            (n_Amount    is null) or
            (n_Amount    <= 0   ) or
            (d_Time      is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- �����˻����
        call increaseUserFundAmount(
            n_Game_ID,                  -- game_id
            n_User_ID,                  -- user_id
            n_Rating_ID,                -- rating_id
            5,                          -- subject_id
            n_Amount,                   -- amount
            n_Ret_Amount,               -- ret_amount
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- ��¼��־

        call logUserFundDetail(
            n_Game_ID,                                -- game_id
            n_User_ID,                                -- user_id
            n_Rating_ID,                              -- rating_id
            5,                                        -- subject_id
            n_Amount,                                 -- amount
            0,                                        -- channel_id
            1,                                        -- discount
            d_Time,                                   -- charge_time
            0,                                        -- charge_detail_id
            ' ',                                      -- order_code
            2,                                        -- charge_type 2 ����
            0,                                        -- promoter_id
            d_Time,                                   -- union_charge_time

            n_Tmp_Fund_Log_ID,                        -- log_id
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        update
            UMS_USER_FUND_SUMMARY
        set
            total_charge = total_charge + n_Amount
        where
            (game_id = n_Game_ID) and
            (user_id = n_User_ID) and
            (rating_id = n_Rating_ID)and
            (subject_id = 5);

        -- ����Ǹ��˺��ڸ�����������ֵ��Ϣ��
        -- ������µ��ܶ��¼
        if (row_count() = 0) then
            insert into UMS_USER_FUND_SUMMARY(
                user_id,        rating_id,        subject_id,
                total_charge,                     total_purchase,
                total_exchange_in,                total_exchange_out,
                delay_msg,      game_id)
            values(
                n_User_ID,      n_Rating_ID,      5,
                n_Amount,                         0,
                0,                                0,
                0,              n_Game_ID);
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE refund(
    in  n_Game_ID             integer,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    out n_Result              integer
)
BEGIN
    declare n_Ret_Amount          integer; /* UMS_USER_FUND.amount%TYPE */
    set n_Result = 0; /* E_ERROR */
    call increaseUserFundAmount(
        n_Game_ID,                  -- game_id
        n_User_ID,                  -- user_id
        n_Rating_ID,                -- rating_id
        n_Subject_ID,               -- subject_id
        n_Amount,                   -- amount
        n_Ret_Amount,               -- ret_amount
        n_Result
    );
END$$

CREATE PROCEDURE deposit5(
    in  n_Game_ID             integer,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Amount              integer,
    out n_Result              integer
)
BEGIN
    declare n_Ret_Amount          integer; /* UMS_USER_FUND.amount%TYPE */
    set n_Result = 0; /* E_ERROR */
    call increaseUserFundAmount(
        n_Game_ID,                  -- game_id
        n_User_ID,                  -- user_id
        n_Rating_ID,                -- rating_id
        5,                          -- subject_id
        n_Amount,                   -- amount
        n_Ret_Amount,               -- ret_amount
        n_Result
    );
END$$

CREATE PROCEDURE consume(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Rating_ID          integer,
    in  n_Subject_ID         integer,
    in  n_Amount             integer,
    out n_Result             integer
)
BEGIN

    declare n_Tmp_Checksum_0      integer; /* UMS_USER_FUND.checksum%TYPE */
    declare n_Tmp_Left_Amount     integer; /* UMS_USER_FUND.amount%TYPE */

    declare n_Tmp_GW_State        integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID    is null     ) or
            (n_User_ID    is null     ) or
            (n_Rating_ID  is null     ) or
            (n_Subject_ID is null     ) or
            (n_Subject_ID not in(3, 5)) or
            (n_Amount     is null     ) or
            (n_Amount     <= 0        )
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

        select
            amount,            checksum
        into
            n_Tmp_Left_Amount, n_Tmp_Checksum_0
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID   ) and
            (rating_id  = n_Rating_ID ) and
            (subject_id = n_Subject_ID) and
            (game_id    = n_Game_ID   )
        for update;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1441;    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            leave label_proc;
        end if;

        -- ��� checksum
        call validateChecksum(
                n_User_ID,
                n_Rating_ID,
                n_Subject_ID,
                n_Tmp_Left_Amount,
                n_Tmp_Checksum_0,
                n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- �������
        if (n_Tmp_Left_Amount < n_Amount) then
            set n_Result = -1441;    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            leave label_proc;
        end if;

        set n_Tmp_Left_Amount = n_Tmp_Left_Amount - n_Amount;

        -- �޸��˻����
        call updateUserFundAmount(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Tmp_Left_Amount,
            n_Result
        );

    end label_proc;
END$$

CREATE PROCEDURE convert3to5(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_Src_Rating_ID    integer,
    in  n_Dst_Rating_ID    integer,
    in  n_Amount           integer,
    in  d_Time             datetime,
    in  s_Order_Code       varchar(32),
    out n_Ret_Amount_3     integer,
    out n_Ret_Amount_5     integer,
    out n_Result           integer
)
BEGIN
    declare n_RetCode             integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_GW_State        integer default  0;
    declare n_Tmp_Total_Cost      integer default  0;
    declare n_Tmp_Purchase_ID     bigint; /* UMS_USER_PURCHASE_DETAIL.purchase_id%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID       is null) or
            (n_User_ID       is null) or
            (n_Src_Rating_ID is null) or
            (n_Dst_Rating_ID is null) or
            (n_Dst_Rating_ID <= 0   ) or
            (
                n_Src_Rating_ID not in (n_Dst_Rating_ID, 0)
            ) or
            (n_Amount        is null) or
            (n_Amount        <= 0   ) or
            (d_Time          is null) or
            (s_Order_Code    is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(n_Game_ID, n_Dst_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        call consume(
            n_Game_ID,
            n_User_ID,
            n_Src_Rating_ID,
            3,
            n_Amount,

            n_Result
        );
        if (n_Result <> 1) then
            leave label_proc;
        end if;

        select
            amount
        into
            n_Ret_Amount_3
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID      ) and
            (rating_id  = n_Src_Rating_ID) and
            (subject_id = 3              ) and
            (game_id    = n_Game_ID      );
        if (FOUND_ROWS() = 0) then
            leave label_proc;
        end if;

        call recharge5(
            n_Game_ID,
            n_User_ID,
            n_Dst_Rating_ID,
            n_Amount,
            d_Time,
            s_Order_Code,
            n_Ret_Amount_5,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE drawBalance(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_Rating_ID        integer,
    in  n_Gateway_ID       integer,
    in  n_Subject_ID       integer,
    in  n_Draw_Amount      integer,

    out n_Ret_Amount       integer,
    out n_Ret_Left_Amount  integer,
    out n_Result           integer
)
BEGIN
    declare n_Left_Draw_Amount    integer; /* UMS_USER_FUND.amount%TYPE */
    declare n_Current_Draw_Amount integer; /* UMS_USER_FUND.amount%TYPE */

    declare s_Tmp_Global_Recharge   varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID     is null) or
            (n_User_ID     is null) or
            (n_Rating_ID   is null) or
            (n_Rating_ID   <= 0   ) or
            (n_Subject_ID  is null) or
            (n_Subject_ID  <> 3   ) or
            (n_Draw_Amount is null) or
            (n_Draw_Amount <= 0   )
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
        -- �Ƿ������ֵ��ȫ��ȫ����Ĭ����
        call getOptionValue(
            n_Tmp_Game_ID,
            'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
            '1',   /* PKG_OPTION.R_OPENED */
            s_Tmp_Global_Recharge
        );

        if (s_Tmp_Global_Recharge <> '1') then    /* PKG_OPTION.R_OPENED */
            set n_Result = -100;    /*PKG_UTIL.E_PARAMETER_ERROR*/
            leave label_proc;
        end if;

        call convert3to5(
            n_Tmp_Game_ID,
            n_User_ID,
            0,                  -- src_rating_id
            n_Rating_ID,        -- dst_rating_id
            n_Draw_Amount,
            now(),
            ' ',
            n_Ret_Left_Amount,  -- 3
            n_Ret_Amount,       -- 5
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE drawBalanceEx(
    in  n_Game_ID          integer,
    in  n_Detail_ID        bigint,
    in  n_User_ID          integer unsigned,
    in  n_Src_Rating_ID    integer,
    in  n_Dst_Rating_ID    integer,
    in  n_Subject_ID       integer,
    in  n_Draw_Amount      integer,

    out n_Ret_Left_Amount  integer,
    out n_Result           integer
)
BEGIN
    declare n_RetCode integer default  0;    /* PKG_UTIL.E_ERROR */

    declare s_Draw_Balance_Ratio varchar(32) default  '1';
    declare n_Charge_Amount_5    integer default  0;

    declare n_Tmp_GW_State        integer default  0;
    declare n_Tmp_Total_Cost      integer default  0;
    declare n_Ret_Amount_5        integer default  0;
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID       is null) or
            (n_Detail_ID     is null) or
            (n_User_ID       is null) or
            (n_Src_Rating_ID is null) or
            (n_Dst_Rating_ID is null) or
            (n_Dst_Rating_ID <= 0   ) or
            (
                n_Src_Rating_ID not in (n_Dst_Rating_ID, 0)
            ) or
            (n_Subject_ID    is null) or
            (n_Subject_ID    <> 3   ) or
            (n_Draw_Amount   is null) or
            (n_Draw_Amount   <= 0   )
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
        -- validate gateway_id
        -- n_Tmp_GW_State = PKG_GATEWAY.GWState(n_Dst_Rating_ID)
        call GWState(n_Tmp_Game_ID, n_Dst_Rating_ID, n_Tmp_GW_State);
        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Tmp_Game_ID,
            'draw_balance_ratio',
            '1',
            s_Draw_Balance_Ratio
        );

        call consume(
            n_Tmp_Game_ID,
            n_User_ID,
            n_Src_Rating_ID,
            3,
            n_Draw_Amount,

            n_Result
        );
        if (n_Result <> 1) then
            leave label_proc;
        end if;

        select
            amount
        into
            n_Ret_Left_Amount
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID      ) and
            (rating_id  = n_Src_Rating_ID) and
            (subject_id = 3              ) and
            (game_id    = n_Tmp_Game_ID      );
        if (FOUND_ROWS() = 0) then
            leave label_proc;
        end if;

        set n_Charge_Amount_5 = n_Draw_Amount * cast(s_Draw_Balance_Ratio as signed integer);

        call recharge5NoPush(
            n_Tmp_Game_ID,
            n_User_ID,
            n_Dst_Rating_ID,
            n_Charge_Amount_5,
            now(),
            n_Ret_Amount_5,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE transferBalance(
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_Src_Rating_ID    integer,
    in  n_Dst_Rating_ID    integer,
    in  n_Subject_ID       integer,
    in  n_Charge_Detail_ID bigint,
    out n_Result           integer
)
BEGIN

    declare n_Amount                 integer default  0; /* LOG_USER_FUND_DETAIL.charge_amount%type */
    declare n_Tmp_Fund_Log_ID        bigint  default  0; /* LOG_USER_FUND_DETAIL.Log_Id%type */
    declare n_Tmp_Fund_Log_ID_5      bigint;
    declare n_Tmp_Fund_Log_ID_3      bigint;
    declare s_Tmp_Auto_Draw_Type     varchar(32);
    declare s_Charge_Order_Code      varchar(32);
    declare s_unCharge_Order_Code    varchar(32);
    declare n_Channel_ID             integer;
    declare n_Discount               integer;
    declare n_Tmp_Subject_ID         integer default 3;
    declare n_Detail_Count           integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set s_unCharge_Order_Code = cast(n_Charge_Detail_ID as char);
        if (
            (n_Game_ID          is null) or
            (n_User_ID          is null) or
            (n_Charge_Detail_ID <= 0   ) or
            (n_Charge_Detail_ID is null) or
            (n_Src_Rating_ID    is null) or
            (n_Src_Rating_ID    =  0   ) or
            (n_Dst_Rating_ID    is null) or
            (n_Dst_Rating_ID    =  0   ) or
            (n_Subject_ID       is null) or
            (n_Subject_ID       <> 3   )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getChargeDetailTotal(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call validateChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        select
            ifnull(max(t.discount), 0),        max(channel_id),
            max(charge_order_code),             count(*)
        into
            n_Discount,                         n_Channel_ID,
            s_Charge_Order_Code,                n_Detail_Count
        from
            LOG_USER_FUND_DETAIL t
        where
            t.game_id          = n_Game_ID         and
            t.charge_detail_id = n_Charge_Detail_ID;

        if (n_Detail_Count > 1) then
            set n_Discount       = 0;
        end if;

        call getOptionValue(
            n_Game_ID,
            'auto_draw_balance',
            null,
            s_Tmp_Auto_Draw_Type
        );
        if(s_Tmp_Auto_Draw_Type = '1') then
            call logUserFundDetail(
                n_Game_ID,
                n_User_ID,
                n_Src_Rating_ID,
                5,
                (-1) * n_Amount,        
                0,
                1,     
                now(),
                0,
                ' ',
                4,
                0,
                now(),

                n_Tmp_Fund_Log_ID_5,
                n_Result
                );
            if (n_Result <> 1) then
                leave label_proc;
            end if;
            update
                UMS_USER_FUND_SUMMARY
            set
                total_charge = total_charge - n_Amount
            where
                (user_id = n_User_ID)and
                (rating_id = n_Src_Rating_ID)and
                (subject_id = 3) and
                (game_id = n_Game_ID);
            set n_Tmp_Subject_ID = 5;
        end if;

        call logUserFundDetail(
            n_Game_ID,
            n_User_ID,
            n_Src_Rating_ID,
            3,
            (-1) * n_Amount,
            n_Channel_ID,
            n_Discount,
            now(),
            n_Charge_Detail_ID,
            s_Charge_Order_Code,
            4,
            0,
            now(),
            n_Tmp_Fund_Log_ID_3,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;
        
        if(s_Tmp_Auto_Draw_Type = '1') then
            set n_Tmp_Fund_Log_ID = n_Tmp_Fund_Log_ID_5;
        else
            set n_Tmp_Fund_Log_ID = n_Tmp_Fund_Log_ID_3;
        end if;
        -- ����һ������ֵ��־
        call createUnchargeLog(
            n_Game_ID,
            n_Charge_Detail_ID,
            null,
            2,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_User_ID,
            n_Subject_ID,
            n_Amount,
            n_Tmp_Fund_Log_ID,
            s_unCharge_Order_Code,

            n_Result
        );
        if (n_Result <> 1) then    
            leave label_proc;
        end if;

        -- �� 0 ���ص�GMת��
        -- ������Ҫ�Ƚ�����ֵ�ɹ�������GS���ٵ���
        -- updateUnchargeInfo ��������
        call pushChargeInfoToGS(
            n_Game_ID,
            n_Tmp_Fund_Log_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Tmp_Subject_ID,
            (-1) * n_Amount,
            now(),
            n_Result
        );
        if (n_Result <> 1) then
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE updateUnchargeInfo(
    in  n_Game_ID        integer,
    in  n_Fund_Log_ID    bigint,
    in  n_Uncharge_State integer,
    out n_Result         integer
)
BEGIN
    declare n_RetCode        integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Operation_Type      integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (n_Fund_Log_ID is null) or
            (n_Uncharge_State is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- ���·���ֵ��־״̬
        call updateUnchargeLog(
            n_Game_ID,
            n_Fund_Log_ID,
            n_Uncharge_State,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- ��ȡ�������ͣ�����������ת��
        call getOperationTypeForUncharge(
            n_Game_ID,
            n_Fund_Log_ID,

            n_Tmp_Operation_Type,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if (n_Tmp_Operation_Type = 1) then
            -- eSales ����
            call doUnchargeByFundLogID(
                n_Game_ID,
                n_Fund_Log_ID,
                n_Result
            );
        elseif (n_Tmp_Operation_Type = 2) then
            -- GM ת��
            call doTransferBalanceByFundLogID(
                n_Game_ID,
                n_Fund_Log_ID,
                n_Result
            );
        end if;

        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getUnchargeState(
    in  n_Game_ID           integer,
    in  n_charge_Detail_ID  integer,
    out n_Uncharge_State    integer,
    out n_Result            integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_charge_Detail_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
             U.uncharge_state
        into
             n_Uncharge_State
        from
             LOG_USER_UNCHARGE_DETAIL U
        where
             U.game_id          = n_Game_ID          and
             U.charge_detail_id = n_charge_Detail_ID and
             U.operation_type   = 2
        order by
             U.fund_log_id desc
        limit 1;
        if (FOUND_ROWS() = 0) then
            set n_Uncharge_State = 0;
            leave label_proc;
        end if;
        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ֵ��ˮ
    --     ���һ�������� 0 �ĳ�ֵ��ˮ
    --     ��δ����
    --     ȫ���ֵ
    --     �˻�����㹻
    --     ��ؼ�¼ checksum ����
    --     ���� 0 ���أ��� 0 ���ط���ֵ
CREATE PROCEDURE validateChargeDetailID (
    in  n_Game_ID             integer,
    in  n_Charge_Detail_ID    bigint,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    out n_Result              integer
)
BEGIN

    declare n_Account_Balance         integer default  0; /* UMS_USER_FUND.amount%type */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Detail_ID <= 0) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Rating_ID is null) or
            (n_Rating_ID < 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID <> 3) or
            (n_Amount is null) or
            (n_Amount <= 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- ����ʻ����
        call getAccountBalance(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Account_Balance,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if (n_Account_Balance < n_Amount) then
            set n_Result = -1441;    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            leave label_proc;
        end if;

        -- ���� ��ֵ��־�� ����Ӧ��¼�� checksum
        call validateChecksumForDetail(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ȡ��ָ����ֵ��ˮ�ŵ��ܶ�
CREATE PROCEDURE getChargeDetailTotal(
    in  n_Game_ID             integer,
    in  n_Charge_Detail_ID    bigint,
    out n_Total_Amount        integer,
    out n_Result              integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) and
            (n_Charge_Detail_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            ifnull(sum(charge_amount), 0)
        into
            n_Total_Amount
        from
            LOG_USER_FUND_DETAIL
        where
            game_id          = n_Game_ID          and
            charge_detail_id = n_Charge_Detail_ID and
            charge_type      = 1;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$


    -- ȡ�˻���� ( UMS_USER_FUND )
CREATE PROCEDURE getAccountBalance (
    in  n_Game_ID             integer,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    out n_Balance             integer,
    out n_Result              integer
)
BEGIN

    declare n_Checksum            integer; /* UMS_USER_FUND.checksum%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null ) or
            (n_User_ID        is null     ) or
            (n_Rating_ID      is null     ) or
            (n_Subject_ID     is null     ) or
            (n_Subject_ID     not in (3,5))
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Balance = 0;

        select
            t.amount,     t.checksum
        into
            n_Balance,    n_Checksum
        from
            UMS_USER_FUND t
        where
            t.user_id    = n_User_ID     and
            t.rating_id  = n_Rating_ID   and
            t.subject_id = n_Subject_ID  and
            t.game_id    = n_Game_ID;
        if (FOUND_ROWS() = 0) then
            set n_Balance = 0;              -- ���ܸ��û�δ���ֵ����ȡ������ִ������
        end if;

        call validateChecksum(
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Balance,
            n_Checksum,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- У�� checksum �Ƿ�Ϸ�
CREATE PROCEDURE validateChecksum (
    in  n_User_ID             integer,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    in  n_Checksum            integer,
    out n_Result              integer
)
BEGIN
    declare n_Checksum_Ret    integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        call checksum(
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Checksum_Ret,
            n_Result
        );

        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if (n_Checksum <> n_Checksum_Ret) then
            set n_Result = -505;    /* PKG_UTIL.E_SYS_DATABASE_DATA_INVALID */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ����charge_detail_id, У�� ��ֵ��־�� ����Ӧ��¼�� checksum
CREATE PROCEDURE validateChecksumForDetail (
    in  n_Game_ID             integer,
    in  n_Charge_Detail_ID    bigint,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    out n_Result              integer
)
BEGIN
    declare n_Log_Amount      integer;
    declare n_Log_Checksum    integer;
    declare n_Detail_Amount   integer;
    declare n_Detail_Checksum integer;
    declare n_Stop            integer;

    declare cur_Checksum cursor for
        select
            charge_amount,
            checksum
        from
            LOG_USER_FUND_DETAIL
        where
            charge_detail_id = n_Charge_Detail_ID and
            user_id          = n_User_ID          and
            rating_id        = n_Rating_ID        and
            subject_id       = n_Subject_ID       and
            game_id          = n_Game_ID;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Charge_Detail_ID is null) or
            (n_User_ID          is null) or
            (n_Rating_ID        is null) or
            (n_Subject_ID       is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        open cur_Checksum;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Checksum into n_Log_Amount, n_Log_Checksum;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            call validateChecksum(
                    n_User_ID,
                    n_Rating_ID,
                    n_Subject_ID,
                    n_Log_Amount,
                    n_Log_Checksum,
                    n_Result
                );
            if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
                close cur_Checksum;
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����һ������ֵ����������һ������ֵ��־��
CREATE PROCEDURE createUnchargeLog(
    in  n_Game_ID             integer,
    in  n_Charge_Detail_ID    bigint,
    in  n_Uncharge_Detail_ID  bigint,
    in  n_Operation_Type      integer,
    in  n_Src_Rating_ID       integer,
    in  n_Dst_Rating_ID       integer,
    in  n_User_ID             integer unsigned,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    in  n_Fund_Log_ID         bigint,
    in  s_Order_Code          varchar(32),

    out n_Result              integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1474; /* PKG_UTIL.E_USER_UNCHARGE_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Detail_ID <= 0) or
            (n_Src_Rating_ID is null) or
            (n_Src_Rating_ID < 0) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID <> 3) or
            (n_Amount is null) or
            (n_Amount <= 0) or
            (n_Fund_Log_ID is null) or
            (s_Order_Code is null) or
            (n_Operation_Type is null) or
            (
                -- eSales������uncharge_detail_id����Ϊnull��dst_rating_id�����0
                (n_Operation_Type = 1) and
                (
                    (n_Uncharge_Detail_ID is null) or
                    (n_Uncharge_Detail_ID <= 0) or
                    (n_Dst_Rating_ID > 0)
                )
            ) or
            (
                -- GMת�ˣ�uncharge_detail_id��Ϊnull��dst_rating_id����Ϊnull
                (n_Operation_Type = 2) and
                (
                    (n_Uncharge_Detail_ID is not null) or
                    (n_Dst_Rating_ID is null) or
                    (n_Dst_Rating_ID <= 0)
                )
            )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into LOG_USER_UNCHARGE_DETAIL(
            charge_detail_id,     uncharge_detail_id,      uncharge_state,
            fund_log_id,          src_rating_id,           dst_rating_id,
            operation_type,       uncharge_time,           user_id,
            subject_id,           amount,                  game_id,
            uncharge_order_code
        )
        values(
            n_Charge_Detail_ID,   n_Uncharge_Detail_ID,    2,
            n_Fund_Log_ID,        n_Src_Rating_ID,         n_Dst_Rating_ID,
            n_Operation_Type,     now(),                   n_User_ID,
            n_Subject_ID,         n_Amount,                n_Game_ID,
            s_Order_Code
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ���ͳ�ֵ���ݵ�GS ��SYS_USER_CHARGE_INFO��
CREATE PROCEDURE pushChargeInfoToGS(
    in  n_Game_ID             integer,
    in  n_Fund_Log_ID         bigint,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    in  d_Charge_Time         datetime,
    out n_Result              integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1472; /* PKG_UTIL.E_CHARGE_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_Fund_Log_ID is null) or
            (n_Fund_Log_ID <= 0) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Rating_ID is null) or
            (n_Rating_ID <= 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in (3, 5)) or
            (n_Amount is null) or
            (n_Amount = 0) or
            (d_Charge_Time is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into SYS_USER_CHARGE_INFO (
            fund_log_id,        user_id,        rating_id,
            subject_id,         charge_amount,
            charge_time,        retry_times,    game_id
        )
        values(
            n_Fund_Log_ID,      n_User_ID,      n_Rating_ID,
            n_Subject_ID,       n_Amount,
            d_Charge_Time,      0,              n_Game_ID
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ���ĳ�ֵ��ˮ�ţ�charge_detail_id���ۼ��˻����
CREATE PROCEDURE reduceBalanceByChargeDetailID(
    in  n_Game_ID             integer,
    in  n_Charge_Detail_ID    bigint,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    out n_Result              integer
)
BEGIN

    declare n_Charge_Amount   integer default  0; /* UMS_USER_FUND.amount%type */
    declare n_Balance         integer default  0; /* UMS_USER_FUND.amount%type */
    declare n_Checksum        integer default  0; /* UMS_USER_FUND.checksum%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Detail_ID <= 0) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Rating_ID is null) or
            (n_Rating_ID < 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in (3, 5)) or
            (n_Amount is null) or
            (n_Amount = 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getChargeDetailTotal(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_Charge_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if(n_Charge_Amount <> n_Amount) then
            set n_Result = -2012;
            leave label_proc;
        end if;

        select
            amount,            checksum
        into
            n_Balance,         n_Checksum
        from
            UMS_USER_FUND
        where
            (user_id    = n_User_ID   ) and
            (rating_id  = n_Rating_ID ) and
            (subject_id = n_Subject_ID) and
            (game_id    = n_Game_ID   )
        for update;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1441;    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            leave label_proc;
        end if;

        -- ��� checksum
        call validateChecksum(
                n_User_ID,
                n_Rating_ID,
                n_Subject_ID,
                n_Balance,
                n_Checksum,
                n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- �������
        if (n_Balance < n_Charge_Amount) then
            set n_Result = -1441;    /* PKG_UTIL.E_USER_BALANCE_NOT_ENOUGH */
            leave label_proc;
        end if;
        set n_Balance = n_Balance - n_Charge_Amount;

        -- �޸��˻����
        call updateUserFundAmount(
            n_Game_ID,
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Balance,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ���·���ֵ��־״̬
CREATE PROCEDURE updateUnchargeLog(
    in  n_Game_ID            integer,
    in  n_Fund_Log_ID        bigint,
    in  n_Uncharge_State     integer,
    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (n_Fund_Log_ID    is null) or
            (n_Uncharge_State is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update
             LOG_USER_UNCHARGE_DETAIL
        set
             uncharge_state = n_Uncharge_State
        where
             game_id     = n_Game_ID     and
             fund_log_id = n_Fund_Log_ID;

        if (row_count() <> 1) then
            set n_Result = -1478;    /* PKG_UTIL.E_USER_UNCHARGE_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ���� fund_log_id ��ȡ����ֵ��Ϣ
CREATE PROCEDURE getUnchargeInfo(
    in  n_Game_ID            integer,
    in  n_Fund_Log_ID        bigint,

    out n_Charge_Detail_ID   bigint,
    out n_Uncharge_Detail_ID bigint,
    out n_Operation_Type     integer,
    out n_Uncharge_State     integer,
    out n_User_ID            integer unsigned,
    out n_Src_Rating_ID      integer,
    out n_Dst_Rating_ID      integer,
    out n_Subject_ID         integer,
    out n_Amount             integer,
    out n_Result             integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; 
        if (
            (n_Game_ID        is null) or
            (n_Fund_Log_ID    is null)
        ) then
            set n_Result = -100;    
            leave label_proc;
        end if;

        select
            t.charge_detail_id,      t.uncharge_detail_id,      t.uncharge_state,
            t.src_rating_id,         t.dst_rating_id,           t.operation_type,
            t.user_id,               t.subject_id,              t.amount
        into
            n_Charge_Detail_ID,      n_Uncharge_Detail_ID,      n_Uncharge_State,
            n_Src_Rating_ID ,        n_Dst_Rating_ID,           n_Operation_Type,
            n_User_ID,               n_Subject_ID,              n_Amount
        from
            LOG_USER_UNCHARGE_DETAIL t
        where
            t.game_id     = n_Game_ID    and
            t.fund_log_id = n_Fund_Log_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1478;    
            leave label_proc;
        end if;

        set n_Result = 1;    
    end label_proc;
END$$

    -- ��¼�ʻ���ϸ��־
CREATE PROCEDURE logUserFundDetail(
    in  n_Game_ID             integer,
    in  n_User_ID             integer unsigned,
    in  n_Rating_ID           integer,
    in  n_Subject_ID          integer,
    in  n_Amount              integer,
    in  n_Channel_ID          integer,
    in  n_Discount            integer,
    in  d_Charge_Time         datetime,
    in  n_Charge_Detail_ID    bigint,
    in  s_Order_Code          varchar(32),
    in  n_Charge_Type         integer,
    in  n_Promoter_ID         integer,
    in  d_Union_Charge_Time   datetime,
    out n_Fund_Log_ID         bigint,
    out n_Result              integer
)
BEGIN

    declare n_Checksum        integer default  0; /* LOG_USER_FUND_DETAIL.checksum%type */
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1449;    /* PKG_UTIL.E_FUND_LOG_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Rating_ID is null) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in (3, 5)) or
            (n_Amount is null) or
            (n_Amount = 0) or
            (n_Channel_ID is null) or
            (n_Discount is null) or
            (d_Charge_Time is null) or
            (d_Union_Charge_Time is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Detail_ID < 0) or
            (s_Order_Code is null) or
            (length(s_Order_Code) > 32) or
            (n_Charge_Type is null) or
            (n_Promoter_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call checksum(
            n_User_ID,
            n_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Checksum,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        insert into LOG_USER_FUND_DETAIL(
            user_id,              rating_id,
            subject_id,           charge_amount,
            channel_id,           discount,
            charge_time,          charge_detail_id,
            promoter_id,          checksum,
            charge_type,          charge_order_code,
            game_id,              union_charge_time      
        )
        values(
            n_User_ID,            n_Rating_ID,
            n_Subject_ID,         n_Amount,
            n_Channel_id,         n_Discount,
            d_Charge_time,        n_Charge_Detail_ID,
            n_Promoter_ID,        n_Checksum,
            n_Charge_Type,        s_Order_Code,
            n_Game_ID,            d_Union_Charge_Time
        );

        select last_insert_id() into n_Fund_Log_ID;

        -- 3ת5���¼log_id,���ڲ�����insertʱ�����˴�insert������ֵ,����ֻ����insert���ж�charge_type.
        if ( s_Order_Code = ' ') then
            update
                LOG_USER_FUND_DETAIL
            set
                charge_order_code = n_Fund_Log_ID
            where
                log_id = n_Fund_Log_ID;
            if (row_count() = 0) then
                set n_Result = -1449;
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- charge_order_codeδ�Ͻ���
CREATE PROCEDURE innerCharge(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Rating_ID          integer,
    in  n_Charge_Amount      integer,
    in  n_Subject_ID         integer,
    in  n_Channel_ID         integer,
    in  n_Discount           integer,
    in  d_Charge_Time        datetime,
    in  n_Promoter_ID        integer,
    in  n_Charge_Detail_ID   bigint,
    in  s_Order_Code         varchar(32),
    in  n_Charge_Type        integer,
    out n_Result             integer
)
BEGIN

    declare n_Tmp_Amount_3        integer;
    declare n_Tmp_Amount_5        integer default 0;
    declare n_Tmp_Checksum_0      integer; /* UMS_USER_FUND.checksum%TYPE */
    declare n_Ret_Amount          integer; /* UMS_USER_FUND.amount%TYPE */

    declare s_Tmp_Auto_Draw_Balnace varchar(32);
    declare s_Tmp_Global_Recharge varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Op_Type         varchar(32); /* SYS_OPTION.option_value%type */

    declare s_Tmp_Order_Code      varchar(32);
    declare d_Tmp_Charge_Time     datetime default now();
    declare n_Tmp_Fund_Log_ID     bigint;
    declare s_Tmp_Fund_Log_ID     varchar(32);
    declare n_Tmp_Count           integer;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1472;    /* PKG_UTIL.E_CHARGE_DUPLICATE */
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_User_ID          is null) or
            (n_Rating_ID        is null) or
            (n_Charge_Amount    is null) or
            (n_Charge_Amount    <= 0   ) or
            (n_Subject_ID       is null) or
            (n_Subject_ID       <> 3   ) or
            (n_Channel_ID       is null) or
            (n_Discount         is null) or
            (d_Charge_Time      is null) or
            (n_Promoter_ID      is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Type      is null) or
            (
                (n_Charge_Type  <>    1) and
                (n_Charge_Type  <>    2) and
                (n_Charge_Type  <>    5)
            )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- �Ƿ�ȫ��ȫ����ֵ��Ĭ���ǣ�
        call getOptionValue(
              n_Game_ID,
              'global_recharge',    /* PKG_OPTION.GLOBAL_RECHARGE */
              '1',   /* PKG_OPTION.R_OPENED */
              S_Tmp_Global_Recharge
              );

        -- �����û���Ҫ�ر�ע��˴����߼��жϣ�����
        if (
            (
                ( S_Tmp_Global_Recharge = '1' ) and    /* PKG_OPTION.R_OPENED */
                ( n_Rating_ID           <> 0 )
            ) or
            (
                (S_Tmp_Global_Recharge = '0') and    /* PKG_OPTION.R_CLOSED */
                (n_Rating_ID           = 0 )
            )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

            -- �Ƿ�����Զ��һ�(Ĭ�Ϸ�)
        call getOptionValue(
                n_Game_ID,
                'auto_draw_balance',
                '0',
                s_Tmp_Auto_Draw_Balnace
                );
        if(
            (s_Tmp_Auto_Draw_Balnace    = '1') and
            (n_Rating_ID                = 0)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'op_type',
            null,
            s_Tmp_Op_Type
            );
        if (s_Tmp_Op_Type = 'auto') then
            set d_Tmp_Charge_Time = d_Charge_Time;
        elseif(s_Tmp_Op_Type = 'oversea') then
            set d_Tmp_Charge_Time = now();
        else
            set n_Result = -2103;
            leave label_proc;
        end if;

        -- �����˻����
        call increaseUserFundAmount(
            n_Game_ID,                  -- game_id
            n_User_ID,                  -- user_id
            n_Rating_ID,                -- rating_id
            n_Subject_ID,               -- subject_id
            n_Charge_Amount,            -- amount
            n_Ret_Amount,               -- ret_amount
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call checksum(n_User_ID, n_Rating_ID, n_Subject_ID, n_Charge_Amount, n_Tmp_Checksum_0, n_Result);
        set s_Tmp_Order_Code = s_Order_Code;

        -- record charge log
        insert into LOG_USER_FUND_DETAIL(
            user_id,              rating_id,
            subject_id,           charge_amount,        channel_id,        discount,
            charge_time,          charge_detail_id,     promoter_id,       checksum,
            charge_type,          charge_order_code,    game_id,           union_charge_time
        )
        values(
            n_User_ID,            n_Rating_ID,
            n_Subject_ID,         n_Charge_Amount,      n_Channel_ID,      n_Discount,
            d_Tmp_Charge_Time,    n_Charge_Detail_ID,   n_Promoter_ID,     n_Tmp_Checksum_0,
            n_Charge_Type,        s_Tmp_Order_Code,     n_Game_ID,         d_Charge_Time
        );

        select last_insert_id() into n_Tmp_Fund_Log_ID;
        set s_Tmp_Fund_Log_ID = cast(n_Tmp_Fund_Log_ID as char);

        -- ִ���Զ��һ�
        if(
            (n_Rating_ID <> 0) and
            (s_Tmp_Auto_Draw_Balnace = '1')
        ) then
			update
                UMS_USER_FUND_SUMMARY
            set
                total_charge = total_charge + n_Charge_Amount
            where
                user_id     = n_User_ID   and
                rating_id   = n_Rating_ID and
                subject_id  = n_Subject_ID and
                game_id     = n_Game_ID;
            if (row_count() = 0) then
                insert into UMS_USER_FUND_SUMMARY(
                    user_id,      rating_id,        subject_id,
                    total_charge, total_purchase,
                    total_exchange_in,              total_exchange_out,
                    delay_msg,    game_id
                )
                values(
                    n_User_ID,    n_Rating_ID,      n_Subject_ID,
                    n_Charge_Amount,            0,
                    0,            0,
                    0,            n_Game_ID
                );  
            end if;
            call convert3to5(
                    n_Game_ID,
                    n_User_ID,
                    n_Rating_ID,
                    n_Rating_ID,
                    n_Charge_Amount,
                    d_Charge_Time,
                    s_Tmp_Fund_Log_ID,
                    n_Tmp_Amount_3,
                    n_Tmp_Amount_5,
                    n_Result
                    );
            if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
                leave label_proc;
            end if;

        elseif(
            (n_Rating_ID <> 0) and
            (s_Tmp_Auto_Draw_Balnace = '0')
        ) then
            call pushChargeInfoToGS(
                    n_Game_ID,
                    n_Tmp_Fund_Log_ID,
                    n_User_ID,
                    n_Rating_ID,
                    3,
                    n_Charge_Amount,
                    d_Charge_Time,
                    n_Result
                    );

            if (n_Result <> 1) then
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ���ͳɹ������� GM ת��
CREATE PROCEDURE doTransferBalanceByFundLogID(
    in  n_Game_ID              integer,
    in  n_Fund_Log_ID          bigint,
    out n_Result               integer
)
BEGIN

    declare n_Gateway_State       integer default  0; /* SYS_GATEWAY.gateway_state%TYPE */

    declare n_Charge_Detail_ID    bigint  default  0; /* LOG_USER_UNCHARGE_DETAIL.charge_detail_id%TYPE */
    declare n_Uncharge_Detail_ID  bigint  default  0; /* LOG_USER_UNCHARGE_DETAIL.charge_detail_id%TYPE */
    declare n_Operation_Type      integer default  0; /* LOG_USER_UNCHARGE_DETAIL.operation_type%TYPE */
    declare n_Uncharge_State      integer default  0; /* LOG_USER_UNCHARGE_DETAIL.uncharge_state%TYPE */
    declare n_User_ID             integer unsigned default  0; /* LOG_USER_UNCHARGE_DETAIL.user_id%TYPE */
    declare n_Src_Rating_ID       integer default  0; /* LOG_USER_UNCHARGE_DETAIL.src_rating_id%TYPE */
    declare n_Dst_Rating_ID       integer default  0; /* LOG_USER_UNCHARGE_DETAIL.dst_rating_id%TYPE */
    declare n_Subject_ID          integer default  0; /* LOG_USER_UNCHARGE_DETAIL.subject_id%TYPE */
    declare n_Amount              integer default  0; /* LOG_USER_UNCHARGE_DETAIL.amount%TYPE */

    declare n_Tmp_Fund_Log_ID     bigint  default  0;
    declare s_Tmp_Auto_Draw_Type  varchar(32);
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (n_Fund_Log_ID    is null) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Tmp_Fund_Log_ID = n_Fund_Log_ID;
        call getUnchargeInfo(
            n_Game_ID,
            n_Fund_Log_ID,

            n_Charge_Detail_ID,
            n_Uncharge_Detail_ID,
            n_Operation_Type,
            n_Uncharge_State,
            n_User_ID,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        if (n_Uncharge_State <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        --  �������״̬
        call GWState(n_Game_ID, n_Src_Rating_ID, n_Gateway_State);
        if (n_Gateway_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        call GWState(n_Game_ID, n_Dst_Rating_ID, n_Gateway_State);
        if (n_Gateway_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        call validateChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call reduceBalanceByChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call chargeForTransfer(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_Subject_ID,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE doUnchargeByFundLogID(
    in  n_Game_ID              integer,
    in  n_Fund_Log_ID          bigint,
    out n_Result               integer
)
BEGIN
    declare n_Charge_Detail_ID    bigint  default  0; /* LOG_USER_UNCHARGE_DETAIL.charge_detail_id%TYPE */
    declare n_Uncharge_Detail_ID  bigint  default  0; /* LOG_USER_UNCHARGE_DETAIL.charge_detail_id%TYPE */
    declare n_Operation_Type      integer default  0; /* LOG_USER_UNCHARGE_DETAIL.operation_type%TYPE */
    declare n_Uncharge_State      integer default  0; /* LOG_USER_UNCHARGE_DETAIL.uncharge_state%TYPE */
    declare n_User_ID             integer unsigned default  0; /* LOG_USER_UNCHARGE_DETAIL.user_id%TYPE */
    declare n_Src_Rating_ID       integer default  0; /* LOG_USER_UNCHARGE_DETAIL.src_rating_id%TYPE */
    declare n_Dst_Rating_ID       integer default  0; /* LOG_USER_UNCHARGE_DETAIL.dst_rating_id%TYPE */
    declare n_Subject_ID          integer default  0; /* LOG_USER_UNCHARGE_DETAIL.subject_id%TYPE */
    declare n_Amount              integer default  0; /* LOG_USER_UNCHARGE_DETAIL.amount%TYPE */

    declare s_Tmp_Auto_Draw_Type  varchar(32);
    declare n_Tmp_Fund_Log_ID     bigint;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (n_Fund_Log_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Tmp_Fund_Log_ID = n_Fund_Log_ID;
        call getUnchargeInfo(
            n_Game_ID,
            n_Fund_Log_ID,

            n_Charge_Detail_ID,
            n_Uncharge_Detail_ID,
            n_Operation_Type,
            n_Uncharge_State,
            n_User_ID,
            n_Src_Rating_ID,
            n_Dst_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;
        
        if (n_Uncharge_State <> 1) then
            leave label_proc;
        end if;

        call validateChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        call reduceBalanceByChargeDetailID(
            n_Game_ID,
            n_Charge_Detail_ID,
            n_User_ID,
            n_Src_Rating_ID,
            n_Subject_ID,
            n_Amount,
            n_Result
        );
        if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- GM ת���У�ΪĿ�����������������ֵ
CREATE PROCEDURE chargeForTransfer(
    in  n_Game_ID              integer,
    in  n_Charge_Detail_ID     bigint,
    in  n_User_ID              integer unsigned,
    in  n_Src_Rating_ID        integer,
    in  n_Dst_Rating_ID        integer,
    in  n_Subject_ID           integer,
    out n_Result               integer
)
BEGIN
    declare n_Charge_Amount  integer;
    declare n_Channel_ID     integer;
    declare n_Discount       integer;
    declare n_Promoter_ID    integer;
    declare n_Checksum       integer;
    declare s_Charge_Order_Code varchar(32);
    declare n_Stop           integer;

    declare curChargeInfo cursor for
        select
            charge_amount, channel_id,
            discount,       promoter_id,   checksum,
            charge_order_code
        from
            LOG_USER_FUND_DETAIL
        where
            (Charge_Detail_ID = n_Charge_Detail_ID) and
            (user_id = n_User_ID) and
            (rating_id = n_Src_Rating_ID) and
            (subject_id = n_Subject_ID) and
            (charge_amount > 0) and
            (game_id = n_Game_ID)
        for update;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Detail_ID <= 0) or
            (n_User_ID is null) or
            (n_User_ID <= 0) or
            (n_Src_Rating_ID is null) or
            (n_Src_Rating_ID <= 0) or
            (n_Dst_Rating_ID is null) or
            (n_Dst_Rating_ID <= 0) or
            (n_Subject_ID is null) or
            (n_Subject_ID not in (3, 5))
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        open curChargeInfo;
        label_loop:loop
            set n_Stop = 0;
            fetch curChargeInfo into n_Charge_Amount, n_Channel_ID, n_Discount, n_Promoter_ID, n_Checksum, s_Charge_Order_Code;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            -- ͨ����ֵ�ӿڣ���������Ӧ�Ʒ����Ķ�Ӧ��Ŀ��
            call innerCharge(
                n_Game_ID,
                n_User_ID,
                n_Dst_Rating_ID,
                n_Charge_Amount,
                n_Subject_ID,
                n_Channel_ID,
                n_Discount,
                now(),
                n_Promoter_ID,
                n_Charge_Detail_ID,
                s_Charge_Order_Code,
                5, /* DF_CHARGE_TYPE_TRANSFER_IN  ת��ת�� */
                n_Result
            );
            if (n_Result <> 1) then    /* PKG_UTIL.S_SUCCESS */
                leave label_proc;
            end if;
        end loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ����Fund_Log_ID��ѯ����ֵ�������� operation_type
    --     1 - eSales ����
    --     2 - GM ת��
CREATE PROCEDURE getOperationTypeForUncharge(
    in  n_Game_ID              integer,
    in  n_Fund_Log_ID          bigint,

    out n_Operation_Type       integer,
    out n_Result               integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID        is null) or
            (n_Fund_Log_ID    is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            t.operation_type
        into
            n_Operation_Type
        from
            LOG_USER_UNCHARGE_DETAIL t
        where
            t.game_id     = n_Game_ID    and
            t.fund_log_id = n_Fund_Log_ID;
        if (FOUND_ROWS() = 0) then
            set n_Result = -1478;    /* PKG_UTIL.E_USER_UNCHARGE_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

    -- ����ָ���� CHARGE_DETAIL_ID ��ѯ��ֵ���� CHARGE_TYPE
CREATE PROCEDURE getChargeTypeByChargeDetailID(
    in  n_Game_ID              integer,
    in  n_Charge_Detail_ID     bigint,

    out n_Charge_Type          integer,
    out n_Result               integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID          is null) or
            (n_Charge_Detail_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            max(t.charge_type)
        into
            n_Charge_Type
        from
            LOG_USER_FUND_DETAIL t
        where
            (t.game_id          = n_Game_ID         )and
            (t.charge_detail_id = n_Charge_Detail_ID);
        if (FOUND_ROWS() = 0) then
            set n_Charge_Type = 0;
            set n_Result = -1473;    /* PKG_UTIL.E_DETAIL_ID_NOT_FOUND */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE logBalanceFromGS(
    in  n_game_id              integer,
    in  n_date                 integer,
    in  n_gateway_id           integer,
    in  n_subject_id           integer,
    in  n_totalcharge          integer,
    in  n_totalpurchase        integer,
    in  n_totalbalance         integer,
    out n_Result               integer
)
BEGIN
    label_proc:begin
        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$
DELIMITER ;
