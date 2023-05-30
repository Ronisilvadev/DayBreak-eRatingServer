DROP PROCEDURE addOptionInfo;
DROP PROCEDURE getOptionInfo;
DROP PROCEDURE updateOptionValue;
DROP PROCEDURE getOptionValue;
DROP PROCEDURE getOptionList;
DROP PROCEDURE addUserIntoBlack;
DROP PROCEDURE delUserFromBlack;
DROP PROCEDURE addLevelStage;
DROP PROCEDURE modifyLevelStage;
DROP PROCEDURE delLevelStage;
DROP PROCEDURE getGameIDListAndUnionAuthMsg;
DELIMITER $$

CREATE PROCEDURE addOptionInfo (
    in  s_Code        varchar(32),
    in  s_Value       varchar(32),
    in  s_Description varchar(256),

    out n_Result      integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = -100; /* E_PARAMETER_ERROR Can't write, because of unique constraint */
        set n_Result = 0;  /* E_ERROR */
        if (
            (s_Code      is null)  or
            (s_Value     is null)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into  SYS_OPTION_INFO (
            option_code,      option_value,      description
            ) values (
            s_Code,    s_Value,    s_Description
        );
        set n_Result = 1;/*S_SUCCESS*/
    end label_proc;
END$$

CREATE PROCEDURE getOptionInfo (
    in  s_Code    varchar(32),

    out n_Result  integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;  /* E_ERROR */
        if (s_Code       is null) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select option_value, description
        from   SYS_OPTION_INFO
        where  option_code    = s_Code;

        set n_Result = 1;/*S_SUCCESS*/
    end label_proc;
END$$

-- 增加option_code
CREATE PROCEDURE  updateOptionValue (
    in  n_Game_ID  integer,
    in  s_Code     varchar(32),
    in  s_Name     varchar(64),
    in  s_Value    varchar(32),

    out n_Result  integer
)
BEGIN
    label_proc:begin
        declare exit handler for 1062 set n_Result = -100; /* E_PARAMETER_ERROR write failed, unique constraint */
        declare exit handler for 1452 set n_Result = -100; /* E_PARAMETER_ERROR write failed, foreign key */
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID   is null) or
            (s_Code      is null) or
            (s_Name      is null) or
            (s_Value     is null)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into SYS_OPTION (
            option_code,    option_name,      option_value,    game_id
        ) values (
            s_Code,  s_Name,    s_Value,    n_Game_ID
        )on duplicate key update option_name = s_Name, option_value = s_Value;

        set n_Result = 1;/*S_SUCCESS*/
    end label_proc;
END$$

-- 获取选项值
CREATE PROCEDURE   getOptionValue (
    in  n_Game_ID          integer,
    in  s_Para_Code        varchar(32),
    in  s_Default_Value    varchar(32),

    out s_Option_Value     varchar(32)
)
BEGIN
    label_proc:begin
        if (
            (n_Game_ID     is null) or
            (s_Para_Code   is null)
        ) then
            set s_Option_Value = s_Default_Value;
            leave label_proc;
        end if;

        select option_value
        into   s_Option_Value
        from   SYS_OPTION
        where  option_code = s_Para_Code
        and    game_id     = n_Game_ID ;

        if (0 = FOUND_ROWS()) then
            set s_Option_Value = s_Default_Value;
        end if;
    end label_proc;
END$$

CREATE PROCEDURE  getOptionList (
    in  n_Game_ID     integer,

    out n_Result      integer
)
BEGIN
    label_proc:begin
        set n_Result = 0;  /* E_ERROR */
        if (n_Game_ID is null) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select o.option_name, o.option_code
        from   SYS_OPTION o
        where o.game_id = n_Game_ID;

        set n_Result = 1;/*S_SUCCESS*/
    end label_proc;
END$$

-- 将user加入黑名单
CREATE PROCEDURE addUserIntoBlack (
    in  n_Game_ID         integer,
    in  s_User_Name       varchar(32),
    in  n_User_Type       integer,

    out n_Result          integer
)
BEGIN
    declare n_Tmp_User_ID integer unsigned default 0;
     label_proc:begin
        declare exit handler for 1062 set n_Result = 1; /*  unique constraint */
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (s_User_Name   is null) or
            (n_User_Type   is null)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select user_id
        into   n_Tmp_User_ID
        from   UMS_USER
        where  user_name = s_User_Name
        and    game_id   = n_Game_ID;

        if (0 = FOUND_ROWS()) then
            set n_Result = -1406;   /* E_USER_ACCOUNT_ERROR */
        end if;

        insert into SYS_BLACKLIST (
            user_id,    user_type,    game_id
        ) values (
            n_Tmp_User_ID,  n_User_Type,  n_Game_ID
        );

        set n_Result = 1; /* S_SUCCESS */
    end label_proc;
END$$

-- 在黑名单里删除user
CREATE PROCEDURE delUserFromBlack (
    in  n_Game_ID          integer,
    in  n_User_ID          integer unsigned,
    in  n_User_Type        integer,

    out n_Result           integer
)
BEGIN
     label_proc:begin
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (n_User_ID     is null) or
            (n_User_Type   is null)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        delete from SYS_BLACKLIST
        where  user_id   = n_User_ID  and
               user_type = n_User_Type and
               game_id   = n_Game_ID;

        set n_Result = 1; /* S_SUCCESS */
    end label_proc;
END$$


-- 增加级别分段
CREATE PROCEDURE addLevelStage (
    in  n_Game_ID          integer,
    in  n_Level            integer,
    in  n_Bgn_Level        integer,
    in  n_End_Level        integer,

    out n_Result           integer
)
BEGIN
    declare n_Count                integer default 0;
     label_proc:begin
        declare exit handler for 1062 set n_Result = 1; /*  unique constraint */
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (n_Level       is null) or
            (n_Bgn_Level   is null) or
            (n_End_Level   is null) or
            (n_Bgn_level >= n_End_Level)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- 判断是否与已有段交叉
        select
            count(*)
        into
            n_Count
        from
            SYS_LEVEL_STAGE t
        where
            t.game_id = n_Game_ID    and
            (
                (
                    t.bgn_level <= n_Bgn_Level and
                    t.end_level >  n_Bgn_Level
                ) or
                (
                    t.bgn_level <  n_End_Level  and
                    t.end_level >= n_End_Level
                ) or
                (
                    t.bgn_level >= n_Bgn_Level  and
                    t.end_level <= n_End_Level
                )
            );
        if (n_Count > 0) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        insert into SYS_LEVEL_STAGE (
            level_stage,    bgn_level,    end_level,  game_id
        ) values (
            n_Level,     n_Bgn_Level,  n_End_Level,  n_Game_ID
        );

        set n_Result = 1; /* S_SUCCESS */
    end label_proc;
END$$

-- 修改级别分段
CREATE PROCEDURE modifyLevelStage (
    in  n_Game_ID          integer,
    in  n_Level            integer,
    in  n_Bgn_Level        integer,
    in  n_End_Level        integer,

    out n_Result           integer
)
BEGIN
    declare n_Count                integer default 0;
     label_proc:begin
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (n_Level       is null) or
            (n_Bgn_Level   is null) or
            (n_End_Level   is null) or
            (n_Bgn_level >= n_End_Level)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- 判断是否与已有段交叉
        select
            count(*)
        into
            n_Count
        from
            SYS_LEVEL_STAGE t
        where
            t.game_id = n_Game_ID    and
            t.level_stage <> n_level and
            (
                (
                    t.bgn_level <= n_Bgn_Level and
                    t.end_level >  n_Bgn_Level
                ) or
                (
                    t.bgn_level <  n_End_Level  and
                    t.end_level >= n_End_Level
                ) or
                (
                    t.bgn_level >= n_Bgn_Level  and
                    t.end_level <= n_End_Level
                )
            );
        if (n_Count > 0) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        update SYS_LEVEL_STAGE
        set    bgn_level = n_Bgn_Level,
               end_level = n_End_Level
        where  level_stage = n_Level
        and    game_id = n_Game_ID;

        if (row_count() = 0) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        set n_Result = 1; /* S_SUCCESS */
    end label_proc;
END$$

-- 删除级别分段
CREATE PROCEDURE delLevelStage (
    in  n_Game_ID          integer,
    in  n_Level            integer,

    out n_Result           integer
)
BEGIN
     label_proc:begin
        set n_Result = 0;  /* E_ERROR */
        if (
            (n_Game_ID     is null) or
            (n_Level     is null)
        ) then
            set n_Result = -100;  /* E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        delete from SYS_LEVEL_STAGE
        where  level_stage  = n_Level
        and    game_id = n_Game_ID;

        set n_Result = 1; /* S_SUCCESS */
    end label_proc;
END$$


CREATE PROCEDURE getGameIDListAndUnionAuthMsg ()
BEGIN
	declare n_Result                integer default  0;
    label_proc:begin
        set n_Result = 1;  /* E_ERROR */
		select n_Result;
		prepare stmt1 from "
		select
			A.game_id,	A.option_code,	A.option_value
		from
			SYS_AUTH_OPTION A,	SYS_GAME_ID B
		where
			A.game_id	=	B.game_id
        ";
		deallocate prepare stmt1;
		
		prepare stmt2 from "
		select
			game_id
		from
			SYS_GAME_ID
		where
			game_id	>0
        ";
		deallocate prepare stmt2;
        set n_Result = 1;/*S_SUCCESS*/
    end label_proc;
END$$

DELIMITER ;
