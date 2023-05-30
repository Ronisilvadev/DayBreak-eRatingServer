DROP PROCEDURE createRole;
DROP PROCEDURE deleteRole;
DROP PROCEDURE deleteAllRole;
DROP PROCEDURE getRoleIdList;
DROP PROCEDURE resumeRole;
DROP PROCEDURE enterGameEx;
DROP PROCEDURE enterGameEx1;
DROP PROCEDURE enterGameEx3;
DROP PROCEDURE leaveGame;
DROP PROCEDURE innerLeaveGame;
DROP PROCEDURE roleStateQuery;
DROP PROCEDURE renameRole;
DELIMITER $$

CREATE PROCEDURE createRole(
    in  n_Game_ID        integer,
    in  n_Gateway_ID     integer,
    in  n_Nationality_ID integer,
    in  n_User_ID        integer unsigned,
    in  s_Role_Name      varchar(32),
    in  n_Gender         integer,
    in  n_Occupation     integer,
    in  n_Initial_Level  integer,
    in  n_User_IP        integer unsigned,
    in  n_User_Port      integer,

    out n_Ret_Role_ID    integer,
    out n_Result         integer
)
BEGIN
    declare n_RetCode        integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Role_State     integer default  0; /* UMS_ROLE.role_state%TYPE */
    declare d_Role_Create_Time   datetime default  now();

    declare n_Ret_Gateway_ID     integer default  0; /* UMS_ROLE.gateway_id%TYPE */
    declare n_Ret_User_ID        integer unsigned; /* UMS_ROLE.user_id%TYPE */
    declare n_Tmp_AD_ID          bigint; /* UMS_ROLE.ad_id%type */
    declare n_Role_Existed       integer default  0;

    declare s_Tmp_Role_Name            varchar(32);
    declare s_Tmp_Original_Role_Name   varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Create_Role_Group    varchar(32); /* SYS_OPTION.option_value%type */
    declare s_Tmp_Mingle_Realm       varchar(32);
    declare n_Tmp_Game_ID         integer;

    declare s_Tmp_Role_Dup_Ret_True      varchar(32);
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID       is null) or
            (n_Gateway_ID    is null) or
            (n_Nationality_ID is null) or
            (n_User_ID       is null) or
            (s_Role_Name     is null) or
            (n_Gender        is null) or
            (
                (n_Gender <> 1) and      -- Male
                (n_Gender <> 2)          -- Female
            )                         or
            (n_Occupation    is null) or
            (n_Occupation    <  0   ) or
            (n_Initial_Level is null) or
            (n_Initial_Level <  0   )
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
        call getOptionValue(
                      n_Tmp_Game_ID,
                      'create_role_group',    /* PKG_OPTION.CREATE_ROLE_GROUP */
                      '1',    /* PKG_OPTION.R_OPENED */
                      s_Tmp_Create_Role_Group
                      );
        if (s_Tmp_Create_Role_Group       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Result = -2101; /* PKG_UTIL.E_DISABLE_ROLE_GROUP */
            leave label_proc;
        end if;

        call getOptionValue(
            n_Game_ID,
            'role_dup_ret_true',
            '1',
            s_Tmp_Role_Dup_Ret_True
            );

        call getOptionValue(
            n_Game_ID,
            'original_role_name',
            '0',
            s_Tmp_Original_Role_Name
            );

	if(s_Tmp_Original_Role_Name = '0') then
	    set s_Tmp_Role_Name = lower(s_Role_Name);
        else
	    set s_Tmp_Role_Name = s_Role_Name;
	end if;

        -- We check whether gateway_id exists?
        call isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        -- We check whether user_id exists.
        select
            IFNULL(ad_id,0)
        into
            n_Tmp_AD_ID
        from
            UMS_USER
        where
            user_id = n_User_ID and
            game_id = n_Tmp_Game_ID;

        if (FOUND_ROWS() <> 1) then  /* NO_DATA_FOUND */
            set n_Result = -1406;    /* PKG_UTIL.E_USER_ACCOUNT_ERROR */
            leave label_proc;
        end if;

        select
            user_id,          role_id,
            gateway_id,       role_state
        into
            n_Ret_User_ID,    n_Ret_Role_ID,
            n_Ret_Gateway_ID, n_Tmp_Role_State
        from
            UMS_ROLE
        where
            role_name = s_Tmp_Role_Name and
            game_id   = n_Tmp_Game_ID;

        if (FOUND_ROWS() = 1) then
            if (
                (n_Tmp_Role_State        = 4           ) and    /* PKG_UTIL.DF_ROLE_STATE_VIRGIN */
                (n_Ret_Gateway_ID        = n_Gateway_ID) and
                (n_Ret_User_ID           = n_User_ID   ) and
                (s_Tmp_Role_Dup_Ret_True = '1'         )
            ) then
                set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
                leave label_proc;
            else
                set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
                leave label_proc;
            end if;
        end if;

        insert into UMS_ROLE(
            /* role_id,*/     user_id,          role_name,
            gateway_id,       nationality_id,   role_gender,
            role_occupation,  role_level,       role_state,
            create_time,      last_logout_time, total_online_second,
            login_id,         money1,           money2,
            experience,       ad_id,            game_id
        )
        values(
            /* n_Ret_Role_ID, */ n_User_ID,       s_Tmp_Role_Name,
            n_Gateway_ID,      n_Nationality_ID,  n_Gender,
            n_Occupation,      n_Initial_Level,   4,    /* PKG_UTIL.DF_ROLE_STATE_VIRGIN */
            d_Role_Create_Time,null,              0,
            0,                 0,                 0,
            0,                 n_Tmp_AD_ID,       n_Tmp_Game_ID
        );

        select LAST_INSERT_ID() into n_Ret_Role_ID;

        call logDailyFirstLogID(
            'UMS_ROLE',
            d_Role_Create_Time,
            n_Ret_Role_ID,
            n_RetCode
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    if (n_Ret_Role_ID is null) then
        set n_Ret_Role_ID = 0;
    end if;
END$$

CREATE PROCEDURE deleteRole(
    in  n_Game_ID        integer,
    in  n_User_ID        integer unsigned,
    in  n_Role_ID        integer,

    out n_Result         integer
)
BEGIN
    declare n_Role_State    integer default  0; /* UMS_ROLE.role_state%TYPE */
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode        integer default  0;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_Role_ID is null)
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

        select
            role_state
        into
            n_Role_State
        from
            UMS_ROLE
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Tmp_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        -- The role has been deleted.
        if (n_Role_State = 2) then    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        end if;

        update
            UMS_ROLE
        set
            role_state  = 2,      -- Deleted    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            delete_time = now()
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Tmp_Game_ID);

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE deleteAllRole(
    in  n_Game_ID        integer,
    in  n_User_ID        integer unsigned,

    out n_Result         integer
)
BEGIN
    declare n_RetCode       integer default 0;
    declare n_Stop          integer default 0;

    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID   integer;
    declare n_Temp_Counter  integer default 0;
    declare n_Temp_Role_Id  integer default 0;

    declare cur_Role_Id_List cursor for
        select role_id
        from UMS_ROLE
        where game_id = n_Tmp_Game_ID
        and user_id = n_User_ID
        and role_state in ( 1, 4);

    declare continue handler for not found set n_Stop = 1;

    label_proc:begin
        set n_Tmp_Game_ID = n_Game_ID;
        set n_Result      = 0;

        open cur_Role_Id_List;

        if (
            (n_Game_ID is null) or
            (n_User_ID is null)
        ) then
            set n_Result = -100;
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

        select
            count(*)
        into
            n_Temp_Counter
        from
            UMS_USER
        where
            user_id = n_User_ID
        and
            game_id = n_Tmp_Game_ID;

        if(n_Temp_Counter <> 1) then
            set n_Result = -1200;
            leave label_proc;
        end if;

        label_loop:loop

            set n_Stop = 0;
            fetch cur_Role_Id_List into n_Temp_Role_Id;
            if (n_Stop = 1) then
                leave label_loop;
            end if;

            set n_Temp_Counter = 0;

            select
                count(*)
            into
                n_Temp_Counter
            from
                UMS_GROUP
            where
                owner_id = n_Temp_Role_Id
            and
                group_state = 1;

            if(n_Temp_Counter > 0) then
                set n_Result = -1262;
                leave label_proc;
            end if;

            update
                UMS_ROLE
            set
                role_state  = 2,
                delete_time = now()
            where
                (user_id = n_User_ID) and
                (role_id = n_Temp_Role_Id) and
                (game_id = n_Tmp_Game_ID);

            if (ROW_COUNT() = 0) then
                set n_Result = -1252;
                leave label_proc;
            end if;

        end loop label_loop;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
    close cur_Role_Id_List;
