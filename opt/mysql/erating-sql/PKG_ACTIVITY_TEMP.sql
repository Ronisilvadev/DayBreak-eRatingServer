-- 活动类型
-- 1:激活码活动
-- 3:冲级赛活动
-- 5:首次消费
-- 6:累计消费
-- 7:每日消费
-- 9:每日最大充值活动
-- 10:每日累计充值活动
-- 11:活动期间累计充值活动
-- 12:首次充值活动

DROP PROCEDURE updateActivityFlag;
DROP PROCEDURE clearActivityFlag;
DROP PROCEDURE addActivity;
DROP PROCEDURE addActivityGateway;
DROP PROCEDURE alterActivityInfo;
DROP PROCEDURE removeAllActGateway;
DROP PROCEDURE enableActivity;
DROP PROCEDURE stopActivity;
DROP PROCEDURE setActivityDetail;
DROP PROCEDURE setActivityConsumeDetail;
DROP PROCEDURE removeActivityPackage;
DROP PROCEDURE getMutexActivity;
DROP PROCEDURE cancelActivityMutex;
DROP PROCEDURE activityMutex;
DROP PROCEDURE judgeActivityCondition;
DROP PROCEDURE addActivityPackage;
DROP PROCEDURE createSnapshot;
DROP PROCEDURE createActivityInfoSnapshot;
DROP PROCEDURE createActivityMaskSnapshot;
DROP PROCEDURE createActivityGWSnapshot;
DROP PROCEDURE createActivityPackageSnapshot;
DROP PROCEDURE createActivityDetailSnapshot;
DROP PROCEDURE createConsumeDetailSnapshot;
DROP PROCEDURE removeActivity;
DROP PROCEDURE removeActivityDetail;
DROP PROCEDURE useSerialNO;
DROP PROCEDURE sendGifts;
DROP PROCEDURE sendRushActivityGift;
DROP PROCEDURE sendChargeGifts;
DROP PROCEDURE sendChargeActivityGifts;
DROP PROCEDURE dailyMaxChargeActivity;
DROP PROCEDURE dailyAccumChargeActivity;
DROP PROCEDURE PeriodAccumChargeActivity;
DROP PROCEDURE getActivityInfoList;
DROP PROCEDURE checkGifts;
DROP PROCEDURE firstChargeRealTime;
DROP PROCEDURE getActivityGatewayById;
DROP PROCEDURE getActivityInfoById;
DROP PROCEDURE getActivityDetailInfo;
DROP PROCEDURE cmpMask;
DROP PROCEDURE setBit;
DROP PROCEDURE clearBit;
DROP PROCEDURE initMask;
DROP FUNCTION  returnBit;
DROP PROCEDURE copyMask;
DROP PROCEDURE accumConsumeActivity;
DROP PROCEDURE dailyConsumeActivity;
DROP PROCEDURE firstConsumeRealTime;
DROP PROCEDURE sendItemCountGifts;
DROP PROCEDURE sendItemAmountGifts;
DROP PROCEDURE sendConsumeGifts;
DELIMITER $$

