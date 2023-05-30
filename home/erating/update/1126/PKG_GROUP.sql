DROP PROCEDURE createGroup;
DROP PROCEDURE deleteGroup;
DROP PROCEDURE transferGroup;
DELIMITER $$


CREATE PROCEDURE createGroup(
    in  n_Game_ID         integer,
    in  n_Role_ID         integer,
    in  s_Group_Name      varchar(32),
    in  n_Group_Type      integer,

    out n_Ret_Group_ID    integer,
    out n_Result          integer
)
BEGIN
    declare n_RetCode                 integer  default  0;    /* PKG_UTIL.E_ERROR */
    declare n_Tmp_Gateway_ID          integer  default  0; /* SYS_GATEWAY.GATEWAY_ID%TYPE */
    declare d_Tmp_Create_Time         datetime default  now();
    declare s_Tmp_Create_Role_Group   varchar(32); /* SYS_OPTION.option_value%type */

    label_proc:begin
        declare exit handler for 1062 set n_Result =  -1901;    /* PKG_UTIL.E_GROUP_EXIST */
        set n_Result = 0; /* E_ERROR */
        set n_Ret_Group_ID = 0;
        call getOptionValue(
                  n_Game_ID,
                  'create_role_group',    /* PKG_OPTION.CREATE_ROLE_GROUP */
                  '1',    /* PKG_OPTION.R_OPENED */

                  s_Tmp_Create_Role_Group
                  );

        if (s_Tmp_Create_Role_Group       = '0') then    /* PKG_OPTION.R_CLOSED */
            set n_Result =  -2101;    /* PKG_UTIL.E_DISABLE_ROLE_GROUP */
            leave label_proc;
        end if;

        if (
            (n_Game_ID        is null) or
            (n_Role_ID        is null) or
            (s_Group_Name     is null) or
            (n_Group_Type     is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- We check whether role_id exists, and get the gateway_id.
        select
             gateway_id
        into
             n_Tmp_Gateway_ID
        from
             UMS_ROLE
        where
             game_id = n_Game_ID and
             role_id = n_Role_ID and
             role_state = 1;     /* PKG_UTIL.DF_ROLE_STATE_NORMAL */

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
             set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
             leave label_proc;
        end if;

        -- create a new group
        insert into UMS_GROUP(
            /* group_id, */    group_name,        group_type,
            gateway_id,        founder_id,        owner_id,
            group_state,                          create_time,
            game_id
        )
        values(
            /* n_Ret_Group_ID, */ lower(s_Group_Name), n_Group_Type,
            n_Tmp_Gateway_ID,     n_Role_ID,           n_Role_ID,
            1,                    d_Tmp_Create_Time,    /* PKG_UTIL.DF_GROUP_STATE_NORMAL */
            n_Game_ID

        );

        select LAST_INSERT_ID() into n_Ret_Group_ID;

        call logDailyFirstLogID(
             'UMS_GROUP',
             d_Tmp_Create_Time,
             n_Ret_Group_ID,
             n_RetCode
        );

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE deleteGroup(
    in  n_Game_ID       integer,
    in  n_Group_ID      integer,
    in  n_Role_ID       integer,

    out n_Result        integer
)
BEGIN
    declare n_Tmp_Gateway_ID          integer default  0; /* SYS_GATEWAY.gateway_id%TYPE */
    declare n_Tmp_Group_State         integer default  0; /* UMS_GROUP.group_state%TYPE */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID            is null) or
            (n_Group_ID           is null) or
            (n_Role_ID            is null)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- We check whether role_id exists, and get the gateway_id.
        select
             gateway_id
        into
             n_Tmp_Gateway_ID
        from
             UMS_ROLE
        where
             game_id = n_Game_ID and
             role_id = n_Role_ID and
             role_state = 1;    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
             set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
             leave label_proc;
        end if;

        -- check the group's state
        select
            group_state
        into
            n_Tmp_Group_State
        from
            UMS_GROUP
        where
            game_id  = n_Game_ID and
            group_id = n_Group_ID and
            owner_id = n_Role_ID;

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
            set n_Result =  -1900;    /* PKG_UTIL.E_GROUP_NOT_EXIST */
            leave label_proc;
        end if;

        if (n_Tmp_Group_State = 2) then    /* PKG_UTIL.DF_GROUP_STATE_DELETED */
            set n_Result =  -1903;    /* PKG_UTIL.E_GROUP_DELETED */
            leave label_proc;
        end if;

        -- marking to delete this group
        update
            UMS_GROUP
        set
            group_state = 2,    /* PKG_UTIL.DF_GROUP_STATE_DELETED */
            delete_time = now()
        where
            game_id  = n_Game_ID and
            group_id = n_Group_ID;

        if (ROW_COUNT() = 0) then
            set n_Result =  -1900;    /* PKG_UTIL.E_GROUP_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

CREATE PROCEDURE transferGroup(
    in  n_Game_ID         integer,
    in  n_Group_ID        integer,
    in  n_From_Role_ID    integer,
    in  n_To_Role_ID      integer,

    out n_Result          integer
)
BEGIN
    declare n_Tmp_From_Gateway_ID     integer default  0; /* SYS_GATEWAY.gateway_id%TYPE */
    declare n_Tmp_To_Gateway_ID       integer default  0; /* SYS_GATEWAY.gateway_id%TYPE */
    declare n_Tmp_Group_State         integer default  0; /* UMS_GROUP.group_state%TYPE */

    label_proc:begin
        set n_Result = 0; /* E_ERROR */
        if (
            (n_Game_ID            is null) or
            (n_Group_ID           is null) or
            (n_From_Role_ID       is null) or
            (n_To_Role_ID         is null) or
            (n_To_Role_ID = n_From_Role_ID)
        ) then
            set n_Result = -100;    /* PKG_UTIL.E_PARAMETER_ERROR */
            leave label_proc;
        end if;

        -- We check whether role_id exists, and get the gateway_id.
        select
             gateway_id
        into
             n_Tmp_From_Gateway_ID
        from
             UMS_ROLE
        where
             game_id = n_Game_ID and
             role_id = n_From_Role_ID and
             role_state = 1; /* PKG_UTIL.DF_ROLE_STATE_NORMAL */

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
             set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
             leave label_proc;
        end if;

        select
             gateway_id
        into
             n_Tmp_To_Gateway_ID
        from
             UMS_ROLE
        where
             game_id = n_Game_ID and
             role_id = n_To_Role_ID and
             role_state = 1;    /* PKG_UTIL.DF_ROLE_STATE_NORMAL */

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
             set n_Result = -1252;    /* PKG_UTIL.E_ROLE_NOT_EXIST */
             leave label_proc;
        end if;

        if (n_Tmp_From_Gateway_ID <> n_Tmp_To_Gateway_ID) then
            set n_Result = -1014; /* PKG_UTIL.E_GATEWAY_DIFF */
            leave label_proc;
        end if;

        -- check the group's state
        select
            group_state
        into
            n_Tmp_Group_State
        from
            UMS_GROUP
        where
            game_id  = n_Game_ID and
            group_id = n_Group_ID and
            owner_id = n_From_Role_ID
        for update;

        if (FOUND_ROWS() = 0) then /* NO_DATA_FOUND */
            set n_Result =  -1900;    /* PKG_UTIL.E_GROUP_NOT_EXIST */
            leave label_proc;
        end if;

        if (n_Tmp_Group_State = 2) then    /* PKG_UTIL.DF_GROUP_STATE_DELETED */
            set n_Result =  -1903;    /* PKG_UTIL.E_GROUP_DELETED */
            leave label_proc;
        end if;

        -- marking to delete this group
        update
            UMS_GROUP
        set
            owner_id = n_To_Role_ID
        where
            game_id  = n_Game_ID and
            group_id = n_Group_ID;

        if (ROW_COUNT() = 0) then
            set n_Result =  -1900;    /* PKG_UTIL.E_GROUP_NOT_EXIST */
            leave label_proc;
        end if;

        set n_Result = 1;    /* PKG_UTIL.S_SUCCESS */
    end label_proc;
END$$

DELIMITER ;
