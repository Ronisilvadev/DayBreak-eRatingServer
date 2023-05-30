DROP PROCEDURE onEnter;
DROP PROCEDURE onLeave;
DROP PROCEDURE onLoginKor;
DROP PROCEDURE onLogoutKor;
DELIMITER $$

CREATE PROCEDURE onLoginKor(
    	IN        n_Game_ID              INTEGER,
    	IN        s_ID_Code              VARCHAR(32),
    	IN        n_User_ID              INTEGER UNSIGNED,
    	IN        n_Gateway_ID           INTEGER,
    	OUT       n_Ret_Available_Time   INTEGER,
        OUT       n_Result               INTEGER
    )
BEGIN
    label_proc:BEGIN

        IF (
            (n_Game_ID     IS NULL) OR
            (s_ID_Code     IS NULL) OR
            (n_User_ID     IS NULL) OR
            (n_Gateway_ID  IS NULL)    
        )THEN
            SET n_Result = -100;
            LEAVE label_proc;
        END IF;
        
        SET n_Ret_Available_Time = 86400 - TIME_TO_SEC(NOW());
        
        -- when the date between 23:40 and 6:00 the user can't enter game
        IF  ((n_Ret_Available_Time >= 18*3600) OR (n_Ret_Available_Time < 20*60))
        THEN 
            SET n_Ret_Available_Time = 0;
        END IF;

        UPDATE
            UMS_USER
        SET
            gateway_id = n_Gateway_ID
        WHERE
            game_id = n_Game_ID     AND
            user_id = n_User_ID;

        SET n_Result = 1;
    END label_proc;
END$$

CREATE PROCEDURE onLogoutKor(
        IN        n_Game_ID               INTEGER,
        IN        s_ID_Code               VARCHAR(32),
        IN        n_User_ID               INTEGER UNSIGNED,
        IN        n_Logout_Flag           INTEGER,
        IN        n_Gateway_ID            INTEGER,
        OUT       n_Ret_Available_Time    INTEGER,
        OUT       n_Result                INTEGER
    )
BEGIN
    label_proc:BEGIN
    
        IF (
            (n_Game_ID     IS NULL) OR
            (s_ID_Code     IS NULL) OR
            (n_User_ID     IS NULL) OR
            (n_Logout_Flag IS NULL) OR
            (n_Gateway_ID  IS NULL)    
        )THEN
            SET n_Result = -100;
            LEAVE label_proc;
        END IF;
        
        SET n_Ret_Available_Time = 86400 - TIME_TO_SEC(NOW());
        -- when the date between 23:40 and 6:00 the user can't enter game          
        IF  ((n_Ret_Available_Time >= 18*3600) OR (n_Ret_Available_Time < 20*60))
        THEN 
            SET n_Ret_Available_Time = 0;
        END IF;
      
        SET n_Result = 1;
     END label_proc;
END$$

CREATE PROCEDURE onEnter(
        IN  n_Game_ID               INTEGER,
        IN  n_User_ID               INTEGER UNSIGNED,
        IN  n_Gateway_ID            INTEGER,
        OUT n_Ret_Adult_Flag        INTEGER,
        OUT n_Ret_Remain_Second     INTEGER,
        OUT n_Result                INTEGER
    )
