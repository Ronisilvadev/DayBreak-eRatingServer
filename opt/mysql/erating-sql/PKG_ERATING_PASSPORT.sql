DROP PROCEDURE modifyPassword;
DELIMITER $$

CREATE PROCEDURE modifyPassword(
    in  n_User_ID         INTEGER, 
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

DELIMITER ;