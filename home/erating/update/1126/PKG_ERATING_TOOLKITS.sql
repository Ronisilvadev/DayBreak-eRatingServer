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
DROP PROCEDURE getUserRoleList;
DROP PROCEDURE getEndActivity;
DROP PROCEDURE getActiveActivity;
DROP PROCEDURE queryAccountInfo;
DROP PROCEDURE queryRoleAccountInfo;
DROP PROCEDURE freezeAccount;
DROP PROCEDURE unfreezeAccount;
DROP PROCEDURE trusteeUser;
DROP PROCEDURE untrusteeUser;
DROP PROCEDURE getUserRole;
DROP PROCEDURE getAppRegistIdListByGatewayId;
DROP PROCEDURE getAppRegistIdListByRoleName;
DROP PROCEDURE getPluginInfo;

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
    in  n_User_ID         integer unsigned,
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
    in  n_User_ID         integer unsigned,
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

    out n_Ret_User_ID        integer unsigned,
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
    out   n_Result              integer
)
BEGIN
    DECLARE n_RetCode       INTEGER DEFAULT  0;
    DECLARE n_Tmp_User_ID   INTEGER UNSIGNED;
    DECLARE n_Begin_Log_ID  INTEGER;
    DECLARE n_End_Log_ID    INTEGER;
    DECLARE n_Sum_Log_ID    INTEGER;
    label_proc:BEGIN
        SET n_Result = 0;
        IF (
	    (n_Game_ID    IS NULL) OR
	    (d_Begin_Date IS NULL) OR
	    (d_End_Date   IS NULL) OR
	    (s_User_Name  IS NULL)
	   ) THEN
	    SET n_Result = -100;
 	    LEAVE label_proc;
        END IF;

	CALL getUserIDByName(n_Game_ID, s_User_Name, n_Tmp_User_ID, n_RetCode);
	IF (n_RetCode <> 1) THEN
	    SET n_Result = n_RetCode;
	LEAVE label_proc;
	END IF;

	BEGIN
	    SELECT
	        COUNT(*)
	    INTO
	        n_Ret_Total_Items
	    FROM
	        UMS_USER_PURCHASE_DETAIL t
	    WHERE
		t.user_id = n_Tmp_User_ID       AND
		t.purchase_time >= d_Begin_Date AND
		t.purchase_time <  d_End_Date   AND
		t.game_id = n_Game_ID;
	END;

	BEGIN
	    SELECT
	        COUNT(*)
	    INTO
	        n_Sum_Log_ID
	    FROM
	        LOG_USER_PURCHASE_DETAIL t
	    WHERE
		t.user_id = n_Tmp_User_ID       AND
		t.purchase_time >= d_Begin_Date AND
		t.purchase_time <  d_End_Date   AND
		t.game_id = n_Game_ID;
	END;

	SET n_Ret_Total_Items = n_Ret_Total_Items + n_Sum_Log_ID;

	IF (n_Ret_Total_Items = 0) THEN
            LEAVE label_proc;
	END IF;

	BEGIN
	    SELECT IFNULL(MIN(log_id), 0),IFNULL(MAX(log_id),9999999999999)
	    INTO   n_Begin_Log_ID,n_End_Log_ID
	    FROM   LOG_DAILY_LOGID
	    WHERE  log_date >= d_Begin_Date AND
	           log_date < d_End_Date    AND
	           table_name = 'LOG_USER_PURCHASE_DETAIL';
	END;

	SET @n_Tmp_User_ID = n_Tmp_User_ID;
	SET @d_Begin_Date = d_Begin_Date;
        SET @d_End_Date = d_End_Date;
        SET @n_Game_ID = n_Game_ID;
        SET @n_Page_Index = n_Page_Index*n_Page_Size;
        SET @n_Page_Size =n_Page_Size;
        SET @n_Begin_Log_ID = n_Begin_Log_ID;
        SET @n_End_Log_ID   = n_End_Log_ID;
        PREPARE s_Sql_Text FROM "
        select
            p.*,q.role_name
        from
            (select
                t.purchase_id,   t.role_id,    t.purchase_ip,
                t.package_id,    t.product_id, t.product_code,
                t.product_num,   t.purchase_time, t.subject_id,
                t.cost_amount
            from
		UMS_USER_PURCHASE_DETAIL t
            where
		t.user_id = ?        and
                t.purchase_time >= ? and
                t.purchase_time <  ? and
                t.game_id = ?
            union all
            select
                 n.purchase_id,   n.role_id,    n.purchase_ip,
                 n.package_id,    n.product_id, n.product_code,
                 n.product_num,   n.purchase_time, n.subject_id,
                 n.cost_amount
            from
                 LOG_USER_PURCHASE_DETAIL n
            where
                 n.user_id = ?      and
                 n.log_id  >= ?     and
                 n.log_id  <= ?	    and
		 n.game_id = ?
            order by
                 purchase_time desc
            limit ?, ?) p,ums_role q
            where p.role_id = q.role_id
            ";

        EXECUTE s_Sql_Text USING @n_Tmp_User_ID, @d_Begin_Date, @d_End_Date, @n_Game_ID, @n_Tmp_User_ID, @n_Begin_Log_ID, @n_End_Log_ID, @n_Game_ID, @n_Page_Index, @n_Page_Size;

        DEALLOCATE PREPARE s_Sql_Text;
        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE getUserIDByName(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),

    out  n_Ret_User_ID      integer unsigned,
    out  n_Result           integer
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
    out   n_Ret_User_ID       integer unsigned,
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

            set @g_Tmp_Begin_Log_ID=n_Tmp_Begin_Log_ID;
            set @g_Tmp_End_Log_ID=n_Tmp_End_Log_ID;
            set @g_Login_MAC=s_Login_MAC;
            set @g_Game_ID=n_Game_ID;
            set @g_Tmp=n_Tmp;
            set @g_Page_Size=n_Page_Size;

            prepare stmt1 from "
                select
                    user_id,    role_id,       server_id,  role_level,  money1,
                    money2,     experience,    login_time, logout_time, login_ip,
                    login_port, province_code, city_code,  mac
                from
                    LOG_RECORD_DETAIL
                where
                    (login_id >= ?) and
                    (login_id <  ?) and
                    (mac      =  ?) and
                    (game_id  =  ?)
                order by
                    login_id desc
                limit ?, ?
            ";
            execute stmt1 using @g_Tmp_Begin_Log_ID, @g_Tmp_End_Log_ID, @g_Login_MAC, @g_Game_ID, @g_Tmp, @g_Page_Size;
            deallocate prepare stmt1;
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

            set @g_Tmp_Begin_Log_ID = n_Tmp_Begin_Log_ID;
            set @g_Login_MAC = s_Login_MAC;
            set @g_Game_ID = n_Game_ID;
            set @g_Tmp = n_Tmp;
            set @g_Page_Size = n_Page_Size;

            prepare stmt1 from "
                select
                    user_id,    role_id,       server_id,  role_level,  money1,
                    money2,     experience,    login_time, logout_time, login_ip,
                    login_port, province_code, city_code,  mac
                from
                    LOG_RECORD_DETAIL
                where
                    (login_id >= ?) and
                    (mac      =  ?) and
                    (game_id  =  ?)
                order by
                    login_id desc
                limit ?, ?
            ";
            execute stmt1 using @g_Tmp_Begin_Log_ID, @g_Login_MAC, @g_Game_ID, @g_Tmp, @g_Page_Size;
            deallocate prepare stmt1;
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

        set @g_Ip = n_Ip;
        set @g_Begin_Time = d_Begin_Time;
        set @g_End_Time = d_End_Time;
        set @g_Game_Id = n_Game_Id;
        set @g_Gateway_Id = n_Gateway_Id;
        set @g_Tmp = n_Tmp;
        set @g_Page_Size = n_Page_Size;

        prepare stmt1 from "
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
                b.login_ip   =  ? and
                b.login_time >= ? and
                b.login_time <  ? and
                a.game_id    =  ? and
                a.gateway_id =  ?
            limit ?, ?
        ";

        execute stmt1 using @g_Ip, @g_Begin_Time, @g_End_Time, @g_Game_Id, @g_Gateway_Id, @g_Tmp, @g_Page_Size;
        deallocate prepare stmt1;

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

