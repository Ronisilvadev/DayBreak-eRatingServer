DROP PROCEDURE itemList;
DROP PROCEDURE itemAdd;
DROP PROCEDURE itemMinus;
DROP PROCEDURE pointAdd;
DELIMITER $$

CREATE PROCEDURE itemList(
    in  n_Game_ID             integer,
    in  n_Gateway_ID          integer,
    in  n_Activity_ID         integer unsigned,
    in  n_User_ID             integer unsigned,
    in  n_Role_ID             integer,
    in  n_Role_Level          integer,
    in  n_Max_Item_Count      integer
)
BEGIN
    declare n_Result                integer default  0;
    declare n_Ret_Item_Count        integer default  0;
    declare n_RetCode               integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Specific_Activity_ID  integer unsigned default  1800000000; -- 专属活动类型 /* UMS_USER_ITEM.ACTIVITY_ID%TYPE */
    declare d_Tmp_Current_Time      datetime default  now();
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Ret_Item_Count = 0;
        set n_Tmp_Game_ID = n_Game_ID;

        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (n_Activity_ID      is null) or
            (n_User_ID          is null) or
            (n_Role_ID          is null) or
            (n_Max_Item_Count   is null) or
            (n_Max_Item_Count   <= 0   )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            select n_Result, n_Ret_Item_Count;
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
        call checkGifts(n_Tmp_Game_ID, n_User_ID, n_Gateway_ID, n_Role_ID, n_Role_Level, n_RetCode);
        set @gw_id = n_Gateway_ID;
        set @user_id = n_User_ID;
        set @role_id = n_Role_ID;
        set @activity_id = n_Activity_ID;
        set @bgn_time = d_Tmp_Current_Time;
        set @end_time = d_Tmp_Current_Time;
        set @game_id = n_Tmp_Game_ID;
        set @max_count = n_Max_Item_Count;

        if (truncate(n_Activity_ID, -8) = n_Specific_Activity_ID) then  -- 精确查询此类活动号，用于特定活动
            select
                count(T.activity_id)
            into
                n_Ret_Item_Count
            from
                UMS_USER_ITEM T
            where
                (gateway_id  in (n_Gateway_ID, 0) ) and
                (user_id     =  n_User_ID         ) and
                (role_id     in (n_Role_ID, 0)    ) and
                (activity_id =  n_Activity_ID     ) and
                (item_num    >  0                 ) and
                (begin_time  <= d_Tmp_Current_Time) and
                (end_time    >  d_Tmp_Current_Time) and
                (game_id     =  n_Tmp_Game_ID         );

            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            if (n_Ret_Item_Count > n_Max_Item_Count) then
               set n_Ret_Item_Count = n_Max_Item_Count;
            end if;
            select n_Result, n_Ret_Item_Count;

            prepare stmt1 from "
                select
                    activity_id, item_code, item_num, unix_timestamp(begin_time), unix_timestamp(end_time)
                from
                    UMS_USER_ITEM
                where
                    (gateway_id in (?, 0)) and
                    (user_id       =  ? ) and
                    (role_id in (?, 0)  ) and
                    (activity_id   =  ? ) and
                    (item_num      >  0 ) and
                    (begin_time    <= ? ) and
                    (end_time      >  ? ) and
                    (game_id       =  ? )
                limit ?
            ";
            execute stmt1 using @gw_id, @user_id, @role_id, @activity_id, @bgn_time, @end_time, @game_id, @max_count;
            deallocate prepare stmt1;
        else                       -- 按活动类型查询
            select
                count(T.activity_id)
            into
                n_Ret_Item_Count
            from
                UMS_USER_ITEM T
            where
                (gateway_id             in (n_Gateway_ID, 0)       ) and
                (user_id                =  n_User_ID               ) and
                (role_id                in (n_Role_ID, 0)          ) and
                (truncate(activity_id, -8) =  truncate(n_Activity_ID, -8)) and
                (item_num               >  0                       ) and
                (begin_time             <= d_Tmp_Current_Time      ) and
                (end_time               >  d_Tmp_Current_Time      ) and
                (game_id                =  n_Tmp_Game_ID               );

            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            if (n_Ret_Item_Count > n_Max_Item_Count) then
               set n_Ret_Item_Count = n_Max_Item_Count;
            end if;
            select n_Result, n_Ret_Item_Count;

            prepare stmt2 from "
                select
                    activity_id, item_code, item_num, unix_timestamp(begin_time), unix_timestamp(end_time)
                from
                    UMS_USER_ITEM
                where
                    (gateway_id             in (?, 0)) and
                    (user_id                =  ?     ) and
                    (role_id                in (?, 0)) and
                    (truncate(activity_id, -8) =  truncate(?, -8)) and
                    (item_num               >  0 ) and
                    (begin_time             <= ? ) and
                    (end_time               >  ? ) and
                    (game_id                =  ? )
                limit ?;
            ";
            execute stmt2 using @gw_id, @user_id, @role_id, @activity_id, @bgn_time, @end_time, @game_id, @max_count;
            deallocate prepare stmt2;
        end if;
    end label_proc;
