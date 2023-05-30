DROP PROCEDURE Number2IP;
DROP PROCEDURE isIPValid;
DROP PROCEDURE IP2Number;
DROP PROCEDURE getIPCount;
DROP PROCEDURE getIPTable;
DELIMITER $$

CREATE PROCEDURE Number2IP(
    in    n_IP_Address     integer unsigned,
    out   s_Ret_IP_Address varchar(32),
    out   n_Result         integer
)
BEGIN
    declare    n_IP_First  integer unsigned;
    declare    n_IP_Second integer unsigned;
    declare    n_IP_Third  integer unsigned;
    declare    n_IP_Fourth integer unsigned;
    lable_proc:begin
        set n_Result = 0;/*E_ERROR*/
        if (
            (n_IP_Address is null) or
            (
                (n_IP_Address < 0) or
                (n_IP_Address > 4294967295)
            )
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        set n_IP_First = floor(n_IP_Address/256/256/256);
        set n_IP_Second = floor(n_IP_Address/256/256);
        set n_IP_Third = floor(n_IP_Address/256);
        set s_Ret_IP_Address = concat(n_IP_First, '.', mod(n_IP_Second, 256), '.', mod(n_IP_Third, 256), '.', mod(n_IP_Address, 256));
        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
    if (n_Result <> 1/*S_SUCCESS*/) then
        set s_Ret_IP_Address = '0.0.0.0';
    end if;
END$$

CREATE PROCEDURE isIPValid(
    in    s_IP_Address      varchar(32),
    out   n_Ret_Is_IP_Valid integer,
    out   n_Result          integer
)
BEGIN
    declare    n_RetCode       integer;

    declare    n_Seg_Start     integer;
    declare    n_Seg_End       integer;
    declare    n_Seg_Number    integer;
    declare    n_Seg_Length    integer;

    declare    i               integer;
    lable_proc:begin
        declare exit handler for sqlexception set n_Result = 1;
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        set n_Seg_Start = 0;
        set n_Seg_End = 0;
        set n_Seg_Number = 0;
        set n_Seg_Length = 0;
        set i = 0;
        set n_Ret_Is_IP_Valid = 0;
        if (
            (s_IP_Address is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        set n_Seg_Start = 1;
        lable_loop:loop
            select locate('.', s_IP_Address, n_Seg_Start) into n_Seg_End;
            if (n_Seg_End = 0) then
                leave lable_loop;
            end if;
            set n_Seg_Length = n_Seg_End - n_Seg_Start;
            begin
                select cast(substring(s_IP_Address, n_Seg_Start, n_Seg_Length) as signed integer) into n_Seg_Number;
                if (
                    (i            = 0    ) and
                    (n_Seg_Number = 0    ) or
                    (n_Seg_Number is null) or
                    (n_Seg_Number < 0    ) or
                    (n_Seg_Number > 255  )
                ) then
                    leave lable_loop;
                end if;
            end;
            set n_Seg_Start = n_Seg_End + 1;
            set i = i + 1;
        end loop lable_loop;

        if (i <> 3) then
            set n_Result = 1;/*S_SUCCESS*/
            leave lable_proc;
        end if;
        begin
            select cast(substring(s_IP_Address, n_Seg_Start) as signed integer) into n_Seg_Number;
            if (
                (n_Seg_Number is null) or
                (n_Seg_Number < 0    ) or
                (n_Seg_Number > 255  )
            ) then
                leave lable_proc;
            end if;
        end;

        set n_Ret_Is_IP_Valid = 1;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE IP2Number(
    in    s_IP_Address     varchar(32),
    out   n_Ret_IP_Address integer unsigned,
    out   n_Result         integer
)
BEGIN
    declare n_RetCode      integer;

    declare n_Seg_Start    integer;
    declare n_Seg_End      integer;
    declare n_Seg_Number   integer unsigned;
    declare n_Seg_Length   integer;

    declare i              integer;
    lable_proc:begin
        declare exit handler for sqlexception set n_Result = 1;
        set n_Result = 0;/*E_ERROR*/
        set n_RetCode = 0;
        set n_Seg_Start = 0;
        set n_Seg_End = 0;
        set n_Seg_Number = 0;
        set n_Seg_Length = 0;
        set i = 0;
        if (
            (s_IP_Address is null)
        ) then
            set n_Result = -100;/*E_PARAMETER_ERROR*/
            leave lable_proc;
        end if;

        set n_Seg_Start      = 1;
        set n_Ret_IP_Address = 0;
        lable_loop:loop
            select locate('.', s_IP_Address, n_Seg_Start) into n_Seg_End;
            if (n_Seg_End = 0) then
                leave lable_loop;
            end if;
            set n_Seg_Length = n_Seg_End - n_Seg_Start;
            begin
                select cast(substring(s_IP_Address, n_Seg_Start, n_Seg_Length) as unsigned integer) into n_Seg_Number;
                if (
                    (i            = 0    ) and
                    (n_Seg_Number = 0    ) or
                    (n_Seg_Number is null) or
                    (n_Seg_Number < 0    ) or
                    (n_Seg_Number > 255  )
                ) then
                    leave lable_proc;
                end if;
                set n_Ret_IP_Address = n_Ret_IP_Address + n_Seg_Number * power(256, 3 - i);
            end;
            set n_Seg_Start = n_Seg_End + 1;
            set i = i + 1;
        end loop lable_loop;

        if (i <> 3) then
            leave lable_proc;
        end if;
        begin
            select cast(substring(s_IP_Address, n_Seg_Start) as unsigned integer) into n_Seg_Number;
            if (
                (n_Seg_Number is null) or
                (n_Seg_Number < 0    ) or
                (n_Seg_Number > 255  )
            ) then
                leave lable_proc;
            end if;
            set n_Ret_IP_Address = n_Ret_IP_Address + n_Seg_Number;
        end;

        set n_Result = 1;/*S_SUCCESS*/
    end lable_proc;
END$$

CREATE PROCEDURE getIPCount(
    OUT n_Row_Count     INTEGER UNSIGNED,
    OUT n_Result        INTEGER
)
BEGIN
    label_proc:BEGIN
        SELECT
            COUNT(*)
        INTO
            n_Row_Count
        FROM
            SYS_IP_AREA;
        SET n_Result = 1;
     END label_proc;
END$$

CREATE PROCEDURE getIPTable(
    IN n_Start        INTEGER UNSIGNED,
    IN n_Stop         INTEGER UNSIGNED
)
BEGIN
    DECLARE n_Result INTEGER;
    label_proc:BEGIN
        IF (
            ( n_Start  IS NULL )OR
            ( n_Stop   IS NULL )OR
            ( n_Start  < 0)     OR
            ( n_Start  > n_Stop)  
           ) THEN
            SET n_Result = -100;
            SELECT n_Result;
            LEAVE label_proc;
        END IF;
        
        SET n_Result = 1;
        SELECT n_Result;
        
        SELECT
            start_ip,end_ip,province,city,country 
        FROM
            SYS_IP_AREA
        WHERE
            (id >  n_Start) AND
            (id <= n_Stop);
     END label_proc;
END$$

DELIMITER ;