-- 根据账号查询角色
CREATE PROCEDURE getUserRoleList(
    in   n_Game_ID          integer,
    in   s_User_Name        varchar(32),
    in   n_Gateway_ID       integer,

    out  n_Result	    integer,
    out  n_Ret_Amount       integer,
    out  n_Ret_Total_Items  integer
)
BEGIN
    declare n_Tmp_User_ID       integer unsigned;
    label_proc:begin
        if (
            (s_User_Name is null) or
            (n_Game_ID   is null)
        ) then
            set n_Result = -100;		/* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            count(*)
        into
            n_Ret_Total_Items
        from
            UMS_ROLE A,
            UMS_USER B
        where
	    (B.user_name =    s_User_Name)					and
            (B.user_id   =    A.user_id)            				and
	    (A.gateway_id = if(n_Gateway_ID=0, A.gateway_id, n_Gateway_ID))	and
            (A.game_id   =    B.game_id)            				and
            (B.game_id   =    n_Game_ID);
        if(found_rows()=0)then
            set n_Result = 1;
            leave label_proc;
        end if;

        select
            role_name, role_id,    gateway_id,
            server_id, role_state, user_name,
            user_online_state,
            role_level,            experience,
            money1,                money2,
            create_time,           total_online_second,
            role_occupation
        from(
            select
                role_name, role_id,    gateway_id,
                server_id, role_state, user_name,
                user_online_state,
                role_level,            experience,
                money1,                money2,
                create_time,           total_online_second,
                role_occupation
            from(
                select
                    A.role_name		   role_name,
                    A.role_id		   role_id,
                    A.gateway_id	   gateway_id,
                    B.server_id		   server_id,
                    A.role_state	   role_state,
                    B.user_name		   user_name,
                    A.login_id		   user_online_state,
                    A.role_level	   role_level,
                    A.experience	   experience,
                    A.money1		   money1,
                    A.Money2		   money2,
                    A.create_time          create_time,
                    A.total_online_second  total_online_second,
                    A.role_occupation      role_occupation
                from
                    UMS_ROLE A,
                    UMS_USER B
                where
                    (B.user_name =    s_User_Name)					and
                    (B.user_id   =    A.user_id)            				and
                    (A.gateway_id = if(n_Gateway_ID=0, A.gateway_id, n_Gateway_ID))	and
                    (A.game_id   =    B.game_id)            				and
                    (B.game_id   =    n_Game_ID)
                )as C
            )as D
        order by gateway_id asc, create_time asc;

        select
            user_id
        into
            n_Tmp_User_ID
        from
            ums_user
        where
            (user_name   =    s_User_Name)    and
            (game_id     =    n_Game_ID);

        select
            ifnull(sum(charge_amount) , 0)
        into
            n_Ret_Amount
        from
            log_user_fund_detail
        where
            (subject_id =    3)             and
            (user_ID    =    n_Tmp_User_ID) and
            (game_id    =    n_Game_ID)     and
            (rating_id  = if(n_Gateway_ID=0, rating_id, n_Gateway_ID));
        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getEndActivity(
in  n_Game_Id           integer,
in  d_Time              datetime,
in  n_Page_Index        integer,
in  n_Page_Size         integer,

out n_Ret_Total_Num     integer,
out n_Result            integer
)
BEGIN
    declare n_Tmp               integer default 0;
    declare s_Temp_Game_Name    varchar(32);
    label_proc:begin
        set n_Result = 0;
        set n_Ret_Total_Num = 0;
        if(
          (n_Game_Id    is null) or
          (d_Time       is null) or
          (n_Page_Index is null) or
          (n_Page_Size  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select game_name
        into s_Temp_Game_Name
        from sys_game_id
        where game_id = n_Game_Id;

        select
            count(*)
        into
            n_Ret_Total_Num
        from
            sys_activity_info t
        where
            t.begin_time = d_Time
        and
            (
              (t.end_time <= now()) or
              (t.activity_state=2)
            )
        and
            t.game_id = n_Game_Id;

        if( n_Ret_Total_Num = 0 ) then
            set n_Result = 1;
            leave label_proc;
        end if;

        set n_Tmp = n_Page_Index*n_Page_Size;

        set @g_Temp_Game_Name=s_Temp_Game_Name;
        set @g_Time=d_Time;
        set @g_Game_Id=n_Game_Id;
        set @g_Tmp=n_Tmp;
        set @g_Page_Size=n_Page_Size;

        prepare stmt1 from "
        select
            a.activity_id, a.activity_name, a.begin_time, a.end_time, ifnull(b.gateway_id, 1) as gateway_id, ?
        from
        (
        select
            t.activity_id, t.activity_name, t.begin_time, t.end_time, t.game_id
        from
            sys_activity_info t
        where
            t.begin_time = ?
        and
            (
              (t.end_time <= now()) or
              (t.activity_state=2)
            )
        and
            t.game_id = ?
        limit ?, ?
        )a left outer join
        sys_activity_gateway b
        on a.game_id = b.game_id
        and a.activity_id = b.activity_id
        and b.gateway_id = 0
        ";
        execute stmt1 using @g_Temp_Game_Name, @g_Time, @g_Game_Id, @g_Tmp, @g_Page_Size;
        deallocate prepare stmt1;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getActiveActivity(
in  n_Game_Id           integer,
in  n_Page_Index        integer,
in  n_Page_Size         integer,

out n_Ret_Total_Num     integer,
out n_Result            integer
)
BEGIN
    declare n_Tmp               integer default 0;
    declare s_Temp_Game_Name    varchar(32);
    label_proc:begin
        set n_Result = 0;
        set n_Ret_Total_Num = 0;
        if(
          (n_Game_Id    is null) or
          (n_Page_Index is null) or
          (n_Page_Size  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select game_name
        into s_Temp_Game_Name
        from sys_game_id
        where game_id = n_Game_Id;

        select
            count(*)
        into
            n_Ret_Total_Num
        from
            sys_activity_info t
        where
            t.activity_state = 1
        and
            t.begin_time <= now()
        and
            t.end_time > now()
        and
            t.game_id = n_Game_Id;
        if( n_Ret_Total_Num = 0 ) then
            set n_Result = 1;
            leave label_proc;
        end if;

        set n_Tmp = n_Page_Index*n_Page_Size;

        set @g_Temp_Game_Name=s_Temp_Game_Name;
        set @g_Game_Id=n_Game_Id;
        set @g_Tmp=n_Tmp;
        set @g_Page_Size=n_Page_Size;

        prepare stmt1 from "
          select
            a.activity_id, a.activity_name, a.begin_time, a.end_time, ifnull(b.gateway_id, 1) as gateway_id, ?
          from
        (
          select
            t.game_id, t.activity_id, t.activity_name, t.begin_time, t.end_time
          from
            sys_activity_info t
          where
            t.activity_state = 1
          and
            t.begin_time <= now()
          and
            t.end_time > now()
          and
            t.game_id = ?
          limit ?, ?
        )a left outer join
          sys_activity_gateway b
          on a.game_id = b.game_id
          and a.activity_id = b.activity_id
          and b.gateway_id = 0
        ";
        execute stmt1 using @g_Temp_Game_Name, @g_Game_Id, @g_Tmp, @g_Page_Size;
        deallocate prepare stmt1;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE queryAccountInfo(
    in n_Game_ID            integer,
    in s_User_Name          varchar(32),

    out n_User_ID           integer unsigned,
    out n_Online_State      integer,
    out n_Gateway_ID        integer,
    out n_Freeze_State      integer,
    out n_Trustee_State     integer,
    out d_Last_Login_Time   date,
    out s_Last_Login_IP     varchar(32),
    out d_Create_Time       date,
    out s_Create_IP         varchar(32),
    out n_Left_Coin         integer,
    out n_Result            integer
)
BEGIN
    DECLARE n_Tmp_User_State     INTEGER;
    DECLARE n_Last_Login_IP      INTEGER UNSIGNED;
    DECLARE n_Create_IP          INTEGER UNSIGNED;
    DECLARE n_Tmp_Login_ID       INTEGER;
    DECLARE d_Last_Logout_Time   DATE;
    label_proc:BEGIN
        SET n_Result = 0; /*E_ERROR*/
        IF (
            (n_Game_ID     IS NULL) OR
            (s_User_Name   IS NULL)
          ) THEN
              SET n_Result = -100;/* PKG_UTIL.E_PARAMETER_ERROR */
              LEAVE label_proc;
        END IF;

        SELECT
            user_state,         user_id
        INTO
            n_Tmp_User_State,   n_User_ID
        FROM
            UMS_USER
        WHERE
            game_id = n_Game_ID AND
            user_name = s_User_Name;
        IF (FOUND_ROWS() = 0 ) THEN
            SET n_Result = -1201; /*PKG_UTIL.E_ACCOUNT_NOT_FOUND*/
            LEAVE label_proc;
        END IF;

        SELECT
            MAX(login_id)
        INTO
            n_Tmp_Login_ID
        FROM
            LOG_RECORD_DETAIL
        WHERE
            game_id = n_Game_ID AND
            user_id = n_User_ID;
        IF (FOUND_ROWS() = 0) THEN
            SET n_Tmp_Login_ID = 0;
        END IF;

        IF (n_Tmp_User_State & 1 > 0) THEN
            SET n_Freeze_State = 1;
        ELSE
            SET n_Freeze_State =0;
        END IF;

        IF (n_Tmp_User_State & 2 > 0) THEN
            SET n_Trustee_State = 1;
        ELSE
            SET n_Trustee_State = 0;
        END IF;

        IF (n_Tmp_Login_ID > 0) THEN
            SELECT
                gateway_id,
                login_ip,
                login_time,
                logout_time
            INTO
                n_Gateway_ID,
                n_Last_Login_IP,
                d_Last_Login_Time,
                d_Last_Logout_Time
            FROM
                LOG_RECORD_DETAIL
            WHERE
                login_id = n_Tmp_Login_ID;
            IF (FOUND_ROWS() = 0 ) THEN
                SET n_Online_State = 0;
                SET n_Gateway_ID = 0;
                SET n_Last_Login_IP =0;
            END IF;

            IF (d_Last_Logout_Time IS NULL) THEN
                SET n_Online_State = 1;
            ELSE
                SET n_Online_State =0;
                SET n_Gateway_ID = 0;
            END IF;
        ELSE
            SET n_Online_State = 0;
        END IF;

        CALL Number2IP(n_Last_Login_IP,s_Last_Login_IP,n_Result);

        SELECT
            first_login_ip,
            first_login_time
        INTO
            n_Create_IP,
            d_Create_Time
        FROM
            LOG_USER_FIRST_LOGIN_INFO
        WHERE
            game_id = n_Game_ID AND
            user_id = n_User_ID;
        IF (FOUND_ROWS() = 0) THEN
            SET n_Create_IP = 0 ;
        END IF;

        CALL Number2IP(n_Create_IP,s_Create_IP,n_Result);

        SELECT
            IFNULL(SUM(amount) , 0)
        INTO
            n_Left_Coin
        FROM
            UMS_USER_FUND
        WHERE
            game_id = n_Game_ID AND
            user_id = n_User_ID;
        IF (FOUND_ROWS() = 0 ) THEN
            SET n_Left_Coin = 0;
        END IF;

        SET n_Result = 1; /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE queryRoleAccountInfo(
    in n_Game_ID        integer,
    in s_Role_Name      varchar(32),
    in n_Exact          integer -- 1为精确匹配，0为模糊匹配
)
BEGIN
    DECLARE n_Tmp_User_ID INTEGER UNSIGNED;
    DECLARE n_Result  INTEGER;
    label_proc:BEGIN
        IF (
            (n_Game_ID IS NULL)   OR
            (s_Role_Name IS NULL) OR
            (n_Exact IS NULL)     OR
            (n_Exact  NOT IN (0,1))
        ) THEN
            SET n_Result = -100;
            SELECT n_Result;
            LEAVE label_proc;
        END IF;

        SET n_Result = 1; /* PKG_UTIL.S_SUCCESS */
        SELECT n_Result;
        IF (n_Exact = 1) THEN
            SELECT
                A.user_id,        B.gateway_id,
                B.role_id,        B.role_name,
                A.user_name
            FROM
                UMS_USER A,UMS_ROLE B
            WHERE
                (B.role_state <>2 )     AND  -- Normal role state
                (A.user_id = B.user_id) AND
                (A.game_id = B.game_id) AND
                (B.game_id    = n_Game_ID) AND
                (B.role_name  = s_Role_Name);
        ELSE
            SELECT
                A.user_id,         B.gateway_id,
                B.role_id,         B.role_name,
                A.user_name
            FROM
                UMS_USER A, UMS_ROLE B
            WHERE
                (B.role_state <> 2) AND -- Normal role state
                (A.user_id    = B.user_id) AND
                (A.game_id    = B.game_id) AND
                (B.game_id    = n_Game_ID) AND
                (B.role_name like concat(s_Role_Name,"%"));
        END IF;

    END label_proc;