CREATE PROCEDURE updateActivityFlag(
    in  n_Game_ID           integer,
    in  n_User_ID           integer,
    in  n_Gateway_ID        integer,
    in  n_Flag_Bit          integer,
    in  b_Mask              tinyblob,
    out n_Result            integer
)
BEGIN
    declare n_RetCode           integer default  0;    /* PKG_UTIL.E_ERROR */

    declare b_Tmp_Mask          tinyblob;
    declare b_Tmp_Mask_Re       tinyblob;
    declare n_Tmp_Result        integer;
    declare n_Tmp_activity_type integer; /* sys_activity_info.activity_type%TYPE */
    declare n_Tmp_gw_ID         integer; /* UMS_USER_ACTIVITY_FLAG.GATEWAY_ID%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_User_ID      is null) or
            (n_Gateway_ID   is null) or
            (n_Flag_Bit     is null) or
            (n_Game_ID      is null) or
            (b_Mask         is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Tmp_gw_ID = n_Gateway_ID;

        -- 判断活动类型，激活码类型将网关设为 0
        select t.activity_type
        into n_Tmp_activity_type
        from sys_activity_info t
        where t.flag_bit = n_Flag_Bit
        and t.game_id = n_Game_ID;

        if(n_Tmp_activity_type = 1/* DF_ACTIVITY_TYPE_SERIAL */) then
            set n_Tmp_gw_ID = 0;
        end if;

        -- find out mask.
        label_loop:loop
            select
                t.mask
            into
                b_Tmp_Mask
            from
                UMS_USER_ACTIVITY_FLAG t
            where
                t.user_id    = n_User_ID   and
                t.gateway_id = n_Tmp_gw_ID and
                t.game_id    = n_Game_ID
            for update;
            if (FOUND_ROWS() = 1) then
                leave label_loop;
            end if;
            -- create record.
            begin
                declare continue handler for 1062 begin end;
                set b_Tmp_Mask = rpad('', 255, 0x00);
                insert into UMS_USER_ACTIVITY_FLAG(
                    user_id,    gateway_id,   mask,        game_id
                )
                values(
                    n_User_ID,  n_Tmp_gw_ID,  b_Tmp_Mask,  n_Game_ID
                );
            end;
        end loop;

        call cmpMask(b_Tmp_Mask, b_Mask, n_RetCode);
        if(n_RetCode = 1) then
            set n_Result = -1414;
            leave label_proc;
        else
            call setBit(n_Flag_Bit, b_Tmp_Mask, b_Tmp_Mask_Re, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            update
                UMS_USER_ACTIVITY_FLAG t
            set
                t.mask = b_Tmp_Mask_Re
            where
                t.user_id    = n_User_ID   and
                t.gateway_id = n_Tmp_gw_ID and
                t.game_id    = n_Game_ID;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE clearActivityFlag(
    in  n_Game_ID           integer,
    in  n_User_ID           integer unsigned,
    in  n_Gateway_ID        integer,
    in  n_Flag_Bit          integer,
    out n_Result            integer
)
BEGIN
    declare n_RetCode           integer default  0;    /* PKG_UTIL.E_ERROR */

    declare b_Tmp_Mask          tinyblob;
    declare b_Tmp_Mask_Re       tinyblob;
    declare n_Tmp_activity_type integer; /* sys_activity_info.activity_type%TYPE */
    declare n_Tmp_gw_ID         integer; /* UMS_USER_ACTIVITY_FLAG.GATEWAY_ID%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_User_ID      is null) or
            (n_Gateway_ID   is null) or
            (n_Flag_Bit     is null) or
            (n_Game_ID      is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Tmp_gw_ID = n_Gateway_ID;
        -- 判断活动类型，激活码类型将网关设为 0
        select t.activity_type
        into n_Tmp_activity_type
        from sys_activity_info t
        where t.flag_bit = n_Flag_Bit
        and t.game_id = n_Game_ID;

        if(n_Tmp_activity_type = 1 /* DF_ACTIVITY_TYPE_SERIAL */) then
            set n_Tmp_gw_ID = 0;
        end if;

        begin
            select
                t.mask
            into
                b_Tmp_Mask
            from
                UMS_USER_ACTIVITY_FLAG t
            where
                t.user_id    = n_User_ID    and
                t.gateway_id = n_Tmp_gw_ID and
                t.game_id    = n_Game_ID
            for update;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1413;    /* PKG_UTIL.E_USER_STATE_NOT_ACTIVATED */
                leave label_proc;
            end if;
        end;

        call clearBit(n_Flag_Bit, b_Tmp_Mask, b_Tmp_Mask_Re, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        update
            UMS_USER_ACTIVITY_FLAG t
        set
            t.mask = b_Tmp_Mask_Re
        where
            t.user_id    = n_User_ID   and
            t.gateway_id = n_Tmp_gw_ID and
            t.game_id    = n_Game_ID;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE judgeActivityCondition(
    in  n_Game_ID           integer,
    in  n_Activity_ID       integer,
    out n_Activity_State    integer,
    out n_Activity_Type     integer,
    out n_Result            integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;
        if(
            (n_Game_ID      is null) or
            (n_Activity_ID  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            t.activity_state, t.activity_type
        into
            n_Activity_State, n_Activity_Type
        from
            sys_activity_info t
        where
            t.game_id = n_Game_ID and
            t.activity_id = n_Activity_ID
        for update;

        if (FOUND_ROWS() = 0) then
            set n_Result = -1514;    /* PKG_UTIL.E_ACTIVITY_NOT_FOUND:无此活动 */
            leave label_proc;
        end if;

        if(n_Activity_State = 1) then
            set n_Result = -1515;    /* PKG_UTIL.E_ACTIVITY_STARTED:该活动已经开启 */
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

/* 新增活动网关 */
CREATE PROCEDURE addActivityGateway(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    in  n_Gateway_ID    integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode               integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Gateway_ID        integer;
    declare n_Stop                  integer;
    declare n_Tmp_GW_State          integer default 0;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        declare exit handler for 1062 set n_Result = -1551;

        open cur_Game_ID_List;
        set n_Result = 0;
        if(
            (n_Activity_ID is null) or
            (n_Gateway_ID  is null) or
            (n_Game_ID     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        call judgeActivityCondition(
             n_Game_ID,
             n_Activity_ID,
             n_Tmp_Activity_State,
             n_Tmp_Activity_Type,
             n_RetCode
        );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- validate gateway_id
        call GWState(
            n_Game_ID,
            n_Gateway_ID,
            n_Tmp_GW_State
        );
        if(n_Tmp_GW_State <> 1) then
            set n_Result = -1010;   /*PKG_UTIL.E_GATEWAY_STATE_ERROR*/
            leave label_proc;
        end if;

        select
            min(gateway_id)
        into
            n_Tmp_Gateway_ID
        from
            sys_activity_gateway
        where
            activity_id = n_Activity_ID and
            game_id     = n_Game_ID;

        if(
           (
             (n_Tmp_Gateway_ID = 0) and
             (n_Gateway_ID     > 0)
           ) or
           (
             (n_Tmp_Gateway_ID > 0) and
             (n_Gateway_ID     = 0)
           )
        ) then
            set n_Result = -1562;   /*PKG_UTIL.E_ACTIVITY_GATEWAY_EXISTS*/
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            begin

                insert into sys_activity_gateway(
                    activity_id,    gateway_id,    game_id
                )
                values(
                    n_Activity_ID,  n_Gateway_ID,  n_cur_Game_ID
                );
            end;

            if(n_Result = -1551) then
	        leave label_proc;
	    end if;

        end loop label_loop;
        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE removeAllActGateway(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode               integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        if(
            (n_Game_ID      is null) or
            (n_Activity_ID  is null)
        ) then
                set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
                leave label_proc;
        end if;

        call judgeActivityCondition(
             n_Game_ID,
             n_Activity_ID,
             n_Tmp_Activity_State,
             n_Tmp_Activity_Type,
             n_RetCode
        );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            delete from
                sys_activity_gateway
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

-- 新增活动
CREATE PROCEDURE addActivity(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    in  s_Activity_Name         varchar(64),
    in  n_Activity_Type         integer,
    in  d_Begin_Time            datetime,
    in  d_End_Time              datetime,
    in  d_Gift_Bgn_Time         datetime,
    in  n_Effect_Period         integer,
    in  d_Role_Bgn_Time         datetime,
    in  d_Role_End_Time         datetime,
    in  n_Activity_Times_Limit  integer,
    in  n_Mutex_Flag            integer,
    out n_Result                integer
)
BEGIN
    declare n_RetCode       integer default 0;

    declare n_Tmp_Flag_Bit  integer;
    declare n_Tmp_Count     integer;
    declare n_Tmp_Counter   integer default 2;
    declare n_cur_Game_ID   integer;
    declare n_Stop          integer;
    declare b_Mask          tinyblob;
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
        open cur_Game_ID_List;
        set n_Result = 0;
        if(
            (n_Game_ID          is null         ) or
            (n_Activity_ID      is null         ) or
            (s_Activity_Name    is null         ) or
            (n_Activity_Type    <0              ) or
            (n_Activity_Type    >12             ) or
            (d_Begin_Time       is null         ) or
            (d_End_Time         is null         ) or
            (d_Begin_Time       >= d_End_Time   ) or
            (n_Effect_Period    is null         ) or
            (n_Effect_Period    <=0             ) or
            (n_Activity_Times_Limit is null     ) or
            (n_Activity_Times_Limit <1          )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        -- 角色开始和结束时间可以同时为空，但不能只有一个为空
        if(
            (
                (d_Role_Bgn_Time is null        ) and
                (d_Role_End_Time is not null    )
            ) or
            (
                (d_Role_Bgn_Time is not null    ) and
                (d_Role_End_Time is null        )
            )
        ) then
            set n_Result = -100;
            leave label_proc; 
        end if;

        if(
            (d_Role_Bgn_Time is not null        ) and
            (d_Role_End_Time is not null        ) and
            (d_Role_Bgn_Time >= d_Role_End_Time )
        ) then
            set n_Result = -100;
            leave label_proc; 
        end if;

        -- 至此 d_Role_Bgn_Time 和 d_Role_End_Time 或者全为空，或者全不空，只需判断任何一个即可
        if(
            (n_Activity_Type = 3                ) and
            (d_Role_Bgn_Time is null            )
        ) then
            set n_Result = -100;
            leave label_proc; 
        end if;

        if(
            (n_Activity_Type = 2) or
            (n_Activity_Type = 4)
        ) then
            set n_Tmp_Flag_Bit = 1;
        else
            -- 在 允许范围内（2~2040，1是新手礼专用）
            -- 取一个未使用的最小值做为活动标识
            label_while:while(n_Tmp_Counter <= 2040) do
                if(n_Tmp_Counter in (select flag_bit from sys_activity_info for update)) then
                    set n_Tmp_Counter = n_Tmp_Counter + 1;
                else
                    leave label_while;
                end if;
            end while label_while;

            if(n_Tmp_Counter > 2040) then
                set n_Result = -1559;   /* PKG_UTIL.E_ACTIVITY_FLAG_NOT_ENOUGH */
                leave label_proc; 
            else
                set n_Tmp_Flag_Bit = n_Tmp_Counter;
            end if;
        end if;

        -- 如果是新手礼或渠道活动,则copy一份已有的新手礼或渠道活动的mask,保证所有的此类活动具有相同的互斥.
        if(n_Tmp_Flag_Bit = 1) then
            select
                mask
            into
                b_Mask
            from
                SYS_ACTIVITY_INFO
            where
                flag_bit = 1 and
                game_id  = n_Game_ID;

            if( found_rows() = 0) then
                call initMask(n_Tmp_Flag_Bit, b_Mask, n_RetCode);
                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end if;
        -- 其它类型的活动则自己初始化自己的掩码
        else
            call initMask(n_Tmp_Flag_Bit, b_Mask, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;        

            insert ignore into sys_activity_info(
                activity_id,        flag_bit,
                activity_name,      activity_type,
                begin_time,         end_time,
                gift_begin_time,    effect_period,
                role_begin_time,    role_end_time,
                activity_state,     game_id,
                mask,               activity_times_limit
                )
            values(
                n_Activity_ID,      n_Tmp_Flag_Bit,
                s_Activity_Name,    n_Activity_Type,
                d_Begin_Time,       d_End_Time,
                d_Gift_Bgn_Time,    n_Effect_Period,
                d_Role_Bgn_Time,    d_Role_End_Time,
                0,                  n_cur_Game_ID,
                b_Mask,             n_Activity_Times_Limit
                );
            if( row_count() = 0 ) then
                set n_Result = -1510;   /* PKG_UTIL.E_ACTIVITY_ID_EXIST */
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

-- 修改活动信息
CREATE PROCEDURE alterActivityInfo(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    in  s_Activity_Name         varchar(64),
    in  d_Begin_Time            datetime,
    in  d_End_Time              datetime,
    in  d_Gift_Bgn_Time         datetime,
    in  n_Effect_Period         integer,
    in  d_Role_Bgn_Time         datetime,
    in  d_Role_End_Time         datetime,
    in  n_Activity_Times_Limit  integer,
    out n_Result                integer
)
BEGIN
    declare n_RetCode               integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        if(
            (n_Game_ID       is null      ) or
            (n_Activity_ID   is null      ) or
            (s_Activity_Name is null      ) or
            (d_Begin_Time    is null      ) or
            (d_End_Time      is null      ) or
            (d_Begin_Time    >= d_End_Time) or
            (n_Effect_Period is null      ) or
            (n_Effect_Period <= 0         ) or
            (n_Activity_Times_Limit is null)or
            (n_Activity_Times_Limit <1    )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;
        -- 可以同时为空，但不能只有一个为空
        if(
            (
                (d_Role_Bgn_Time is null          ) and
                (d_Role_End_Time is not null      )
            ) or
            (
                (d_Role_Bgn_Time is not null      ) and
                (d_Role_End_Time is null          )
            )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        if(
            (d_Role_Bgn_Time is not null       ) and
            (d_Role_End_Time is not null       ) and
            (d_Role_Bgn_Time >= d_Role_End_Time)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call judgeActivityCondition(
                n_Game_ID,
                n_Activity_ID,
                n_Tmp_Activity_State,
                n_Tmp_Activity_Type,
                n_RetCode
        );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if(
           (n_Tmp_Activity_Type = 3) and
           (d_Role_Bgn_Time is null) and
           (d_Role_End_Time is null)
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

            if (n_Tmp_Activity_State = 0) then
                update sys_activity_info
                set
                    activity_name       = s_Activity_Name,
                    begin_time          = d_Begin_Time,
                    end_time            = d_End_Time,
                    gift_begin_time     = d_Gift_Bgn_Time,
                    effect_period       = n_Effect_Period,
                    role_begin_time     = d_Role_Bgn_Time,
                    role_end_time       = d_Role_End_Time,
		            activity_times_limit=n_Activity_Times_Limit
                where
                    game_id     = n_cur_Game_ID     and
                    activity_id = n_Activity_ID;

                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;

            elseif (n_Tmp_Activity_State = 2) then
                update sys_activity_info
                set
                    activity_name       = s_Activity_Name,
                    end_time            = d_End_Time,
                    gift_begin_time     = d_Gift_Bgn_Time,
                    effect_period       = n_Effect_Period,
                    role_begin_time     = d_Role_Bgn_Time,
                    role_end_time       = d_Role_End_Time
                where
                    game_id     = n_cur_Game_ID and
                    activity_id = n_Activity_ID;
                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE enableActivity(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare n_Tmp_Count     integer default 0;
    declare n_Tmp_Cnt       integer default 0;
    declare d_Tmp_Time      datetime;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
    declare d_Tmp_End_Time          datetime;
    declare d_Tmp_Begin_Time        datetime;
    declare n_cur_Game_ID           integer;
    declare n_Stop                  integer;
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
        open cur_Game_ID_List;
        set n_Result = 0;
        set d_Tmp_Time = now();

        if(
            (n_Game_ID      is null) or
            (n_Activity_ID  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            activity_type,
            activity_state,
            end_time,
            begin_time
        into
            n_Tmp_Activity_Type,
            n_Tmp_Activity_State,
            d_Tmp_End_Time,
            d_Tmp_Begin_Time
        from
            sys_activity_info
        where
            activity_id = n_Activity_ID and
            game_id     = n_Game_ID
        for update;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        if ( n_Tmp_Activity_State = 1 ) then
            set n_Result = -1515;   /* PKG_UTIL.E_ACTIVITY_STARTED */
            leave label_proc;
        end if;

        if ( d_Tmp_End_Time < d_Tmp_Time ) then
            set n_Result = -1505;   /* PKG_UTIL.E_ACTIVITY_EXPIRED */
            leave label_proc;
        end if;

        -- 推迟开启的活动，调整开启时间为当前时间
        -- 在状态从2转为1时不会修改开始时间,只有0转为1时有可能修改

        if (
            ( d_Tmp_Begin_Time     <  d_Tmp_Time) and
            ( n_Tmp_Activity_State =  0         )
        ) then
            set d_Tmp_Begin_Time = d_Tmp_Time;
        end if;

        if (
            ( n_Tmp_Activity_Type = 2 ) or
            ( n_Tmp_Activity_Type = 4 )
        ) then
            select
                count(*)
            into
                n_Tmp_Count
            from
                sys_activity_info
            where
                (activity_type = n_Tmp_Activity_Type ) and
                (game_id       = n_Game_ID           ) and
                (activity_state = 1                  ) and
                (
                    (
                        begin_time <= d_Tmp_Begin_Time and
                        end_time   >  d_Tmp_Begin_Time
                    ) or
                    (
                        begin_time <  d_Tmp_End_Time   and
                        end_time   >= d_Tmp_End_Time
                    ) or
                    (
                        begin_time >= d_Tmp_Begin_Time and
                        end_time   <= d_Tmp_End_Time
                    )
                );

            if (n_Tmp_Count > 0) then
                set n_Result = -1557;  /* PKG_UTIL.E_ACTIVITY_COUNT_ERROR */
                leave label_proc;
            end if;
        end if;

        -- 激活码活动 可以无区组
        if(n_Tmp_Activity_Type <> 1) then
            select
                count(*)
            into
                n_Tmp_Count
            from
                sys_activity_gateway
            where
                activity_id = n_Activity_ID and
                game_id     = n_Game_ID;

            if( n_Tmp_Count = 0 ) then
                set n_Result = -1554;   /* PKG_UTIL.E_ACTIVITY_NO_GATEWAY */
                leave label_proc;
            end if;
        end if;

        if (
            (n_Tmp_Activity_Type < 5) or
            (n_Tmp_Activity_Type > 7)
        ) then
        -- 激活码、新手礼、冲级、渠道、充值
            select
                count(*)
            into
                n_Tmp_Count
            from
                sys_activity_detail
            where
                activity_id = n_Activity_ID and
                game_id     = n_Game_ID;
            if( n_Tmp_Count = 0 ) then
                set n_Result = -1555;   /* PKG_UTIL.E_ACTIVITY_NO_DETAIL */
                leave label_proc;
            end if;

            -- 激活码活动 可以无礼品
            if(n_Tmp_Activity_Type <> 1) then
                select
                    count(distinct t.package_id)
                into
                    n_Tmp_Cnt
                from
                    sys_activity_detail t,
                    sys_activity_package p
                where
                    (t.activity_id = n_Activity_ID )and
                    (t.package_id  = p.package_id  )and
                    (t.game_id     = n_Game_ID     );

                if ( n_Tmp_Count <> n_Tmp_Cnt ) then
                    set n_Result = -1556;   /* PKG_UTIL.E_ACTIVITY_NO_PACKAGE */
                    leave label_proc;
                end if;
            end if;
        else
        -- 累计消费、每日消费
            select
                count(*)
            into
                n_Tmp_Count
            from
                sys_activity_consume_detail
            where
                activity_id = n_Activity_ID and
                game_id     = n_Game_ID;
            if( n_Tmp_Count = 0 ) then
                set n_Result = -1555;   /* PKG_UTIL.E_ACTIVITY_NO_DETAIL */
                leave label_proc;
            end if;

            select
                count(distinct t.package_id)
            into
                n_Tmp_Cnt
            from
                sys_activity_consume_detail t,
                sys_activity_package p
            where
                (t.activity_id = n_Activity_ID )and
                (t.package_id  = p.package_id  )and
                (t.game_id     = n_Game_ID     );

            if ( n_Tmp_Count <> n_Tmp_Cnt ) then
                set n_Result = -1556;   /* PKG_UTIL.E_ACTIVITY_NO_PACKAGE */
                leave label_proc;
            end if;
        end if;
 
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            -- 为了createSnapshot()函数的调用,先update SYS_ACTIVITY_INFO begin_time
            -- createSnapshot 需要使用 SYS_ACTIVITY_INFO.activity_state 来判断状态
            update
                sys_activity_info
            set
                begin_time     = d_Tmp_Begin_Time
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;

            call createSnapshot(n_cur_Game_ID, n_Activity_ID, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            -- update SYS_ACTIVITY_INFO activity_state
            update
                sys_activity_info
            set
                activity_state = 1
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;
            if( row_count() = 0) then
                set n_Result = -1514;
                leave label_proc;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE createSnapshot(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare d_Tmp_End_Time  datetime;
    declare d_Tmp_Bgn_Time  datetime;

    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_State    integer;

    declare s_Activity_Info_Snap    varchar(4000) default '';
    declare s_Activity_GW_Snap      varchar(4000) default '';
    declare s_Total_Detail_Snap     text default '';
    declare s_Snapshot_Info         text default '';
    declare s_Activity_Mask_Snap    varchar(1025) default '';

    label_proc:begin
        set n_Result = 0;
        if(
            (n_Game_ID      is null) or
            (n_Activity_ID  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        -- make snapshot of SYS_ACTIVITY_INFO
        call createActivityInfoSnapshot(n_Game_ID, n_Activity_ID, s_Activity_Info_Snap, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if(s_Activity_Info_Snap is not null) then
            set s_Snapshot_Info = concat(s_Snapshot_Info, s_Activity_Info_Snap);
        end if;

        -- make snapshot of mask
        call createActivityMaskSnapshot(n_Game_ID, n_Activity_ID, s_Activity_Mask_Snap, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- make snapshot of SYS_ACTIVITY_GATEWAY
        call createActivityGWSnapshot(n_Game_ID, n_Activity_ID, s_Activity_GW_Snap, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
    
        if(s_Activity_GW_Snap is not null) then
            set s_Snapshot_Info = concat(s_Snapshot_Info, s_Activity_GW_Snap);
        end if;

        -- make snapshot of SYS_ACTIVITY_DETAIL or SYS_ACTIVITY_CONSUME_DETAIL
        select
            activity_type,          begin_time,     end_time,       activity_state
        into
            n_Tmp_Activity_Type,    d_Tmp_Bgn_Time, d_Tmp_End_Time, n_Tmp_Activity_State
        from
            sys_activity_info
        where
            activity_id = n_Activity_ID and
            game_id     = n_Game_ID;
    
        if(found_rows() = 0) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        if (
             (n_Tmp_Activity_Type < 5) or
             (n_Tmp_Activity_Type > 7)
        ) then
            call createActivityDetailSnapshot(n_Game_ID, n_Activity_ID, s_Total_Detail_Snap, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        else
            call createConsumeDetailSnapshot(n_Game_ID, n_Activity_ID, s_Total_Detail_Snap, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;
        set s_Snapshot_Info = concat(s_Snapshot_Info, s_Total_Detail_Snap);
        -- activity_state = 0,快照开始时间为SYS_ACTIVITY_INFO表中的开始时间
        if(n_Tmp_Activity_State = 0) then
            insert into log_activity_snapshot(
                game_id,
                activity_id,
                begin_time,
                end_time,
                detail_snapshot,
                mask_snapshot
            )
            values(
                n_Game_ID,
                n_Activity_ID,
                d_Tmp_Bgn_Time,
                d_Tmp_End_Time,
                s_Snapshot_Info,
                s_Activity_Mask_Snap
            );

            if(row_count() = 0) then
                leave label_proc;
            end if;
        -- activity_state = 2,快照开始时间为当前时间
        else
            insert into log_activity_snapshot(
                game_id,
                activity_id,
                begin_time,
                end_time,
                detail_snapshot,
                mask_snapshot
            )
            values(
                n_Game_ID,
                n_Activity_ID,
                now(),
                d_Tmp_End_Time,
                s_Snapshot_Info,
                s_Activity_Mask_Snap
            );

            if(row_count() = 0) then
                leave label_proc;
            end if;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE stopActivity(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare d_Tmp_Time              datetime;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_State    integer;
    declare d_Tmp_End_Time          datetime;
    declare d_Tmp_Bgn_Time          datetime;
    declare n_Tmp_Log_ID            bigint;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        set d_Tmp_Time = now();

        if(
            (n_Game_ID      is null) or
            (n_Activity_ID  is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            activity_type,
            activity_state,
            end_time,
            begin_time
        into
            n_Tmp_Activity_Type,
            n_Tmp_Activity_State,
            d_Tmp_End_Time,
            d_Tmp_Bgn_Time
        from
            sys_activity_info
        where
            activity_id = n_Activity_ID and
            game_id     = n_Game_ID
        for update;
        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        if ( n_Tmp_Activity_State = 2 ) then
            set n_Result = -1517;   /* PKG_UTIL.E_ACTIVITY_CLOSED */
            leave label_proc;
        end if;

        if(d_Tmp_End_Time < d_Tmp_Time) then
            set n_Result = -1505;   /* PKG_UTIL.E_ACTIVITY_EXPIRED */
            leave label_proc;
        else
            set d_Tmp_End_Time = d_Tmp_Time;
        end if;

        
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            select
                max(log_id)
            into
                n_Tmp_Log_ID
            from
                log_activity_snapshot
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;
            if( found_rows() = 0 ) then
                set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                leave label_proc;
            end if;
            /*
            关闭时间小于活动开始时间,说明活动还未实际开启.
            这种情况下为了修改活动和再次开启活动时正确的判断活动是否实际开启,将活动状态设置为0(未开启).
            未实际开启之前的快照无用,所以删除快照表中最后一条记录.
            */
            if(d_Tmp_Time < d_Tmp_Bgn_Time) then
                update
                    sys_activity_info
                set
                    activity_state = 0
                where
                    activity_id = n_Activity_ID and
                    game_id     = n_cur_Game_ID;
                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;
                delete from
                    log_activity_snapshot
                where
                    log_id = n_Tmp_Log_ID;
                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;
            else
                update
                    sys_activity_info
                set
                    end_time = d_Tmp_End_Time,
                    activity_state = 2
                where
                    activity_id = n_Activity_ID and
                    game_id     = n_cur_Game_ID;
                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;

                update
                    log_activity_snapshot
                set
                    end_time = d_Tmp_Time
                where
                    log_id = n_Tmp_Log_ID;
                if( row_count() = 0 ) then
                    set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE setActivityDetail(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    in  n_Lower_Limit   integer,
    in  n_Upper_Limit   integer,
    out n_Package_ID    integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare n_Count         integer default 0;

    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_State    integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        if (
            (n_Activity_ID is null         ) or
            (n_Lower_Limit is null         ) or
            (n_Upper_Limit is null         ) or
            (n_Lower_Limit >  n_Upper_Limit) or
            (n_Game_ID     is null         )
        ) then
            set n_Result = -100;
            leave label_proc; 
        end if;

        call judgeActivityCondition(
            n_Game_ID,
            n_Activity_ID,
            n_Tmp_Activity_State,
            n_Tmp_Activity_Type,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (
            (n_Tmp_Activity_Type >= 5) and
            (n_Tmp_Activity_Type <= 7)
        ) then
            set n_Result = -1519;    /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        -- 判断级别是否交叉
        select
            count(*)
        into
            n_Count
        from
            sys_activity_detail
        where
            activity_id = n_Activity_ID and
            game_id = n_Game_ID         and
            (
              (
                  lower_limit <= n_Lower_Limit and
                  upper_limit >  n_Lower_Limit
              ) or
              (
                  lower_limit <  n_Upper_Limit and
                  upper_limit >= n_Upper_Limit
              ) or
              (
                  lower_limit >= n_Lower_Limit and
                  upper_limit <= n_Upper_Limit
              )
            );

        if (n_Count > 0) then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        insert into sys_activity_package_id values(null);
        select last_insert_id() into n_Package_ID;

        insert ignore into sys_activity_detail(
            activity_id,     lower_limit,     upper_limit,
            game_id,         package_id
        )
        values(
            n_Activity_ID,   n_Lower_Limit,   n_Upper_Limit,
            n_Game_ID,       n_Package_ID
        );
        if( row_count() = 0 ) then
            set n_Result = -1520;   /* PKG_UTIL.E_ACTIVITY_DETAIL_EXISTS */
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            if( n_cur_Game_ID <> n_Game_ID ) then
                insert ignore into sys_activity_detail(
                    activity_id,     lower_limit,     upper_limit,
                    game_id,         package_id
                )
                values(
                    n_Activity_ID,   n_Lower_Limit,   n_Upper_Limit,
                    n_cur_Game_ID,   n_Package_ID
                );
                if( row_count() = 0 ) then
                    set n_Result = -1520;   /* PKG_UTIL.E_ACTIVITY_DETAIL_EXISTS */
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE setActivityConsumeDetail(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    in  n_Limit_Type    integer,
    in  n_Subject_ID    integer,
    in  s_Product_Code  varchar(32),
    in  n_Lower_Limit   integer,
    in  n_Upper_Limit   integer,
    out n_Package_ID    integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare n_Count         integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Limit_Type        integer;
    declare n_Tmp_Subject_ID        integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;

        if (
            (n_Game_ID              is null) or
            (n_Activity_ID          is null) or
            (n_Limit_Type           is null) or
            (n_Limit_Type     not in (1, 2)) or
            (n_Subject_ID           is null) or
            (n_Subject_ID  not in (3, 4, 5)) or
            (s_Product_Code         is null) or
            (n_Lower_Limit          is null) or
            (n_Upper_Limit          is null) or
            (n_Lower_Limit >  n_Upper_Limit)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        -- 判断活动状态是否正常
        call judgeActivityCondition(
                n_Game_ID,
                n_Activity_ID,
                n_Tmp_Activity_State,
                n_Tmp_Activity_Type,
                n_RetCode
                );

        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (
            (n_Tmp_Activity_Type < 5) or
            (n_Tmp_Activity_Type > 7)
        ) then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT:活动条件冲突 */
            leave label_proc;
        end if;

        -- 首次消费活动必须配成所有道具，limit_type = 1 的
        if (
            (n_Tmp_Activity_Type =  5) and
            (
             (s_Product_Code    <> 'ALL' ) or
             (n_Limit_Type      <> 1     )
            )
        ) then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        -- 判断条件类型是否相同: 一个活动只允许一种条件类型
        begin
            declare exit handler for 1172 set n_Result = -1519;
            select
                distinct limit_type
            into
                n_Tmp_Limit_Type
            from
                sys_activity_consume_detail
            where
                activity_id = n_Activity_ID and
                game_id     = n_Game_ID;
        end;

        if(n_Result = -1519) then
            leave label_proc;
        end if;

        if (
            (n_Tmp_Limit_Type     <> 0) and
            (
             (n_Tmp_Limit_Type    <> n_Limit_Type   ) or
             (n_Tmp_Activity_Type = 5               ) -- 首次消费 只配一个详情
            )
        )then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        -- 判断一个活动是否配了多种 subject_id
        begin
            declare exit handler for 1172 set n_Result = -1519;
            select
                distinct subject_id
            into
                n_Tmp_Subject_ID
            from
                sys_activity_consume_detail
            where
                activity_id  = n_Activity_ID and
                game_id      = n_Game_ID;
        end;

        if(n_Result = -1519) then
            leave label_proc;
        end if;

        if (
            (n_Tmp_Subject_ID     is not null) and
            (n_Tmp_Subject_ID <> n_Subject_ID)
        )then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        -- 判断同一个物品的条件是否交叉
        select
            count(*)
        into
            n_Count
        from
            sys_activity_consume_detail
        where
            activity_id  = n_Activity_ID and
            product_code = s_Product_Code and
            game_id      = n_Game_ID and
            (
              (
                  lower_limit <= n_Lower_Limit and
                  upper_limit >  n_Lower_Limit
              ) or
              (
                  lower_limit <  n_Upper_Limit and
                  upper_limit >= n_Upper_Limit
              ) or
              (
                  lower_limit >= n_Lower_Limit and
                  upper_limit <= n_Upper_Limit
              )
            );

        if (n_Count > 0) then
            set n_Result = -1519;   /* PKG_UTIL.E_CONDITION_CONFLICT */
            leave label_proc;
        end if;

        insert into sys_activity_package_id values(null);
        select last_insert_id() into n_Package_ID;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            begin
                declare exit handler for 1062 set n_Result = -1520;

                insert ignore into sys_activity_consume_detail(
                    activity_id,     limit_type,     subject_id,
                    product_code,    lower_limit,    upper_limit,
                    game_id,         package_id
                )
                values(
                    n_Activity_ID,   n_Limit_Type,   n_Subject_ID,
                    s_Product_Code,  n_Lower_Limit,  n_Upper_Limit,
                    n_cur_Game_ID,       n_Package_ID
                );
            end;

            if(n_Result = -1520) then
                leave label_proc;
            end if;

        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE addActivityPackage(
    in  n_Package_ID        integer,
    in  s_Item_Code         varchar(32),
    in  s_Item_name         varchar(32),
    in  n_Item_Num          integer,
    out n_Result            integer
)
BEGIN
    declare n_RetCode       integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_ID       integer;
    declare n_Tmp_Game_ID           integer;

    label_proc:begin
        set n_Result = 0;

        if (
            (n_Package_ID  is null) or
            (s_Item_Code   is null) or
            (s_Item_name   is null) or
            (n_Item_Num    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            activity_id,        game_id
        into
            n_Tmp_Activity_ID,  n_Tmp_Game_ID
        from
            sys_activity_detail
        where
            package_id = n_Package_ID
        and game_id in (
            select
                ifnull(max(game_id), 0)
            from 
                sys_activity_detail
            where 
                package_id = n_Package_ID
            );
        if( found_rows() = 0) then
            select
                activity_id,        game_id
            into
                n_Tmp_Activity_ID,  n_Tmp_Game_ID
            from
                sys_activity_consume_detail
            where
                package_id = n_Package_ID
            and game_id in (
            select
                ifnull(max(game_id), 0)
            from 
                sys_activity_consume_detail
            where 
                package_id = n_Package_ID
            );

            if( found_rows() = 0) then
                set n_Result = -1518;   /* PKG_UTIL.E_PACKAGE_NOT_EXIST:无此包 */
                leave label_proc;
            end if;
        end if;

        call judgeActivityCondition(
                n_Tmp_Game_ID,
                n_Tmp_Activity_ID,
                n_Tmp_Activity_State,
                n_Tmp_Activity_Type,
                n_RetCode
                );

        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        insert ignore into sys_activity_package(
            package_id,   item_code,
            item_name,    item_num
        )
        values(
            n_Package_ID,   s_Item_Code,
            s_Item_name,    n_Item_Num
        );

        if( row_count() = 0) then
            set n_Result = -1552;   /* PKG_UTIL.E_PACKAGE_ITEM_EXISTS */
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE removeActivityPackage(
    in  n_Package_ID        integer,
    in  s_Item_Code         varchar(32),
    out n_Result            integer
)
BEGIN
    declare n_RetCode       integer default 0;

    declare n_Tmp_Activity_State    integer;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_ID       integer;
    declare n_Tmp_Game_ID           integer;

    label_proc:begin
        set n_Result = 0;

        if(
            (n_Package_ID   is null) or
            (s_Item_Code    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            activity_id,        game_id
        into
            n_Tmp_Activity_ID,  n_Tmp_Game_ID
        from
            sys_activity_detail
        where
            package_id = n_Package_ID 
        and game_id in (
            select
                ifnull(max(game_id), 0)
            from 
                sys_activity_detail
            where 
                package_id = n_Package_ID
            );
        if( found_rows() = 0) then
            select
                activity_id,        game_id
            into
                n_Tmp_Activity_ID,  n_Tmp_Game_ID
            from
                sys_activity_consume_detail
            where
                package_id = n_Package_ID
            and game_id in (
            select
                ifnull(max(game_id), 0)
            from 
                sys_activity_consume_detail
            where 
                package_id = n_Package_ID
            );

            if( found_rows() = 0 ) then
                set n_Result = -1518;   /* PKG_UTIL.E_PACKAGE_NOT_EXIST:无此包 */
                leave label_proc;
            elseif( found_rows() > 1 ) then
                set n_Result = -1557;   /* PKG_UTIL.E_ACTIVITY_COUNT_ERROR */
                leave label_proc;
            end if;
        elseif( found_rows()>1 ) then
            set n_Result = -1557;   /* PKG_UTIL.E_ACTIVITY_COUNT_ERROR */
            leave label_proc;
        end if;

        call judgeActivityCondition(
                n_Tmp_Game_ID,
                n_Tmp_Activity_ID,
                n_Tmp_Activity_State,
                n_Tmp_Activity_Type,
                n_RetCode
                );

        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        delete from
            sys_activity_package
        where
            (item_code = s_Item_Code) and
            (package_id = n_Package_ID);

        if(row_count() = 0) then
            set n_Result = -1469;   /*PKG_UTIL.E_PACKAGE_ITEM_NOT_FOUND*/
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getMutexActivity(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare n_Tmp_Activity_Type     integer;
    declare b_Tmp_Mask              tinyblob;

    label_proc:begin
        set n_Result = 0;

        if (
            (n_Game_ID     is null) or
            (n_Activity_ID is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            activity_type,
            mask
        into
            n_Tmp_Activity_Type,
            b_Tmp_Mask
        from
            sys_activity_info
        where
            game_id     = n_Game_ID and
            activity_id = n_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        if (n_Tmp_Activity_Type <> 1) then
            set n_Result = -1561;   /* PKG_UTIL.E_ACTIVITY_CANNOT_MUTEX */
            leave label_proc;
        end if;

        select
            activity_id       as  activity_id,
            flag_bit          as  flag_bit,
            activity_name     as  activity_name,
            activity_type     as  activity_type,
            begin_time        as  begin_time,
            end_time          as  end_time,
            activity_state    as  activity_state,
            gift_begin_time   as  gift_begin_time,
            effect_period     as  effect_period,
            role_begin_time   as  role_begin_time,
            role_end_time     as  role_end_time
        from
            sys_activity_info
        where
            (game_id       =  n_Game_ID    ) and
            (activity_type = 1) and
            (activity_id   <> n_Activity_ID) and
            (flag_bit       >= 1           ) and
            (returnBit(flag_bit, b_Tmp_Mask) = 1);

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE cancelActivityMutex(
    in  n_Game_ID               integer,
    in  n_First_Activity_ID     integer,
    in  n_Second_Activity_ID    integer,
    out n_Result                integer
)
BEGIN
    declare n_RetCode       integer default 0;

    declare n_First_Flag_Bit        integer;
    declare n_Second_Flag_Bit       integer;
    declare b_First_Mask            tinyblob;
    declare b_Second_Mask           tinyblob;
    declare b_Tmp_First_Mask        tinyblob;
    declare b_Tmp_Second_Mask       tinyblob;
    declare n_First_Activity_Type   integer;
    declare n_Second_Activity_Type  integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        if (
            (n_Game_ID              is null) or
            (n_First_Activity_ID    is null) or
            (n_Second_Activity_ID   is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            flag_bit,           mask,            activity_type
        into
            n_First_Flag_Bit,   b_First_Mask,    n_First_Activity_Type
        from
            sys_activity_info
        where
            game_id     = n_Game_ID and
            activity_id = n_First_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        select
            flag_bit,           mask,            activity_type
        into
            n_Second_Flag_Bit,  b_Second_Mask,   n_Second_Activity_Type
        from
            sys_activity_info
        where
            game_id   = n_Game_ID and
            activity_id = n_Second_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        -- 新手礼之间的互斥不能取消
        if (
            (
              (n_First_Activity_Type = 4  ) or
              (n_First_Activity_Type = 2  )
            ) and
            (
               (n_Second_Activity_Type = 4 ) or
               (n_Second_Activity_Type = 2)
            )
        ) then
            set n_Result = -1560;   /* PKG_UTIL.E_ACTIVITY_MUST_MUTEX */
            leave label_proc;
        end if;

        -- 由于消费和冲级活动不能设置互斥,直接返回正确
        if ((n_First_Activity_Type  <> 1) or
            (n_Second_Activity_Type <> 1)
        ) then
            set n_Result = 1;
            leave label_proc;
        end if;

        call clearBit(n_First_Flag_Bit, b_Second_Mask, b_Tmp_Second_Mask, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        call clearBit(n_Second_Flag_Bit, b_First_Mask, b_Tmp_First_Mask, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            update -- 取消第一个活动的互斥
                sys_activity_info
            set
                mask = b_Tmp_First_Mask
            where
                game_id     = n_cur_Game_ID and
                activity_id = n_First_Activity_ID;

            update -- 取消第二个活动的互斥
                sys_activity_info
            set
                mask = b_Tmp_Second_Mask
            where
                game_id   = n_cur_Game_ID and
                activity_id = n_Second_Activity_ID;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE activityMutex(
    in  n_Game_ID               integer,
    in  n_First_Activity_ID     integer,
    in  n_Second_Activity_ID    integer,
    out n_Result                integer
)
BEGIN
    declare n_RetCode           integer default 0;

    declare n_First_Flag_Bit        integer;
    declare n_Second_Flag_Bit       integer;
    declare b_First_Mask            tinyblob;
    declare b_Second_Mask           tinyblob;
    declare b_Tmp_First_Mask        tinyblob;
    declare b_Tmp_Second_Mask       tinyblob;
    declare n_First_Activity_Type   integer;
    declare n_Second_Activity_Type  integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        if (
            (n_Game_ID              is null) or
            (n_First_Activity_ID    is null) or
            (n_Second_Activity_ID   is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            flag_bit,           mask,           activity_type
        into
            n_First_Flag_Bit,   b_First_Mask,   n_First_Activity_Type
        from
            sys_activity_info
        where
            game_id     = n_Game_ID and
            activity_id = n_First_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        select
            flag_bit,           mask,            activity_type
        into
            n_Second_Flag_Bit,  b_Second_Mask,   n_Second_Activity_Type
        from
            sys_activity_info
        where
            game_id     = n_Game_ID and
            activity_id = n_Second_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        -- 由于渠道和新手礼活动必然互斥,直接返回正确
        if (
            (
              (n_First_Activity_Type = 4  ) or
              (n_First_Activity_Type = 2  )
            ) and
            (
               (n_Second_Activity_Type = 4) or
               (n_Second_Activity_Type = 2)
            )
        ) then
            set n_Result = 1;
            leave label_proc;
        end if;
        -- 消费和冲级活动不能设置互斥
        if ((n_First_Activity_Type  <> 1) or
            (n_Second_Activity_Type <> 1)
        ) then
            set n_Result = -1561;   /* PKG_UTIL.E_ACTIVITY_CANNOT_MUTEX */
            leave label_proc;
        end if;

        call setBit(n_First_Flag_Bit, b_Second_Mask, b_Tmp_Second_Mask, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call setBit(n_Second_Flag_Bit, b_First_Mask, b_Tmp_First_Mask, n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            
            update -- 设置第一个活动的互斥
                sys_activity_info
            set
                mask = b_Tmp_First_Mask
            where
                game_id     = n_cur_Game_ID and
                activity_id = n_First_Activity_ID;

            update -- 设置第二个活动的互斥
                sys_activity_info
            set
                mask = b_Tmp_Second_Mask
            where
                game_id     = n_cur_Game_ID and
                activity_id = n_Second_Activity_ID;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE createActivityInfoSnapshot(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    out s_Activity_Info_Snap    varchar(4000),
    out n_Result                integer
)
BEGIN
    declare s_Tmp_Activity_ID       varchar(11);
    declare s_Tmp_Flag_Bit          varchar(5);
    declare s_Tmp_Activity_Name     varchar(64);
    declare s_Tmp_Activity_Type     varchar(3);
    declare s_Tmp_Begin_time        varchar(22);
    declare s_Tmp_End_Time          varchar(22);
    declare s_Tmp_Activity_State    varchar(2);
    declare s_Tmp_Gift_Bgn_Time     varchar(22);
    declare s_Tmp_Effect_Period     varchar(11);
    declare s_Tmp_Role_Bgn_Time     varchar(22);
    declare s_Tmp_Role_End_Time     varchar(22);
    declare n_Activity_Times_Limit  integer;

    label_proc:begin
        set n_Result = 0;
        set s_Activity_Info_Snap = '';

        if(
          (n_Game_ID        is null) or
          (n_Activity_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            concat(activity_id),                            concat(flag_bit),
            activity_name,                                  concat(activity_type),
            date_format(begin_time, '%Y-%c-%e %k:%i:%s'),   date_format(end_time, 'yyyy-mm-dd hh24:mi:ss'),
            concat(activity_state),                         date_format(gift_begin_time, '%Y-%c-%e %k:%i:%s'),
            concat(effect_period),                          date_format(role_begin_time, '%Y-%c-%e %k:%i:%s'),
            date_format(role_end_time, '%Y-%c-%e %k:%i:%s'),activity_times_limit
        into
            s_Tmp_Activity_ID,      s_Tmp_Flag_Bit,
            s_Tmp_Activity_Name,    s_Tmp_Activity_Type,
            s_Tmp_Begin_Time,       s_Tmp_End_Time,
            s_Tmp_Activity_State,   s_Tmp_Gift_Bgn_Time,
            s_Tmp_Effect_Period,    s_Tmp_Role_Bgn_Time,
            s_Tmp_Role_End_Time,    n_Activity_Times_Limit
        from
            sys_activity_info
        where
            game_id     = n_Game_ID     and
            activity_id = n_Activity_ID;

        if( found_rows() = 0) then
            set n_Result = -1514;
            leave label_proc;
        end if;

        set s_Activity_Info_Snap = concat('SYS_ACTIVITY_INFO(',
                'activity_id=',        s_Tmp_Activity_ID,
                'game_id=',            n_Game_ID,
                ',flag_bit=',          s_Tmp_Flag_Bit,
                ',activity_name=',     s_Tmp_Activity_Name,
                ',activity_type=',     s_Tmp_Activity_Type,
                ',begin_time=',        s_Tmp_Begin_Time,
                ',end_time=',          s_Tmp_End_Time,
                ',activity_state=',    s_Tmp_Activity_State,
                ',gift_begin_time=',   s_Tmp_Gift_Bgn_Time,
                ',effect_period=',     s_Tmp_Effect_Period,
                ',role_begin_time=',   s_Tmp_Role_Bgn_Time,
                ',role_end_time=',     s_Tmp_Role_End_Time,
                ',activity_times_limit=',   n_Activity_Times_Limit,
                ')');

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE createActivityMaskSnapshot(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    out s_Activity_Mask_Snap    varchar(1025),
    out n_Result                integer
)
BEGIN
    declare b_Tmp_Mask          tinyblob;

    label_proc:begin
        set n_Result = 0;

        if(
          (n_Game_ID        is null) or
          (n_Activity_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            mask
        into
            b_Tmp_Mask
        from
            sys_activity_info
        where
            game_id     = n_Game_ID  and
            activity_id = n_Activity_ID;

        if( found_rows() = 0 ) then
            set n_Result = -1514;   /* PKG_UTIL.E_ACTIVITY_NOT_FOUND */
            leave label_proc;
        end if;

        select b_Tmp_Mask into s_Activity_Mask_Snap;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE createActivityGWSnapshot(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    out s_Activity_GW_Snap      varchar(4000),
    out n_Result                integer
)
BEGIN
    declare n_Stop              integer default 0;
    declare n_Temp_Activity_Id  integer;
    declare n_Temp_Gateway_Id   integer;
    declare n_Temp_Game_Id      integer;

    declare cur_Activity_GW_List cursor
    for
    select  activity_id, gateway_id, game_id
    from    sys_activity_gateway
    where   game_id     = n_Game_ID
    and     activity_id = n_Activity_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;
        set s_Activity_GW_Snap = '';

        if(
          (n_Game_ID        is null) or
          (n_Activity_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Activity_GW_List;
        label_loop:loop
            fetch cur_Activity_GW_List into n_Temp_Activity_Id, n_Temp_Gateway_Id, n_Temp_Game_Id;
            if(n_Stop = 1) then
                leave label_loop;
            end if;

            set s_Activity_GW_Snap = concat(s_Activity_GW_Snap,
                                            'SYS_ACTIVITY_GATEWAY(',
                                            'game_id=',
                                            n_Temp_Game_Id,
                                            ',activity_id=',
                                            n_Temp_Activity_Id,
                                            ',gateway_id=',
                                            n_Temp_Gateway_Id,
                                            ')');
        end loop label_loop;
        close cur_Activity_GW_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE createActivityDetailSnapshot(
    in  n_Game_ID               integer,
    in  n_Activity_ID           integer,
    out s_Total_Detail_Snap     text,
    out n_Result                integer
)
BEGIN
    declare n_RetCode           integer default 0;
    declare n_Stop              integer default 0;
    declare n_Temp_Activity_Id  integer;
    declare n_Temp_Game_Id      integer;
    declare n_Temp_Lower_Limit  integer;
    declare n_Temp_Upper_Limit  integer;
    declare n_Temp_Package_Id   integer;

    declare s_Activity_Package_Snap     varchar(4000) default '';
    declare s_Activity_Detail_Snap      varchar(4000) default '';

    declare cur_Activity_Detail_List cursor
    for
    select
        activity_id, game_id, lower_limit, upper_limit, package_id
    from
        sys_activity_detail
    where
        game_id     = n_Game_ID  and
        activity_id = n_Activity_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;
        set s_Total_Detail_Snap = '';

        if(
          (n_Game_ID        is null) or
          (n_Activity_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Activity_Detail_List;
        label_loop:loop
            fetch cur_Activity_Detail_List 
            into 
                n_Temp_Activity_Id,
                n_Temp_Game_Id,
                n_Temp_Lower_Limit,
                n_Temp_Upper_Limit,
                n_Temp_Package_Id;

            if(n_Stop = 1) then
                leave label_loop;
            end if;

            set s_Activity_Detail_Snap = concat(s_Activity_Detail_Snap,
                                                'SYS_ACTIVITY_DETAIL(',
                                                'activity_id=',
                                                n_Temp_Activity_Id,
                                                'game_id=',
                                                n_Temp_Game_Id,
                                                ',lower_limit=',
                                                n_Temp_Lower_Limit,
                                                ',upper_limit=',
                                                n_Temp_Upper_Limit,
                                                ',package_id=',
                                                n_Temp_Package_Id,
                                                ')');

            set s_Total_Detail_Snap = concat(s_Total_Detail_Snap, s_Activity_Detail_Snap);

            call createActivityPackageSnapshot(n_Temp_Package_Id,
                                               s_Activity_Package_Snap,
                                               n_RetCode);
            if(n_RetCode = 1) then
                set s_Total_Detail_Snap = concat(s_Total_Detail_Snap, s_Activity_Package_Snap);
            end if;
        end loop label_loop;
        close cur_Activity_Detail_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE createActivityPackageSnapshot(
    in  n_Package_ID                integer,
    out s_Activity_Package_Snap     varchar(4000),
    out n_Result                    integer
)
BEGIN
    declare n_Stop              integer default 0;
    declare n_Temp_Package_Id   integer;
    declare s_Temp_Item_Code    varchar(32);
    declare s_Temp_Item_Name    varchar(32);
    declare n_Temp_Item_Num     integer;

    declare cur_Activity_Package_List cursor
    for
    select
        package_id, item_code, item_name, item_num
    from
        sys_activity_package
    where
        package_id = n_Package_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;
        set s_Activity_Package_Snap = '';

        if(n_Package_ID is null) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Activity_Package_List;
        label_loop:loop
            fetch cur_Activity_Package_List
            into
                n_Temp_Package_Id,
                s_Temp_Item_Code,
                s_Temp_Item_Name,
                n_Temp_Item_Num;

            if(n_Stop = 1) then
                leave label_loop;
            end if;

            set s_Activity_Package_Snap = concat(s_Activity_Package_Snap,
                                                'SYS_ACTIVITY_PACKAGE(',
                                                'package_id=',
                                                n_Temp_Package_Id,
                                                ',item_code=',
                                                s_Temp_Item_Code,
                                                ',item_name=',
                                                s_Temp_Item_Name,
                                                ',item_num=',
                                                n_Temp_Item_Num,
                                                ')');
        end loop label_loop;
        close cur_Activity_Package_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE createConsumeDetailSnapshot(
    in  n_Game_ID           integer,
    in  n_Activity_ID       integer,
    out s_Total_Detail_Snap text,
    out n_Result            integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare n_Stop          integer default 0;

    declare n_Temp_Activity_Id  integer;
    declare n_Temp_Game_Id      integer;
    declare n_Temp_Limit_Type   integer;
    declare n_Temp_Subject_Id   integer;
    declare s_Temp_Product_Code varchar(32);
    declare n_Temp_Lower_Limit  integer;
    declare n_Temp_Upper_Limit  integer;
    declare n_Temp_Package_Id   integer;

    declare s_Activity_Package_Snap varchar(4000) default '';
    declare s_Activity_Detail_Snap  varchar(4000) default '';

    declare cur_Consume_Detail_List cursor
    for
    select
        activity_id,
        game_id,
        limit_type,
        subject_id,
        product_code,
        lower_limit,
        upper_limit,
        package_id
    from
        sys_activity_consume_detail
    where
        game_id     = n_Game_ID
    and
        activity_id = n_Activity_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;
        set s_Total_Detail_Snap = '';

        if(
          (n_Game_ID        is null) or
          (n_Activity_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Consume_Detail_List;
        label_loop:loop
            fetch cur_Consume_Detail_List
            into
                n_Temp_Activity_Id,
                n_Temp_Game_Id,
                n_Temp_Limit_Type,
                n_Temp_Subject_Id,
                s_Temp_Product_Code,
                n_Temp_Lower_Limit,
                n_Temp_Upper_Limit,
                n_Temp_Package_Id;

            if(n_Stop = 1) then
                leave label_loop;
            end if;

            set s_Activity_Detail_Snap = concat(s_Activity_Detail_Snap,
                                                'SYS_ACTIVITY_CONSUME_DETAIL(',
                                                'activity_id=',
                                                n_Temp_Activity_Id,
                                                ',game_id=',
                                                n_Temp_Game_Id,
                                                ',limit_type=',
                                                n_Temp_Limit_Type,
                                                ',subjuct_id=',
                                                n_Temp_Subject_Id,
                                                ',product_code=',
                                                s_Temp_Product_Code,
                                                ',lower_limit=',
                                                n_Temp_Lower_Limit,
                                                ',upper_limit=',
                                                n_Temp_Upper_Limit,
                                                ',package_id=',
                                                n_Temp_Package_Id,
                                                ')'
                                                );

            set s_Total_Detail_Snap = concat(s_Total_Detail_Snap, s_Activity_Detail_Snap);

            call createActivityPackageSnapshot(n_Temp_Package_Id, s_Activity_Package_Snap, n_RetCode);

            if(n_RetCode = 1) then
                set s_Total_Detail_Snap = concat(s_Total_Detail_Snap, s_Activity_Package_Snap);
            end if;
        end loop label_loop;
        close cur_Consume_Detail_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE removeActivity(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode   integer default 0;
    declare n_Stop      integer default 0;

    declare n_Temp_Package_Id       integer;
    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_State    integer;
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

    declare cur_Detail_List cursor
    for
    select
        package_id
    from
        sys_activity_detail
    where
        activity_id = n_Activity_ID
    and
        game_id = n_Game_ID;

    declare cur_Consume_Detail_List cursor
    for
    select
        package_id
    from
        sys_activity_consume_detail
    where
        activity_id = n_Activity_ID
    and
        game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        open cur_Game_ID_List;
        set n_Result = 0;

        if(
          (n_Activity_ID is null) or
          (n_Activity_ID = 1)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call judgeActivityCondition(
                                    n_Game_ID,
                                    n_Activity_ID,
                                    n_Tmp_Activity_State,
                                    n_Tmp_Activity_Type,
                                    n_RetCode);

        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if(n_Tmp_Activity_State = 2) then
            set n_Result = -1517;   /* PKG_UTIL.E_ACTIVITY_CLOSED */
            leave label_proc;
        end if;
        if (
	        (n_Tmp_Activity_Type < 5) or
	        (n_Tmp_Activity_Type > 7)
	        ) then
            -- 激活码、新手礼、冲级、渠道
            -- delete activity package
            open cur_Detail_List;
                label_loop:loop
                    set n_Stop = 0;
                    fetch cur_Detail_List
                    into n_Temp_Package_Id;

                    if(n_Stop = 1) then
                        leave label_loop;
                    end if;

                    delete from sys_activity_package
                    where package_id = n_Temp_Package_Id;
                end loop label_loop;
            close cur_Detail_List;
        else
            -- 首次消费、 累计消费、每日消费
            -- delete activity package
            open cur_Consume_Detail_List;
                label_loop:loop
                    set n_Stop = 0;
                    fetch cur_Consume_Detail_List
                    into n_Temp_Package_Id;

                    if(n_Stop = 1) then
                        leave label_loop;
                    end if;

                    delete from sys_activity_package
                    where package_id = n_Temp_Package_Id;
                end loop label_loop;
            close cur_Consume_Detail_List;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

             -- delete activity gateway
            delete from
                SYS_ACTIVITY_GATEWAY
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;

            if (
	        (n_Tmp_Activity_Type < 5) or
	        (n_Tmp_Activity_Type > 7)
	        ) then     
                -- delete activity detail
                delete from
                    sys_activity_detail
                where
                    activity_id = n_Activity_ID and
                    game_id     = n_cur_Game_ID;
            else    
                -- delete activity detail
                delete from
                    sys_activity_consume_detail
                where
                    activity_id = n_Activity_ID and
                    game_id     = n_cur_Game_ID;
            end if;

            -- delete activity
            delete from
                sys_activity_info
            where
                activity_id = n_Activity_ID and
                game_id     = n_cur_Game_ID;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE removeActivityDetail(
    in  n_Game_ID       integer,
    in  n_Activity_ID   integer,
    in  n_Package_ID    integer,
    out n_Result        integer
)
BEGIN
    declare n_RetCode   integer default 0;

    declare n_Tmp_Activity_Type     integer;
    declare n_Tmp_Activity_State    integer;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;

        if(
          (n_Activity_ID is null) or
          (n_Package_ID  is null) or
          (n_Game_ID     is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        call judgeActivityCondition(n_Game_ID,
                                    n_Activity_ID,
                                    n_Tmp_Activity_State,
                                    n_Tmp_Activity_Type,
                                    n_RetCode);
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- delete activity package
        delete from
            sys_activity_package
        where
            package_id = n_Package_ID;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            -- delete activity detail
            if (
	        (n_Tmp_Activity_Type < 5) or
	        (n_Tmp_Activity_Type > 7)
	        ) then
                delete from
                    sys_activity_detail
                where
                    ( activity_id = n_Activity_ID ) and
                    ( package_id = n_Package_ID )   and
                    ( game_id = n_cur_Game_ID );

                if( row_count() = 0 ) then
                    set n_Result = -1518;   /* PKG_UTIL.E_PACKAGE_NOT_EXIST */
                    leave label_proc;
                end if;
            else
                delete from
                    sys_activity_consume_detail
                where
                    ( activity_id = n_Activity_ID ) and
                    ( package_id = n_Package_ID )   and
                    ( game_id = n_cur_Game_ID );
                if( row_count() = 0 ) then
                    set n_Result = -1518;   /* PKG_UTIL.E_PACKAGE_NOT_EXIST */
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE useSerialNO(
    in  n_Game_ID       integer,
    in  s_Serial_NO     varchar(32),
    in  s_User_Name     varchar(32),
    in  n_User_ID       integer,
    in  n_User_IP       integer unsigned,
    in  s_Province_Code varchar(32),
    in  s_City_Code     varchar(32),
    out n_Result        integer
)
BEGIN
    declare n_RetCode   integer default 0;

    declare n_Tmp_Activity_ID       integer default 0;
    declare n_Tmp_Activity_Type     integer default 0;
    declare n_Tmp_Serial_State      integer default 0;
    declare n_Tmp_Use_Limit         integer default 0;
    declare d_Tmp_Bgn_Time          datetime;
    declare d_Tmp_End_Time          datetime;
    declare n_Tmp_Activity_State    integer default 0;
    declare d_Tmp_Gift_Bgn_Time     datetime;
    declare n_Tmp_Effect_Period     integer;
    declare n_Tmp_Flag_Bit          integer;
    declare d_Tmp_Use_Time          datetime;
    declare n_Tmp_User_Value        integer default 0;
    declare b_Tmp_Mask              tinyblob;
    declare n_Tmp_Gateway_ID        integer default 0;
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
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        open cur_Game_ID_List;
        set n_Result = 0;
        set d_Tmp_Use_Time = now();

        if (
            (s_Serial_NO      is null) or
            (s_User_Name      is null) or
            (n_User_ID        is null) or
            (n_User_IP        is null) or
            (s_Province_Code  is null) or
            (s_City_Code      is null) or
            (n_Game_ID        is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        -- verify serial_No.
        begin
            select
                activity_id,       use_limit,       serial_state
            into
                n_Tmp_Activity_ID, n_Tmp_Use_Limit, n_Tmp_Serial_State
            from
                SYS_SERIAL_NO
            where
                serial_no = s_Serial_NO and
                game_id   = n_Game_ID
            for update;

            if( found_rows() = 0) then
                set n_Result = -1481;   /* PKG_UTIL.E_USER_SERIALNO_NOT_FOUND */
                leave label_proc;
            end if;
        end;
        -- verify use times.
        if (
            (n_Tmp_Use_Limit    >  0              ) and
            (n_Tmp_Serial_State >= n_Tmp_Use_Limit)
        ) then
            set n_Result = -1482;   /* PKG_UTIL.E_USER_SERIALNO_USED */
            leave label_proc;
        end if;

        -- query activity basic info.
        begin
            select
                flag_bit,               activity_type,
                begin_time,             end_time,
                activity_state,         gift_begin_time,
                effect_period,          mask
            into
                n_Tmp_Flag_Bit,           n_Tmp_Activity_Type,
                d_Tmp_Bgn_Time,           d_Tmp_End_Time,
                n_Tmp_Activity_State,     d_Tmp_Gift_Bgn_Time,
                n_Tmp_Effect_Period,      b_Tmp_Mask
            from
                SYS_ACTIVITY_INFO
            where
                (activity_id   =  n_Tmp_Activity_ID) and
                (activity_state = 1                ) and
                (game_id       =  n_Game_ID        );

            if( found_rows() = 0 ) then
                set n_Result = -1505;   /* PKG_UTIL.E_ACTIVITY_EXPIRED */
                leave label_proc;
            end if;
        end;

        -- 激活码时间判断
        if(d_Tmp_End_Time <= d_Tmp_Use_Time) then
            set n_Result = -1483;   /* PKG_UTIL.E_USER_SERIALNO_EXPIRED:激活码过期 */
            leave label_proc;
        elseif (d_Tmp_Bgn_Time > d_Tmp_Use_Time) then
            set n_Result = -1485;   /* PKG_UTIL.E_USER_SERIALNO_NOT_STARTED:激活码未开启 */
            leave label_proc;
        end if;

        if ( d_Tmp_Gift_Bgn_Time is null ) then
           set d_Tmp_Gift_Bgn_Time = d_Tmp_Use_Time;
        end if;

        -- 获取帐号下最大角色级别，用于激活等级限制
        select
            ifnull(max(role_level), 0)
        into
            n_Tmp_User_Value
        from
            UMS_ROLE
        where
            user_id    = n_User_ID  and
            role_state = 1          and
            game_id    = n_Game_ID;

        -- 激活码活动获取活动所在网关， 用于向单网关发送道具
        if (n_Tmp_Activity_Type = 1) then
            begin
                select
                    ifnull(gateway_id,0)
                into
                    n_Tmp_Gateway_ID
                from
                    sys_activity_gateway
                where
                    game_id = n_Game_ID  and
                    activity_id = n_Tmp_Activity_ID;

                if( found_rows() > 1) then
                    set n_Result = -1562;   /* PKG_UTIL.E_ACTIVITY_GATEWAY_DIFF:网关配置冲突 */
                    leave label_proc;
                end if;
            end;
        end if;

        -- send gifts.
        call sendGifts(n_Game_ID,
                       n_User_ID,
                       0,    -- role_id
                       n_Tmp_User_Value,    -- user_value
                       n_Tmp_Gateway_ID,    -- dst gateway_id
                       n_Tmp_Activity_ID,
                       n_Tmp_Flag_Bit,
                       d_Tmp_Gift_Bgn_Time,
                       date_add(d_Tmp_Gift_Bgn_Time,interval n_Tmp_Effect_Period second),
                       b_Tmp_Mask,
                       n_RetCode
                       );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        label_loop:loop
            set n_Stop = 0;
            fetch cur_Game_ID_List into n_cur_Game_ID;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            -- modify serial_no state.
            update
                SYS_SERIAL_NO
            set
                serial_state = serial_state + 1
            where
                serial_no = s_Serial_NO and
                game_id   = n_cur_Game_ID;

            -- record use log.
            begin
                insert ignore into LOG_SERIAL_USE(
                    serial_no,      activity_id,        use_user_id,
                    use_time,       use_ip,             province_code,
                    city_code,      game_id
                )
                values(
                    s_Serial_NO,    n_Tmp_Activity_ID,  n_User_ID,
                    d_Tmp_Use_Time, n_User_IP,          s_Province_Code,
                    s_City_Code,    n_cur_Game_ID
                );

                if( row_count() = 0) then
                    set n_Result = -1414;   /* PKG_UTIL.E_USER_STATE_ACTIVATED */
                    leave label_proc;
                end if;
            end;
        end loop label_loop;

        set n_Result = 1;
    end label_proc;
    close cur_Game_ID_List;
END$$

CREATE PROCEDURE sendGifts(
    in  n_Game_ID       integer,
    in  n_User_ID       integer,
    in  n_Role_ID       integer,
    in  n_User_Value    integer,
    in  n_Gateway_ID    integer,
    in  n_Activity_ID   integer,
    in  n_Flag_Bit      integer,
    in  d_Begin_Time    datetime,
    in  d_End_Time      datetime,
    in  b_Mask          tinyblob,

    out n_Result        integer
)
BEGIN
    declare n_RetCode   integer default 0;
    declare n_Stop      integer default 0;

    declare n_Tmp_Package_ID    integer;
    declare s_Temp_Item_Code    varchar(32);
    declare n_Temp_Item_Num     integer;

    declare cur_Item_List cursor
    for
    select item_code,item_num
    from SYS_ACTIVITY_PACKAGE
    where package_id = n_Tmp_Package_ID;

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;

        if (
            (n_User_ID       is null) or
            (n_Role_ID       is null) or
            (n_User_Value    is null) or
            (n_Gateway_ID    is null) or
            (n_Activity_ID   is null) or
            (d_Begin_Time    is null) or
            (d_End_Time      is null) or
            (n_Game_ID       is null) or
            (b_Mask          is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        begin
            select
                package_id
            into
                n_Tmp_Package_ID
            from
                SYS_ACTIVITY_DETAIL
            where
                activity_id =  n_Activity_ID and
                lower_limit <= n_User_Value  and
                upper_limit >  n_User_Value  and
                game_id     =  n_Game_ID;

            if( found_rows() = 0) then
                set n_Result = -1553;   /* PKG_UTIL.E_CONDITION_NOT_SATISFIED:活动条件不满足 */
                leave label_proc;
            end if;
        end;

        -- update flag.
        call updateActivityFlag(n_Game_ID,
                                n_User_ID,
                                n_Gateway_ID,
                                n_Flag_Bit,
                                b_Mask,
                                n_RetCode);

        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- send gifts
        open cur_Item_List;
        label_loop:loop
            fetch cur_Item_List into s_Temp_Item_Code, n_Temp_Item_Num;
            if(n_Stop = 1) then
                leave label_loop;
            end if;

            call itemAdd(n_Game_ID,
                         0, -- src gateway_id
                         n_Gateway_ID,  -- dst gateway_id
                         n_Activity_ID,
                         n_User_ID,
                         n_Role_ID,
                         s_Temp_Item_Code,
                         n_Temp_Item_Num,
                         d_Begin_Time,
                         d_End_Time,
                         '0',
                         n_RetCode
                        );
            if(n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc; 
            end if;

        end loop label_loop;
        close cur_Item_List;

        insert into LOG_USER_ACTIVITY_GIFT(
            game_id,
            activity_id,    user_id,        role_id,
            gateway_id,     send_time
        )
        values(
            n_Game_ID,
            n_Activity_ID,  n_User_ID,      n_Role_ID,
            n_Gateway_ID,   now()
        );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE sendRushActivityGift(
    IN  n_Game_ID          INTEGER, 
    IN  n_User_ID          INTEGER, 
    IN  n_Role_ID          INTEGER, 
    IN  n_Role_Level       INTEGER,
    IN  n_Role_Begin_Time  datetime,
    IN  n_Role_End_Time    datetime, 
    IN  n_Gateway_ID       INTEGER, 
    IN  n_Activity_ID      INTEGER, 
    IN  n_Flag_Bit         INTEGER,
    IN  d_Begin_Time       datetime, 
    IN  d_End_Time         datetime,
    IN  b_Mask             tinyblob,

    out n_Result integer
)
BEGIN
    declare n_RetCode         integer default 0;
    declare n_Role_Max_Level  integer default 0;
    declare n_Tmp_Package_ID  integer;
    declare n_Tmp_Item_Code   varchar(32);
    declare n_Tmp_Item_Num    integer;
    declare n_Stop            integer;
    declare cur_Item_List cursor for
        select
            item_code, item_num
        from
            SYS_ACTIVITY_PACKAGE
        where
            package_id = n_Tmp_Package_ID;
    label_proc:begin
    declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        if (
            (n_User_ID         is null) or
            (n_Role_ID         is null) or
            (n_Role_Level      is null) or
            (n_Role_Begin_Time is null) or
            (n_Role_End_Time   is null) or
            (n_Gateway_ID      is null) or
            (n_Activity_ID     is null) or
            (d_Begin_Time      is null) or
            (d_End_Time        is null) or
            (n_Game_ID         is null) or
            (b_Mask            is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        -- update flag.
        call updateActivityFlag(
            n_Game_ID,
            n_User_ID,
            n_Gateway_ID,
            n_Flag_Bit,
            b_Mask,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        select
            max(role_level)
        into
            n_Role_Max_level
        from
            UMS_ROLE
        where
            user_id     =  n_User_ID    and
            gateway_id  =  n_Gateway_ID and
            create_time >= n_Role_Begin_Time and
            create_time <  n_Role_End_Time   and
            role_state  =  1     and
            game_id     =  n_Game_ID;

        -- 没有查到角色
        if (n_Role_Max_level is null) then
            set n_Result = -1252;
            leave label_proc;
        end if;

        -- if the value passed by GS is larger.
        if (n_Role_Level > n_Role_Max_level) then
            set n_Role_Max_level = n_Role_Level;
        end if;

        begin
            select
                package_id
            into
                n_Tmp_Package_ID
            from
                SYS_ACTIVITY_DETAIL
            where
                activity_id =  n_Activity_ID and
                lower_limit <= n_Role_Max_level  and
                upper_limit >  n_Role_Max_level  and
                game_id     =  n_Game_ID;
            if(found_rows()=0) then
                set n_Result = -1553;
                leave label_proc;
            end if;
        end;

        -- send gifts.
        open cur_Item_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Item_List into  n_Tmp_Item_Code, n_Tmp_Item_Num;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            call itemAdd(
                n_Game_ID,
                0, -- src gateway_id
                n_Gateway_ID, -- dst gateway_id
                n_Activity_ID,
                n_User_ID,
                n_Role_ID,
                n_Tmp_Item_Code,
                n_Tmp_Item_Num,
                d_Begin_Time,
                d_End_Time,
                '0',
                n_RetCode
            );
            if (n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end loop label_loop;
        close cur_Item_List;
        insert into LOG_USER_ACTIVITY_GIFT(
            game_id,
            activity_id,    user_id,        role_id,
            gateway_id,     send_time
        )
        values(
            n_Game_ID,
            n_Activity_ID,  n_User_ID,      n_Role_ID,
            n_Gateway_ID,   now()
        );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE sendChargeGifts(
 IN  n_Game_ID      INTEGER, 
 IN  n_User_ID      INTEGER, 
 IN  n_Role_ID      INTEGER, 
 IN  n_Gateway_ID   INTEGER,
 IN  n_Activity_ID  INTEGER, 
 IN  n_Flag_Bit     INTEGER, 
 IN  n_Package_ID   INTEGER,
 IN  d_Begin_Time   DATETIME,
 IN  d_End_Time     DATETIME, 
 OUT n_Result       INTEGER
 )
BEGIN
    declare n_RetCode         integer default 0;

    declare n_Tmp_Package_ID  integer;
    declare n_cur_item_code   varchar(32);
    declare n_cur_item_num    integer;
    declare n_Stop            integer;
    declare cur_Item_List cursor for
            select
                item_code, item_num
            from
                SYS_ACTIVITY_PACKAGE
            where
                package_id = n_Package_ID;
    label_proc:begin
    declare continue handler for not found set n_Stop = 1;
    set n_Result = 0;
        if (
            (n_Game_ID       is null) or
            (n_User_ID       is null) or
            (n_Role_ID       is null) or
            (n_Gateway_ID    is null) or
            (n_Activity_ID   is null) or
            (n_Flag_Bit      is null) or
            (n_Package_ID    is null) or
            (d_Begin_Time    is null) or
            (d_End_Time      is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        select
            package_id
        into
            n_Tmp_Package_ID
        from
            SYS_ACTIVITY_DETAIL
        where
            package_id = n_Package_ID
        and
            game_id = n_Game_ID;    
        if( found_rows() = 0 ) then
            set n_Result = -1518;       -- 礼品包不存在
            leave label_proc;
        end if;

        -- send gifts.
        open cur_Item_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Item_List into n_cur_item_code, n_cur_item_num;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            call itemAdd(
                n_Game_ID,
                0, -- src gateway_id
                n_Gateway_ID, -- dst gateway_id
                n_Activity_ID,
                n_User_ID,
                n_Role_ID,
                n_cur_item_code,
                n_cur_item_num,
                d_Begin_Time,
                d_End_Time,
                '0',
                n_RetCode
            );
            if (n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end loop;
        close cur_Item_List;

        insert into LOG_USER_ACTIVITY_GIFT(
            game_id,
            activity_id,    user_id,    role_id,    gateway_id,     send_time
        )
        values(
            n_Game_ID,
            n_Activity_ID,  n_User_ID,  n_Role_ID,  n_Gateway_ID,   now()
        );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE sendChargeActivityGifts(
 IN  n_Game_ID               INTEGER, 
 IN  n_Gateway_ID            INTEGER,
 IN  n_Activity_ID           INTEGER, 
 IN  n_Activity_Type         INTEGER, 
 IN  n_Flag_Bit              INTEGER,
 IN  d_Gift_Bgn_Time         DATETIME, 
 IN  d_Gift_End_Time         DATETIME,
 IN  d_Activity_Bgn_Time     DATETIME, 
 IN  d_Activity_End_Time     DATETIME, 
 IN  b_Mask                  TINYBLOB,
 IN  n_Activity_Times_Limit  INTEGER,
 OUT n_Result                INTEGER
 )
BEGIN
    declare n_RetCode           integer default 0;
    declare n_Last_User_ID      integer;
    declare n_draw_times_limit  integer default 0;
    declare n_Stop              integer;
    declare n_cur_user_id       integer;
    declare n_cur_package_id    integer;
        -- 每日单一充值最大值
    declare cur_Max_Charge_List cursor for
            select
                A.user_id, B.package_id
            from
            (
                select
                    user_id, charge_amount
                from
                    LOG_USER_FUND_DETAIL
                where
                    charge_time >= d_Activity_Bgn_Time and
                    charge_time <  d_Activity_End_Time and
                    game_id       =  n_Game_ID and
                    charge_type = 1 and
                    subject_id = 3  and
                    rating_id = if(n_Gateway_ID=0, rating_id, n_Gateway_ID)
                order by 
                    user_id, charge_amount desc
            )A,
            (
                select
                    lower_limit, upper_limit, package_id
                from
                    SYS_ACTIVITY_DETAIL
                where
                    activity_id  =  n_Activity_ID  and
                    game_id      =  n_Game_ID
            )B
            where
                A.charge_amount  >= B.lower_limit and
                A.charge_amount  <  B.upper_limit;
        -- 累计充值
    declare cur_Assum_Charge_List cursor for
            select
                A.user_id, B.package_id
            from
            (
                select
                    user_id, sum(charge_amount) summ
                from
                    LOG_USER_FUND_DETAIL
                where
                    charge_time >= d_Activity_Bgn_Time and
                    charge_time <  d_Activity_End_Time and
                    game_id       =  n_Game_ID and
                    charge_type = 1 and
                    subject_id = 3  and
                    rating_id = if(n_Gateway_ID=0, rating_id, n_Gateway_ID)
                group by
                    user_id
            )A,
            (
                select
                    lower_limit, upper_limit, package_id
                from
                    SYS_ACTIVITY_DETAIL
                where
                    activity_id  = n_Activity_ID  and
                    game_id      = n_Game_ID
            )B
            where
                A.summ       >= B.lower_limit and
                A.summ       <  B.upper_limit;
    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        if (
            (n_Game_ID              is null) or
            (n_Activity_ID          is null) or
            (n_Gateway_ID           is null) or
            (n_Activity_Type        is null) or
            (n_Activity_Type        <= 8   ) or
            (n_Activity_Type        >  11  ) or
            (n_Flag_Bit             is null) or
            (n_Flag_Bit             <  0   ) or
            (d_Gift_Bgn_Time        is null) or
            (d_Gift_End_Time        is null) or
            (d_Activity_Bgn_Time    is null) or
            (d_Activity_End_Time    is null) or
            (n_Activity_Times_Limit is null) or
            (b_Mask                 is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;
        -- 每日充值最大值 一定数量奖励
        if( n_Activity_Type = 9 ) then
            set n_Last_User_ID = 0;
            open cur_Max_Charge_List;
            label_loop:loop
                set n_Stop = 0;
                fetch cur_Max_Charge_List into n_cur_user_id, n_cur_package_id;
                if (n_Stop = 1) then
                    leave label_loop;
                end if;            
                if (n_Last_User_ID = n_cur_user_id) then
                    if( n_draw_times_limit >= n_Activity_Times_Limit ) then
                        set n_Last_User_ID = n_cur_user_id;
                        iterate label_loop;
                    end if;
                    set n_draw_times_limit = n_draw_times_limit + 1;           
                    call sendChargeGifts(
                       n_Game_ID,
                       n_cur_user_id,
                       0,                             -- role_id
                       n_Gateway_ID,                  -- gateway_id
                       n_Activity_ID,                 -- activity_id
                       n_Flag_Bit,                    -- flag_bit
                       n_cur_package_id,              -- package_id
                       d_Gift_Bgn_Time,               -- gift_begin_time
                       d_Gift_End_Time,               -- gift_end_time
                       n_RetCode
                    );
                    if (n_RetCode <> 1) then
                        set n_Result = n_RetCode;
                        leave label_proc;
                    end if;
                    set n_Last_User_ID = n_cur_user_id;
                    iterate label_loop;
                end if;
                if (n_Last_User_ID <> n_cur_user_id) then
                -- update flag.
                    set n_draw_times_limit = 1;
                    call updateActivityFlag(
                        n_Game_ID,
                        n_cur_user_id,
                        n_Gateway_ID,
                        n_Flag_Bit,
                        b_Mask,
                        n_RetCode
                    );
                    if (n_RetCode <> 1) then
                        if (n_RetCode = -1414) then
                        -- 已经发送过
                            set n_Last_User_ID = n_cur_user_id;
                            iterate label_loop;
                        else
                            set n_Result = n_RetCode;
                            leave label_proc;
                        end if;
                    end if;
                end if;

                call sendChargeGifts(
                           n_Game_ID,
                           n_cur_user_id,
                           0,                             -- role_id
                           n_Gateway_ID,                  -- gateway_id
                           n_Activity_ID,                 -- activity_id
                           n_Flag_Bit,                    -- flag_bit
                           n_cur_package_id,    -- package_id
                           d_Gift_Bgn_Time,               -- gift_begin_time
                           d_Gift_End_Time,                -- gift_end_time
                           n_RetCode
                );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;

                set n_Last_User_ID = n_cur_user_id;
            end loop label_loop;
            close cur_Max_Charge_List;
      
            open cur_Max_Charge_List;
            label_loop:loop
                set n_Stop = 0;
                fetch cur_Max_Charge_List into n_cur_user_id, n_cur_package_id;
                if (n_Stop = 1) then
                    leave label_loop;
                end if;
            -- 清除活动标志
                call clearActivityFlag(
                         n_Game_ID,
                         n_cur_user_id,
                         n_Gateway_ID,
                         n_Flag_Bit,
                         n_RetCode
                );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end loop label_loop;
            close cur_Max_Charge_List;

         -- 累计充值 一定数量 奖励
         elseif(
         ( n_Activity_Type = 10 ) or 
         ( n_Activity_Type = 11 )
         ) then
            set n_Last_User_ID = 0;
            open cur_Assum_Charge_List;
            label_loop:loop
                set n_Stop = 0;
                fetch cur_Assum_Charge_List into n_cur_user_id, n_cur_package_id;
                if (n_Stop = 1) then
                    leave label_loop;
                end if;
                if (n_Last_User_ID <> n_cur_user_id) then
                -- update flag.
                    call updateActivityFlag(
                        n_Game_ID,
                        n_cur_user_id,
                        n_Gateway_ID,
                        n_Flag_Bit,
                        b_Mask,
                        n_RetCode
                    );
                    if (n_RetCode <> 1) then
                        if (n_RetCode = -1414) then
                        -- 已经发送过
                            set n_Last_User_ID = n_cur_user_id;
                            iterate label_loop;
                        else
                            set n_Result = n_RetCode;
                            leave label_proc;
                        end if;
                    end if;
                end if;

                call sendChargeGifts(
                           n_Game_ID,
                           n_cur_user_id,                 -- user_id
                           0,                             -- role_id
                           n_Gateway_ID,                  -- gateway_id
                           n_Activity_ID,                 -- activity_id
                           n_Flag_Bit,                    -- flag_bit
                           n_cur_package_id,              -- package_id
                           d_Gift_Bgn_Time,               -- gift_begin_time
                           d_Gift_End_Time,               -- gift_end_time
                           n_RetCode
            );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;

                set n_Last_User_ID = n_cur_user_id;
            end loop label_loop;
            close cur_Assum_Charge_List;
      
            open cur_Assum_Charge_List;
            label_loop:loop
                set n_Stop = 0;
                fetch cur_Assum_Charge_List into n_cur_user_id, n_cur_package_id;
                if (n_Stop = 1) then
                    leave label_loop;
                end if;
                call clearActivityFlag(
                         n_Game_ID,
                         n_cur_user_id,
                         n_Gateway_ID,
                         n_Flag_Bit,
                         n_RetCode
                );

                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end loop label_loop;
            close cur_Assum_Charge_List;
        end if;
        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE dailyMaxChargeActivity(
OUT n_Result   INTEGER
)
BEGIN
    declare n_RetCode                   integer default 0;

    declare d_Stat_Start_Time           datetime default now();
    declare d_Stat_End_Time             datetime;
    declare d_Tmp_Day                   date;
    declare d_Bgn_Time                  datetime;
    declare d_End_Time                  datetime;
    declare n_Ret_Stat_Flag             integer;
    declare n_Limit_Type                integer;
    declare d_Tmp_Gift_Bgn_Time         datetime;

    declare n_cur_Activity_ID           integer;
    declare n_cur_Flag_Bit              integer;
    declare d_cur_Gift_Bgn_Time         datetime;
    declare n_cur_effect_period         integer;
    declare d_cur_Bgn_Time              datetime;
    declare d_cur_End_Time              datetime;
    declare b_cur_mask                  tinyblob;
    declare n_cur_game_id               integer;
    declare n_cur_activity_times_limit  integer;
    declare n_cur_gateway_id            integer;
    declare n_Stop                      integer;

    declare cur_Activity_List cursor for
        select
            activity_id,        flag_bit,
            gift_begin_time,    effect_period,
            begin_time,         end_time,
            mask,               game_id,
            activity_times_limit
        from
            SYS_ACTIVITY_INFO
        where
            activity_type = 9 and
            activity_state = 1 and
            end_time > d_Tmp_Day;

    declare cur_Gateway_List cursor for
        select
            gateway_id
        from
            SYS_ACTIVITY_GATEWAY
        where
            activity_id = n_cur_Activity_ID and
            game_id = n_cur_game_id;

     label_proc:begin
        
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        set d_Tmp_Day = date(adddate(now(),-1));
        -- 记录定时任务信息
        call getStatStateAndLocked(
            d_Tmp_Day,
            'DAILY_MAX_CHARGE_ACTIVITY',
            n_Ret_Stat_Flag,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Ret_Stat_Flag = 1) then
            set n_Result = 1;
            leave label_proc;
        end if;


        open cur_Activity_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Activity_List into n_cur_Activity_ID, n_cur_Flag_Bit, d_cur_Gift_Bgn_Time, n_cur_effect_period, 
            d_cur_Bgn_Time, d_cur_End_Time, b_cur_mask, n_cur_game_id, n_cur_activity_times_limit;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            if ( d_cur_Gift_Bgn_Time is null ) then
                set d_Tmp_Gift_Bgn_Time = d_Stat_Start_Time;
            else
                set d_Tmp_Gift_Bgn_Time = d_cur_Gift_Bgn_Time;
            end if;

            if (d_cur_Bgn_Time >= d_Tmp_Day) then
                set d_Bgn_Time = d_cur_Bgn_Time;
            else
                set d_Bgn_Time = d_Tmp_Day;
            end if;

            set d_End_Time = date(adddate(d_Tmp_Day,1));
            if (d_cur_End_Time < d_End_Time) then
                set d_End_Time = d_cur_End_Time;
            end if;

            open cur_Gateway_List;
            label_Gateway_loop:loop
                set n_Stop = 0;
                fetch cur_Gateway_List into n_cur_gateway_id;
                if( n_Stop = 1) then
                    leave label_Gateway_loop;
                end if;
                call sendChargeActivityGifts(
                        n_cur_game_id,
                        n_cur_gateway_id,
                        n_cur_Activity_ID,
                        9,     -- activity_type
                        n_cur_Flag_Bit,
                        d_Tmp_Gift_Bgn_Time,
                        from_unixtime(unix_timestamp(d_Tmp_Gift_Bgn_Time) + n_cur_effect_period),
                        d_Bgn_Time,
                        d_End_Time,
                        b_cur_mask,
                        n_cur_activity_times_limit,
                        n_RetCode
                );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end loop label_Gateway_loop;
            close cur_Gateway_List;    
        end loop label_loop;
        close cur_Activity_List;

        -- 更新定时任务信息
        set d_Stat_End_Time = now();
        call setStatState(
            d_Tmp_Day,
            'DAILY_MAX_CHARGE_ACTIVITY',
            d_Stat_Start_Time,
            d_Stat_End_Time,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        set n_Result = 1;
     end label_proc;
END$$

CREATE PROCEDURE dailyAccumChargeActivity( 
OUT n_Result   INTEGER
)
BEGIN
    declare n_RetCode                  integer default 0;

    declare d_Stat_Start_Time          datetime default now();
    declare d_Stat_End_Time            datetime;
    declare d_Tmp_Day                  date;
    declare d_Bgn_Time                 datetime;
    declare d_End_Time                 datetime;

    declare n_Ret_Stat_Flag            integer;
    declare n_Limit_Type               integer;
    declare d_Tmp_Gift_Bgn_Time        datetime;
    declare n_cur_Activity_ID          integer;
    declare n_cur_Flag_Bit             integer;
    declare d_cur_Gift_Bgn_Time        datetime;
    declare n_cur_effect_period        integer;
    declare d_cur_Bgn_Time             datetime;
    declare d_cur_End_Time             datetime;
    declare b_cur_mask                 tinyblob;
    declare n_cur_game_id              integer;
    declare n_cur_activity_times_limit integer;
    declare n_cur_gateway_id           integer;
    declare n_Stop                     integer;

        --  每日活动信息
    declare cur_Activity_List cursor for
        select
            activity_id,        flag_bit,
            gift_begin_time,    effect_period,
            begin_time,         end_time,
            mask,               game_id,
            activity_times_limit
        from
            SYS_ACTIVITY_INFO
        where
            activity_type = 10 and
            activity_state = 1 and
            end_time > d_Tmp_Day;

    declare cur_Gateway_List cursor for
        select
            gateway_id
        from
            SYS_ACTIVITY_GATEWAY
        where
            activity_id = n_cur_Activity_ID and
            game_id = n_cur_game_id;

    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        set d_Tmp_Day = date(adddate(now(),-1));
        -- 记录定时任务信息
        call getStatStateAndLocked(
            d_Tmp_Day,
            'DAILY_ACCUM_CHARGE_ACTIVITY',
            n_Ret_Stat_Flag,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Ret_Stat_Flag = 1) then
            set n_Result = 1;
            leave label_proc;
        end if;

        open cur_Activity_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Activity_List into n_cur_Activity_ID, n_cur_Flag_Bit, d_cur_Gift_Bgn_Time, n_cur_effect_period, 
            d_cur_Bgn_Time, d_cur_End_Time, b_cur_mask, n_cur_game_id, n_cur_activity_times_limit;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            if ( d_cur_Gift_Bgn_Time is null ) then
                set d_Tmp_Gift_Bgn_Time = d_Stat_Start_Time;
            else
                set d_Tmp_Gift_Bgn_Time = d_cur_Gift_Bgn_Time;
            end if;

            if (d_cur_Bgn_Time >= d_Tmp_Day) then
                set d_Bgn_Time = d_cur_Bgn_Time;
            else
                set d_Bgn_Time = d_Tmp_Day;
            end if;

            set d_End_Time = date(adddate(d_Tmp_Day,1));
            if (d_cur_End_Time < d_End_Time) then
                set d_End_Time = d_cur_End_Time;
            end if;

             open cur_Gateway_List;
             label_Gateway_loop:loop
                set n_Stop = 0;
                fetch cur_Gateway_List into n_cur_gateway_id;
                if( n_Stop = 1) then
                    leave label_Gateway_loop;
                end if;   
                call sendChargeActivityGifts(
                        n_cur_game_id,
                        n_cur_gateway_id,
                        n_cur_Activity_ID,
                        10,     -- activity_type
                        n_cur_Flag_Bit,
                        d_Tmp_Gift_Bgn_Time,
                        from_unixtime(unix_timestamp(d_Tmp_Gift_Bgn_Time) + n_cur_effect_period),
                        d_Bgn_Time,
                        d_End_Time,
                        b_cur_mask,
                        n_cur_activity_times_limit,
                        n_RetCode
                );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end loop label_Gateway_loop;
            close cur_Gateway_List;    
        end loop label_loop;
        close cur_Activity_List;

        -- 更新定时任务信息
        set d_Stat_End_Time = now();
        call setStatState(
            d_Tmp_Day,
            'DAILY_ACCUM_CHARGE_ACTIVITY',
            d_Stat_Start_Time,
            d_Stat_End_Time,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE PeriodAccumChargeActivity( 
OUT n_Result  INTEGER
)
BEGIN
    declare n_RetCode                  integer default 0;

    declare d_Stat_Start_Time          datetime default now();
    declare d_Stat_End_Time            datetime;
    declare d_Tmp_Day                  date;
    declare n_Ret_Stat_Flag            integer;
    declare n_Limit_Type               integer;
    declare d_Tmp_Gift_Bgn_Time        datetime;

    declare n_cur_Activity_ID          integer;
    declare n_cur_Flag_Bit             integer;
    declare d_cur_Gift_Bgn_Time        datetime;
    declare n_cur_effect_period        integer;
    declare d_cur_Bgn_Time             datetime;
    declare d_cur_End_Time             datetime;
    declare b_cur_mask                 tinyblob;
    declare n_cur_game_id              integer;
    declare n_cur_activity_times_limit integer;
    declare n_cur_gateway_id           integer;
    declare n_Stop                     integer;

        --  每日活动信息
    declare cur_Activity_List cursor for
        select
            activity_id,        flag_bit,
            gift_begin_time,    effect_period,
            begin_time,         end_time,
            mask,               game_id,
            activity_times_limit
        from
            SYS_ACTIVITY_INFO
        where
            activity_type = 11 and
            activity_state = 1 and
            date(adddate(end_time,1)) = CURDATE();

    declare cur_Gateway_List cursor for
        select
            gateway_id
        from
            SYS_ACTIVITY_GATEWAY
        where
            activity_id = n_cur_Activity_ID and
            game_id = n_cur_game_id;

    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        set d_Tmp_Day = date(adddate(now(),-1));
        -- 记录定时任务信息
        call getStatStateAndLocked(
            d_Tmp_Day,
            'PERIOD_ACCUM_CHARGE_ACTIVITY',
            n_Ret_Stat_Flag,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Ret_Stat_Flag = 1) then
            set n_Result = 1;
            leave label_proc;
        end if;

        open cur_Activity_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Activity_List into n_cur_Activity_ID, n_cur_Flag_Bit, d_cur_Gift_Bgn_Time, n_cur_effect_period, 
            d_cur_Bgn_Time, d_cur_End_Time, b_cur_mask, n_cur_game_id, n_cur_activity_times_limit;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            if ( d_cur_Gift_Bgn_Time is null ) then
               set d_Tmp_Gift_Bgn_Time = d_Stat_Start_Time;
            else
               set d_Tmp_Gift_Bgn_Time = d_cur_Gift_Bgn_Time;
            end if;

            open cur_Gateway_List;
             label_Gateway_loop:loop
                set n_Stop = 0;
                fetch cur_Gateway_List into n_cur_gateway_id;
                if( n_Stop = 1) then
                    leave label_Gateway_loop;
                end if;
                call sendChargeActivityGifts(
                        n_cur_game_id,
                        n_cur_gateway_id,
                        n_cur_Activity_ID,
                        11,     -- activity_type
                        n_cur_Flag_Bit,
                        d_Tmp_Gift_Bgn_Time,
                        from_unixtime(unix_timestamp(d_Tmp_Gift_Bgn_Time) + n_cur_effect_period),
                        d_cur_Bgn_Time,
                        d_cur_End_Time,
                        b_cur_mask,
                        n_cur_activity_times_limit,
                        n_RetCode
                );
                if (n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    leave label_proc;
                end if;
            end loop label_Gateway_loop;
            close cur_Gateway_List;    
        end loop label_loop;
        close cur_Activity_List;

        -- 更新定时任务信息
        set d_Stat_End_Time = now();
        call setStatState(
            d_Tmp_Day,
            'PERIOD_ACCUM_CHARGE_ACTIVITY',
            d_Stat_Start_Time,
            d_Stat_End_Time,
            n_RetCode
        );
        if (n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;
        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getActivityInfoList
(
in  n_Game_Id           integer,
in  n_Page_Index        integer,
in  n_Page_Size         integer,
out n_Ret_Total_Items   integer,
out n_Result            integer
)
BEGIN
    declare s_Temp_Game_Name varchar(32);
    label_proc:begin
        set n_Result = 0;
        set n_Ret_Total_Items = 0;

        if(
           (n_Game_Id is null) or
           (n_Page_Index is null ) or
           (n_Page_Size is null)
        )then
            set n_Result = -100;
            leave label_proc;
        end if;

        select game_name
        into s_Temp_Game_Name
        from sys_game_id
        where game_id = n_Game_Id;

        if(found_rows() = 0) then
            set n_Result = -1122;
            leave label_proc;
        end if;

        select ifnull(count(*),0)
        into n_Ret_Total_Items
        from sys_activity_info
        where game_id = n_Game_Id;

        if(found_rows() = 0) then
            set n_Result = 0;
            leave label_proc;
        end if;

        set @n_Page_Index = n_Page_Index*n_Page_Size;
        set @n_Page_Size = n_Page_Size;
        set @s_Temp_Game_Name = s_Temp_Game_Name;
        set @n_Game_Id = n_Game_Id;

        prepare s_Sql_Text from '
            select
                activity_id,    flag_bit,       activity_name,
                activity_type,
                DATE_FORMAT(begin_time,"%Y-%m-%d %H:%i:%s") as begin_time,
                DATE_FORMAT(end_time,"%Y-%m-%d %H:%i:%s") as end_time,
                DATE_FORMAT(gift_begin_time,"%Y-%m-%d %H:%i:%s") as gift_begin_time,
                effect_period,
                DATE_FORMAT(role_begin_time,"%Y-%m-%d %H:%i:%s") as role_begin_time,
                role_end_time,  activity_state, ? as game_name,
                game_id
            from
                sys_activity_info
            where
                game_id = ?
            limit ?, ?';
            execute s_Sql_Text using @s_Temp_Game_Name, @n_Game_Id, @n_Page_Index, @n_Page_Size;

            deallocate prepare s_Sql_Text;
        if(found_rows() = 0) then
            set n_Result = 0;
            leave label_proc;
        end if;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE checkGifts(
IN  n_Game_ID     INTEGER,
IN  n_User_ID     INTEGER,
IN  n_Gateway_ID  INTEGER,
IN  n_Role_ID     INTEGER,
IN  n_Role_Level  INTEGER,
OUT n_Result      INTEGER
)
BEGIN
    declare d_Tmp_Gift_Bgn_Time      datetime default now();
    declare d_Tmp_Use_Time           datetime default now();
    declare n_Tmp_Gateway_Count      integer;
    declare n_Tmp_Gateway_Id         integer;
    declare n_Stop                   integer;
    declare n_cur_Activity_ID        integer;
    declare n_cur_Activity_type      integer;
    declare n_cur_flag_bit           integer;
    declare d_cur_Gift_Begin_Time    datetime;
    declare n_cur_effect_period      integer;
    declare d_cur_Role_Begin_Time    datetime;
    declare d_cur_Role_End_Time      datetime;
    declare d_cur_Begin_Time         datetime;
    declare d_cur_End_Time           datetime;
    declare n_cur_mask               tinyblob;
    declare n_RetCode                integer default 0;
    declare s_Tmp_Beginner           varchar(32);
    declare n_Tmp_User_Value         integer;
    declare cur_Activity_List cursor for
        select
            activity_id,        activity_type,
            flag_bit,           gift_begin_time,
            effect_period,      role_begin_time,
            role_end_time,      begin_time,
            end_time,           mask
        from
            SYS_ACTIVITY_INFO
        where
            begin_time    <= d_Tmp_Use_Time and
            end_time      >  d_Tmp_Use_Time and
            activity_state = 1              and
            game_id       =  n_Game_ID      and
            activity_type  in (2, 3, 5);

    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        if (
            (n_User_ID    is null) or
            (n_Gateway_ID is null) or
            (n_Gateway_ID <= 0   ) or
            (n_Game_ID    is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        open cur_Activity_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Activity_List into n_cur_Activity_ID,n_cur_Activity_type,n_cur_flag_bit,d_cur_Gift_Begin_Time,
            n_cur_effect_period,d_cur_Role_Begin_Time,d_cur_Role_End_Time,d_cur_Begin_Time,d_cur_End_Time,n_cur_mask;
            if (n_Stop = 1) then
                leave label_loop;
            end if;
            -- 检查本区组是否在活动范围内
            select
                count(gateway_id)
            into
                n_Tmp_Gateway_Count
            from
                SYS_ACTIVITY_GATEWAY
            where
                activity_id =  n_cur_Activity_ID and
                gateway_id  in ( n_Gateway_ID, 0 ) and
                game_id     =  n_Game_ID;
            if(n_Tmp_Gateway_Count <> 1) then
                iterate label_loop;
            end if;

            if ( d_cur_Gift_Begin_Time is null ) then
                set d_Tmp_Gift_Bgn_Time = d_Tmp_Use_Time;
            else
                set d_Tmp_Gift_Bgn_Time = d_cur_Gift_Begin_Time;
            end if;

            -- 冲级
            if (n_cur_Activity_type = 3) then
                start transaction;
                call sendRushActivityGift(
                    n_Game_ID,
                    n_User_ID,
                    0,    -- role_id
                    n_Role_Level,
                    d_cur_Role_Begin_Time,
                    d_cur_Role_End_Time,
                    n_Gateway_ID,
                    n_cur_Activity_ID,
                    n_cur_flag_bit,
                    d_Tmp_Gift_Bgn_Time,
                    from_unixtime(unix_timestamp(d_Tmp_Gift_Bgn_Time) + n_cur_effect_period),
                    n_cur_mask,
                    n_RetCode
                );
                if( 1 = n_RetCode ) then
                    commit;
                else
                    rollback;
                end if;
                iterate label_loop;
            -- 首次消费
            elseif (n_cur_Activity_type = 5) then
                call firstConsumeRealTime(
                                          n_Game_ID,
                                          n_User_ID,
                                          n_cur_Activity_ID,
                                          n_cur_flag_bit,
                                          d_cur_Begin_Time,
                                          d_cur_End_Time,
                                          d_Tmp_Gift_Bgn_Time,
                                          date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                                          n_cur_mask,
                                          n_RetCode
                                         );
                if( 1 = n_RetCode ) then
                    commit;
                else
                    rollback;
                end if;
                iterate label_loop;

            elseif (n_cur_Activity_type = 2) then
                set n_Tmp_Gateway_Id = 0;

                call getOptionValue( n_Game_ID, 'beginner_activity', null, s_Tmp_Beginner);
                if(s_Tmp_Beginner <> '1') then
                    iterate label_loop;
                end if;

                begin
                    select 1
                    into n_Tmp_User_Value
                    from ums_user
                    where user_id = n_User_ID
                    and user_name like 'lk%'
                    and game_id = n_Game_ID;

                    if(found_rows() = 0) then
                        iterate label_loop;
                    end if;
                end;
            end if;

            -- send gift
            call sendGifts(
                           n_Game_ID,
                           n_User_ID,
                           0,
                           n_Tmp_User_Value,
                           n_Tmp_Gateway_ID,
                           n_cur_Activity_ID,
                           n_cur_flag_bit,
                           d_Tmp_Gift_Bgn_Time,
                           date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                           n_cur_mask,
                           n_RetCode);

            if(n_RetCode = 1) then
                commit;
            else
                rollback;
            end if;

        end loop label_loop;
        close cur_Activity_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE firstChargeRealTime(
IN  n_Game_ID        INTEGER, 
IN  s_User_Name      VARCHAR(255), 
IN  n_Gateway_ID     INTEGER,
IN  n_Charge_Amount  INTEGER, 
OUT n_Result         INTEGER
)
BEGIN
    declare n_RetCode                   integer  default 0;
    declare n_Tmp_Package_ID            integer;
    declare n_Tmp_User_ID               integer;
    declare n_Tmp_Count                 integer;
    declare n_cur_Activity_ID           integer;
    declare n_cur_Flag_Bit              integer;
    declare d_cur_Gift_Bgn_Time         datetime;
    declare n_cur_effect_period         integer;
    declare b_cur_mask                  tinyblob;
    declare n_Tmp_Gateway_ID            integer;
    declare n_Stop                      integer;
    declare cur_Activity_List cursor for
        select
            activity_id,        flag_bit,
            gift_begin_time,    effect_period,
            mask
        from
            SYS_ACTIVITY_INFO
        where
            activity_type = 12 and
            activity_state = 1 and
            end_time > now() and
            begin_time <= now() and
            game_id = n_Game_ID;

    label_proc:begin
        declare continue handler for not found set n_Stop = 1;
        set n_Result = 0;
        if(
            (n_Game_ID is null ) or
            (s_User_Name is null ) or
            (n_Gateway_ID is null ) or
            (n_Charge_Amount is null)
        ) then
            set n_Result = -100;
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

        open cur_Activity_List;
        label_loop:loop
            set n_Stop = 0;
            fetch cur_Activity_List into n_cur_Activity_ID, n_cur_Flag_Bit, d_cur_Gift_Bgn_Time, n_cur_effect_period, 
            b_cur_mask;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            select
                package_id
            into
                n_Tmp_Package_ID
            from
                SYS_ACTIVITY_DETAIL
            where
                activity_id  = n_cur_Activity_ID  and
                game_id      = n_Game_ID and
                n_Charge_Amount >= lower_limit and
                n_Charge_Amount <  upper_limit;
            if(found_rows()=0) then
                set n_Result = -1518;
                leave label_proc;
            end if;
            
            select
                gateway_id
            into
                n_Tmp_Gateway_ID
            from
                SYS_ACTIVITY_GATEWAY
            where
                activity_id =  n_cur_Activity_ID and
                gateway_id  in ( n_Gateway_ID, 0 ) and
                game_id     =  n_Game_ID;
            if(found_rows() = 0) then
                leave label_loop;
            end if;

            select
                count(*)
            into
                n_Tmp_Count
            from
                LOG_USER_FUND_DETAIL   
            where
                user_id = n_Tmp_User_ID and
                game_id = n_Game_ID and
                subject_id = 3 and
                charge_type = 1 and
                rating_id = if(n_Tmp_Gateway_ID=0, rating_id, n_Tmp_Gateway_ID);
            if(n_Tmp_Count <> 1) then
                set n_Result = 1;
                leave label_proc;    
            end if;
            call updateActivityFlag(
                        n_Game_ID,
                        n_Tmp_User_ID,
                        n_Tmp_Gateway_ID,
                        n_cur_Flag_Bit,
                        b_cur_mask,
                        n_RetCode
            );
            if (1 <> n_RetCode) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
            call sendChargeGifts(
                        n_Game_ID,
                        n_Tmp_User_ID,          -- user_id
                        0,                      -- role_id
                        n_Tmp_Gateway_ID,           -- gateway_id
                        n_cur_Activity_ID,      -- activity_id
                        n_cur_Flag_Bit,         -- flag_bit
                        n_Tmp_Package_ID,       -- package_id
                        d_cur_Gift_Bgn_Time,    -- gift_bgn_time
                        from_unixtime(unix_timestamp(d_cur_Gift_Bgn_Time)+n_cur_effect_period),     -- gift_end_time
                        n_RetCode
            );
            if (n_RetCode <> 1) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end loop label_loop;
        close cur_Activity_List;

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE getActivityGatewayById(
in n_activityId    integer,
in n_gameId        integer
)
BEGIN
    label_proc:begin
        if(
            (n_activityId is null ) or
            (n_gameId     is null )
        ) then
            leave label_proc;
        end if;

	    SELECT gateway_id 
	    FROM sys_activity_gateway
	    WHERE activity_id = n_activityId
        AND game_id = n_gameId;
    end label_proc;
END$$

CREATE PROCEDURE getActivityInfoById(
in  n_activityId    integer,
in  n_activityType  integer,
in  n_gameId        integer
)
BEGIN
    label_proc:begin
        if(
            (n_activityId   is null ) or
            (n_activityType is null ) or
            (n_gameId       is null)
        ) then
            leave label_proc;
        end if;

        SELECT
        game_id, activity_id, activity_name, activity_type,
        DATE_FORMAT(begin_time,'%Y-%m-%d %H:%i:%s') as begin_time, 
        DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') as end_time,
        activity_state,
        DATE_FORMAT(gift_begin_time,'%Y-%m-%d %H:%i:%s') as gift_begin_time,
        effect_period,
        DATE_FORMAT(role_begin_time,'%Y-%m-%d %H:%i:%s') as role_begin_time,
        DATE_FORMAT(role_end_time,'%Y-%m-%d %H:%i:%s') as role_end_time
        FROM sys_activity_info
        WHERE activity_id = n_activityId
        and game_id = n_gameId
        and activity_type = n_activityType;
    end label_proc;
END$$

CREATE PROCEDURE getActivityDetailInfo(
in  n_activityId    integer,
in  n_gameId        integer
)
BEGIN
    label_proc:begin
        if(
            (n_activityId is null ) or
            (n_gameId     is null )
        ) then
            leave label_proc;
        end if;

        SELECT
        upper_limit, lower_limit, package_id
        FROM sys_activity_detail
        WHERE activity_id = n_activityId
        AND game_id = n_gameId;
    end label_proc;
END$$

CREATE PROCEDURE cmpMask(
in  b_Mask_First    tinyblob,
in  b_Mask_Second   tinyblob,
out n_Result        integer
)
BEGIN
    declare n_Counter    integer default 1;
    declare n_Tmp1       integer default 0;
    declare n_Tmp2       integer default 0;
    label_proc:begin
        set n_Result=0;
        if
        (
          (b_Mask_First  is null ) or
          (b_Mask_Second is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        label_loop:loop
            if(n_Counter > 255) then
                leave label_loop;
            end if;

            set n_Tmp1 = ascii(substring(b_Mask_First, n_Counter, 1));
            set n_Tmp2 = ascii(substring(b_Mask_Second, n_Counter, 1));

            if((n_Tmp1&n_Tmp2) <> 0) then
                set n_Result = 1;
                leave label_proc;
            end if;

            set n_Counter=n_Counter+1;
        end loop label_loop;
        set n_Result=0;
    end label_proc;
END$$

CREATE PROCEDURE initMask(
in  n_Flag_Bit      integer,
out b_ReMask        tinyblob,
out n_Result        integer
)
BEGIN
    declare n_Tmp_Result      integer default 0;
    declare n_Tmp_Remain      integer default 0;
    label_proc:begin
        set n_Result=0;
        if
        (
          (n_Flag_Bit is null) or
          (n_Flag_Bit < 1    ) or
          (n_Flag_Bit > 2040 )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Tmp_Result = n_Flag_Bit div 8;
        set n_Tmp_Remain = n_Flag_Bit % 8;
        if(n_Tmp_Remain = 0) then
            set n_Tmp_Result = n_Tmp_Result - 1;
            set n_Tmp_Remain = 8;
        end if;

        set b_ReMask = rpad('', n_Tmp_Result, 0x00);
        set b_ReMask = concat(b_ReMask, char(pow(2, 8-n_Tmp_Remain)));
        set b_ReMask = rpad(b_ReMask, 255, 0x00);

        set n_Result=1;
    end label_proc;
END$$

CREATE PROCEDURE setBit(
in  n_Flag_Bit      integer,
in  b_InMask        tinyblob,
out b_ReMask        tinyblob,
out n_Result        integer
)
BEGIN
    declare b_Tmp_Head                  tinyblob;
    declare b_Tmp_End                   tinyblob;
    declare n_Tmp_Result                integer default 0;
    declare n_Tmp_Remain                integer default 0;
    declare n_Tmp                       integer default 0;
    declare n_Tmp1                      integer default 0;
    label_proc:begin
        set n_Result=0;
        if
        (
          (n_Flag_Bit is null ) or
          (n_Flag_Bit < 1     ) or
          (n_Flag_Bit > 2040  ) or
          (b_InMask   is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Tmp_Result = n_Flag_Bit div 8;
        set n_Tmp_Remain = n_Flag_Bit % 8;
        if(n_Tmp_Remain = 0) then
            set n_Tmp_Result = n_Tmp_Result-1;
            set n_Tmp_Remain = 8;
        end if;

        set n_Tmp = pow(2, 8-n_Tmp_Remain);
        set b_Tmp_Head = substring(b_InMask, 1, n_Tmp_Result);
        set b_Tmp_End = substring(b_InMask, n_Tmp_Result+2, 254-n_Tmp_Result);

        set n_Tmp1 = ascii(substring(b_InMask, n_Tmp_Result+1, 1));
        set n_Tmp = n_Tmp1+n_Tmp-(n_Tmp1&n_Tmp);
        set b_ReMask = concat(b_Tmp_Head, char(n_Tmp), b_Tmp_End);

        set n_Result=1;
    end label_proc;
END$$

CREATE PROCEDURE clearBit(
in  n_Flag_Bit      integer,
in  b_InMask        tinyblob,
out b_ReMask        tinyblob,
out n_Result        integer
)
BEGIN
    declare b_Tmp_Head                  tinyblob;
    declare b_Tmp_End                   tinyblob;
    declare n_Tmp_Result                integer default 0;
    declare n_Tmp_Remain                integer default 0;
    declare n_Tmp                       integer default 0;
    declare n_Tmp1                      integer default 0;
    label_proc:begin
        set n_Result=0;
        if
        (
          (n_Flag_Bit is null ) or
          (n_Flag_Bit < 1     ) or
          (n_Flag_Bit > 2040  ) or
          (b_InMask   is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Tmp_Result = n_Flag_Bit div 8;
        set n_Tmp_Remain = n_Flag_Bit % 8;
        if(n_Tmp_Remain = 0) then
            set n_Tmp_Result = n_Tmp_Result-1;
            set n_Tmp_Remain = 8;
        end if;

        set n_Tmp = pow(2, 8-n_Tmp_Remain);
        set b_Tmp_Head = substring(b_InMask, 1, n_Tmp_Result);
        set b_Tmp_End = substring(b_InMask, n_Tmp_Result+2, 254-n_Tmp_Result);

        set n_Tmp1 = ascii(substring(b_InMask, n_Tmp_Result+1, 1));
        set n_Tmp1 = n_Tmp1 - (n_Tmp1&n_Tmp);
        set b_ReMask = concat(b_Tmp_Head, char(n_Tmp1), b_Tmp_End);

        set n_Result=1;
    end label_proc;
END$$

CREATE FUNCTION returnBit(
n_Flag_Bit    integer,
b_Mask        tinyblob
)returns integer
BEGIN
    declare n_Tmp_Result                integer default 0;
    declare n_Tmp_Remain                integer default 0;
    declare n_Tmp                       integer default 0;

    if
    (
      (n_Flag_Bit is null ) or
      (n_Flag_Bit < 1     ) or
      (n_Flag_Bit > 2040  ) or
      (b_Mask     is null )
    ) then
        return -100;
    end if;

    set n_Tmp_Result = n_Flag_Bit div 8;
    set n_Tmp_Remain = n_Flag_Bit % 8;
    if(n_Tmp_Remain = 0) then
        set n_Tmp_Result = n_Tmp_Result-1;
        set n_Tmp_Remain = 8;
    end if;

    set n_Tmp = ascii(substring(b_Mask, n_Tmp_Result+1, 1));
    if((n_Tmp&pow(2, 8-n_Tmp_Remain)) <> 0) then
        return 1;
    end if;

    return 0;
END$$

CREATE PROCEDURE copyMask(
in  b_Mask_First   tinyblob,
in  b_Mask_Second  tinyblob,
out b_Re_Mask      tinyblob,
out n_Result       integer
)
BEGIN
    declare n_Counter    integer default 1;
    declare n_Tmp1       integer default 0;
    declare n_Tmp2       integer default 0;
    declare n_Tmp3       integer default 0;
    declare b_Tmp_Mask   tinyblob;
    label_proc:begin
        set n_Result=0;
        if
        (
          (b_Mask_First  is null ) or
          (b_Mask_Second is null )
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set b_Tmp_Mask = '';

        label_loop:loop
            if(n_Counter > 255) then
                leave label_loop;
            end if;

            set n_Tmp1 = ascii(substring(b_Mask_First, n_Counter, 1));
            set n_Tmp2 = ascii(substring(b_Mask_Second, n_Counter, 1));

            set n_Tmp3 = n_Tmp1|n_Tmp2;
            set b_Tmp_Mask = concat(b_Tmp_Mask, char(n_Tmp3));
            set n_Counter=n_Counter+1;
        end loop label_loop;

        set b_Re_Mask = b_Tmp_Mask;
        set n_Result=1;
    end label_proc;
END$$

-- 发送消费促消奖励接口
CREATE PROCEDURE sendConsumeGifts
(
  in  n_Game_ID        integer,
  in  n_User_ID        integer,
  in  n_Role_ID        integer,
  in  n_Gateway_ID     integer,
  in  n_Activity_ID    integer,
  in  n_Flag_Bit       integer,
  in  n_Package_ID     integer,
  in  d_Begin_Time     datetime,
  in  d_End_Time       datetime,
  out n_Result         integer
)
BEGIN
    declare n_RetCode            integer default 0;
    declare n_Stop               integer default 0;
    declare n_Temp_Package_ID    integer;

    declare s_Temp_Item_Code     varchar(32) default '';
    declare n_Temp_Item_Num      integer default 0;

    declare cur_Item_List cursor for
        select item_code, item_num
        from sys_activity_package
        where package_id = n_Package_ID;

    label_proc:begin
        if(
         (n_Game_ID           is null) or
         (n_User_ID           is null) or
         (n_Role_ID           is null) or
         (n_Gateway_ID        is null) or
         (n_Activity_ID       is null) or
         (n_Flag_Bit          is null) or
         (n_Package_ID        is null) or
         (d_Begin_Time        is null) or
         (d_End_Time          is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Result = 0;

        begin
            declare exit handler for not found set n_Result = -1518;

            select package_id
            into n_Temp_Package_ID
            from sys_activity_consume_detail
            where package_id = n_Package_ID
            and   game_id    = n_Game_ID;
        end;

        if(n_Result = -1518) then
            leave label_proc;
        end if;

        -- send gifts
        begin
            declare continue handler for not found set n_Stop = 1;
            open cur_Item_List;

            label_loop:loop
                fetch cur_Item_List into s_Temp_Item_Code, n_Temp_Item_Num;
                if(n_Stop = 1) then
                    leave label_loop;
                end if;

                if(s_Temp_Item_Code = 's-point') then
                    call pointAdd(
                                 n_Game_ID,
                                 n_User_ID,
                                 n_Temp_Item_Num,
                                 n_RetCode
                                 );
                else
                    call itemAdd(
                                 n_Game_ID,
                                 0,              -- src gateway_id
                                 n_Gateway_ID,   -- dst gateway_id
                                 n_Activity_ID,
                                 n_User_ID,
                                 n_Role_ID,
                                 s_Temp_Item_Code,
                                 n_Temp_Item_Num,
                                 d_Begin_Time,
                                 d_End_Time,
                                 '0',
                                 n_RetCode
                                );
                end if;

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Item_List;
                    leave label_proc;
                end if;
            end loop label_loop;

            close cur_Item_List;
        end;

        insert into log_user_activity_gift(
            game_id,
            activity_id,    user_id,    role_id,    gateway_id,     send_time
        )
        values(
            n_Game_ID,
            n_Activity_ID,  n_User_ID,  n_Role_ID,  n_Gateway_ID,   now()
        );

        set n_Result = 1;
    end label_proc;
END$$

CREATE PROCEDURE accumConsumeActivity(
    in  d_Time          datetime,
    out n_Result        integer
)
BEGIN
    declare n_RetCode                  integer default 0;
    declare n_Stop                     integer default 0;
    declare d_Stat_Start_Time          datetime default now();
    declare d_Tmp_Day                  datetime;
    declare n_Ret_Stat_Flag            integer;
    declare n_Limit_Type               integer;
    declare d_Tmp_Gift_Bgn_Time        datetime;

    declare n_cur_activity_id              integer;
    declare n_cur_game_id                  integer;
    declare n_cur_flag_bit                 integer;
    declare d_cur_gift_begin_time          datetime;
    declare n_cur_effect_period            integer;
    declare d_cur_begin_time               datetime;
    declare d_cur_end_time                 datetime;
    declare b_cur_mask                     tinyblob;

    -- 累计消费活动信息
    declare cur_Activity_List cursor for
        select
            activity_id,        game_id,
            flag_bit,
            gift_begin_time,    effect_period,
            begin_time,         end_time,
            mask
        from
            sys_activity_info
        where
            (activity_type   = 6           ) and
            (activity_state  = 1           ) and
            (end_time        >= timestamp(date(d_Tmp_Day))) and
            (end_time        <  timestamp(date(adddate(now(), 1))));

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;

        if(d_Time is null) then
            set d_Tmp_Day = timestamp(date(adddate(now(), -1)));
        else
            set d_Tmp_Day = timestamp(date(d_Time));
        end if;

        call getStatStateAndLocked(
                                   d_Tmp_Day,
                                   'ACCUM_CONSUME_ACTIVITY',
                                   n_Ret_Stat_Flag,
                                   n_RetCode
                                   );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if(n_Ret_Stat_Flag = 1) then
            set n_Result=1;
            leave label_proc;
        end if;

        open cur_Activity_List;

        label_loop:loop
            fetch cur_Activity_List into
            n_cur_activity_id, n_cur_game_id, n_cur_flag_bit,
            d_cur_gift_begin_time, n_cur_effect_period, d_cur_begin_time,
            d_cur_end_time, b_cur_mask;

            if (n_Stop = 1) then
                leave label_loop;
            end if;

            begin
                declare exit handler for 1172 set n_Result = -1519;
                declare exit handler for not found set n_Result = -1555;

                select distinct limit_type
                into n_Limit_Type
                from sys_activity_consume_detail
                where activity_id = n_cur_activity_id;
            end;

            if(
               (n_Result = -1519) or
               (n_Result = -1555)
            ) then
                close cur_Activity_List;
                leave label_proc;
            end if;

            if(d_cur_gift_begin_time is null) then
                set d_Tmp_Gift_Bgn_Time = d_Stat_Start_Time;
            else
                set d_Tmp_Gift_Bgn_Time = d_cur_gift_begin_time;
            end if;

            if(n_Limit_Type = 1) then
                call sendItemCountGifts(
                                        n_cur_game_id,
                                        n_cur_activity_id,
                                        6,
                                        n_cur_flag_bit,
                                        d_Tmp_Gift_Bgn_Time,
                                        date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                                        d_cur_begin_time,
                                        d_cur_end_time,
                                        b_cur_mask,
                                        n_RetCode
                                       );

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Activity_List;
                    leave label_proc;
                end if;
            elseif(n_Limit_Type = 2) then
                call sendItemAmountGifts(
                                        n_cur_game_id,
                                        n_cur_activity_id,
                                        6,
                                        n_cur_flag_bit,
                                        d_Tmp_Gift_Bgn_Time,
                                        date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                                        d_cur_begin_time,
                                        d_cur_end_time,
                                        b_cur_mask,
                                        n_RetCode
                                       );

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Activity_List;
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        close cur_Activity_List;

        call setStatState(
                          d_Tmp_Day,
                          'ACCUM_CONSUME_ACTIVITY',
                          d_Stat_Start_Time,
                          now(),
                          n_RetCode
                          );

        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result=1;
    end label_proc;

    if(n_Result = 1) then
        commit;
    else
        rollback;
    end if;

END$$

CREATE PROCEDURE dailyConsumeActivity
(
    in  d_Time          datetime,
    out n_Result        integer
)
BEGIN
    declare n_RetCode            integer  default 0;
    declare n_Stop               integer  default 0;
    declare d_Stat_Start_Time    datetime default now();
    declare d_Tmp_Day            datetime;
    declare d_Bgn_Time           datetime;
    declare d_End_Time           datetime;

    declare n_Ret_Stat_Flag      integer;
    declare n_Limit_Type         integer;
    declare d_Tmp_Gift_Bgn_Time  datetime;

    declare n_cur_activity_id       integer;
    declare n_cur_flag_bit          integer;
    declare d_cur_gift_begin_time   datetime;
    declare n_cur_effect_period     integer;
    declare d_cur_begin_time        datetime;
    declare d_cur_end_time          datetime;
    declare b_cur_mask              tinyblob;
    declare n_cur_game_id           integer;

    declare cur_Activity_List cursor for
        select
            activity_id,   game_id,    flag_bit,
            gift_begin_time, effect_period, begin_time, end_time,mask
        from  sys_activity_info
        where activity_type  = 7
        and   activity_state = 1
        and   end_time > timestamp(date(d_Tmp_Day));

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Result = 0;

        if(d_Time is null) then
            set d_Tmp_Day = timestamp(date(adddate(now(), -1)));
        else
            set d_Tmp_Day = timestamp(date(d_Time));
        end if;

        call getStatStateAndLocked(
                                   d_Tmp_Day,
                                   'DAILY_CONSUME_ACTIVITY',
                                   n_Ret_Stat_Flag,
                                   n_RetCode
                                   );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if(n_Ret_Stat_Flag = 1) then
            set n_Result=1;
            leave label_proc;
        end if;

        open cur_Activity_List;
        label_loop:loop
            fetch cur_Activity_List into
            n_cur_activity_id, n_cur_game_id, n_cur_flag_bit,
            d_cur_gift_begin_time, n_cur_effect_period, d_cur_begin_time,
            d_cur_end_time, b_cur_mask;

            if (n_Stop = 1) then
                leave label_loop;
            end if;

            begin
                declare exit handler for 1172 set n_Result = -1519;
                declare exit handler for not found set n_Result = -1555;

                select distinct limit_type
                into n_Limit_Type
                from sys_activity_consume_detail
                where activity_id = n_cur_activity_id;
            end;

            if(
               (n_Result = -1519) or
               (n_Result = -1555)
            ) then
                close cur_Activity_List;
                leave label_proc;
            end if;

            if(d_cur_gift_begin_time is null) then
                set d_Tmp_Gift_Bgn_Time = d_Stat_Start_Time;
            else
                set d_Tmp_Gift_Bgn_Time = d_cur_gift_begin_time;
            end if;

            if(d_cur_begin_time >= d_Tmp_Day) then
                set d_Bgn_Time = d_cur_begin_time;
            else
                set d_Bgn_Time = d_Tmp_Day;
            end if;

            set d_End_Time = adddate(d_Tmp_Day, 1);

            if(d_cur_end_time < d_End_Time) then
                set d_End_Time = d_cur_end_time;
            end if;

            if(n_Limit_Type = 1) then
                call sendItemCountGifts(
                                        n_cur_game_id,
                                        n_cur_activity_id,
                                        7,
                                        n_cur_flag_bit,
                                        d_Tmp_Gift_Bgn_Time,
                                        date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                                        d_Bgn_Time,
                                        d_End_Time,
                                        b_cur_mask,
                                        n_RetCode
                                       );

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Activity_List;
                    leave label_proc;
                end if;
            elseif(n_Limit_Type = 2) then
                call sendItemAmountGifts(
                                        n_cur_game_id,
                                        n_cur_activity_id,
                                        7,
                                        n_cur_flag_bit,
                                        d_Tmp_Gift_Bgn_Time,
                                        date_add(d_Tmp_Gift_Bgn_Time, interval n_cur_effect_period second),
                                        d_Bgn_Time,
                                        d_End_Time,
                                        b_cur_mask,
                                        n_RetCode
                                       );

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Activity_List;
                    leave label_proc;
                end if;
            end if;
        end loop label_loop;

        close cur_Activity_List;

        call setStatState(
                          d_Tmp_Day,
                          'DAILY_CONSUME_ACTIVITY',
                          d_Stat_Start_Time,
                          now(),
                          n_RetCode
                          );

        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result=1;
    end label_proc;

    if(n_Result =1) then
        commit;
    else
        rollback;
    end if;

END$$

CREATE PROCEDURE firstConsumeRealTime
(
  in  n_Game_ID              integer,
  in  n_User_ID              integer,
  in  n_Activity_ID          integer,
  in  n_Flag_Bit             integer,
  in  d_Bgn_Time             datetime,
  in  d_End_Time             datetime,
  in  d_Gift_Bgn_Time        datetime,
  in  d_Gift_End_Time        datetime,
  in  b_Mask                 tinyblob,
  out n_Result               integer
)
BEGIN
    declare n_RetCode            integer default 0;
    declare n_Stop               integer default 0;
    declare n_Tmp_Subject_ID     integer;
    declare n_Tmp_Package_ID     integer;
    declare n_Tmp_Count          integer default 0;

    label_proc:begin
        if(
           (n_Game_ID        is null) or
           (n_User_ID        is null) or
           (n_Activity_ID    is null) or
           (n_Flag_Bit       is null) or
           (d_Bgn_Time       is null) or
           (d_End_Time       is null) or
           (d_Gift_Bgn_Time  is null) or
           (d_Gift_End_Time  is null) or
           (b_Mask           is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Result = 0;

        begin
            declare exit handler for 1172 set n_Result = -1557;
            declare exit handler for not found set n_Result = -1555;

            select subject_id, package_id
            into n_Tmp_Subject_ID, n_Tmp_Package_ID
            from sys_activity_consume_detail
            where activity_id  = n_Activity_ID
            and   product_code = 'ALL'
            and   game_id      = n_Game_ID;
        end;

        select count(*)
        into n_Tmp_Count
        from ums_user_purchase_detail
        where user_id       =  n_User_ID
        and   subject_id    =  n_Tmp_Subject_ID
        and   purchase_time >= d_Bgn_Time
        and   purchase_time <  d_End_Time
        and   game_id       =  n_Game_ID;

        if(n_Tmp_Count = 0) then
            set n_Result = -1553;
            leave label_proc;
        end if;

        call updateActivityFlag(
                                n_Game_ID,
                                n_User_ID,
                                0,
                                n_Flag_Bit,
                                b_Mask,
                                n_RetCode
                               );
        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        call sendConsumeGifts(
                              n_Game_ID,
                              n_User_ID,
                              0,
                              0,
                              n_Activity_ID,
                              n_Flag_Bit,
                              n_Tmp_Package_ID,
                              d_Gift_Bgn_Time,
                              d_Gift_End_Time,
                              n_RetCode
                             );

        if(n_RetCode <> 1) then
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        set n_Result = 1;
    end;
END;

-- limit_type=1 道具数量为条件 发送奖励
CREATE PROCEDURE sendItemCountGifts
(
    in  n_Game_ID            integer,
    in  n_Activity_ID        integer,
    in  n_Activity_Type      integer,
    in  n_Flag_Bit           integer,
    in  d_Gift_Bgn_Time      datetime,
    in  d_Gift_End_Time      datetime,
    in  d_Purchase_Bgn_Time  datetime,
    in  d_Purchase_End_Time  datetime,
    in  b_Mask               tinyblob,
    out n_Result             integer
)
BEGIN
    declare n_RetCode            integer default 0;
    declare n_Stop               integer default 0;

    declare n_Last_User_ID       integer default 0;
    declare n_Temp_User_ID       integer;
    declare n_Temp_Package_ID    integer;
    -- 单一物品 累计数量
    declare cur_Single_List cursor for
        select
            A.user_id, B.package_id
        from
        (
            select
                user_id, product_code, subject_id, sum(product_num) summ
            from
                ums_user_purchase_detail
            where
                purchase_time >= d_Purchase_Bgn_Time and
                purchase_time <  d_Purchase_End_Time and
                game_id       =  n_Game_ID
            group by
                user_id, product_code, subject_id
        )A,
        (
            select
                subject_id, product_code, lower_limit, upper_limit, package_id
            from
                sys_activity_consume_detail p
            where
                activity_id  =  n_Activity_ID  and
                product_code <> 'ALL'          and
                limit_type   = 1               and
                game_id      =  n_Game_ID
        )B
        where
            A.summ         >= B.lower_limit and
            A.summ         <  B.upper_limit and
            A.subject_id   =  B.subject_id  and
            A.product_code =  B.product_code;

    -- 所有物品 累计数量
    declare cur_All_List cursor for
        select
            A.user_id, B.package_id
        from
        (
            select
                user_id, sum(product_num) summ, subject_id
            from
                ums_user_purchase_detail
            where
                purchase_time >= d_Purchase_Bgn_Time and
                purchase_time <  d_Purchase_End_Time and
                game_id       =  n_Game_ID
            group by
                user_id, subject_id
        )A,
        (
            select
                subject_id, lower_limit, upper_limit, package_id
            from
                sys_activity_consume_detail
            where
                activity_id  = n_Activity_ID  and
                product_code = 'ALL'          and
                limit_type   = 1              and
                game_id      = n_Game_ID
        )B
        where
            A.subject_id =  B.subject_id  and
            A.summ       >= B.lower_limit and
            A.summ       <  B.upper_limit;

        declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        if(
         (n_Game_ID           is null) or
         (n_Activity_ID       is null) or
         (n_Activity_Type     is null) or
         (n_Activity_Type     <= 5   ) or
         (n_Flag_Bit          is null) or
         (n_Flag_Bit          <  0   ) or
         (d_Gift_Bgn_Time     is null) or
         (d_Gift_End_Time     is null) or
         (d_Purchase_Bgn_Time is null) or
         (d_Purchase_End_Time is null) or
         (b_Mask              is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Result = 0;

        begin
            open cur_Single_List;

            label_loop:loop
                fetch cur_Single_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                label_next:begin
                    if(n_Last_User_ID <> n_Temp_User_ID) then
                        commit;

                        call updateActivityFlag(
                                                n_Game_ID,
                                                n_Temp_User_ID,
                                                0,
                                                n_Flag_Bit,
                                                b_Mask,
                                                n_RetCode
                                                );

                        if(n_RetCode <> 1) then
                            if(n_RetCode = -1414) then
                                leave label_next;
                            else
                                set n_Result = n_RetCode;
                                close cur_Single_List;
                                leave label_proc;
                            end if;
                        end if;
                    end if;

                    call sendConsumeGifts(
                                      n_Game_ID,
                                      n_Temp_User_ID,
                                      0,
                                      0,
                                      n_Activity_ID,
                                      n_Flag_Bit,
                                      n_Temp_Package_ID,
                                      d_Gift_Bgn_Time,
                                      d_Gift_End_Time,
                                      n_RetCode
                                      );

                    if(n_RetCode <> 1) then
                        set n_Result = n_RetCode;
                        close cur_Single_List;
                        leave label_proc;
                    end if;

                end label_next;

                set n_Last_User_ID = n_Temp_User_ID;
            end loop label_loop;

            close cur_Single_List;
            commit;

            set n_Stop = 0;
            open cur_Single_List;
            label_loop:loop
                fetch cur_Single_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                call clearActivityFlag(n_Game_ID, n_Temp_User_ID, 0, n_Flag_Bit, n_RetCode);

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Single_List;
                    leave label_proc;
                end if;
            end loop label_loop;
            close cur_Single_List;
        end;

        begin
            set n_Last_User_ID = 0;

            set n_Stop = 0;
            open cur_All_List;

            label_loop:loop
                fetch cur_All_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                label_next:begin
                    if(n_Last_User_ID <> n_Temp_User_ID) then
                        commit;

                        call updateActivityFlag(
                                                n_Game_ID,
                                                n_Temp_User_ID,
                                                0,
                                                n_Flag_Bit,
                                                b_Mask,
                                                n_RetCode
                                                );

                        if(n_RetCode <> 1) then
                            if(n_RetCode = -1414) then
                                leave label_next;
                            else
                                set n_Result = n_RetCode;
                                close cur_All_List;
                                leave label_proc;
                            end if;
                        end if;
                    end if;

                    call sendConsumeGifts(
                                          n_Game_ID,
                                          n_Temp_User_ID,
                                          0,
                                          0,
                                          n_Activity_ID,
                                          n_Flag_Bit,
                                          n_Temp_Package_ID,
                                          d_Gift_Bgn_Time,
                                          d_Gift_End_Time,
                                          n_RetCode
                                          );

                    if(n_RetCode <> 1) then
                        set n_Result = n_RetCode;
                        close cur_All_List;
                        leave label_proc;
                    end if;

                end label_next;

                set n_Last_User_ID = n_Temp_User_ID;
            end loop label_loop;

            close cur_All_List;
            commit;

            set n_Stop = 0;
            open cur_All_List;
            label_loop:loop
                fetch cur_All_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                call clearActivityFlag(n_Game_ID, n_Temp_User_ID, 0, n_Flag_Bit, n_RetCode);

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_All_List;
                    leave label_loop;
                end if;
            end loop label_loop;
            close cur_All_List;
        end;

        set n_Result = 1;
    end label_proc;
END$$

-- limit_type = 2 消费金额为条件 发放奖励
CREATE PROCEDURE sendItemAmountGifts
(
  in  n_Game_ID           integer,
  in  n_Activity_ID       integer,
  in  n_Activity_Type     integer,
  in  n_Flag_Bit          integer,
  in  d_Gift_Bgn_Time     datetime,
  in  d_Gift_End_Time     datetime,
  in  d_Purchase_Bgn_Time datetime,
  in  d_Purchase_End_Time datetime,
  in  b_Mask              tinyblob,
  out n_Result            integer
)
BEGIN
    declare n_RetCode         integer default 0;
    declare n_Last_User_ID    integer default 0;
    declare n_Stop            integer default 0;

    declare n_Temp_User_ID    integer;
    declare n_Temp_Package_ID integer;

    -- 单一物品 累计金额
    declare cur_Single_List cursor for
        select
            A.user_id, B.package_id
        from
        (
            select
                user_id, product_code, subject_id, sum(cost_amount) summ
            from
                ums_user_purchase_detail
            where
                purchase_time >= d_Purchase_Bgn_Time and
                purchase_time <  d_Purchase_End_Time and
                game_id       =  n_Game_ID
            group by
                user_id, product_code, subject_id
        )A,
        (
            select
                subject_id, product_code, lower_limit, upper_limit, package_id
            from
                sys_activity_consume_detail
            where
                activity_id  =  n_Activity_ID  and
                product_code <> 'ALL'          and
                limit_type   = 2               and
                game_id      =  n_Game_ID
        )B
        where
            A.summ         >= B.lower_limit and
            A.summ         <  B.upper_limit and
            A.subject_id   =  B.subject_id  and
            A.product_code =  B.product_code;

    -- 所有物品 累计金额
    declare cur_All_List cursor for
        select
            A.user_id, B.package_id
        from
        (
            select
                user_id, sum(cost_amount) summ, subject_id
            from
                ums_user_purchase_detail
            where
                purchase_time >= d_Purchase_Bgn_Time and
                purchase_time <  d_Purchase_End_Time and
                game_id       =  n_Game_ID
            group by
                user_id, subject_id
        )A,
        (
            select
                subject_id, lower_limit, upper_limit, package_id
            from
                sys_activity_consume_detail
            where
                activity_id  = n_Activity_ID  and
                product_code = 'ALL'          and
                limit_type   = 2              and
                game_id      = n_Game_ID
        )B
        where
            A.subject_id =  B.subject_id  and
            A.summ       >= B.lower_limit and
            A.summ       <  B.upper_limit;

            declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        if(
         (n_Game_ID            is null) or
         (n_Activity_ID        is null) or
         (n_Activity_Type      is null) or
         (n_Activity_Type      <= 5   ) or
         (n_Flag_Bit           is null) or
         (n_Flag_Bit           <  0   ) or
         (d_Gift_Bgn_Time      is null) or
         (d_Gift_End_Time      is null) or
         (d_Purchase_Bgn_Time  is null) or
         (d_Purchase_End_Time  is null) or
         (b_Mask               is null)
        ) then
            set n_Result = -100;
            leave label_proc;
        end if;

        set n_Result = 0;

        -- 发放单一物品 一定金额 奖励
        begin
            open cur_Single_List;

            label_loop:loop
                fetch cur_Single_List into n_Temp_User_ID, n_Temp_Package_ID;
                if(n_Stop = 1) then
                    leave label_loop;
                end if;

                label_next:begin
                    if(n_Last_User_ID <> n_Temp_User_ID) then
                        commit;

                        call updateActivityFlag(
                                            n_Game_ID,
                                            n_Temp_User_ID,
                                            0,
                                            n_Flag_Bit,
                                            b_Mask,
                                            n_RetCode
                                            );

                        if(n_RetCode <> 1) then
                            if(n_RetCode = -1414) then
                                leave label_next;
                            else
                                set n_Result = n_RetCode;
                                close cur_Single_List;
                                leave label_proc;
                            end if;
                        end if;
                    end if;

                    call sendConsumeGifts(
                                          n_Game_ID,
                                          n_Temp_User_ID,
                                          0,
                                          0,
                                          n_Activity_ID,
                                          n_Flag_Bit,
                                          n_Temp_Package_ID,
                                          d_Gift_Bgn_Time,
                                          d_Gift_End_Time,
                                          n_RetCode
                                         );

                    if(n_RetCode <> 1) then
                        set n_Result = n_RetCode;
                        close cur_Single_List;
                        leave label_proc;
                    end if;

                end label_next;

                set n_Last_User_ID = n_Temp_User_ID;
            end loop label_loop;
            close cur_Single_List;
            commit;

            set n_Stop = 0;
            open cur_Single_List;
            label_loop:loop
                fetch cur_Single_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                call clearActivityFlag(n_Game_ID, n_Temp_User_ID, 0, n_Flag_Bit, n_RetCode);

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_Single_List;
                    leave label_proc;
                end if;
            end loop label_loop;
            close cur_Single_List;

        end;

        begin
            set n_Last_User_ID = 0;

            set n_Stop = 0;
            open cur_All_List;

            label_loop:loop
                fetch cur_All_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                label_next:begin
                    if(n_Last_User_ID <> n_Temp_User_ID) then
                        commit;
                        -- update flag
                        call updateActivityFlag(
                                                n_Game_ID,
                                                n_Temp_User_ID,
                                                0,
                                                n_Flag_Bit,
                                                b_Mask,
                                                n_RetCode
                                                );

                        if(n_RetCode <> 1) then
                            if(n_RetCode = -1414) then
                                leave label_next;
                            else
                                set n_Result = n_RetCode;
                                close cur_All_List;
                                leave label_proc;
                            end if;
                        end if;
                    end if;

                    call sendConsumeGifts(
                                          n_Game_ID,
                                          n_Temp_User_ID,
                                          0,
                                          0,
                                          n_Activity_ID,
                                          n_Flag_Bit,
                                          n_Temp_Package_ID,
                                          d_Gift_Bgn_Time,
                                          d_Gift_End_Time,
                                          n_RetCode
                                          );

                    if(n_RetCode <> 1) then
                        set n_Result = n_RetCode;
                        close cur_All_List;
                        leave label_proc;
                    end if;

                end label_next;

                set n_Last_User_ID = n_Temp_User_ID;
            end loop label_loop;

            close cur_All_List;
            commit;

            set n_Stop = 0;
            open cur_All_List;
            label_loop:loop
                fetch cur_All_List into n_Temp_User_ID, n_Temp_Package_ID;
                if( n_Stop = 1) then
                    leave label_loop;
                end if;

                call clearActivityFlag(n_Game_ID, n_Temp_User_ID, 0, n_Flag_Bit, n_RetCode);

                if(n_RetCode <> 1) then
                    set n_Result = n_RetCode;
                    close cur_All_List;
                    leave label_loop;
                end if;
            end loop label_loop;
            close cur_All_List;

        end;

        set n_Result = 1;
    end label_proc;
END$$

DELIMITER ;
