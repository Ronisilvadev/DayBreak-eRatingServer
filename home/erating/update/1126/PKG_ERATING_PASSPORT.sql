DROP PROCEDURE modifyPassword;
DROP PROCEDURE onlineCountQueryEx;
DELIMITER $$

CREATE PROCEDURE modifyPassword(
    in  n_User_ID         INTEGER unsigned, 
    in  s_New_Password    VARCHAR(32), 
    out n_Result          INTEGER
)
BEGIN
    label_proc:begin
    if (
            (n_User_ID      is null) or
            (s_New_Password is null)
        ) then
            set n_Result = -100;
            leave label_proc;
    end if;

    update
        UMS_USER
    set
        password = s_New_Password
    where
        user_id = n_User_ID;
    if (row_count() = 0) then
        set n_Result = -1406;
        leave label_proc;
    end if;

        set n_Result = 1;
    end label_proc;
END$$


CREATE PROCEDURE onlineCountQueryEx(
    in  n_Game_ID         integer,
    in  n_Gateway_ID      integer, 
    out n_HighestOnline   integer,
    out n_CurrentOnline   integer,
    out n_LowestOnline    integer,
    out n_Result          integer
)
BEGIN
    declare n_Temp              integer;
    declare n_Tmp_Gateway_ID    integer;

    label_proc:begin
    if (
        (n_Game_ID      is null) or
        (n_Gateway_ID   is null)
       ) then
            set n_Result = -100;
            leave label_proc;
    end if;
    select
        count(*)
    into
        n_Temp
    from
        SYS_GAME_ID
    where
        game_id = n_Game_ID;

    if( n_Temp = 0 ) then
        set n_Result = -1122;
        leave label_proc;
    end if;

    call getUniteGateway(n_Game_ID,n_Gateway_ID,n_Tmp_Gateway_ID,n_Result);
    call isGatewayIDExisted(n_Game_ID,n_Tmp_Gateway_ID,n_Result);
    if(n_Result<>1) then
        leave label_proc;
    end if;
    
    if(n_Gateway_ID = 0) then
        select
            sum(t.user_online_count)
        into
            n_CurrentOnline
        from
            LOG_USER_ONLINE_COUNT t
        where
            t.game_id = n_Game_ID;
    else
        select
            sum(user_online_count)
        into
            n_CurrentOnline
        from
            LOG_USER_ONLINE_COUNT t
        where
            (t.game_id = n_Game_ID) and
            (t.gateway_id = n_Tmp_Gateway_ID);
    end if;
    if (n_CurrentOnline is null) then
        set n_CurrentOnline = 0;
    end if;
    
    select
        max_count
    into
        n_HighestOnline
    from
        STAT_CEO_INFO
    where
        game_id = n_Game_ID and
        gateway_id = n_Tmp_Gateway_ID and
        stat_date = DATE_FORMAT(NOW(), '%Y-%m-%d');
    if(n_HighestOnline is null) then
        set n_HighestOnline = 0;
    end if;

        set n_LowestOnline = 0;
        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;