END$$

CREATE PROCEDURE freezeAccount(
    in n_Game_ID       integer,
    in s_User_Name     varchar(32),

    out n_Result       integer
    )
BEGIN
    SET n_Result = 0;
    label_proc:BEGIN
        IF (
            (n_Game_ID    IS NULL) OR
            (s_User_Name  IS NULL)
           ) THEN
            SET n_Result = -100;
            LEAVE labeL_proc;
        END IF;

        UPDATE
            UMS_USER
        SET
            user_state = (user_state + 1 - (user_state & 1)) /* bitand(user_state, 1) */
        WHERE
            user_name = s_User_Name AND
            game_id   = n_Game_ID;
        IF (ROW_COUNT() = 0) THEN
            SET n_Result = -1201; /* PKG_UTIL.E_ACCOUNT_NOT_FOUND */
            LEAVE label_proc;
        END IF;

        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE unfreezeAccount(
    in n_Game_ID     integer,
    in s_User_Name   varchar(32),

    out n_Result     integer
    )
BEGIN
    SET n_Result = 0;
    label_proc:BEGIN
        IF (
            (s_User_Name   IS NULL) OR
            (n_Game_ID     IS NULL)
           ) THEN
            SET n_Result = -100;
            LEAVE label_proc;
        END IF;

        UPDATE
            UMS_USER
        SET
            user_state = (user_state - (user_state & 1)) /* bitand(user_state, 1) */
        WHERE
            user_name = s_User_Name AND
            game_id   = n_Game_ID;

        IF (ROW_COUNT() = 0) THEN
            SET n_Result = -1201;
            LEAVE label_proc;
        END IF;

        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE trusteeUser(
    IN n_Game_ID       INTEGER,
    IN n_User_ID       INTEGER UNSIGNED,
    IN s_Temp_Password VARCHAR(32),
    IN s_Allow_IP      VARCHAR(32),
    IN n_Trustee_Type  INTEGER,   -- 登陆托管

    OUT n_Result       INTEGER
    )