BEGIN
        DECLARE n_RetCode              INTEGER DEFAULT 0;
        DECLARE d_Tmp_Birthday         DATETIME;
        DECLARE s_Tmp_ID_Code          VARCHAR(32);
        DECLARE n_Tmp_User_State       INTEGER;
        DECLARE n_Tmp_User_Type        INTEGER;
        DECLARE n_Tmp_Game_ID          INTEGER;
        label_proc:BEGIN
            SELECT
                birthday,              user_type,
                user_state,            id_code
            INTO
                d_Tmp_Birthday,        n_Tmp_User_Type,
                n_Tmp_User_State,      s_Tmp_ID_Code
            FROM
                UMS_USER
            WHERE
                game_id = n_Game_ID AND
                user_id = n_User_ID;
            IF (FOUND_ROWS()=0)THEN 
                SET n_Result = -1400;
                LEAVE label_proc;
            END IF;
        IF (s_Tmp_ID_Code = '0') THEN
            SET s_Tmp_ID_Code = n_User_ID;
        END IF;

        -- 判断是否是未成年，以决定是否获取收益时间
        IF ((n_Tmp_User_State & 8) = 8) THEN
            SET n_Ret_Adult_Flag = 1;
        ELSE
            -- 非成人状态，则判断目前年龄是否已满18岁
            IF (
                (IFNULL(TIMESTAMPDIFF(MONTH,d_Tmp_Birthday, now()),0) < 18 * 12) AND
                ((n_Tmp_User_State & 3) <> 2)
            )THEN  -- 仍是未成年人
                SET n_Ret_Adult_Flag = 0;

                -- 计算有效时间
                IF (n_Game_ID = 1224) THEN
                    CALL onLoginKor(
                            n_Game_ID,
                            s_Tmp_ID_Code,
                            n_User_ID,
                            n_Gateway_ID,
                            n_Ret_Remain_Second,
                            n_RetCode
                            );
                    IF (n_RetCode <> 1) THEN
                        SET n_Ret_Remain_Second = 86400 - TIME_TO_SEC(NOW());
                    END IF;
                ELSE 
                    SET n_Ret_Remain_Second = 3600 * 5;
                END IF;
            ELSE   -- 年龄已满18岁，设置为成人状态
               UPDATE
                     UMS_USER
               SET
                     user_state = 8
               WHERE
                     game_id = n_Game_ID AND
                     user_id = n_User_ID;
               SET n_Ret_Adult_Flag = 1;
            END IF;
        END IF;
        SET n_Result = 1;
     END label_proc;
    END$$

 CREATE PROCEDURE onLeave(
        IN  n_Game_ID                INTEGER,
        IN  n_User_ID                INTEGER UNSIGNED,
        IN  n_Logout_Flag            INTEGER,
        IN  n_Gateway_ID             INTEGER,
        OUT n_Ret_Adult_Flag         INTEGER,
        OUT n_Ret_Remain_Second      INTEGER,
        OUT n_Result                 INTEGER
    )
BEGIN
    DECLARE n_RetCode              INTEGER DEFAULT 0;
    DECLARE d_Tmp_Birthday         DATETIME;
    DECLARE s_Tmp_ID_Code          VARCHAR(32);
    DECLARE n_Tmp_User_State       INTEGER DEFAULT 0;
    DECLARE n_Tmp_User_Type        INTEGER DEFAULT 0;
    label_proc:BEGIN
            SET n_RetCode = 0;
            SELECT
                birthday,              user_type,
                user_state,            id_code
            INTO
                d_Tmp_Birthday,        n_Tmp_User_Type,
                n_Tmp_User_State,      s_Tmp_ID_Code
            FROM
                UMS_USER
            WHERE
                game_id = n_Game_ID AND
                user_id = n_User_ID;
            IF (FOUND_ROWS()=0)THEN 
                SET  n_Result = -1400;
                LEAVE label_proc;
            END IF;
            IF (s_Tmp_ID_Code = '0') THEN
                SET s_Tmp_ID_Code = n_User_ID;
            END IF;
            -- 判断是否是未成年，以决定是否获取收益时间
            IF ((n_Tmp_User_State & 8) = 8) THEN
                SET n_Ret_Adult_Flag = 1;
            ELSE
                IF (
                    (IFNULL(TIMESTAMPDIFF(MONTH,d_Tmp_Birthday, now()),0) < 18 * 12) AND
                    ((n_Tmp_User_State & 3) <> 2)
                   ) THEN
                    SET n_Ret_Adult_Flag = 0;

                    -- 计算有效时间
                    IF(n_Game_ID = 1224) THEN
                        CALL onLogoutKor(
                            n_Game_ID,
                            s_Tmp_ID_Code,
                            n_User_ID,
                            n_Logout_Flag,    -- Logout
                            n_Gateway_ID,
                            n_Ret_Remain_Second,
                            n_RetCode
                            );
                        IF (n_RetCode <> 1) THEN
                            SET n_Ret_Remain_Second = 86400 - TIME_TO_SEC(NOW());
                        END IF;
                    ELSE
                        SET n_Ret_Remain_Second = 3600 * 5;
                    END IF;
                END IF;
            END IF;
            SET n_Result = 1;
    END label_proc;
END$$

DELIMITER ;