END$$

CREATE PROCEDURE getRoleIdList(
    in  n_Game_ID        integer,
    in  n_Gateway_ID     integer,
    in  n_User_ID        integer unsigned,
    in  n_Max_Role_Count integer
)
BEGIN
    declare n_Result                integer default  0;
    declare n_Ret_Role_Count        integer default  0;
    declare n_RetCode               integer default  0;

    declare n_Tmp_Game_ID           integer;
    declare s_Tmp_Mingle_Realm      varchar(32);

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Ret_Role_Count = 0;
        set n_Tmp_Game_ID = n_Game_ID;

        if (
            (n_Game_ID          is null) or
            (n_Gateway_ID       is null) or
            (n_User_ID          is null) or
            (n_Max_Role_Count   is null) or
            (n_Max_Role_Count   <= 0   )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            select n_Result, n_Ret_Role_Count;
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

        select
            count(*)
        into
            n_Ret_Role_Count
        from
            UMS_ROLE
        where
            (user_id     =  n_User_ID     ) and
            (role_state  in (1, 4)        ) and
            (gateway_id  = n_Gateway_ID   ) and
            (game_id     =  n_Tmp_Game_ID );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
        if (n_Ret_Role_Count > n_Max_Role_Count) then
           set n_Ret_Role_Count = n_Max_Role_Count;
        end if;
        select n_Result, n_Ret_Role_Count;

        set @user_id = n_User_ID;
        set @game_id = n_Tmp_Game_ID;
        set @gateway_id = n_Gateway_ID;
        set @max_count = n_Max_Role_Count;

        prepare stmt1 from "
            select
                role_id
            from
                UMS_ROLE
            where
                (user_id       =  ? ) and
                (game_id       =  ? ) and
                (gateway_id    =  ? ) and
                (role_state    in (1, 4) )
            limit ?
        ";
        execute stmt1 using @user_id, @game_id, @gateway_id, @max_count;
        deallocate prepare stmt1;

    end label_proc;
END$$

CREATE PROCEDURE resumeRole(
    in  n_Game_ID        integer,
    in  n_User_ID        integer unsigned,
    in  n_Role_ID        integer,

    out n_Result         integer
)
BEGIN
    declare n_Role_State    integer default  0; /* UMS_ROLE.role_state%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID is null) or
            (n_User_ID is null) or
            (n_Role_ID is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        select
            role_state
        into
            n_Role_State
        from
            UMS_ROLE
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        -- The role state is normal.
        if (n_Role_State = 1) then    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */
            set n_Result = -1257;    /* PKG_UTIL.E_ROLE_STATE_NORMAL */
            leave label_proc;
        end if;

        update
            UMS_ROLE
        set
            role_state = 1,      -- 鎭㈠    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */
            delete_time = null
        where
            (user_id = n_User_ID) and
            (role_id = n_Role_ID) and
            (game_id = n_Game_ID);

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE enterGameEx(
    IN  n_Game_ID            INTEGER,
    IN  n_User_ID            INTEGER UNSIGNED,
    IN  n_Role_ID            INTEGER,
    IN  n_Gateway_ID         INTEGER,
    IN  n_Server_ID          INTEGER,
    IN  n_Role_Level         INTEGER,
    IN  n_User_IP            INTEGER UNSIGNED,
    IN  n_User_Port          INTEGER,
    IN  s_MAC                VARCHAR(16),
    IN  s_Province_Code      VARCHAR(16),
    IN  s_City_Code          VARCHAR(16),
    IN  s_Country_Code       VARCHAR(16),
    IN  s_Hardware_SN1       VARCHAR(32),
    IN  s_Hardware_SN2       VARCHAR(32),
    IN  n_Max_Balance_Count  INTEGER,
    OUT n_Ret_Balance_Count  INTEGER,
    OUT n_Ret_Balance_Type   INTEGER,
    OUT n_Ret_Balance_Amount INTEGER,
    OUT n_Result             INTEGER
)
BEGIN
    CALL enterGameEx1(
        n_Game_ID,
        n_User_ID,
        n_Role_ID,
        n_Gateway_ID,
        n_Server_ID,
        n_Role_Level,
        n_User_IP,
        n_User_Port,
        s_MAC,
        s_Province_Code,
        s_City_Code,
        s_Country_Code,
        
        s_Hardware_SN1,
        s_Hardware_SN2,
        n_Max_Balance_Count,
        0,
        n_Ret_Balance_Count,
        n_Ret_Balance_Type,
        n_Ret_Balance_Amount,
        n_Result
    );
END$$


CREATE PROCEDURE enterGameEx1(
    IN  n_Game_ID            INTEGER,
    IN  n_User_ID            INTEGER UNSIGNED,
    IN  n_Role_ID            INTEGER,
    IN  n_Gateway_ID         INTEGER,
    IN  n_Server_ID          INTEGER,
    IN  n_Role_Level         INTEGER,
    IN  n_User_IP            INTEGER UNSIGNED,
    IN  n_User_Port          INTEGER,
    IN  s_MAC                VARCHAR(16),
    IN  s_Province_Code      VARCHAR(16),
    IN  s_City_Code          VARCHAR(16),
    IN  s_Country_Code       VARCHAR(16),
    IN  s_Hardware_SN1       VARCHAR(32),
    IN  s_Hardware_SN2       VARCHAR(32),
    IN  n_Max_Balance_Count  INTEGER,
    IN  n_Client_Type        INTEGER,

    OUT n_Ret_Balance_Count  INTEGER,
    OUT n_Ret_Balance_Type   INTEGER,
    OUT n_Ret_Balance_Amount INTEGER,
    OUT n_Result             INTEGER
)
BEGIN
    DECLARE n_RetCode       INTEGER DEFAULT  0;    

    DECLARE n_Tmp_User_ID          INTEGER UNSIGNED; 
    DECLARE n_Tmp_Role_State       INTEGER; 
    DECLARE n_Tmp_Enter_Time       DATETIME DEFAULT  NOW();
    DECLARE n_Tmp_Log_ID           INTEGER; 
    DECLARE n_Tmp_Login_ID         BIGINT; 

    DECLARE n_Tmp_Adult_Flag       INTEGER DEFAULT  1;
    DECLARE n_Tmp_Remain_Seconds   INTEGER DEFAULT  3600 * 5;    
    DECLARE s_Role_GW_Check        VARCHAR(32); 
    DECLARE n_Last_Log_err         INTEGER DEFAULT  0;
    DECLARE n_Last_Gateway_ID      INTEGER DEFAULT  0; 
    DECLARE n_Last_Server_ID       INTEGER DEFAULT  0; 
    DECLARE s_Last_Province_Code   VARCHAR(16) DEFAULT  'other';
    DECLARE s_Last_City_Code       VARCHAR(16) DEFAULT  'other';
    DECLARE s_Tmp_Mingle_Realm        VARCHAR(32);
    DECLARE n_Tmp_Game_ID          INTEGER;
    label_proc:BEGIN
        SET n_Result = 0; 
        SET n_Tmp_Game_ID = n_Game_ID;
        
        IF (
            (n_Game_ID           IS NULL) OR
            (n_Role_ID           IS NULL) OR
            (n_Gateway_ID        IS NULL) OR
            (n_Server_ID         IS NULL) OR
            (n_Role_Level        IS NULL) OR
            (n_User_IP           IS NULL) OR
            (n_User_Port         IS NULL) OR
            (s_Province_Code     IS NULL) OR
            (s_City_Code         IS NULL) OR
            (n_Client_Type       IS NULL)
        ) THEN
            SET n_Result = -100;    
            LEAVE label_proc;
        END IF;

        CALL getOptionValue(
            n_Game_ID,
            'allow_mingle_realm',
            '',
            s_Tmp_Mingle_Realm
            );
        IF (s_Tmp_Mingle_Realm = '1') THEN
            CALL isMingleUserIDExisted(n_Tmp_Game_ID, n_User_ID, n_RetCode);
            IF( n_RetCode <> 1 ) THEN
                SET n_Result = n_RetCode;
                LEAVE label_proc;   
            END IF;
        END IF;
        
        CALL getOptionValue(
            n_Tmp_Game_ID,
            'role_gw_check',    
            '1',    
            s_Role_GW_Check
            );
        IF (s_Role_GW_Check = '1') THEN    
            SELECT
                user_id,       role_state,       login_id
            INTO
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            FROM
                UMS_ROLE
            WHERE
                gateway_id = n_Gateway_ID AND
                role_id    = n_Role_ID    AND
                game_id    = n_Tmp_Game_ID;
            IF (FOUND_ROWS() = 0) THEN
                SET n_Result = -1252;    
                LEAVE label_proc;
            END IF;
        ELSE
            SELECT
                user_id,       role_state,       login_id
            INTO
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            FROM
                UMS_ROLE
            WHERE
                role_id    = n_Role_ID AND
                game_id    = n_Tmp_Game_ID;
            IF (FOUND_ROWS() = 0) THEN
                SET n_Result = -1252;    
                LEAVE label_proc;
            END IF;

            
            
            CALL isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
            IF (n_RetCode <> 1) THEN    
                SET n_Result = n_RetCode;
                LEAVE label_proc;
            END IF;
        END IF;

        SET n_Ret_Balance_Count = 0;

        
        IF (n_Tmp_Role_State = 2) THEN    
            SET n_Result = -1253;    
            LEAVE label_proc;
        
        ELSEIF (n_Tmp_Role_State = 4) THEN    
            CALL logRoleFirstLogin(
                n_Tmp_Game_ID,
                n_Role_ID,
                n_Tmp_User_ID,
                n_Gateway_ID,
                n_Tmp_Enter_Time,
                n_User_IP,
                s_Province_Code,
                s_City_Code,
                S_Country_Code,
                s_MAC,
                n_Client_Type,
                n_RetCode
            );
            
            IF (n_RetCode = 1) THEN    
                UPDATE
                    UMS_ROLE
                SET
                    role_state = 1    
                WHERE
                    role_id = n_Role_ID;
                
            END IF;
        END IF;

        
        IF (n_Tmp_Login_ID > 0) THEN
            UPDATE
                LOG_RECORD_DETAIL
            SET
                logout_time = n_Tmp_Enter_Time,
                role_level  = n_Role_Level,
                money1      = 0,
                money2      = 0,
                experience  = 0
            WHERE
                login_id = n_Tmp_Login_ID;

            SELECT
                gateway_id,             server_id,
                province_code,          city_code
            INTO
                n_Last_Gateway_ID,      n_Last_Server_ID,
                s_Last_Province_Code,   s_Last_City_Code
            FROM
                LOG_RECORD_DETAIL
            WHERE
                login_id = n_Tmp_Login_ID;

            
            SET n_Tmp_Login_ID = 0;
            SET n_Last_Log_err = 1;
        END IF;

        
        CALL onEnter(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Gateway_ID,
            n_Tmp_Adult_Flag,
            n_Tmp_Remain_Seconds,
            n_RetCode
        );
        IF (n_RetCode <> 1) THEN    
            SET n_Result = n_RetCode;
            LEAVE label_proc;
        END IF;

        IF (n_Tmp_Adult_Flag = 0) THEN
            SET n_Ret_Balance_Type = 100; 
            SET n_Ret_Balance_Amount = n_Tmp_Remain_Seconds;
            SET n_Ret_Balance_Count = 1;
        END IF;

        CALL logLoginEx(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Role_ID,
            n_Gateway_ID,
            n_Server_ID,
            n_Role_Level,
            n_Tmp_Enter_Time,
            n_User_IP,
            n_User_Port,
            s_MAC,
            s_Province_Code,
            s_City_Code,
            s_Country_Code,
            s_Hardware_SN1,
            s_Hardware_SN2,
            n_Client_Type,
            null,
            n_Tmp_Login_ID, 
            n_RetCode
        );

        IF (n_Tmp_Login_ID IS NULL) THEN
            SET n_Tmp_Login_ID = 0;
        END IF;

        
        UPDATE
            UMS_ROLE
        SET
            login_id = n_Tmp_Login_ID
        WHERE
            role_id = n_Role_ID AND
            game_id = n_Tmp_Game_ID;

        SET n_Result = 1;    
    END label_proc;
END$$

CREATE PROCEDURE enterGameEx3(
    IN  n_Game_ID            INTEGER,
    IN  n_User_ID            INTEGER UNSIGNED,
    IN  n_Role_ID            INTEGER,
    IN  n_Gateway_ID         INTEGER,
    IN  n_Server_ID          INTEGER,
    IN  n_Role_Level         INTEGER,
    IN  n_User_IP            INTEGER UNSIGNED,
    IN  n_User_Port          INTEGER,
    IN  s_MAC                VARCHAR(16),
    IN  s_Uddi               VARCHAR(64),
    IN  s_Province_Code      VARCHAR(16),
    IN  s_City_Code          VARCHAR(16),
    IN  s_Country_Code       VARCHAR(16),
    IN  s_Hardware_SN1       VARCHAR(32),
    IN  s_Hardware_SN2       VARCHAR(32),
    IN  n_Max_Balance_Count  INTEGER,
    IN  n_Client_Type        INTEGER,

    OUT n_Ret_Balance_Count  INTEGER,
    OUT n_Ret_Balance_Type   INTEGER,
    OUT n_Ret_Balance_Amount INTEGER,
    OUT n_Result             INTEGER
)
BEGIN
    DECLARE n_RetCode       INTEGER DEFAULT  0;    

    DECLARE n_Tmp_User_ID          INTEGER UNSIGNED; 
    DECLARE n_Tmp_Role_State       INTEGER; 
    DECLARE n_Tmp_Enter_Time       DATETIME DEFAULT  NOW();
    DECLARE n_Tmp_Log_ID           INTEGER; 
    DECLARE n_Tmp_Login_ID         BIGINT; 

    DECLARE n_Tmp_Adult_Flag       INTEGER DEFAULT  1;
    DECLARE n_Tmp_Remain_Seconds   INTEGER DEFAULT  3600 * 5;    
    DECLARE s_Role_GW_Check        VARCHAR(32); 
    DECLARE n_Last_Log_err         INTEGER DEFAULT  0;
    DECLARE n_Last_Gateway_ID      INTEGER DEFAULT  0; 
    DECLARE n_Last_Server_ID       INTEGER DEFAULT  0; 
    DECLARE s_Last_Province_Code   VARCHAR(16) DEFAULT  'other';
    DECLARE s_Last_City_Code       VARCHAR(16) DEFAULT  'other';
    DECLARE s_Tmp_Mingle_Realm        VARCHAR(32);
    DECLARE n_Tmp_Game_ID          INTEGER;
    label_proc:BEGIN
        SET n_Result = 0; 
        SET n_Tmp_Game_ID = n_Game_ID;
        
        IF (
            (n_Game_ID           IS NULL) OR
            (n_Role_ID           IS NULL) OR
            (n_Gateway_ID        IS NULL) OR
            (n_Server_ID         IS NULL) OR
            (n_Role_Level        IS NULL) OR
            (n_User_IP           IS NULL) OR
            (n_User_Port         IS NULL) OR
            (s_Country_Code      IS NULL) OR
            (n_Client_Type       IS NULL)
        ) THEN
            SET n_Result = -100;    
            LEAVE label_proc;
        END IF;

        CALL getOptionValue(
            n_Game_ID,
            'allow_mingle_realm',
            '',
            s_Tmp_Mingle_Realm
            );
        IF (s_Tmp_Mingle_Realm = '1') THEN
            CALL isMingleUserIDExisted(n_Tmp_Game_ID, n_User_ID, n_RetCode);
            IF( n_RetCode <> 1 ) THEN
                SET n_Result = n_RetCode;
                LEAVE label_proc;   
            END IF;
        END IF;
        
        CALL getOptionValue(
            n_Tmp_Game_ID,
            'role_gw_check',    
            '1',    
            s_Role_GW_Check
            );
        IF (s_Role_GW_Check = '1') THEN    
            SELECT
                user_id,       role_state,       login_id
            INTO
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            FROM
                UMS_ROLE
            WHERE
                gateway_id = n_Gateway_ID AND
                role_id    = n_Role_ID    AND
                game_id    = n_Tmp_Game_ID;
            IF (FOUND_ROWS() = 0) THEN
                SET n_Result = -1252;    
                LEAVE label_proc;
            END IF;
        ELSE
            SELECT
                user_id,       role_state,       login_id
            INTO
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            FROM
                UMS_ROLE
            WHERE
                role_id    = n_Role_ID AND
                game_id    = n_Tmp_Game_ID;
            IF (FOUND_ROWS() = 0) THEN
                SET n_Result = -1252;    
                LEAVE label_proc;
            END IF;

            
            
            CALL isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
            IF (n_RetCode <> 1) THEN    
                SET n_Result = n_RetCode;
                LEAVE label_proc;
            END IF;
        END IF;

        SET n_Ret_Balance_Count = 0;

        
        IF (n_Tmp_Role_State = 2) THEN    
            SET n_Result = -1253;    
            LEAVE label_proc;
        
        ELSEIF (n_Tmp_Role_State = 4) THEN    
            CALL logRoleFirstLogin(
                n_Tmp_Game_ID,
                n_Role_ID,
                n_Tmp_User_ID,
                n_Gateway_ID,
                n_Tmp_Enter_Time,
                n_User_IP,
                s_Province_Code,
                s_City_Code,
                s_Country_Code,
                s_MAC,
                n_Client_Type,
                n_RetCode
            );
            
            IF (n_RetCode = 1) THEN    
                UPDATE
                    UMS_ROLE
                SET
                    role_state = 1    
                WHERE
                    role_id = n_Role_ID;
                
            END IF;
        END IF;

        
        IF (n_Tmp_Login_ID > 0) THEN
            UPDATE
                LOG_RECORD_DETAIL
            SET
                logout_time = n_Tmp_Enter_Time,
                role_level  = n_Role_Level,
                money1      = 0,
                money2      = 0,
                experience  = 0
            WHERE
                login_id = n_Tmp_Login_ID;

            SELECT
                gateway_id,             server_id,
                province_code,          city_code
            INTO
                n_Last_Gateway_ID,      n_Last_Server_ID,
                s_Last_Province_Code,   s_Last_City_Code
            FROM
                LOG_RECORD_DETAIL
            WHERE
                login_id = n_Tmp_Login_ID;

            
            SET n_Tmp_Login_ID = 0;
            SET n_Last_Log_err = 1;
        END IF;

        
        CALL onEnter(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Gateway_ID,
            n_Tmp_Adult_Flag,
            n_Tmp_Remain_Seconds,
            n_RetCode
        );
        IF (n_RetCode <> 1) THEN    
            SET n_Result = n_RetCode;
            LEAVE label_proc;
        END IF;

        IF (n_Tmp_Adult_Flag = 0) THEN
            SET n_Ret_Balance_Type = 100; 
            SET n_Ret_Balance_Amount = n_Tmp_Remain_Seconds;
            SET n_Ret_Balance_Count = 1;
        END IF;

        CALL logLoginEx(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Role_ID,
            n_Gateway_ID,
            n_Server_ID,
            n_Role_Level,
            n_Tmp_Enter_Time,
            n_User_IP,
            n_User_Port,
            s_MAC,
            s_Province_Code,
            s_City_Code,
            s_Country_Code,
            s_Hardware_SN1,
            s_Hardware_SN2,
            n_Client_Type,
            s_Uddi,

            n_Tmp_Login_ID, 
            n_RetCode
        );

        IF (n_Tmp_Login_ID IS NULL) THEN
            SET n_Tmp_Login_ID = 0;
        END IF;

        
        UPDATE
            UMS_ROLE
        SET
            login_id = n_Tmp_Login_ID
        WHERE
            role_id = n_Role_ID AND
            game_id = n_Tmp_Game_ID;

        SET n_Result = 1;    
    END label_proc;
END$$

CREATE PROCEDURE leaveGame(
    in  n_Game_ID            integer,
    in  n_User_ID            integer unsigned,
    in  n_Role_ID            integer,
    in  n_Gateway_ID         integer,
    in  n_Logout_Flag        integer,
    in  n_Role_Level         integer,
    in  n_Community_ID       integer,
    in  n_Occupation         integer,
    in  n_Money1             integer,
    in  n_Money2             integer,
    in  n_Experience         integer,
    in  n_Max_Balance_Count  integer,

    out n_Ret_Balance_Count  integer,
    out n_Ret_Balance_Type   integer,
    out n_Ret_Balance_Amount integer,
    out n_Result             integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Adult_Flag     integer default  0;
    declare n_Tmp_Remain_Seconds integer default  3600 * 5;    /* PKG_UTIL.DF_MAX_VALUABLE_SECONDS */

    declare n_Tmp_User_ID        integer unsigned; /* UMS_ROLE.user_id%TYPE */
    declare n_Tmp_Role_State     integer; /* UMS_ROLE.role_state%TYPE */
    declare n_Tmp_Login_ID       bigint;  /* UMS_ROLE.login_id%TYPE */
    declare n_Tmp_Server_ID      integer; /* LOG_RECORD_DETAIL.server_id%TYPE */
    declare n_Tmp_Online_Second  integer default  0; /* UMS_ROLE.total_online_second%TYPE */

    declare n_Tmp_User_IP        integer unsigned; /* LOG_RECORD_DETAIL.login_ip%TYPE */
    declare s_Tmp_Province_Code  varchar(16) default  'other'; /* LOG_RECORD_DETAIL.province_code%TYPE */
    declare s_Tmp_City_Code      varchar(16) default  'other'; /* LOG_RECORD_DETAIL.city_code%TYPE */

    declare d_Tmp_Leave_Time     datetime  default now();
    declare s_Role_GW_Check      varchar(32);
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        -- Parameters validation.
        if (
            (n_Game_ID     is null) or
            (n_Role_ID     is null) or
            (n_Logout_Flag is null) or
            ( n_Logout_Flag not in (1,2,3) ) or -- 1-normal, 2-payment, 3-abnormal.
            (n_Role_Level  is null) or
            (n_Occupation  is null) or
            (n_Money1      is null) or
            (n_Money2      is null) or
            (n_Experience  is null)
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
        set n_Ret_Balance_Count = 0;
        -- check whether the MSG_LEAVE_GAME is legal.
        call getOptionValue(
            n_Tmp_Game_ID,
            'role_gw_check',    /* PKG_OPTION.ROLE_GW_CHECK */
            '1',    /* PKG_OPTION.R_OPENED */
            s_Role_GW_Check
        );
        if (s_Role_GW_Check = '1') then    /* PKG_OPTION.R_OPENED */
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                gateway_id = n_Gateway_ID and
                role_id    = n_Role_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;
        else
            select
                user_id,       role_state,       login_id
            into
                n_Tmp_User_ID, n_Tmp_Role_State, n_Tmp_Login_ID
            from
                UMS_ROLE
            where
                role_id    = n_Role_ID;
            if (FOUND_ROWS() = 0) then
                set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
                leave label_proc;
            end if;

            -- 角色可能不在其本身的网关登录，需要检测目标网关是否存在
            -- n_RetCode = PKG_GATEWAY.isGatewayIDExisted(n_Gateway_ID)
            call isGatewayIDExisted(n_Tmp_Game_ID, n_Gateway_ID, n_RetCode);
            if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
                set n_Result = n_RetCode;
                leave label_proc;
            end if;
        end if;

        -- check whether the role has been deleted.
        if (n_Tmp_Role_State = 2) then    /* PKG_UTIL.DF_ROLE_STATE_DELETED */
            set n_Result = -1253;    /* PKG_UTIL.E_ROLE_DELETED */
            leave label_proc;
        end if;

        -- calculate indulgence time.
        call onLeave(
            n_Tmp_Game_ID,
            n_Tmp_User_ID,
            n_Logout_Flag,
            n_Gateway_ID,
            n_Tmp_Adult_Flag,
            n_Tmp_Remain_Seconds,
            n_RetCode
        );
        if (n_RetCode <> 1) then    /* PKG_UTIL.S_SUCCESS */
            set n_Result = n_RetCode;
            leave label_proc;
        end if;

        if (n_Tmp_Adult_Flag = 0) then
            set n_Ret_Balance_Type = 100; -- 100    /* PKG_UTIL.DF_SUBJECT_ID_VALUABLE_TIME */
            set n_Ret_Balance_Amount = n_Tmp_Remain_Seconds;
            set n_Ret_Balance_Count = 1;
        end if;

        if (n_Logout_Flag = 2) then
            -- update role's attributes.
            update
                UMS_ROLE
            set
                role_level          = n_Role_Level,
                nationality_id      = n_Community_ID,
                role_occupation     = n_Occupation,
                money1              = n_Money1,
                money2              = n_Money2,
                experience          = n_Experience
            where
                role_id = n_Role_ID and
                game_id = n_Tmp_Game_ID;
        elseif ( n_Logout_Flag in (1,3) ) then
            if (n_Tmp_Login_ID = 0) then
                -- if not find loginId, so can't update, insert a new record.
                call logLogoutAbnormal(
                    n_Tmp_Game_ID,
                    n_Gateway_ID,
                    n_Tmp_User_ID,
                    n_Role_ID,
                    n_Role_Level,
                    n_Money1,
                    n_Money2,
                    n_Experience,
                    n_RetCode
                );
            else
                -- We must record logout information in LOG_RECORD_DETAIL.
                call logLogout(
                    n_Tmp_Login_ID,
                    n_Role_Level,
                    n_Money1,
                    n_Money2,
                    n_Experience,
                    n_Tmp_Server_ID,
                    n_Tmp_Online_Second,
                    n_Tmp_User_IP,
                    s_Tmp_Province_Code,
                    s_Tmp_City_Code,
                    n_RetCode
                );
            end if;

            if (n_Logout_Flag <> 3) then
                -- update role's rich attributes.
                update
                    UMS_ROLE
                set
                    role_level          = n_Role_Level,
                    nationality_id      = n_Community_ID,
                    role_occupation     = n_Occupation,
                    login_id            = 0,
                    last_logout_time    = d_Tmp_Leave_Time,
                    total_online_second = total_online_second + n_Tmp_Online_Second,
                    money1              = n_Money1,
                    money2              = n_Money2,
                    experience          = n_Experience
                where
                    role_id = n_Role_ID and
                    game_id = n_Tmp_Game_ID;
            end if;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- call this CREATE PROCEDURE while role is still online at enterGame.
CREATE PROCEDURE innerLeaveGame(
    in  n_Game_ID           integer,
    in  n_Role_ID           integer,
    in  n_Gateway_ID        integer,
    in  n_Role_Level        integer,
    in  n_Login_ID          integer,

    out n_Result            integer
)
BEGIN
    declare n_RetCode            integer default  0;    /* PKG_UTIL.E_ERROR */

    declare n_Tmp_Online_Second  integer default  0;  /* UMS_ROLE.total_online_second%TYPE */
    declare n_Tmp_Server_ID      integer default  0; /* LOG_RECORD_DETAIL.server_id%TYPE */
    declare n_Tmp_User_IP        integer unsigned default  0; /* LOG_RECORD_DETAIL.login_ip%TYPE */
    declare s_Tmp_Province_Code  varchar(16) default  'other'; /* LOG_RECORD_DETAIL.province_code%TYPE */
    declare s_Tmp_City_Code      varchar(16) default  'other'; /* LOG_RECORD_DETAIL.city_code%TYPE */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        -- Parameters validation.
        if (
            (n_Game_ID     is null) or
            (n_Role_ID     is null) or
            (n_Role_Level  is null) or
            (n_Login_ID    is null) or
            (n_Login_ID    <= 0   )
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- update to offline status.
        update
            UMS_ROLE
        set
            login_id = 0
        where
            role_id = n_Role_ID and
            game_id = n_Game_ID;
        -- ignore ROW_COUNT() = 0.

        -- record LOG_RECORD_DETAIL
        call logLogout(
            n_Login_ID,
            n_Role_Level,
            0, -- money1
            0, -- money2
            0, -- exp
            n_Tmp_Server_ID,
            n_Tmp_Online_Second,
            n_Tmp_User_IP,
            s_Tmp_Province_Code,
            s_Tmp_City_Code,
            n_RetCode
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

-- @Purpose: just judge whether n_Role_Name is already exists at present.
CREATE PROCEDURE roleStateQuery(
    in  n_Game_ID          integer,
    in  n_Gateway_ID       integer,
    in  n_User_ID          integer unsigned,
    in  n_Role_Name        varchar(32),

    out n_Ret_Role_State   integer,
    out n_Result           integer
)
BEGIN
    declare s_Tmp_Mingle_Realm         varchar(32);
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;

    declare s_Tmp_Role_Name             varchar(32); /* UMS_ROLE.role_name%TYPE */
    declare s_Tmp_Original_Role_Name    varchar(32); /* SYS_OPTION.option_value%type */
    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID        is null) or
            (n_Gateway_ID     is null) or
--            (n_User_ID        is null) or
            (n_Role_Name      is null)
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

        call getOptionValue(
            n_Game_ID,
            'original_role_name',
            '0',
            s_Tmp_Original_Role_Name
            );

	if(s_Tmp_Original_Role_Name = '0') then
	    set s_Tmp_Role_Name = lower(n_Role_Name);
        else
	    set s_Tmp_Role_Name = n_Role_Name;
	end if;

        select
            role_state
        into
            n_Ret_Role_State
        from
            UMS_ROLE
        where
            role_name  = s_Tmp_Role_Name and
            game_id    = n_Tmp_Game_ID;
        if (FOUND_ROWS() <> 1) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE renameRole(
    in  n_Game_ID         integer,
    in  n_User_ID         integer unsigned,
    in  n_Role_ID         integer,
    in  s_Role_Name       varchar(32),

    out n_Result          integer
)
BEGIN
    declare s_Old_Role_Name         varchar(32); /* UMS_ROLE.role_name%TYPE */
    declare s_Tmp_Role_Name         varchar(32); /* UMS_ROLE.role_name%TYPE */
    declare s_Tmp_Mingle_Realm      varchar(32);
    declare s_Tmp_Original_Role_Name    varchar(32); /* SYS_OPTION.option_value%type */
    declare n_Tmp_Game_ID           integer;
    declare n_RetCode               integer default  0;
    label_proc:begin
        declare exit handler for 1062 set n_Result = -1251;    /* PKG_UTIL.E_ROLE_EXIST */
        set n_Result = 0; /* E_ERROR */
        set n_Tmp_Game_ID = n_Game_ID;
        if (
            (n_Game_ID         is null) or
            (n_Role_ID         is null) or
            (s_Role_Name       is null)
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

        call getOptionValue(
            n_Game_ID,
            'original_role_name',
            '0',
            s_Tmp_Original_Role_Name
            );

	if(s_Tmp_Original_Role_Name = '0') then
	    set s_Tmp_Role_Name = lower(s_Role_Name);
        else
	    set s_Tmp_Role_Name = s_Role_Name;
	end if;

        select
            role_name
        into
            s_Old_Role_Name
        from
            UMS_ROLE t
        where
            (t.role_id = n_Role_ID)       and
            (t.role_state in (1, 4)) and    /* PKG_UTIL.DF_ROLE_STATE_NORMAL , PKG_UTIL.DF_ROLE_STATE_VIRGIN */
            (t.game_id = n_Tmp_Game_ID);

        if (FOUND_ROWS() <> 1) then /* NO_DATA_FOUND */
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        if (s_Tmp_Role_Name = s_Old_Role_Name) then
            set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
            leave label_proc;
        end if;

        update
            UMS_ROLE t
        set
            t.role_name = s_Tmp_Role_Name
        where
            t.role_id    = n_Role_ID and
            t.game_id    = n_Tmp_Game_ID;

        if (ROW_COUNT() = 0) then
            set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