END$$

CREATE PROCEDURE itemAdd(
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_Item_Gateway_ID  integer,
    in  n_Activity_ID      integer unsigned,
    in  n_User_ID          integer unsigned,
    in  n_Role_ID          integer,
    in  s_Item_Code        varchar(32),
    in  n_Item_Num         integer,
    in  d_Begin_Time       datetime,
    in  d_End_Time         datetime,
    in  s_order_code       varchar(32),

    out n_Result           integer
)
BEGIN
    declare n_RetCode       integer default  0;    /* PKG_UTIL.E_ERROR */

    declare d_Tmp_Begin_Time      datetime; /* UMS_USER_ITEM.begin_time%TYPE */
    declare d_Tmp_End_Time        datetime; /* UMS_USER_ITEM.end_time%TYPE */

    declare n_Item_Num_Remained   integer default  0; /* UMS_USER_ITEM.item_num%TYPE */
    declare n_No_Item             integer default  0;
    declare n_Tmp_Gateway_State   integer; /* SYS_GATEWAY.gateway_state%TYPE */
    declare n_Tmp_GW_State        integer default  0;
    declare d_Tmp_Add_Time        datetime default  now();
    declare s_Tmp_Mingle_Realm    varchar(32);
    declare n_Tmp_Role_ID         integer;
    declare n_Tmp_Game_ID         integer;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1464;    /* PKG_UTIL.E_USER_ITEM_DUP */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID         is null) or
            (n_Gateway_ID      is null) or
            (n_Item_Gateway_ID is null) or
            (n_Activity_ID     is null) or
            (n_User_ID         is null) or
            (n_Role_ID         is null) or
            (s_Item_Code       is null) or
            (n_Item_Num        is null) or
            (
                (n_Item_Num <= 0) or  /* MIN_INT */
                (n_Item_Num > 2147483647) /* MAX_INT */
            )
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
        call getGatewayState(n_Tmp_Game_ID, n_Item_Gateway_ID, n_Tmp_GW_State, n_RetCode);
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Tmp_GW_State <> 1) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        call isUserIDExisted(n_Tmp_Game_ID, n_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Role_ID <> 0) then
            select
                role_id
            into
                n_Tmp_Role_ID
            from
                UMS_ROLE
            where
                role_id = n_Role_ID and
                gateway_id = n_Item_Gateway_ID and
                user_id = n_User_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -100;
                leave label_proc;
            end if;
        end if;

        set d_Tmp_Begin_Time = IFNULL(d_Begin_Time, d_Tmp_Add_Time);
        set d_Tmp_End_Time = IFNULL(d_End_Time, ADDDATE(d_Begin_Time, INTERVAL 1 YEAR));

        if (d_End_Time < d_Tmp_Add_Time) then
            set n_Result = -1465;    /* PKG_UTIL.E_USER_ITEM_END_TIME_INVALID */
            leave label_proc;
        end if;

        select
            item_num
        into
            n_Item_Num_Remained
        from
            UMS_USER_ITEM
        where
            (user_id     = n_User_ID        ) and
            (role_id     = n_Role_ID        ) and
            (gateway_id  = n_Item_Gateway_ID) and
            (activity_id = n_Activity_ID    ) and
            (item_code   = s_Item_Code      ) and
            (begin_time  = d_Tmp_Begin_Time ) and
            (end_time    = d_Tmp_End_Time   ) and
            (game_id     = n_Tmp_Game_ID        )
        for update;

        if (FOUND_ROWS() = 0) then
            insert into UMS_USER_ITEM(
                user_id,    gateway_id,        activity_id,   item_code,
                item_num,   begin_time,        end_time,      game_id,
		role_id
            )
            values(
                n_User_ID,  n_Item_Gateway_ID, n_Activity_ID, s_Item_Code,
                n_Item_Num, d_Tmp_Begin_Time,  d_Tmp_End_Time,n_Tmp_Game_ID,
		n_Role_ID
            );
        else
            set n_Item_Num_Remained = n_Item_Num_Remained + n_Item_Num;
            if (
                (n_Item_Num_Remained > 2147483647) or /* MAX_VALUE */
                (n_Item_Num_Remained <= 0) /* MIN_VALUE */
            ) then
                set n_Result = -1466;    /* PKG_UTIL.E_USER_ITEM_NUMBER_INVALID */
                leave label_proc;
            end if;

            update
                UMS_USER_ITEM
            set
                item_num   = n_Item_Num_Remained
            where
                (user_id     = n_User_ID        ) and
                (role_id     = n_Role_ID        ) and
                (gateway_id  = n_Item_Gateway_ID) and
                (activity_id = n_Activity_ID    ) and
                (item_code   = s_Item_Code      ) and
                (begin_time  = d_Tmp_Begin_Time ) and
                (end_time    = d_Tmp_End_Time   ) and
                (game_id     = n_Tmp_Game_ID        );

            if (ROW_COUNT() = 0) then
                leave label_proc;
                set n_Result = -1468;    /* PKG_UTIL.E_USER_ITEM_UPDATE_ERROR */
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
        call logItemOperation(
            n_Tmp_Game_ID,
            n_Item_Gateway_ID,n_Activity_ID,     n_User_ID,     n_Role_ID,
            s_Item_Code,     'A',               n_Item_Num,    s_order_code,
            n_RetCode
        );
    end label_proc;
