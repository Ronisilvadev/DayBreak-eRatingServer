DROP PROCEDURE freezeUser;
DROP PROCEDURE unfreezeUser;
DROP PROCEDURE freezeUserList;
DROP PROCEDURE unfreezeUserList;
DROP PROCEDURE addFilterMAC;
DROP PROCEDURE delFilterMAC;
DROP PROCEDURE result_unite;
DROP PROCEDURE view_log_unite;
DROP PROCEDURE getUserInfo;
DROP PROCEDURE getUserItemInfo;
DROP PROCEDURE getLogUserItemInfo;
DROP PROCEDURE getLogDetailInfoByUser;
DROP PROCEDURE getUserPurchaseList;
DROP PROCEDURE getUserIDByName;
DROP PROCEDURE getUserFundLog;
DROP PROCEDURE getUserFundList;
DROP PROCEDURE getRoleListBlur;
DROP PROCEDURE getUserNameByRole;
DROP PROCEDURE getPackage;
DROP PROCEDURE setPackage;
DROP PROCEDURE generateSerialCode;
DROP PROCEDURE updateSerialMedia;
DROP PROCEDURE getLogDetailInfoByMAC;
DROP PROCEDURE getLoginInfoByIp;
DROP PROCEDURE transferBalanceForGM;
DROP PROCEDURE getTransferInfo;
DROP PROCEDURE getRoleNameByID;
DROP PROCEDURE getChargeDetail;

DELIMITER $$