BEGIN
    DECLARE n_Ret_Allow_IP    INTEGER;
    label_proc:BEGIN
        IF(
            (n_Game_ID        IS NULL) OR
            (n_User_ID        IS NULL) OR
            (n_Trustee_Type  <> 1   )  OR
            (s_Temp_Password  IS NULL) OR
            (s_Allow_IP      IS NULL)
          ) THEN
              SET n_Result = -100;
              LEAVE label_proc;
          END IF;

          UPDATE
              UMS_USER
          SET
              user_state = (user_state + 2 - (user_state & 2))
          WHERE
              user_id   = n_User_ID AND
              game_id   = n_Game_ID;

          IF (ROW_COUNT() =0) THEN
              SET n_Result = -1406;
              LEAVE label_proc;
          END IF;

          CALL IP2Number(s_Allow_IP,n_Ret_Allow_IP,n_Result);

          INSERT INTO UMS_USER_SECURITY_CODE(
                user_id,       security_type, security_code,
                effect_time,   expire_time,   CHECKSUM,
                game_id
                )
           VALUES(
                n_User_ID,   1,               CONCAT('',n_Ret_Allow_IP),
                NOW(),       DATE_ADD(NOW(), INTERVAL 7 DAY),   0,
                n_Game_ID
                );
           IF( ROW_COUNT() = 0 ) THEN
               UPDATE
                   UMS_USER_SECURITY_CODE
               SET
                   security_code = CONCAT('',n_Ret_Allow_IP),
                   effect_time   = NOW(),
                   expire_time   = DATE_ADD(NOW(), INTERVAL 7 DAY)
               WHERE
                   user_id = n_User_ID AND
                   security_type = 1       AND
                   game_id = n_Game_ID;
           END IF;

           INSERT INTO UMS_USER_SECURITY_CODE(
               user_id,       security_type,        security_code,
               effect_time,   expire_time,          CHECKSUM,
               game_id
           )
           VALUES(
               n_User_ID,   2,                    s_Temp_Password,
               NOW(),       DATE_ADD(NOW(), INTERVAL 7 DAY),          0,
               n_Game_ID
           );
           IF (ROW_COUNT() = 0) THEN
               UPDATE
                   UMS_USER_SECURITY_CODE
               SET
                   security_code = s_Temp_Password,
                   effect_time   = NOW(),
                   expire_time   = DATE_ADD(NOW(), INTERVAL 7 DAY)
               WHERE
                   user_id = n_User_ID AND
                   security_type = 2       AND
                   game_id = n_Game_ID;
            END IF;
        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE untrusteeUser(
    IN n_Game_ID    INTEGER,
    IN n_User_ID    INTEGER UNSIGNED,
    OUT n_Result    INTEGER
    )
