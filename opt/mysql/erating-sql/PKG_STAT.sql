DROP PROCEDURE onlineUserCount;
DROP PROCEDURE peakCCU;
DROP PROCEDURE newUserCount;
DROP PROCEDURE statAVGCountInfo;
DROP PROCEDURE getStatStateAndLocked;
DROP PROCEDURE setStatState;
DROP PROCEDURE statAvgOnlineSeconds;
DELIMITER $$

-- 五分钟在线人数采样。
CREATE PROCEDURE onlineUserCount(
    out n_Result        integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = 1;
        set n_Result = 0; /* E_ERROR */

        insert into STAT_USER_ONLINE(
            stat_time,
            gateway_id,  online_count, game_id
        )
        select
            DATE_FORMAT(now(), '%Y-%c-%e %k:%i:00'),
            gateway_id,  sum(user_online_count), game_id
        from
            LOG_USER_ONLINE_COUNT
        group by
            game_id,
            gateway_id;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE peakCCU(
    out n_Result        integer
)
BEGIN
    label_proc:begin
        set n_Result = 0; /* E_ERROR */

        insert into STAT_CEO_INFO
        select CURDATE() as stat_date,
               t.game_id,
               IFNULL(gateway_id, 0) as gateway_id,
               sum(user_online_count) as max_count,
               now() as max_count_time,
               0 as avg_count,
               0 as avg_second
        from LOG_USER_ONLINE_COUNT t
        group by t.game_id, t.gateway_id with ROLLUP
        having game_id is not null
        on duplicate key update
               max_count_time = IF(max_count<values(max_count),values(max_count_time),max_count_time),
               max_count      = IF(max_count<values(max_count),values(max_count),max_count);

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE newUserCount(
    out n_Result     integer
)
BEGIN
    declare n_RetCode integer default 0;    /* PKG_UTIL.E_ERROR */

    declare d_Tmp_Stat_Day        date;
    declare d_Stat_Start_Time     datetime;
    declare d_Stat_End_Time       datetime;

    declare n_Tmp_Min_LOG_ID      bigint;    /* LOG_DAILY_LOGID.log_id%TYPE */
    declare n_Tmp_Max_LOG_ID      bigint;    /* LOG_DAILY_LOGID.log_id%TYPE */

    declare n_Tmp_Min_LOG_ID2     bigint;    /* LOG_DAILY_LOGID.log_id%TYPE */
    declare n_Tmp_Max_LOG_ID2     bigint;    /* LOG_DAILY_LOGID.log_id%TYPE */

    declare n_Ret_Stat_Flag       tinyint;   /* LOG_STAT_STATE.stat_flag%TYPE */
    label_proc:begin
        declare exit handler for 1062 set n_Result = 0;
        set d_Stat_Start_Time = now();

        set d_Tmp_Stat_Day = date(adddate(now(),-1));

        call getStatStateAndLocked(
            d_Tmp_Stat_Day,
            'STAT_NEW_USER',
            n_Ret_Stat_Flag,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Ret_Stat_Flag = 1) then
            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        select
            log_id
        into
            n_Tmp_Min_LOG_ID
        from
            LOG_DAILY_LOGID
        where
            log_date   = d_Tmp_Stat_Day and
            table_name = 'LOG_ROLE_FIRST_LOGIN';

        select
            ifnull(min(log_id), 9999999999)
        into
            n_Tmp_Max_LOG_ID
        from
            LOG_DAILY_LOGID
        where
            log_date   >= adddate(d_Tmp_Stat_Day, 1) and
            table_name =  'LOG_ROLE_FIRST_LOGIN';

        if (found_rows() = 0)then
            set n_Tmp_Min_LOG_ID = 0;
            set n_Tmp_Max_LOG_ID = 0;
        end if;

        select
            log_id
        into
            n_Tmp_Min_LOG_ID2
        from
            LOG_DAILY_LOGID
        where
            log_date   = d_Tmp_Stat_Day and
            table_name = 'LOG_USER_FIRST_LOGIN_INFO';

        select
            ifnull(min(log_id), 9999999999)
        into
            n_Tmp_Max_LOG_ID2
        from
            LOG_DAILY_LOGID
        where
            log_date   >= adddate(d_Tmp_Stat_Day, 1) and
            table_name =  'LOG_USER_FIRST_LOGIN_INFO';

        if (found_rows() = 0) then
             set n_Tmp_Min_LOG_ID2 = 0;
             set n_Tmp_Max_LOG_ID2 = 0;
        end if;

        insert into STAT_NEW_USER (
           stat_date,  gateway_id, user_count,
           role_count, authen_users, game_id
        )
        select
            d_Tmp_Stat_Day,
            t.gateway_id,
            sum(t.user_count),
            sum(t.role_count),
            sum(t.authen_count),
            t.game_id
        from
        (
            select
                gateway_id, 0 as user_count, 0 as role_count, count(user_id) as authen_count, game_id
            from
                LOG_USER_FIRST_LOGIN_INFO
            where
                log_id >= n_Tmp_Min_LOG_ID2   and
                log_id <  n_Tmp_Max_LOG_ID2
            group by
                game_id, gateway_id
            union all
            select
                gateway_id, 0 as user_count, count(role_id) as role_count, 0 as authen_count, game_id
            from
                LOG_ROLE_FIRST_LOGIN
            where
                log_id >= n_Tmp_Min_LOG_ID   and
                log_id <  n_Tmp_Max_LOG_ID
            group by
                game_id, gateway_id
            union all
            select
                gateway_id, count(user_id)as user_count, 0 as role_count, 0 as authen_count, game_id
            from
                LOG_ROLE_FIRST_LOGIN
            where
                first_role = 1               and
                log_id >= n_Tmp_Min_LOG_ID   and
                log_id <  n_Tmp_Max_LOG_ID
            group by
                game_id, gateway_id
        ) t
        group by
            t.game_id,
            t.gateway_id;
        -- total all gateways.
        insert into STAT_NEW_USER (
            stat_date,  gateway_id,  user_count,
            role_count, authen_users, game_id
        )
        select
            d_Tmp_Stat_Day,
            0, -- all gateway.
            0,
            ifnull(sum(role_count), 0),
            ifnull(sum(authen_users), 0),
            game_id
        from
            STAT_NEW_USER
        where
            stat_date = d_Tmp_Stat_Day
        group by
            game_id;

        update STAT_NEW_USER s
        set s.user_count= (
                       select ifnull(count(distinct user_id), 0)
                         from LOG_ROLE_FIRST_LOGIN
                        where
                              game_id = s.game_id        and
                              first_role = 1             and
                              log_id >= n_Tmp_Min_LOG_ID and
                              log_id <  n_Tmp_Max_LOG_ID
                        )
        where
            s.stat_date = d_Tmp_Stat_Day
        and
	    s.gateway_id = 0;

        set d_Stat_End_Time = now();
        call setStatState(
            d_Tmp_Stat_Day,
            'STAT_NEW_USER',
            d_Stat_Start_Time,
            d_Stat_End_Time,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- 每日均值在线统计（按网关、线）
CREATE PROCEDURE statAVGCountInfo(
    out   n_Result        integer
)
BEGIN
    declare    n_RetCode integer default 0;   /* PKG_UTIL.E_ERROR */

    declare    d_Tmp_Stat_Day        date;
    declare    d_Stat_Start_Time     datetime;
    declare    d_Stat_End_Time       datetime;

    declare    n_Ret_Stat_Flag       integer;

    declare    n_Cur_Game_ID         integer;
    declare    n_Cur_Gateway_id      integer;

    declare    n_Tmp_Avg_Count       integer;
    declare    n_Cur_Stop            integer;

    declare curCEOInfo cursor for
        select
            game_id, gateway_id
        from
            STAT_CEO_INFO
        where
            (stat_date = d_Tmp_Stat_Day) and
            (gateway_id >0          )
        for update;
    label_proc:begin
        declare continue handler for not found set n_Cur_Stop = 1;
        set d_Stat_Start_Time = now();

        set d_Tmp_Stat_Day = date(adddate(now(),-1));

        -- 日志加锁
        call getStatStateAndLocked(
            d_Tmp_Stat_Day,
            'STAT_CEO_INFO',
            n_Ret_Stat_Flag,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Ret_Stat_Flag = 1) then
            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        -- 开始统计
        open curCEOInfo;
        label_loop:loop
            set n_Cur_Stop = 0;
            fetch curCEOInfo into n_Cur_Game_ID, n_Cur_Gateway_id;
            if (n_Cur_Stop = 1) then
                leave label_loop;
            end if;
            select
                AVG(t.online_count)
            into
                n_Tmp_Avg_Count
            from
            (
                select
                    stat_time,  sum(online_count) as online_count
                from
                    STAT_USER_ONLINE
                where
                    (game_id          =  n_Cur_Game_ID        ) and
                    (gateway_id       =  n_Cur_Gateway_id     ) and
                    (stat_time        >= d_Tmp_Stat_Day       ) and
                    (stat_time        <  adddate(d_Tmp_Stat_Day, 1) )
                group by stat_time
            ) t;
            if (found_rows() = 0) then
                set n_Tmp_Avg_Count = 0;
            end if;

            if (n_Tmp_Avg_Count is null) then
                set n_Tmp_Avg_Count = 0;
            end if;
            if (n_Tmp_Avg_Count > 0) then
                update
                    STAT_CEO_INFO
                set
                    avg_count = n_Tmp_Avg_Count
                where
                    stat_date = d_Tmp_Stat_Day and
                    game_id   = n_Cur_Game_ID and
                    gateway_id = n_Cur_Gateway_id;

                update
                    STAT_CEO_INFO
                set
                    avg_count = avg_count + n_Tmp_Avg_Count
                where
                    stat_date = d_Tmp_Stat_Day and
                    game_id   = n_Cur_Game_ID and
                    gateway_id = 0;

            end if;
        end loop;
        close curCEOInfo;


        -- 标记为已统计过
        set d_Stat_End_Time = now();
        call setStatState(
            d_Tmp_Stat_Day,
            'STAT_CEO_INFO',
            d_Stat_Start_Time,
            d_Stat_End_Time,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE getStatStateAndLocked(
    in    d_Stat_Day      date,
    in    s_Table_Name    varchar(32),
    out   n_Ret_Stat_Flag integer,
    out   n_Result        integer
)
BEGIN
    label_proc:begin
        declare continue handler for 1062 begin end;
        set n_Result = 0;    /* PKG_UTIL.E_ERROR */
        if (
            (d_Stat_Day   is null) or
            (s_Table_Name is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        label_loop:loop
            select
                stat_flag
            into
                n_Ret_Stat_Flag
            from
                LOG_STAT_STATE
            where
                (stat_date  = d_Stat_Day) and
                (table_name = s_Table_Name)
            for update;
            if (found_rows() = 1) then
                leave label_loop;
            end if;

            insert into LOG_STAT_STATE(
                stat_date,  table_name,   stat_flag, start_time, end_time
            )
            values(
                d_Stat_Day, s_Table_Name, 0,         null,       null
            );
        end loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE setStatState(
    in    d_Stat_Day      date,
    in    s_Table_Name    varchar(32),
    in    d_Start_Time    datetime,
    in    d_End_Time      datetime,
    out   n_Result        integer
)
BEGIN
    label_proc:begin
        if (
            (d_Stat_Day   is null) or
            (s_Table_Name is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update
            LOG_STAT_STATE
        set
            stat_flag  = 1, -- Has statistics.
            start_time = d_Start_Time,
            end_time   = d_End_Time
        where
            (stat_date  = d_Stat_Day) and
            (table_name = s_Table_Name);

        if (row_count() = 0) then
            leave label_proc;
        end if;
        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE statAvgOnlineSeconds(
    out   n_Result        integer
)
BEGIN
    declare    d_Tmp_Stat_Day        date;
    declare    n_Tmp_Avg_Seconds     integer;
    declare    n_Tmp_Min_LOG_ID      bigint;
    declare    n_Tmp_Max_LOG_ID      bigint;
    declare    n_Tmp_Min_LOG_ID_YESTERDAY bigint;
    declare    n_Tmp_Max_LOG_ID_YESTERDAY bigint;

    declare    n_Cur_Game_ID         integer;
    declare    n_Cur_Gateway_id      integer;
    declare    n_Cur_Avg_Seconds     integer;
    declare    n_Cur_Stop            integer;

    declare curAvgSecondsInfo cursor for
        select
            game_id,
            gateway_id,
            -- server_id,
            avg_seconds
        from
            STAT_CEO_INFO
        where
            stat_date = d_Tmp_Stat_Day
        for update;
    label_proc:begin
        declare continue handler for not found set n_Cur_Stop = 1;
        set d_Tmp_Stat_Day = date(adddate(now(),-1));

        select
            log_id
        into
            n_Tmp_Min_LOG_ID
        from
            LOG_DAILY_LOGID
        where
            log_date = d_Tmp_Stat_Day and
            table_name = 'LOG_RECORD_DETAIL';
        if (found_rows() = 0) then
            leave label_proc;
        end if;

        select
            min(log_id)
        into
            n_Tmp_Max_LOG_ID
        from
            LOG_DAILY_LOGID
        where
            log_date >= adddate(d_Tmp_Stat_Day, 1) and
            table_name = 'LOG_RECORD_DETAIL';
        if (
            (n_Tmp_Max_LOG_ID is null) or
            (found_rows() = 0)
        ) then
            set n_Tmp_Max_LOG_ID = 99999999999999;
        end if;

        -- Get yesterday's min_login_id and max_login_id
        select
            log_id
        into
            n_Tmp_Min_LOG_ID_YESTERDAY
        from
            LOG_DAILY_LOGID
        where
            log_date = adddate(d_Tmp_Stat_Day, -1) and
            table_name = 'LOG_RECORD_DETAIL';
        if (found_rows() = 0) then
            set n_Tmp_Min_LOG_ID_YESTERDAY = n_Tmp_Min_LOG_ID - 1;
        end if;

        set n_Tmp_Max_LOG_ID_YESTERDAY = n_Tmp_Min_LOG_ID;

        -- 分三种在线时长统计情况:
        --     今日登入、今日登出
        --     今日登入、未在当日登出
        --     前一日登入、今日登出
        -- 异常情况处理：
        --     在线时长超过24小时的，暂时按非法数据，不列入统计范围
        --     logout_time is null的，在线时间只计算到登入当天晚00:00:00
        open curAvgSecondsInfo;
        label_loop:loop
            set n_Cur_Stop = 0;
            set n_Cur_Game_ID = 0;
            set n_Cur_Gateway_id = 0;
            set n_Cur_Avg_Seconds = 0;
            fetch curAvgSecondsInfo into n_Cur_Game_ID, n_Cur_Gateway_id, n_Cur_Avg_Seconds;
            if (n_Cur_Stop <> 0) then
                leave label_loop;
            end if;

            if (n_Cur_Gateway_id <> 0) then
                begin
                    select
                        sum(unix_timestamp(t.logout_time) - unix_timestamp(t.login_time)) / count(distinct t.role_id)
                    into
                        n_Tmp_Avg_Seconds
                    from
                        (
                        -- 今日登入、今日登出：
                        --     online_seconds = logout_time - login_time
                        select
                            role_id, login_time, logout_time
                        from
                            LOG_RECORD_DETAIL
                        where
                            (game_id = n_Cur_Game_ID)   and
                            (gateway_id = n_Cur_Gateway_id) and
                            (login_id >= n_Tmp_Min_LOG_ID) and
                            (login_id <  n_Tmp_Max_LOG_ID) and
                            (logout_time is not null) and
                            (logout_time < adddate(d_Tmp_Stat_Day, 1))
                        union all
                        -- 今日登入、未在当日登出：
                        --     online_seconds = logout_time - trunc(d_Tmp_Stat_Day)
                        select
                           role_id, login_time, adddate(d_Tmp_Stat_Day, 1) as logout_time
                        from
                           LOG_RECORD_DETAIL
                        where
                           (game_id = n_Cur_Game_ID)  and
                           (gateway_id = n_Cur_Gateway_id) and
                           (login_id >= n_Tmp_Min_LOG_ID) and
                           (login_id <  n_Tmp_Max_LOG_ID) and
                           (
                               (logout_time is null) or
                               (
                                   (logout_time >= adddate(d_Tmp_Stat_Day, 1)) and
                                   (logout_time <  adddate(d_Tmp_Stat_Day, 2))
                               )
                           )
                        union all
                        -- 前一日登入、今日登出：
                        --     online_seconds = logout_time - trunc(d_Tmp_Stat_Day)
                        select
                           role_id, d_Tmp_Stat_Day as login_time, logout_time
                        from
                           LOG_RECORD_DETAIL
                        where
                           (game_id = n_Cur_Game_ID)    and
                           (gateway_id = n_Cur_Gateway_id) and
                           (login_id >= n_Tmp_Min_LOG_ID_YESTERDAY) and
                           (login_id <  n_Tmp_Max_LOG_ID_YESTERDAY) and
                           (logout_time is not null) and
                           (logout_time >= d_Tmp_Stat_Day) and
                           (logout_time <  adddate(d_Tmp_Stat_Day, 1))
                        ) t;
                end;
            else
                begin
                    select
                        sum(unix_timestamp(t.logout_time) - unix_timestamp(t.login_time)) / count(distinct t.role_id)
                    into
                        n_Tmp_Avg_Seconds
                    from
                        (
                        -- 今日登入、今日登出：
                        --     online_seconds = logout_time - login_time
                        select
                            role_id, login_time, logout_time
                        from
                            LOG_RECORD_DETAIL
                        where
                            (game_id = n_Cur_Game_ID) and
                            (login_id >= n_Tmp_Min_LOG_ID) and
                            (login_id <  n_Tmp_Max_LOG_ID) and
                            (logout_time is not null) and
                            (logout_time < adddate(d_Tmp_Stat_Day, 1))
                        union all
                        -- 今日登入、未在当日登出：
                        --     online_seconds = logout_time - trunc(d_Tmp_Stat_Day)
                        select
                           role_id, login_time, adddate(d_Tmp_Stat_Day, 1) as logout_time
                        from
                           LOG_RECORD_DETAIL
                        where
                           (game_id = n_Cur_Game_ID) and
                           (login_id >= n_Tmp_Min_LOG_ID) and
                           (login_id <  n_Tmp_Max_LOG_ID) and
                           (
                               (logout_time is null) or
                               (
                                   (logout_time >= adddate(d_Tmp_Stat_Day, 1)) and
                                   (logout_time <  adddate(d_Tmp_Stat_Day, 2))
                               )
                           )
                        union all
                        -- 前一日登入、今日登出：
                        --     online_seconds = logout_time - trunc(d_Tmp_Stat_Day)
                        select
                           role_id, d_Tmp_Stat_Day as login_time, logout_time
                        from
                           LOG_RECORD_DETAIL
                        where
                           (game_id = n_Cur_Game_ID)    and
                           (login_id >= n_Tmp_Min_LOG_ID_YESTERDAY) and
                           (login_id <  n_Tmp_Max_LOG_ID_YESTERDAY) and
                           (logout_time is not null) and
                           (logout_time >= d_Tmp_Stat_Day) and
                           (logout_time <  adddate(d_Tmp_Stat_Day, 1))
                        ) t;
                end;
            end if;

            if (n_Tmp_Avg_Seconds is null) then
                set n_Tmp_Avg_Seconds = 0;
            end if;

            if (n_Tmp_Avg_Seconds > 0) then
                update
                    STAT_CEO_INFO
                set
                    avg_seconds = n_Tmp_Avg_Seconds
                where
                    game_id = n_Cur_Game_ID and
                    gateway_id = n_Cur_Gateway_id and
                    stat_date = d_Tmp_Stat_Day;
            end if;
        end loop;
        close curAvgSecondsInfo;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