CREATE PROCEDURE getTransferInfo(
    in  n_Game_ID           integer,
    in  charge_Order_Code   varchar(32),
    out n_Uncharge_State    integer,
    out n_Result            integer
)
BEGIN
    declare n_RetCode               integer default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Charge_Detail_ID  bigint;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID                 is null) or
            (charge_Order_Code         is null) 
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            t.charge_detail_id
        into
            n_Tmp_Charge_Detail_ID
        from
            LOG_USER_FUND_DETAIL t
        where
            t.charge_order_code = charge_Order_Code
        and
            t.charge_type = 1
        and
            t.game_id = n_Game_ID;
        if(found_rows() = 0 ) then
            set n_Result = -1448;
            leave label_proc;
        end if;

        call getUnchargeState(
            n_Game_ID,
            n_Tmp_Charge_Detail_ID,
            n_Uncharge_State,
            n_RetCode
            );
        if ( n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE freezeUser(
    in  n_Game_ID         integer,
    in  n_User_ID         integer,
    out n_Result          integer
)
BEGIN
    declare n_RetCode integer default  0;    /* PKG_UTIL.E_ERROR */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID         is null) or
            (n_User_ID         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call isUserIDExisted(n_Game_ID, n_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        update
            UMS_USER
        set
            user_state = (user_state + 1 - (user_state & 1)) /* bitand(user_state, 1) */
        where
            user_id = n_User_ID and
            game_id = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE unfreezeUser(
    in  n_Game_ID         integer,
    in  n_User_ID         integer,
    out n_Result          integer
)
BEGIN
    declare n_RetCode integer default  0;    /* PKG_UTIL.E_ERROR */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_User_ID         is null) or
            (n_Game_ID         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call isUserIDExisted(n_Game_ID, n_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        update
            UMS_USER
        set
            user_state = (user_state - (user_state & 1)) /* bitand(user_state, 1) */
        where
            user_id = n_User_ID and
            game_id = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 批量冻结
CREATE PROCEDURE freezeUserList(
    in  n_Game_ID              integer,
    in  s_user_id_string       varchar(4000),
    out n_Result               integer
)
BEGIN
    declare n_RetCode              integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_User_ID          integer unsigned; /* UMS_USER.user_id%type */
    declare n_Count                integer default  0;
    declare n_Seg_Start            integer;
    declare n_Seg_End              integer;
    declare n_Seg_Length           integer;
    label_proc:begin
        set n_Seg_Start = 1;
        set n_Seg_End = 0;
        set n_Seg_Length = 0;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID         is null) or
            (s_user_id_string  is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        lable_loop:loop
            select locate(',', s_user_id_string, n_Seg_Start) into n_Seg_End;
            if (n_Seg_End = 0) then
                leave lable_loop;
            end if;
            set n_Seg_Length = n_Seg_End - n_Seg_Start;
            select cast(substring(s_user_id_string, n_Seg_Start, n_Seg_Length) as unsigned integer) into n_Tmp_User_ID;

            update
                UMS_USER
            set
                user_state = (user_state + 1 - (user_state & 1)) /* bitand(user_state, 1) */
            where
                user_id = n_Tmp_User_ID and
                game_id = n_Game_ID;

            set n_Seg_Start = n_Seg_End + 1;
        end loop lable_loop;

        select cast(substring(s_user_id_string, n_Seg_Start) as unsigned integer) into n_Tmp_User_ID;

        update
            UMS_USER
        set
            user_state = (user_state + 1 - (user_state & 1)) /* bitand(user_state, 1) */
        where
            user_id = n_Tmp_User_ID and
            game_id = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 批量解冻
CREATE PROCEDURE unfreezeUserList(
    in  n_Game_ID              integer,
    in  s_user_id_string       varchar(4000),
    out n_Result               integer
)
BEGIN
    declare n_RetCode              integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_User_ID          integer; /* UMS_USER.user_id%type */
    declare n_Count                integer default  0;
    declare n_Seg_Start            integer;
    declare n_Seg_End              integer;
    declare n_Seg_Length           integer;
    label_proc:begin
        set n_Seg_Start = 1;
        set n_Seg_End = 0;
        set n_Seg_Length = 0;
        set n_Result = 0; /* E_ERROR */
        if (s_user_id_string  is null) or
           (n_Game_ID         is null) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        lable_loop:loop
            select locate(',', s_user_id_string, n_Seg_Start) into n_Seg_End;
            if (n_Seg_End = 0) then
                leave lable_loop;
            end if;
            set n_Seg_Length = n_Seg_End - n_Seg_Start;
            select cast(substring(s_user_id_string, n_Seg_Start, n_Seg_Length) as unsigned integer) into n_Tmp_User_ID;

            update
                UMS_USER
            set
                user_state = (user_state - (user_state & 1)) /* bitand(user_state, 1) */
            where
                user_id = n_Tmp_User_ID and
                game_id = n_Game_ID;

            set n_Seg_Start = n_Seg_End + 1;
        end loop lable_loop;

        select cast(substring(s_user_id_string, n_Seg_Start) as unsigned integer) into n_Tmp_User_ID;

        update
            UMS_USER
        set
            user_state = (user_state - (user_state & 1)) /* bitand(user_state, 1) */
        where
            user_id = n_Tmp_User_ID and
            game_id = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 添加一个需要被封停的MAC地址
CREATE PROCEDURE addFilterMAC(
    in  n_Game_ID             integer,
    in  s_MAC                 varchar(16),
    out n_Result              integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = 1;
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (s_MAC         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into SYS_FILTER_MAC(
            mac,      game_id
        )
        values(
            s_MAC,    n_Game_ID
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 删除一个被封停的MAC地址
CREATE PROCEDURE delFilterMAC(
    in  n_Game_ID             integer,
    in  s_MAC                 varchar(16),
    out n_Result              integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (s_MAC         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        delete from
            SYS_FILTER_MAC
        where
            mac     = s_MAC and
            game_id = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 合服结果查询
CREATE PROCEDURE result_unite(
    in  n_Game_ID               integer,
    in  n_Dst_Gw_ID     integer,
    in  n_Src_Gw_ID     integer,
    out n_Out_Exec_Result   integer,
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Out_Exec_Result = 0;  /*E_RROR*/
        if(
        (n_Game_ID  is null) or
        (n_Dst_Gw_ID    is null) or
        (n_Src_Gw_ID    is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select u1.exec_result
        into n_Out_Exec_Result
        from LOG_UNITE u1
        where u1.log_id = (
            select  max(u2.log_id)
            from    LOG_UNITE u2
            where   u2.game_id      = n_Game_ID     and
                u2.src_gateway_id   = n_Src_Gw_ID   and
                u2.dst_gateway_id   = n_Dst_Gw_ID
        )
        and u1.message = 'RESULT_CODE_UNITE';

        if(found_rows() = 0) then
            set n_Result = 0;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

-- 合服时剩余记录
CREATE PROCEDURE view_log_unite(
    in  n_Game_ID           integer,
    in  n_Dst_Gw_ID     integer,
    in  n_Src_Gw_ID     integer,
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;

        if (
        (n_Game_ID   is null) or
        (n_Dst_Gw_ID is null) or
        (n_Src_Gw_ID is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select  u.exec_result,u.message,u.exec_time
        from    LOG_UNITE u
        where   u.game_id =     n_Game_ID   and
            u.dst_gateway_id = n_Dst_Gw_ID  and
            u.src_gateway_id = n_Src_Gw_ID
        order by u.log_id desc;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserInfo(
    in  n_Game_ID            integer,
    in  s_User_Name          varchar(32),

    out n_Ret_User_ID        integer,
    out n_Ret_User_Type      integer,
    out n_Ret_User_Flag      integer,
    out d_Ret_Birthday       datetime,
    out n_Ret_ID_Verify_Flag integer,
    out n_Ret_Promoter_ID    integer,
    out n_Ret_Gateway_ID     integer,
    out n_Ret_Server_ID      integer,
    out n_Ret_User_State     integer,
    out n_Result             integer
)
BEGIN
    declare n_Tmp_Count      integer;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID   is null) or
            (s_User_Name is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            count(*)
        into
            n_Tmp_Count
        from
            UMS_USER r
        where
            r.user_name = s_User_Name and
            r.game_id   in
            (
                select
                	game_id
            	from
                	sys_slave_games
        		where
                	game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            		)
        		union
        		select
            		n_Game_ID
            );

        if (n_Tmp_Count <> 1) then
            set n_Result = -1406;
            leave label_proc;
        end if;
        select
            r.user_id,              r.user_type,         r.user_flag,        r.birthday,
            r.id_verify_flag,       r.promoter_id,       r.gateway_id,       r.server_id,
            r.user_state
        into
            n_Ret_User_ID,          n_Ret_User_Type,     n_Ret_User_flag,    d_Ret_Birthday,
            n_Ret_ID_Verify_Flag,   n_Ret_Promoter_ID,   n_Ret_Gateway_ID,   n_Ret_Server_ID,
            n_Ret_User_State
        from
            UMS_USER r
        where
            r.user_name = s_User_Name and
            r.game_id   in
            (
                select
                	game_id
            	from
                	sys_slave_games
        		where
                	game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            		)
        		union
        		select
            		n_Game_ID
            );

   	    select
            t.role_id,          t.role_name,          t.gateway_id,
            t.nationality_id,   t.role_gender,        t.role_occupation,
            t.role_level,       t.role_state,         t.create_time,
            t.delete_time,      t.last_logout_time,   t.total_online_second,
            inet_ntoa(d.first_login_ip),    t.game_id
        from
            UMS_ROLE t,
            LOG_ROLE_FIRST_LOGIN d
        where
            t.user_id = n_Ret_User_ID and
            t.role_id = d.role_id and
            t.game_id = d.game_id and
            t.game_id in
            (
                select
                	game_id
            	from
                	sys_slave_games
        		where
                	game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            		)
        		union
        		select
            		n_Game_ID
            );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserItemInfo(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),
    in   n_Page_Index       integer,
    in   n_Page_Size        integer,
    in   d_Begin_Time       datetime,
    in   d_End_Time         datetime,
    in   s_Item_Code        varchar(32),

    out  n_Ret_Total_Items  integer,
    out  n_Result               integer
)
BEGIN
    declare n_RetCode       integer default  0;
    declare n_Ret_User_ID   integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null) or
            (d_Begin_Time is null) or
            (d_End_Time   is null) or
            (n_Page_Size  is null) or
            (n_Page_Index is null) or
            (n_Page_Size  <= 0   ) or
            (n_Page_Index <  0   )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (s_Item_Code is null) then
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    UMS_USER_ITEM t
                where
                    (t.user_id    =  n_Ret_User_ID) and
                    (t.begin_time >= d_Begin_Time)  and
                    (t.begin_time <  d_End_time)    and
                    (t.game_id    =  n_Game_ID );
                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    set n_Ret_Total_Items = 0;
                end if;
            end;

            set @n_Ret_User_ID = n_Ret_User_ID;
            set @d_Begin_Time = d_Begin_Time;
            set @d_End_time = d_End_time;
            set @n_Game_ID = n_Game_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.gateway_id, t.activity_id, t.item_code, t.item_num, t.begin_time, t.end_time
                from
                    UMS_USER_ITEM t
                where
                    (t.user_id    =  ?) and
                    (t.begin_time >= ?) and
                    (t.begin_time <  ?) and
                    (t.game_id    =  ?)
                order by
                    t.activity_id, t.begin_time desc
                limit ?, ?';
            execute s_Sql_Text using @n_Ret_User_ID, @d_Begin_Time, @d_End_time, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        else
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    UMS_USER_ITEM t
                where
                    (t.user_id    =  n_Ret_User_ID) and
                    (t.begin_time >= d_Begin_Time)  and
                    (t.begin_time <  d_End_time)    and
                    (t.item_code  =  s_Item_Code)   and
                    (t.game_id    =  n_Game_ID);

                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    set n_Ret_Total_Items = 0;
                end if;
            end;

            set @n_Ret_User_ID = n_Ret_User_ID;
            set @d_Begin_Time = d_Begin_Time;
            set @d_End_time = d_End_time;
            set @n_Game_ID = n_Game_ID;
            set @s_Item_Code = s_Item_Code;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.gateway_id, t.activity_id, t.item_code, t.item_num, t.begin_time, t.end_time
                from
                    UMS_USER_ITEM t
                where
                    (t.user_id    =  ?) and
                    (t.begin_time >= ?) and
                    (t.begin_time <  ?) and
                    (t.item_code  =  ?) and
                    (t.game_id    =  ?)
                order by
                    t.activity_id, t.begin_time desc
                limit ?, ?';
            execute s_Sql_Text using @n_Ret_User_ID, @d_Begin_Time, @d_End_time, @s_Item_Code, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getLogUserItemInfo(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),
    in   n_Page_Index       integer,
    in   n_Page_Size        integer,
    in   d_Begin_Time       datetime,
    in   d_End_Time         datetime,
    in   s_Item_Code        varchar(32),

    out  n_Ret_Total_Items  integer,
    out  n_Result               integer
)
BEGIN
    declare n_RetCode       integer default  0;
    declare n_Ret_User_ID   integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null) or
            (d_Begin_Time is null) or
            (d_End_Time   is null) or
            (n_Page_Size  is null) or
            (n_Page_Index is null) or
            (n_Page_Size  <= 0   ) or
            (n_Page_Index <  0   )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

            call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

            if (s_Item_Code is null) then
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    LOG_USER_ITEM t
                where
                    (t.user_id    =  n_Ret_User_ID) and
                    (t.log_time   >= d_Begin_Time)  and
                    (t.log_time   <  d_End_time)    and
                    (t.game_id    =  n_Game_ID);

                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    set n_Ret_Total_Items = 0;
                end if;
            end;

            set @n_Ret_User_ID = n_Ret_User_ID;
            set @d_Begin_Time = d_Begin_Time;
            set @d_End_time = d_End_time;
            set @n_Game_ID = n_Game_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.gateway_id,
                    t.activity_id,
                    t.item_code,
                    t.item_num,
                    t.log_time,
                    t.operation_code
                from
                    LOG_USER_ITEM t
                where
                    t.user_id  =  ?  and
                    t.log_time >= ?  and
                    t.log_time <  ?  and
                    t.game_id  =  ?
                order by
                    t.log_time desc
                limit ?, ?';
            execute s_Sql_Text using @n_Ret_User_ID, @d_Begin_Time, @d_End_time, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        else
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    LOG_USER_ITEM t
                where
                    (t.user_id    =  n_Ret_User_ID) and
                    (t.log_time   >= d_Begin_Time)  and
                    (t.log_time   <  d_End_time)    and
                    (t.item_code  =  s_Item_Code)   and
                    (t.game_id    =  n_Game_ID);

                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    set n_Ret_Total_Items = 0;
                end if;
            end;

            set @n_Ret_User_ID = n_Ret_User_ID;
            set @d_Begin_Time = d_Begin_Time;
            set @d_End_time = d_End_time;
            set @n_Game_ID = n_Game_ID;
            set @s_Item_Code = s_Item_Code;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.gateway_id,
                    t.activity_id,
                    t.item_code,
                    t.item_num,
                    t.log_time,
                    t.operation_code
                from
                    LOG_USER_ITEM t
                where
                    t.user_id  =  ?  and
                    t.log_time >= ?  and
                    t.log_time <  ?  and
                    t.item_code = ?  and
                    t.game_id  =  ?
                order by
                    t.log_time desc
                limit ?, ?';
            execute s_Sql_Text using @n_Ret_User_ID, @d_Begin_Time, @d_End_time, @s_Item_Code, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getLogDetailInfoByUser(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),
    in   n_Page_Index       integer,
    in   n_Page_Size        integer,
    in   d_Begin_Time       datetime,
    in   d_End_Time         datetime,

    out  n_Ret_Total_Items  integer,
    out  n_Result               integer
)
BEGIN
    declare n_RetCode           integer default  0;
    declare n_Ret_User_ID       integer unsigned;
    declare n_Tmp_Begin_Log_ID  integer;
    declare n_Tmp_End_Log_ID    integer;
    declare n_Tmp_Log_Date      datetime;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null) or
            (d_Begin_Time is null) or
            (d_End_Time   is null) or
            (n_Page_Index is null) or
            (n_Page_Size  is null) or
            (d_Begin_Time >= d_End_Time)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Tmp_Log_Date = DATE_FORMAT(d_Begin_Time, '%Y-%m-%d');
        lable_loop:loop
            select
                t.log_id
            into
                n_Tmp_Begin_Log_ID
            from
                LOG_DAILY_LOGID t
            where
                t.log_date   = n_Tmp_Log_Date   and
                t.table_name = 'LOG_RECORD_DETAIL';

            if(FOUND_ROWS() = 1)then
                leave lable_loop;
            else
                if (n_Tmp_Log_Date >= DATE_FORMAT(d_End_Time, '%Y-%m-%d')) then
                    set n_Ret_Total_Items = 0;
                    leave label_proc;
                end if;
                set n_Tmp_Log_Date = adddate(n_Tmp_Log_Date, 1);
            end if;
        end loop lable_loop;

        set n_Tmp_Log_Date = DATE_FORMAT(d_End_Time, '%Y-%m-%d');
        lable_loop:loop
            select
                t.log_id
            into
                n_Tmp_End_Log_ID
            from
                LOG_DAILY_LOGID t
            where
                t.log_date   = n_Tmp_Log_Date   and
                t.table_name = 'LOG_RECORD_DETAIL';

            if(FOUND_ROWS() <>0)then
               leave lable_loop;
            else
                if (n_Tmp_Log_Date >= curdate()) then
                    leave lable_loop;
                end if;
                set n_Tmp_Log_Date = adddate(n_Tmp_Log_Date, 1);
            end if;
        end loop lable_loop;

        if (n_Tmp_End_Log_ID is not null) then
            begin
               select
                   count(*)
               into
                   n_Ret_Total_Items
               from
                   LOG_RECORD_DETAIL t
               where
                   (t.login_id >= n_Tmp_Begin_Log_ID) and
                   (t.login_id <  n_Tmp_End_Log_ID  ) and
                   (t.user_id  =  n_Ret_User_ID     ) and
                   (t.game_id  =  n_Game_ID         );

               if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                   set n_Ret_Total_Items = 0;
               end if;
            end;

            set @n_Tmp_Begin_Log_ID = n_Tmp_Begin_Log_ID;
            set @n_Tmp_End_Log_ID = n_Tmp_End_Log_ID;
            set @n_Ret_User_ID = n_Ret_User_ID;
            set @n_Game_ID = n_Game_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.user_id,    t.role_id,       t.server_id,  t.role_level,  t.money1,
                    t.money2,     t.experience,    t.login_time, t.logout_time, t.login_ip,
                    t.login_port, t.province_code, t.city_code,  t.mac
                from
                    LOG_RECORD_DETAIL t
                where
                    (t.login_id >= ? ) and
                    (t.login_id <  ? ) and
                    (t.user_id  =  ? ) and
                    (t.game_id  =  ? )
                order by
                    t.login_id desc
                limit ?, ?';
            execute s_Sql_Text using @n_Tmp_Begin_Log_ID, @n_Tmp_End_Log_ID, @n_Ret_User_ID, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        else
            begin
               select
                   count(*)
               into
                   n_Ret_Total_Items
               from
                   LOG_RECORD_DETAIL t
               where
                   (t.login_id >= n_Tmp_Begin_Log_ID) and
                   (t.user_id  =  n_Ret_User_ID     ) and
                   (t.game_id  =  n_Game_ID         );

               if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                   set n_Ret_Total_Items = 0;
               end if;
            end;

            set @n_Tmp_Begin_Log_ID = n_Tmp_Begin_Log_ID;
            set @n_Ret_User_ID = n_Ret_User_ID;
            set @n_Game_ID = n_Game_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    t.user_id,    t.role_id,       t.server_id,  t.role_level,  t.money1,
                    t.money2,     t.experience,    t.login_time, t.logout_time, t.login_ip,
                    t.login_port, t.province_code, t.city_code,  t.mac
                from
                    LOG_RECORD_DETAIL t
                where
                    (t.login_id >= ? ) and
                    (t.user_id  =  ? ) and
                    (t.game_id  =  ? )
                order by
                    t.login_id desc
                limit ?, ?';
            execute s_Sql_Text using @n_Tmp_Begin_Log_ID, @n_Ret_User_ID, @n_Game_ID, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserPurchaseList(
    in    n_Game_ID             integer,
    in    s_User_Name           varchar(32),
    in    d_Begin_Date          datetime,
    in    d_End_Date            datetime,
    in    n_Page_Index          integer,
    in    n_Page_Size           integer,

    out   n_Ret_Total_Items     integer,
    out   n_Result                integer
)
BEGIN
    declare n_RetCode       integer default  0;
    declare n_Ret_User_ID   integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (d_Begin_Date is null) or
            (d_End_Date   is null) or
            (s_User_Name  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

            call getUserIDByName(n_Game_ID, s_User_Name, n_Tmp_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        begin
            select
                count(*)
            into
                n_Ret_Total_Items
            from
                UMS_USER_PURCHASE_DETAIL t
            where
                t.user_id = n_Tmp_User_ID       and
                t.purchase_time >= d_Begin_Date and
                t.purchase_time <  d_End_Date   and
                t.game_id = n_Game_ID;

            if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                leave label_proc;
            end if;
        end;

        set @n_Tmp_User_ID = n_Tmp_User_ID;
        set @d_Begin_Date = d_Begin_Date;
        set @d_End_Date = d_End_Date;
        set @n_Game_ID = n_Game_ID;
        set @n_Page_Index = n_Page_Index*n_Page_Size;
        set @n_Page_Size =n_Page_Size;
        prepare s_Sql_Text from '
            select
                t.purchase_id,   t.role_id,    t.purchase_ip,
                t.package_id,    t.product_id, t.product_num,
                t.purchase_time, t.subject_id, t.cost_amount
            from
                UMS_USER_PURCHASE_DETAIL t
            where
                t.user_id = ?        and
                t.purchase_time >= ? and
                t.purchase_time <  ? and
                t.game_id = ?
            order by
                t.purchase_time desc
            limit ?, ?';
        execute s_Sql_Text using @n_Tmp_User_ID, @d_Begin_Date, @d_End_Date, @n_Game_ID, @n_Page_Index, @n_Page_Size;

        deallocate prepare s_Sql_Text;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserIDByName(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),

    out  n_Ret_User_ID      integer,
    out  n_Result               integer
)
BEGIN
    declare n_RetCode       integer default  0;
    label_proc:begin
        set n_Result = 0;

        call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserFundLog(
    in    n_Game_ID             integer,
    in    s_User_Name           varchar(32),
    in    d_Begin_Time          datetime,
    in    d_End_Time            datetime,
    in    n_Page_Index          integer,
    in    n_Page_Size           integer,

    out   n_Ret_Total_Items     integer,
    out   n_Result                integer
)
BEGIN
    declare n_RetCode       integer default  0;
    declare n_Ret_User_ID   integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null) or
            (d_Begin_Time is null) or
            (d_End_Time   is null)
        )then
            set n_Result = -100;
            leave label_proc;
        end if;

            call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        begin
            select
                count(*)
            into
                n_Ret_Total_Items
            from
                LOG_USER_FUND_DETAIL t
            where
                (t.user_id     =  n_Ret_User_ID) and
                (t.charge_time >= d_Begin_Time ) and
                (t.charge_time <  d_End_Time   ) and
                (t.game_id     =  n_Game_ID    );
            if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                leave label_proc;
            end if;
        end;

        set @n_Ret_User_ID = n_Ret_User_ID;
        set @d_Begin_Time = d_Begin_Time;
        set @d_End_Time = d_End_Time;
        set @n_Game_ID = n_Game_ID;
        set @n_Page_Index = n_Page_Index*n_Page_Size;
        set @n_Page_Size =n_Page_Size;
        prepare s_Sql_Text from '
            select
                t.rating_id,
                t.subject_id,
                t.charge_amount,
                t.charge_time,
                t.charge_type,
                t.charge_detail_id,
                t.charge_order_code
            from
                LOG_USER_FUND_DETAIL t
            where
                (t.user_id     =  ? ) and
                (t.charge_time >= ? ) and
                (t.charge_time <  ? ) and
                (t.game_id     =  ? )
            order by
                t.charge_time desc
            limit ?, ?';
        execute s_Sql_Text using @n_Ret_User_ID, @d_Begin_Time, @d_End_Time, @n_Game_ID, @n_Page_Index, @n_Page_Size;

        deallocate prepare s_Sql_Text;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserFundList(
    in    n_Game_ID             integer,
    in    s_User_Name           varchar(32),

    out   n_Result                integer
)
BEGIN
    declare n_RetCode       integer default  0;
    declare n_Ret_User_ID   integer unsigned;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID    is null) or
            (s_User_Name  is null)
        )then
            set n_Result = -100;
            leave label_proc;
        end if;

            call getUserID(n_Game_ID, s_User_Name, n_Ret_User_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        select
            t.rating_id,
            t.subject_id,
            t.amount
        from
            UMS_USER_FUND t
        where
            t.user_id = n_Ret_User_ID and
            t.game_id = n_Game_ID
        order by
            t.rating_id;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE transferBalanceForGM(
    in    n_Game_ID              integer,
    in    s_User_Name            varchar(32),
    in    n_Src_Rating_ID        integer,
    in    n_Dst_Rating_ID        integer,
    in    n_Subject_ID           integer,
    in    n_Charge_Detail_ID     bigint,
    out   n_Result               integer
)
BEGIN
    declare n_RetCode             integer default  0;
    declare n_Tmp_User_ID         integer unsigned;
    declare n_Tmp_Count           integer default 0;
    declare s_Tmp_Auto_Draw_Type  varchar(32);
    declare n_Charge_Amount       integer;
    declare d_Tmp_Charge_Time     datetime;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID          is null) or
            (s_User_Name        is null) or
            (n_Src_Rating_ID    is null) or
            (n_Dst_Rating_ID    is null) or
            (n_Subject_ID       is null) or
            (n_Charge_Detail_ID is null)
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
            ifnull(sum(t.charge_amount), 0), max(t.charge_time)
        into
            n_Charge_Amount, d_Tmp_Charge_Time
        from
            LOG_USER_FUND_DETAIL t
        where
            t.charge_detail_id = n_Charge_Detail_ID
        and
            t.charge_type = 1
        and
            t.game_id = n_Game_ID
        and
            t.rating_id = n_Src_Rating_ID
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
            n_Charge_Detail_ID,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getRoleListBlur(
    in    n_Game_ID           integer,
    in    s_Role_Name         varchar(32),
    in    n_Gateway_ID        integer,
    in    n_Page_Index        integer,
    in    n_Page_Size         integer,

    out   n_Ret_Total_Items   integer,
    out   n_Result            integer
)
BEGIN
    declare n_RetCode       integer default  0;
    label_proc:begin
        set n_Result = 0;
        if (
            (s_Role_Name is null) or
            (n_Game_ID   is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if (n_Gateway_ID = 0) then
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    UMS_ROLE A,
                    UMS_USER B
                where
                    A.role_name like concat("%",s_Role_Name,"%") and
                    (B.user_id   =    A.user_id) and
                    (A.game_id   =    B.game_id) and
                    A.game_id   in
                    (
                        select
            			    game_id
        				from
            				sys_slave_games
        			    where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
                				where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
            				)
        				union
        				select
            				n_Game_ID
                    );

                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    leave label_proc;
                end if;
            end;

            set @s_Role_Name = s_Role_Name;
            set @n_Game_ID = n_Game_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    A.role_name  role_name,
                    A.role_id    role_id,
                    A.gateway_id gateway_id,
                    B.server_id  server_id,
                    A.role_state role_state,
                    B.user_name  user_name,
                    A.login_id   user_online_state,
                    B.game_id    game_id
                from
                    UMS_ROLE A,
                    UMS_USER B
                where
                    A.role_name like concat("%",?,"%") and
                    (B.user_id   =    A.user_id        ) and
                    (A.game_id   =    B.game_id        ) and
                    A.game_id    in
                    (
                        select
            			    game_id
        				from
            				sys_slave_games
        				where
            				game_id = ? or
            				slave_game_id = ?
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    			    ifnull(game_id, 0)
                				from
                    				sys_slave_games
                				where
                    				game_id = ? or
                    				slave_game_id = ?
            				)
        				union
        				select
            				?
                    )
                limit ?, ?';
            execute s_Sql_Text using @s_Role_Name, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID,
                @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        else
            begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    UMS_ROLE A,
                    UMS_USER B
                where
                    A.role_name like concat("%",s_Role_Name,"%") and
                    (A.gateway_id = n_Gateway_ID) and
                    (B.user_id   =    A.user_id) and
                    (A.game_id   =    B.game_id) and
                    A.game_id   in
                    (
                        select
            			    game_id
        				from
            				sys_slave_games
        			    where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
                				where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
            				)
        				union
        				select
            				n_Game_ID
                    );

                if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
                    leave label_proc;
                end if;
            end;

            set @s_Role_Name = s_Role_Name;
            set @n_Game_ID = n_Game_ID;
            set @n_Gateway_ID = n_Gateway_ID;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select
                    A.role_name  role_name,
                    A.role_id    role_id,
                    A.gateway_id gateway_id,
                    B.server_id  server_id,
                    A.role_state role_state,
                    B.user_name  user_name,
                    A.login_id   user_online_state,
                    B.game_id    game_id
                from
                    UMS_ROLE A,
                    UMS_USER B
                where
                    A.role_name like concat("%",?,"%") and
                    (A.gateway_id = ?     ) and
                    (B.user_id   =    A.user_id        ) and
                    (A.game_id   =    B.game_id        ) and
                    A.game_id    in
                    (
                        select
            			    game_id
        				from
            				sys_slave_games
        				where
            				game_id = ? or
            				slave_game_id = ?
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    			    ifnull(game_id, 0)
                				from
                    				sys_slave_games
                				where
                    				game_id = ? or
                    				slave_game_id = ?
            				)
        				union
        				select
            				?
                    )
                limit ?, ?';
            execute s_Sql_Text using @s_Role_Name, @n_Gateway_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID,
                @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getUserNameByRole(
    in    n_Game_ID           integer,
    in    s_Role_Name         varchar(32),
    in    n_Gateway_ID        integer,

    out   s_Ret_User_Name     varchar(32),
    out   n_Ret_User_ID       integer,
    out   n_Result            integer
)
BEGIN
    declare n_Tmp_Count       integer;
    label_proc:begin
        set n_Result = 0;

        if (
            (s_Role_Name is null) or
            (n_Gateway_ID   is null) or
            (n_Game_ID   is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if (n_Gateway_ID = 0) then
            begin
                select
                    count(*)
                into
                    n_Tmp_Count
                from
                    UMS_USER A, UMS_ROLE B
                where
                    (A.user_id    = B.user_id)   and
                    (B.role_name  = s_Role_Name) and
                    (A.game_id    = B.game_id)   and
                    B.game_id    in
                    (
                        select
            				game_id
        				from
            				sys_slave_games
        				where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
               					where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
    						)
        				union
        				select
            			    n_Game_ID
                    );

                if (n_Tmp_Count <> 1) then
                    set n_Result = -1250;
                    leave label_proc;
                end if;
            end;

            begin
                select
                    A.user_name, A.user_id
                into
                    s_Ret_User_Name, n_Ret_User_ID
                from
                    UMS_USER A, UMS_ROLE B
                where
                    (A.user_id    = B.user_id)   and
                    (B.role_name  = s_Role_Name) and
                    (A.game_id    = B.game_id)   and
                    B.game_id    in
                    (
                        select
            				game_id
        				from
            				sys_slave_games
        				where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
               					where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
    						)
        				union
        				select
            			    n_Game_ID
                    );
            end;
        else
            begin
                select
                    count(*)
                into
                    n_Tmp_Count
                from
                    UMS_USER A, UMS_ROLE B
                where
                    (A.user_id    = B.user_id)   and
                    (B.role_name  = s_Role_Name) and
                    (B.gateway_id = n_Gateway_ID) and
                    (A.game_id    = B.game_id)   and
                    B.game_id    in
                    (
                        select
            				game_id
        				from
            				sys_slave_games
        				where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
               					where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
    						)
        				union
        				select
            			    n_Game_ID
                    );

                if (n_Tmp_Count <> 1) then
                    set n_Result = -1250;
                    leave label_proc;
                end if;
            end;
            begin
                select
                    A.user_name, A.user_id
                into
                    s_Ret_User_Name, n_Ret_User_ID
                from
                    UMS_USER A, UMS_ROLE B
                where
                    (A.user_id    = B.user_id)   and
                    (B.role_name  = s_Role_Name) and
                    (B.gateway_id = n_Gateway_ID) and
                    (A.game_id    = B.game_id)   and
                    B.game_id    in
                    (
                        select
            				game_id
        				from
            				sys_slave_games
        				where
            				game_id = n_Game_ID or
            				slave_game_id = n_Game_ID
        				union
        				select
            				slave_game_id
        				from
            				sys_slave_games
        				where
            				game_id in (
                				select
                    				ifnull(game_id, 0)
                				from
                    				sys_slave_games
               					where
                    				game_id = n_Game_ID or
                    				slave_game_id = n_Game_ID
    						)
        				union
        				select
            			    n_Game_ID
                    );
            end;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getPackage(
    in  n_Game_ID       integer,
    in  n_Package_ID    integer,
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;

        select
            *
        from
            sys_activity_package
        where
            package_id = n_Package_ID;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE setPackage(
    in  n_Game_ID       integer,
    in  n_package_ID    integer,
    in  s_item_code     varchar(32),
    in  s_item_name     varchar(32),
    in  n_item_num      integer,
    out n_Result        integer
)
BEGIN
    call addActivityPackage(
            n_package_ID,
            s_item_code,
            s_item_name,
            n_item_num,
            n_Result
        );
END$$

CREATE PROCEDURE generateSerialCode(
    in  n_Game_ID       integer,
    in  s_serial_no     varchar(32),
    in  n_Activity_ID   integer,
    in  s_media_name    varchar(32),
    in  n_use_limit     integer,
    out n_Result        integer
)
BEGIN
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare d_Tmp_Create_Time       datetime default now();
    declare cur_Game_ID_List cursor for
        select
            game_id
        from
            sys_slave_games
        where
            game_id = n_Game_ID or
            slave_game_id = n_Game_ID
        union
        select
            slave_game_id
        from
            sys_slave_games
        where
            game_id in (
                select
                    ifnull(game_id, 0)
                from
                    sys_slave_games
                where
                    game_id = n_Game_ID or
                    slave_game_id = n_Game_ID
            )
        union
        select
            n_Game_ID;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        
        open cur_Game_ID_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            insert ignore into sys_serial_no(
                serial_no,     activity_id,   media_name,
                use_limit,     serial_state,  game_id,
                create_time
            )
            values(
                s_serial_no,   n_Activity_ID, s_media_name,
                n_use_limit,   0,             n_cur_Game_ID,
                d_Tmp_Create_Time
            );
            if( row_count() = 0) then
                leave label_loop;
            end if;
        end loop label_loop;
        close cur_Game_ID_List;
        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE updateSerialMedia(
    in  n_Game_ID       integer,
    in  s_Media_Name    varchar(32),
    in  s_Serial_List   varchar(4000),
    out n_Result        integer
)
BEGIN
    declare n_Temp      integer default 0;
    declare n_Stop                  integer;
    declare n_cur_Game_ID           integer;
    declare cur_Game_ID_List cursor for
        select
            game_id
        from
            sys_slave_games
        where
            game_id = n_Game_ID or
            slave_game_id = n_Game_ID
        union
        select
            slave_game_id
        from
            sys_slave_games
        where
            game_id in (
                select
                    ifnull(game_id, 0)
                from
                    sys_slave_games
                where
                    game_id = n_Game_ID or
                    slave_game_id = n_Game_ID
            )
        union
        select
            n_Game_ID;
    declare exit handler for sqlexception set n_Result = -100;
    declare continue handler for not found set n_Stop = 1;
    open cur_Game_ID_List;
    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID      is null) or
            (s_Media_Name   is null) or
            (s_Serial_List  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            set @imp_sql=concat("update sys_serial_no set media_name='",
                            s_Media_Name,
                            "' where game_id=",
                            n_cur_Game_ID,
                            " and serial_no in(",
                            s_Serial_List,
                            ");");
            prepare st from @imp_sql;

            execute st;
            set n_Temp = row_count();
            deallocate prepare st;

            if( n_Temp =0 ) then
                set n_Result = -1481;   /* PKG_UTIL.E_USER_SERIALNO_NOT_FOUND */
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE getLogDetailInfoByMAC(
      in  n_Game_ID         integer,
      in  s_Login_MAC       varchar(16),
      in  d_Begin_Time      datetime,
      in  d_End_Time        datetime,
      in  n_Page_Index      integer,
      in  n_Page_Size       integer,
      out n_Ret_Total_Items integer,
      out n_Result          integer
)
BEGIN
    declare n_Tmp_Begin_Log_ID  bigint unsigned;
    declare n_Tmp_End_Log_ID    bigint unsigned;
    declare d_Tmp_Log_Date      datetime;
    declare n_Tmp               integer default 0;
    label_proc:begin
        set n_Result = 0;
        if(
            (n_Game_ID    is null)or
            (s_Login_MAC  is null)or
            (d_Begin_Time is null)or
            (d_End_Time   is null)or
            (n_Page_Index is null)or
            (n_Page_Size  is null)or
            (d_Begin_Time >= d_End_Time)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set d_Tmp_Log_Date = DATE_FORMAT(d_Begin_Time, '%Y-%m-%d');

        begin
        label_loop:loop
            select
                log_id
            into
                n_Tmp_Begin_Log_ID
            from
                LOG_DAILY_LOGID
            where
                log_date   = d_Tmp_Log_Date   and
                table_name = 'LOG_RECORD_DETAIL';

            if(found_rows()=0)then
                if (d_Tmp_Log_Date >= DATE_FORMAT(d_End_Time, '%Y-%m-%d')) then
                    set n_Ret_Total_Items = 0;
                    leave label_proc;
                end if;
                set d_Tmp_Log_Date = ADDDATE(d_Tmp_Log_Date, 1);
            else
                leave label_loop;
            end if;
        end loop label_loop;
        end;

        set d_Tmp_Log_Date = DATE_FORMAT(d_End_Time, '%Y-%m-%d');

        begin
        label_loop:loop
            select
                log_id
            into
                n_Tmp_End_Log_ID
            from
                LOG_DAILY_LOGID
            where
                log_date   = d_Tmp_Log_Date   and
                table_name = 'LOG_RECORD_DETAIL';

            if(found_rows()=0)then
                if (d_Tmp_Log_Date >= curdate()) then
                    leave label_loop;
                end if;
                set d_Tmp_Log_Date = ADDDATE(d_Tmp_Log_Date, 1);
            else
                leave label_loop;
            end if;
        end loop label_loop;
        end;

        set n_Tmp = n_Page_Index*n_Page_Size;

        if (n_Tmp_End_Log_ID is not null) then
            label_temp:begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    LOG_RECORD_DETAIL
                where
                    (login_id >= n_Tmp_Begin_Log_ID) and
                    (login_id <  n_Tmp_End_Log_ID  ) and
                    (mac      =  s_Login_MAC       ) and
                    (game_id  =  n_Game_ID         );

                if(found_rows()=0)then
                    leave label_temp;
                end if;
            end label_temp;

            select
                user_id,    role_id,       server_id,  role_level,  money1,
                money2,     experience,    login_time, logout_time, login_ip,
                login_port, province_code, city_code,  mac
            from
                LOG_RECORD_DETAIL
            where
                (login_id >= n_Tmp_Begin_Log_ID) and
                (login_id <  n_Tmp_End_Log_ID  ) and
                (mac      =  s_Login_MAC       ) and
                (game_id  =  n_Game_ID         )
            order by
                login_id desc
            limit n_Tmp, n_Page_Size;
        else
            label_temp:begin
                select
                    count(*)
                into
                    n_Ret_Total_Items
                from
                    LOG_RECORD_DETAIL
                where
                    (login_id >= n_Tmp_Begin_Log_ID) and
                    (mac      =  s_Login_MAC       ) and
                    (game_id  =  n_Game_ID         );

                if(found_rows()=0)then
                    leave label_temp;
                end if;
            end label_temp;

            select
                user_id,    role_id,       server_id,  role_level,  money1,
                money2,     experience,    login_time, logout_time, login_ip,
                login_port, province_code, city_code,  mac
            from
                LOG_RECORD_DETAIL
            where
                (login_id >= n_Tmp_Begin_Log_ID) and
                (mac      =  s_Login_MAC       ) and
                (game_id  =  n_Game_ID         )
            order by
                login_id desc
            limit n_Tmp, n_Page_Size;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getLoginInfoByIp(
in  n_Game_Id           integer,
in  n_Ip                bigint unsigned,
in  n_Page_Index        integer,
in  n_Page_Size         integer,
in  d_Begin_Time        datetime,
in  d_End_Time          datetime,
in  n_Gateway_Id        integer,

out n_Ret_Total_Items   integer,
out n_Result            integer
)
BEGIN
    declare n_Tmp               integer default 0;
    label_proc:begin
        set n_Result = 0;
        set n_Ret_Total_Items = 0;
        if(
          (n_Game_Id    is null) or
          (n_Ip         is null) or
          (n_Page_Index is null) or
          (n_Page_Size  is null) or
          (d_Begin_Time is null) or
          (d_End_Time   is null) or
          (n_Gateway_Id is null) or
          (d_End_Time <= d_Begin_Time)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select 
            count(*)
        into
            n_Ret_Total_Items
        from
            log_record_detail b
        left join
            ums_user a
        on
            a.user_id=b.user_id     and
            a.game_id=b.game_id
        left join
            ums_role c
        on
            b.role_id=c.role_id     and
            b.game_id=c.game_id
        where
            b.login_ip   =  n_Ip          and
            b.login_time >= d_Begin_Time  and
            b.login_time <  d_End_Time    and
            a.game_id    =  n_Game_Id     and
            a.gateway_id =  n_Gateway_Id;

        if( n_Ret_Total_Items = 0 ) then
            set n_Result = 1;
            leave label_proc;
        end if;

        set n_Tmp = n_Page_Index*n_Page_Size;

        select 
            a.user_name,    c.role_name,
            b.login_time,   b.logout_time
        from
            log_record_detail b
        left join
            ums_user a
        on
            a.user_id=b.user_id     and
            a.game_id=b.game_id
        left join
            ums_role c
        on
            b.role_id=c.role_id     and
            b.game_id=c.game_id
        where
            b.login_ip   =  n_Ip           and
            b.login_time >= d_Begin_Time   and
            b.login_time <  d_End_Time     and
            a.game_id    =  n_Game_Id      and
            a.gateway_id =  n_Gateway_Id
        limit n_Tmp, n_Page_Size;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getRoleNameByID(
        in  n_Game_ID          integer,
        in  n_Role_ID          integer,

        out s_Ret_Role_Name    varchar(32),
        out n_Result           integer
    )
BEGIN
        declare n_RetCode               integer default 0;
        label_proc:begin
        if (
            (n_Game_ID is null) or
            (n_Role_ID is null)
        ) then
            set n_Result = -100;
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
            game_id in
            (
                select
            		game_id
        		from
            		sys_slave_games
        		where
            		game_id = n_Game_ID or
            		slave_game_id = n_Game_ID
        		union
        		select
            		slave_game_id
        		from
            		sys_slave_games
        		where
            		game_id in (
                		select
                    		ifnull(game_id, 0)
                		from
                    		sys_slave_games
                		where
                    		game_id = n_Game_ID or
                    		slave_game_id = n_Game_ID
            	)
        		union
        		select
            		n_Game_ID
            );
        if(found_rows() = 0 ) then
            set n_Result = -1252;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getChargeDetail(
    in    n_Game_ID           integer,
    in    d_Begin_Date        datetime,
    in    d_End_Date          datetime,
    in    n_Page_Index        integer,
    in    n_Page_Size         integer,
    in    s_Charge_Code       varchar(32),

    out   n_Ret_Total_Items   integer,
    out   n_Result            integer
)
BEGIN
    declare n_RetCode       integer default  0;
    label_proc:begin
        set n_Result = 0;
        if (
            (n_Game_ID is null) or
            (d_Begin_Date is null) or
            (d_End_Date is null) or
            (n_Page_Index is null) or
            (n_Page_Size is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if ((s_Charge_Code is null) or ( s_Charge_Code = "")) then
            select count(*)
            into n_Ret_Total_Items
            from LOG_USER_FUND_DETAIL t
			where t.charge_type=1
			and t.subject_id=3
			and t.charge_time>=d_Begin_Date
			and t.charge_time<d_End_Date
			and t.game_id in
				(
			        select
            			game_id
        			from
            			sys_slave_games
        			where
            			game_id = n_Game_ID or
            			slave_game_id = n_Game_ID
        			union
        			select
            			slave_game_id
        			from
            			sys_slave_games
        			where
            			game_id in (
                			select
                    			ifnull(game_id, 0)
                			from
                    			sys_slave_games
                			where
                    			game_id = n_Game_ID or
                    			slave_game_id = n_Game_ID
            			)
        			union
        			select
            			n_Game_ID
			    );

            set @n_Game_ID = n_Game_ID;
            set @d_Begin_Date = d_Begin_Date;
            set @d_End_Date = d_End_Date;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            prepare s_Sql_Text from '
                select c.charge_detail_id, c.charge_order_code, c.channel_id,
                    c.charge_amount,c.charge_time,c.rating_id,u.gateway_id,u.user_name, c.game_id
                from ums_user u,
				    (select t.charge_detail_id, t.charge_order_code, t.channel_id,
				        t.charge_amount,t.charge_time,t.rating_id,t.user_id, t.game_id
				     from log_user_fund_detail t
					 where t.charge_type=1
					 and t.subject_id=3
					 and t.charge_time>=?
					 and t.charge_time<?
					 and t.game_id in
					     (
					         select
            				 	 game_id
        					 from
            					 sys_slave_games
        					 where
            					 game_id = ? or
            					 slave_game_id = ?
        					 union
        					 select
            					 slave_game_id
        					 from
            					 sys_slave_games
        					 where
            					 game_id in (
                					 select
                    					 ifnull(game_id, 0)
                					 from
                    					 sys_slave_games
                					 where
                    					 game_id = ? or
                    				 slave_game_id = ?
            					 )
        					 union
        					 select
            					 ?
					     )
	                 )c
	            where u.user_id=c.user_id
	            and u.game_id = c.game_id
	            order by c.charge_time desc
	            limit ?,?';
            execute s_Sql_Text using @d_Begin_Date, @d_End_Date, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID,
            @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        else
            select count(*)
            into n_Ret_Total_Items
            from LOG_USER_FUND_DETAIL t
			where t.charge_type=1
			and t.subject_id=3
			and t.charge_time>=d_Begin_Date
			and t.charge_time<d_End_Date
			and t.game_id in
				(
			        select
            			game_id
        			from
            			sys_slave_games
        			where
            			game_id = n_Game_ID or
            			slave_game_id = n_Game_ID
        			union
        			select
            			slave_game_id
        			from
            			sys_slave_games
        			where
            			game_id in (
                			select
                    			ifnull(game_id, 0)
                			from
                    			sys_slave_games
                			where
                    			game_id = n_Game_ID or
                    			slave_game_id = n_Game_ID
            			)
        			union
        			select
            			n_Game_ID
			    )
			and t.charge_order_code in ( s_Charge_Code );

            set @n_Game_ID = n_Game_ID;
            set @d_Begin_Date = d_Begin_Date;
            set @d_End_Date = d_End_Date;
            set @n_Page_Index = n_Page_Index*n_Page_Size;
            set @n_Page_Size =n_Page_Size;
            set @s_Charge_Code =s_Charge_Code;
            prepare s_Sql_Text from '
                select c.charge_detail_id, c.charge_order_code, c.channel_id,
                    c.charge_amount,c.charge_time,c.rating_id,u.gateway_id,u.user_name, c.game_id
                from ums_user u,
				    (select t.charge_detail_id, t.charge_order_code, t.channel_id,
				        t.charge_amount,t.charge_time,t.rating_id,t.user_id, t.game_id
				     from log_user_fund_detail t
					 where t.charge_type=1
					 and t.subject_id=3
					 and t.charge_time>=?
					 and t.charge_time<?
					 and t.game_id in
					     (
					         select
            				 	 game_id
        					 from
            					 sys_slave_games
        					 where
            					 game_id = ? or
            					 slave_game_id = ?
        					 union
        					 select
            					 slave_game_id
        					 from
            					 sys_slave_games
        					 where
            					 game_id in (
                					 select
                    					 ifnull(game_id, 0)
                					 from
                    					 sys_slave_games
                					 where
                    					 game_id = ? or
                    				 slave_game_id = ?
            					 )
        					 union
        					 select
            					 ?
					     )
	                 and t.charge_order_code in(?)
	                 )c
	            where u.user_id=c.user_id
	            and u.game_id = c.game_id
	            order by c.charge_time desc
	            limit ?,?';
            execute s_Sql_Text using @d_Begin_Date, @d_End_Date, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID, @n_Game_ID,
            @s_Charge_Code, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