END$$

CREATE PROCEDURE itemMinus(
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_Item_Gateway_ID  integer,
    in  n_Activity_ID      integer unsigned,
    in  n_User_ID          integer unsigned,
    in  n_Role_ID          integer,
    in  s_Item_Code        varchar(32),
    in  n_Item_Num         integer,

    out n_Result           integer
)
BEGIN
    declare n_RetCode          integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Item_Remain_Num   integer; /* UMS_USER_ITEM.item_num%TYPE */

    declare n_Tmp_Gateway_State integer; /* SYS_GATEWAY.gateway_state%TYPE */
    declare n_Tmp_Item_Num      integer; /* UMS_USER_ITEM.item_num%TYPE */
    declare n_Count             integer;
    declare n_Stop              integer;
    declare n_Cur_Gateway_ID    integer;
    declare n_Cur_Item_Num      integer;
    declare n_Cur_Role_ID       integer;
    declare d_Cur_Begin_Time    datetime;
    declare d_Cur_End_Time      datetime;
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare curItemInfo cursor for 
        select
	    gateway_id, role_id, begin_time, end_time, item_num
        from
            UMS_USER_ITEM
        where
	        (game_id       =  n_Tmp_Game_ID    ) and
            (gateway_id    in (n_Gateway_ID, 0)) and
            (user_id       =  n_User_ID        ) and
            (role_id       in (n_Role_ID,0)    ) and
            (item_code     =  s_Item_Code      ) and
            (item_num      >  0                ) and
            (activity_id   =  n_Activity_ID    ) and
            (begin_time    <=  now()           ) and
            (end_time      >   now()           )
        order by
            item_num desc, gateway_id desc, end_time asc
        for update;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Gateway_ID      is null) or
            (n_Item_Gateway_ID is null) or
            (n_Activity_ID     is null) or
            (n_User_ID         is null) or
            (n_Role_ID         is null) or
            (s_Item_Code       is null) or
            (n_Item_Num        is null) or
            (n_Item_Num        <  1   )
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
        else
            call isUserIDExisted(n_Game_ID, n_User_ID, n_RetCode);
            if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;
        call getGatewayState(n_Tmp_Game_ID, n_Gateway_ID, n_Tmp_Gateway_State, n_RetCode);
        if (
            (n_RetCode           <> 1) or    /* PKG_UTIL.S_SUCCESS */
            (n_Tmp_Gateway_State is null)
        ) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (
            (n_Item_Gateway_ID   = 0) and
            (
                (n_Tmp_Gateway_State = 3) or
                (n_Tmp_Gateway_State = 4)
            )
        ) then
            set n_Result = -1010;    /* PKG_UTIL.E_GATEWAY_STATE_ERROR */
            leave label_proc;
        end if;

        if (n_Item_Gateway_ID <> 0) then
            call isGatewayIDExisted(n_Tmp_Game_ID, n_Item_Gateway_ID, n_RetCode);
            if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        -- if n_Item_Gate_ID is not 0, it must equal to n_Gateway_ID.
        if (
            (n_Item_Gateway_ID <> 0) and
            (n_Item_Gateway_ID <> n_Gateway_ID)
        ) then
            set n_Result = -1450;    /* PKG_UTIL.E_USER_IB_ITEM_ERROR */
            leave label_proc;
        end if;

	open curItemInfo;
        set n_Tmp_Item_Num = n_Item_Num;
        label_loop:loop
            set n_Cur_Gateway_ID = 0;
            set n_Cur_Item_Num = 0;
            set n_Cur_Role_ID = 0;
            set d_Cur_Begin_Time = now();
            set d_Cur_End_Time = now();
            set n_Stop = 0;
            fetch curItemInfo into n_Cur_Gateway_ID, n_Cur_Role_ID, d_Cur_Begin_Time, d_Cur_End_Time, n_Cur_Item_Num;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            if (n_Cur_Item_Num = 0) then
                set n_Result = -1461;    /* PKG_UTIL.E_USER_ITEM_NOT_FOUND */
                leave label_proc;
            end if;
               set n_Tmp_Item_Remain_Num = n_Cur_Item_Num - n_Tmp_Item_Num;
            begin
                if (n_Tmp_Item_Remain_Num = 0) then
                    delete from
                        UMS_USER_ITEM
                    where
                        (game_id       =  n_Tmp_Game_ID        ) and
                        (gateway_id    =  n_Cur_Gateway_ID ) and
                        (user_id       =  n_User_ID        ) and
                        (role_id       =  n_Cur_Role_ID    ) and
                        (item_code     =  s_Item_Code      ) and
                        (activity_id   =  n_Activity_ID    ) and
                        (begin_time    =  d_Cur_Begin_Time ) and
                        (end_time      =  d_Cur_End_Time   );
		elseif (n_Tmp_Item_Remain_Num > 0) then
                    update
                        UMS_USER_ITEM
                    set
                        item_num = n_Tmp_Item_Remain_Num
                    where
                        (game_id       =  n_Tmp_Game_ID        ) and
                        (gateway_id    =  n_Cur_Gateway_ID ) and
                        (user_id       =  n_User_ID        ) and
                        (role_id       =  n_Cur_Role_ID    ) and
                        (item_code     =  s_Item_Code      ) and
                        (activity_id   =  n_Activity_ID    ) and
                        (begin_time    =  d_Cur_Begin_Time ) and
                        (end_time      =  d_Cur_End_Time   );
                else
                    delete from
                       UMS_USER_ITEM
                    where
                        (game_id       =  n_Tmp_Game_ID        ) and
                        (gateway_id    =  n_Cur_Gateway_ID ) and
                        (user_id       =  n_User_ID        ) and
                        (role_id       =  n_Cur_Role_ID    ) and
                        (item_code     =  s_Item_Code      ) and
                        (activity_id   =  n_Activity_ID    ) and
                        (begin_time    =  d_Cur_Begin_Time ) and
                        (end_time      =  d_Cur_End_Time   );
                    set n_Tmp_Item_Num = n_Tmp_Item_Num - n_Cur_Item_Num;
                end if;
                if ( n_Tmp_Item_Remain_Num >= 0 )then
                    call logItemOperation(
                        n_Tmp_Game_ID,
                        n_Gateway_ID,    n_Activity_ID,  n_User_ID, n_Role_ID,
                        s_Item_Code,     'D',            n_Tmp_Item_Num - n_Tmp_Item_Remain_Num,
                        '0',             n_RetCode
                    );
                    set n_Tmp_Item_Num = 0;
                    leave label_loop;
                else
                    call logItemOperation(
                        n_Tmp_Game_ID,
                        n_Gateway_ID,    n_Activity_ID,  n_User_ID, n_Role_ID,
                        s_Item_Code,     'D',            n_Cur_Item_Num,
                        '0',             n_RetCode
                    );
                end if;
            end;
        end loop label_loop;

        close curItemInfo;

        if (
            (n_Tmp_Item_Remain_Num < 0) or
            (n_Tmp_Item_Num > 0)
        ) then
            set n_Result = -1462;    /* PKG_UTIL.E_USER_ITEM_NOT_ENOUGH */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE pointAdd
(
  in  n_Game_ID        integer,
  in  n_User_ID        integer unsigned,
  in  n_Point          integer,
  out n_Result         integer
)
BEGIN
    declare n_RetCode    integer default 0;
    declare n_Stop       integer default 0;

    label_proc:begin
        set n_Result = 0;

        if(
          (n_Game_ID is null) or
          (n_User_ID is null) or
          (n_Point   is null) or
          (n_Point   < 0    )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call isUserIDExisted(
                            n_Game_ID,
                            n_User_ID,
                            n_RetCode
                            );

        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        begin
            insert into ums_user_consume_point
            ( user_id, amount, game_id )
            values
            (n_User_ID, n_Point, n_Game_ID)
            on duplicate key update amount = amount + n_Point;

            if(row_count() = 0) then
                leave label_proc;
            end if;
        end;

        set n_Result = 1;
    end label_proc;

    if(n_Result = 1) then
        call logConsumePointOperation(
                                     n_Game_ID,
                                     n_User_ID,
                                     n_Point,
                                     n_RetCode
                                     );
    end if;

END$$

DELIMITER ;