BEGIN
    label_proc:BEGIN
        IF(
            (n_User_ID    IS NULL) OR
            (n_Game_ID      IS NULL)
          ) THEN
            SET n_Result = -100;
            LEAVE label_proc;
        END IF;

        UPDATE
            UMS_USER
        SET
            user_state = (user_state - (user_state & 2))
        WHERE
            user_id = n_User_ID AND
            game_id   = n_Game_ID;
        IF ( ROW_COUNT() = 0) THEN
            SET n_Result = -1406;
            LEAVE label_proc;
        END IF;

        DELETE FROM
            UMS_USER_SECURITY_CODE
        WHERE
            (user_id = n_User_ID) AND
            (security_type IN (1, 2)) AND
            (game_id = n_Game_ID);
        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE getUserRole(
    in n_Game_ID    integer,
    in s_User_Name  varchar(32)

    )
BEGIN
    DECLARE n_Result  INTEGER;
    label_proc:begin
        if (
            (s_User_Name is null) or
            (n_Game_ID   is null)
          ) then
            set n_Result = -100;
            SELECT n_Result;
            leave label_proc;
        end if;

        set n_Result = 1;
        select n_Result;
        select
            A.user_id,         B.gateway_id,
            B.role_id,         B.role_name,
            B.role_gender,
            B.role_occupation, B.role_level
        from
            UMS_USER A, UMS_ROLE B
        where
            (B.role_state = 1) and -- Normal role state
            (A.user_id    = B.user_id) and
            (A.user_name  = s_User_Name) and
            (A.game_id    = B.game_id) and
            (B.game_id    = n_Game_ID);
    end label_proc;
