DROP PROCEDURE charge;
DELIMITER $$

CREATE PROCEDURE charge(
IN  n_Game_ID INTEGER, 
IN  s_User_Name VARCHAR(255), 
IN  n_Rating_ID INTEGER, 
IN  n_Channel_ID INTEGER, 
IN  n_Discount INTEGER, 
IN  n_Subject_ID INTEGER, 
IN  n_Charge_Amount INTEGER, 
IN  n_Charge_Money INTEGER, 
IN  n_Charge_Detail_ID BIGINT, 
IN  n_Charge_Type INTEGER,
OUT n_Result INTEGER
)
BEGIN
    declare           n_RetCode                  integer   default 0;
    declare           n_Tmp_User_ID              integer;
    declare           s_Tmp_User_Name            varchar(32);
    declare           s_Tmp_Password             varchar(32);
    declare           n_Tmp_User_Type            integer;
    declare           n_Tmp_Promoter_ID          integer default 0;
    declare           n_Tmp_User_State           integer;
    declare           d_Tmp_Birthday             datetime;
    declare           s_Tmp_ID_Code              varchar(32);
    declare           n_Tmp_ID_Verify_Flag       integer;
    declare           s_Tmp_Op_Type              varchar(32);
    declare           s_Tmp_Charge_Ratio         varchar(32);
    declare           n_Tmp_Charge_Ratio         integer;
    declare           n_Tmp_Count                integer;

    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID          is null) or
            (s_User_Name        is null) or
            (n_Rating_ID        is null) or
            (n_Channel_ID       is null) or
            (n_Discount         is null) or
            (n_Subject_ID       is null) or
            (n_Subject_ID       <> 3   ) or
            (n_Charge_Amount    is null) or
            (n_Charge_Amount    <= 0)    or
            (n_Charge_Money     is null) or
            (n_Charge_Money     <= 0)    or
            (n_Charge_Detail_ID is null) or
            (n_Charge_Type      is null) or
            (
                (n_Charge_Type  <>    1) and
                (n_Charge_Type  <>    2) and
                (n_Charge_Type  <>    3)
            )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'op_type',
            null,
            s_Tmp_Op_Type
            );
        if (
            (s_Tmp_Op_Type <> 'auto') or
            (s_Tmp_Op_Type   is null)
        ) then
            set n_Result = -2103;
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'charge_ratio',
            null,
            s_Tmp_Charge_Ratio
            );
        if( s_Tmp_Charge_Ratio is null ) then
            set n_Result = -1470;
            leave label_proc;
        end if;

        set n_Tmp_Charge_Ratio = CAST(s_Tmp_Charge_Ratio AS CHAR);
        if ( n_Tmp_Charge_Ratio * n_Charge_Money <> n_Charge_Amount ) then
            set n_Result = -1470;
            leave label_proc;
        end if;

        select
            promoter_id
        into
            n_Tmp_Promoter_ID
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id = n_Game_ID;
        if(found_rows() = 0 ) then
            set n_Result = -20000;
            leave label_proc;
        end if;

        select
            user_id
        into
            n_Tmp_User_ID
        from
            UMS_USER
        where
            user_name = s_User_Name and
            game_id = n_Game_ID;
        call innerCharge(
            n_Game_ID,
            n_Tmp_User_ID,
            n_Rating_ID,
            n_Charge_Amount,
            n_Subject_ID,
            n_Channel_ID,
            n_Discount,
            now(),
            n_Tmp_Promoter_ID,
            n_Charge_Detail_ID,
            n_Charge_Detail_ID,
            n_Charge_Type,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
