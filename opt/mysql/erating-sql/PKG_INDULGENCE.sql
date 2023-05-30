DROP PROCEDURE onEnter;
DROP PROCEDURE onLeave;

DELIMITER $$

CREATE PROCEDURE onEnter(
    in    n_Game_ID              integer,
    in    n_User_ID              integer,
    out   n_Ret_Adult_Flag       integer,
    out   n_Ret_Remain_Second    integer,
    out   n_Result               integer
)
BEGIN
    set n_Ret_Adult_Flag = 1;
    set n_Ret_Remain_Second = 3600 * 5;
    set n_Result = 1;
END$$

CREATE PROCEDURE onLeave(
    in    n_Game_ID              integer,
    in    n_User_ID              integer,
    in    n_Logout_Flag          integer,
    out   n_Ret_Adult_Flag       integer,
    out   n_Ret_Remain_Second    integer,
    out   n_Result               integer
)
BEGIN
    set n_Ret_Adult_Flag = 1;
    set n_Ret_Remain_Second = 3600 * 5;
    set n_Result = 1;
END$$

DELIMITER ;