END$$

CREATE PROCEDURE getAppRegistIdListByGatewayId(
    in  n_Gateway_ID        integer,
    in  n_Page_Index        integer,
    in  n_Page_Size         integer,

    out n_Ret_Total_Num     integer,
    out n_Result            integer
    )
BEGIN
    label_proc:begin
        if (
            (n_Gateway_ID is null) or
            (n_Page_Index is null) or
            (n_Page_Size  is null)
          ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Ret_Total_Num = 0;

        select
            count(distinct t.app_regist_id, t.client_type)
        into
            n_Ret_Total_Num
        from
            UMS_USER_APP_MSG t,
            (
                select
                    distinct game_id, user_id
                from
                    UMS_ROLE
                where
                    gateway_id = n_Gateway_ID
            ) a
        where
            t.game_id = a.game_id and
            t.user_id = a.user_id;

        if( n_Ret_Total_Num = 0 ) then
            set n_Result = 1;
            leave label_proc;
        end if;

        set @n_Gateway_ID = n_Gateway_ID;
        set @n_Page_Index = n_Page_Index*n_Page_Size;
        set @n_Page_Size =n_Page_Size;
        prepare s_Sql_Text from '
            select
                distinct t.app_regist_id, t.client_type
            from
                UMS_USER_APP_MSG t,
                (
                    select
                        distinct game_id, user_id
                    from
                        UMS_ROLE
                    where
                        gateway_id = ?
                ) a
            where
                t.game_id = a.game_id and
                t.user_id = a.user_id
            limit ?, ?';
        execute s_Sql_Text using @n_Gateway_ID, @n_Page_Index, @n_Page_Size;

        deallocate prepare s_Sql_Text;

        SET n_Result = 1;

    end label_proc;
END$$

CREATE PROCEDURE getAppRegistIdListByRoleName(
    in  n_Gateway_ID        integer,
    in  s_Role_Name         varchar(32),

    out n_Result            integer
)
BEGIN
    label_proc:begin
        if (
            (n_Gateway_ID is null) or
            (s_Role_Name  is null)
          ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            distinct t1.app_regist_id, t1.client_type
        from
            ums_user_app_msg t1,
            ums_role t2
        where
            t1.user_id = t2.user_id
        and
            t2.role_name = s_Role_Name
        and
            t2.gateway_id = n_Gateway_ID;

        SET n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getPluginInfo(
    in  s_Role_Name          varchar(32),
    in  n_User_Ip            integer unsigned,
    in  n_Type               integer,
    in  d_Begin_Time         datetime,
    in  d_End_Time           datetime,
    in  n_Page_Index         integer,
    in  n_Page_Size          integer,

    out n_Ret_Total_Items    integer,
    out n_Result             integer
)
BEGIN
    label_proc:begin
        if (
             (d_Begin_Time       is null) or
             (d_End_Time         is null) or
             (n_Page_Index       is null) or
             (n_Page_Size        is null)
         ) then
             set n_Result = -100;
             leave label_proc;
        end if;

        begin
            select
                count(*)
            into
                n_Ret_Total_Items
            from
                LOG_RECORD_PLUGIN_INFO t1,
                UMS_ROLE t2
            where
                t1.role_id = t2.role_id
            and
                t2.role_name = if(s_Role_Name = '', t2.role_name, lower(s_Role_Name))
            and
                t1.user_ip = if(n_User_Ip = 0, t1.user_ip, n_User_Ip)
            and
                t1.type = if(n_Type = 0, t1.type, n_Type)
            and
                t1.log_time >= d_Begin_Time
            and
                t1.log_time < d_End_Time;
        end;

        set @sql_text = concat('
            select
                t1.game_id,   t1.gateway_id,  t3.user_name, t2.role_name,
                t1.log_time, t1.user_ip,     t1.mac,       t1.message,     t1.type
            from
                LOG_RECORD_PLUGIN_INFO t1,
                UMS_ROLE t2,
                UMS_USER t3
            where
                t1.role_id = t2.role_id
            and
                t2.role_name = if(? = right(?, 0), t2.role_name, ?)
            and
                t1.user_ip = if(? = 0, t1.user_ip, ?)
            and
                t1.type = if(? = 0, t1.type, ?)
            and
                t1.log_time >= ?
            and
                t1.log_time < ?
            and
                t3.game_id = t1.game_id
            and
                t3.user_id = t1.user_id
            order by t1.log_time desc
            limit ?, ?');
        prepare s_Sql_Text from @sql_text;
        set @Role_Name = s_Role_Name;
        set @User_Ip = n_User_Ip;
	set @Info_Type = n_Type;
	set @d_Begin_Time = d_Begin_Time;
	set @d_End_time = d_End_time;
	set @n_Page_Index = n_Page_Index*n_Page_Size;
        set @n_Page_Size =n_Page_Size;
        execute s_Sql_Text using @Role_Name, @Role_Name, @Role_Name, @User_Ip, @User_Ip, @Info_Type, @Info_Type, @d_Begin_Time, @d_End_time, @n_Page_Index, @n_Page_Size;

        deallocate prepare s_Sql_Text;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
