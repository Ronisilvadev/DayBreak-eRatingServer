DROP PROCEDURE unchargeByID;
DELIMITER $$

CREATE PROCEDURE unchargeByID(
IN  n_User_ID             INTEGER unsigned,
IN  n_Rating_ID           INTEGER, 
IN  n_Charge_Detail_ID    BIGINT, 
IN  n_Uncharge_Detail_ID  BIGINT, 
IN  n_Uncharge_Amount     INTEGER, 
IN  n_Charge_Type         INTEGER, 
IN  n_Game_ID             INTEGER, 
IN  n_Channel_ID          INTEGER, 
OUT n_Result              INTEGER
)
BEGIN
    declare           n_RetCode                      integer   default 0;
    declare           s_Tmp_Auto_Draw_Type           varchar(32);
    declare           s_Charge_Detail_ID             varchar(32);
    declare           n_Tmp_Count                    integer;
    declare           n_Charge_Amount                integer;
    declare           d_Tmp_Charge_Time              datetime;

    label_proc:begin
        set n_Result = 0;
        set s_Charge_Detail_ID = cast(n_Charge_Detail_ID as char);
        if (
            (n_User_ID            is null) or
            (n_Rating_ID          is null) or
            (n_Charge_Detail_ID   is null) or
            (n_Uncharge_Detail_ID is null) or
            (n_Uncharge_Amount    is null) or
            (n_Game_ID            is null) or
            (n_Charge_Type        is null) or
            (n_Charge_Type        <>    1)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            ifnull(sum(t.charge_amount), 0), max(t.charge_time)
        into
            n_Charge_Amount, d_Tmp_Charge_Time
        from
            LOG_USER_FUND_DETAIL t
        where
            t.charge_detail_id = n_Charge_Detail_ID
        and
            t.charge_type = n_Charge_Type
        and
            t.game_id = n_Game_ID
        and
            t.rating_id = n_Rating_ID
        and
            t.user_id = n_User_ID;
        if(found_rows() = 0 ) then
            set n_Result = -1448;
            leave label_proc;
        end if;

        if( n_Charge_Amount <> n_Uncharge_Amount ) then
            set n_Result = -2012;
            leave label_proc;
        end if;

        if( 0 <> n_Rating_ID ) then
            select
                count(*)
            into
                n_Tmp_Count
            from
                ums_user_purchase_detail t
            where
                t.game_id = n_Game_ID
            and
                t.user_id = n_User_ID
            and
                t.gateway_id = n_Rating_ID
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
                    n_User_ID,
                    n_Rating_ID,
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
                t.user_id = n_User_ID
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
        	n_Charge_Detail_ID,
        	n_Uncharge_Detail_ID,
        	n_Uncharge_Amount,
        	3,
        	1,
        	n_User_ID,
        	n_Rating_ID,
        	null,
        	s_Charge_Detail_ID,
        	
        	n_Result
        );
    end label_proc;
END$$

DELIMITER ;
