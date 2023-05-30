drop procedure if exists disable_gateway_setting;
drop procedure if exists kickoff_user;
drop procedure if exists record_unite;
drop procedure if exists role_trans;
drop procedure if exists total_fund_trans;
drop procedure if exists fund_detail_trans;
drop procedure if exists log_fund_detail_trans;
drop procedure if exists log_fund_exchange_trans;
drop procedure if exists charge_info_trans;
drop procedure if exists user_fund_summary_trans;
drop procedure if exists rating_fund_summary_trans;
drop procedure if exists purchase_trans;
drop procedure if exists item_trans;
drop procedure if exists misc_trans;
drop procedure if exists activity_gateway_trans;
drop procedure if exists activity_flag_trans;
drop procedure if exists group_trans;
drop procedure if exists pre_log_unite;
drop procedure if exists do_unite;
drop procedure if exists check_checksum;

delimiter $$

/*合并服务器--禁用对账配置项*/
create procedure disable_gateway_setting(
  in  n_Game_ID           integer, 
  in  n_Src_Gateway_ID    integer,
  out n_Exec_Result       integer
)
begin
label_proc:begin

    set n_Exec_Result = 0;
    if(
    (n_Game_ID          is null) or
    (n_Src_Gateway_ID   is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    update  SYS_GATEWAY_SETTING
    set     state = 4
    where   gateway_id = n_Src_Gateway_ID
    and     game_id = n_Game_ID;

    set n_Exec_Result = 1;

end label_proc;
end$$

/*合并服务器--将原服所有帐号状态置为离线*/
create procedure kickoff_user(
    in  n_Game_ID           integer,
    in  n_Src_Gateway_ID    integer,
    out n_Exec_Result       integer
)
begin
    declare n_Temp_User_ID  integer unsigned;
    declare n_Stop        integer default 0;    

    declare cur_Temp_User cursor
    for
    select user_id
    from UMS_USER
    where game_id = n_Game_ID
    and gateway_id = n_Src_Gateway_ID;

    declare continue handler for not found set n_Stop = 1;

label_proc:begin

    set n_Exec_Result = 0;
    if(
    (n_Game_ID             is null) or
    (n_Src_Gateway_ID      is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp_User;
    label_loop:loop
        FETCH cur_Temp_User into n_Temp_User_ID;
        if (n_Stop = 1) then
            leave label_loop;
        end if;

        update UMS_USER
        set        gateway_id = 0, server_id = 0
        where      gateway_id = n_Src_Gateway_ID
              and        game_id = n_Game_ID
        and    user_id = n_Temp_User_ID;

    end loop label_loop;
    close cur_Temp_User;
    
    set n_Exec_Result = 1;

end label_proc;
end$$

/*合并服务器--记录日志*/
create procedure record_unite(
    in  n_Game_ID          integer,
    in  n_Dst_Gateway_ID   integer,
    in  n_Src_Gateway_ID   integer,
    in  n_Exec_Result      integer,
    in  s_Message        varchar(1024)
)
begin
label_proc:begin

    INSERT into LOG_UNITE(
    game_id,
    src_gateway_id, dst_gateway_id,
    exec_result,    message,
    exec_time
    )VALUES(
    n_Game_ID,
    n_Src_Gateway_ID, n_Dst_Gateway_ID,
    n_Exec_Result,    s_Message,
    now()
    );

end label_proc;
end$$

/*合并服务器--角色转服*/
create procedure role_trans(
    in  n_Game_ID          integer, 
    in  n_Dst_Gateway_ID   integer, 
    in  n_Src_Gateway_ID   integer, 
    out n_Exec_Result      integer
)
begin
    declare n_Counter1      integer default 0;
    declare n_Counter2      integer default 0;
    declare n_Stop        integer default 0;
    declare n_Temp_Role_ID    integer;

    declare cur_Temp_Role cursor for
    select role_id
    from UMS_ROLE
       where gateway_id = n_Src_Gateway_ID
        and game_id    = n_Game_ID;
    
    declare continue handler for not found set n_Stop = 1;
    set n_Exec_Result = 0;
label_proc:begin
    
    if(
    (n_Game_ID             is null) or
    (n_Dst_Gateway_ID         is null) or
    (n_Src_Gateway_ID         is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp_Role;
    label_loop:loop
        FETCH cur_Temp_Role into n_Temp_Role_ID;
              if (n_Stop = 1) then
                leave label_loop;
              end if;
        
        update UMS_ROLE
            set gateway_id = n_Dst_Gateway_ID, login_id = 0
            where gateway_id = n_Src_Gateway_ID
            and game_id        = n_Game_ID
        and role_id    = n_Temp_Role_ID;        

    end loop label_loop;
    close cur_Temp_Role;

    select count(role_id)
    into n_Counter1
    from UMS_ROLE
    where gateway_id = n_Src_Gateway_ID
    and   game_id    = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服角色：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的源服角色：XXX 失败；残留的源服角色数为 ', n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select count(role_id)
    into n_Counter2
    from UMS_ROLE
    where gateway_id = n_Dst_Gateway_ID
    and   game_id    = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
        concat('查询源服及目标服角色数量：',n_Counter1,' 源服角色数量；',n_Counter2,' 目标服角色数量'));

end label_proc;
end$$

/*合并服务器--总账户转服*/
create procedure total_fund_trans(
    in  n_Game_ID          integer,
    in  n_Dst_Gateway_ID   integer,
    in  n_Src_Gateway_ID   integer,
    in  n_Subject_ID       integer,
    out n_Exec_Result      integer
)
begin
    declare n_Counter1      integer default 0;
    declare n_Counter2      integer default 0;
    declare n_Counter3      integer default 0;
    declare n_Stop          integer default 0;
    declare n_Temp_User_ID  integer unsigned;
    declare n_Temp_Amount      integer default 0;
    declare n_Temp_Checksum integer default 0;

    declare cur_Temp_User_ID cursor for
        select distinct user_id
        from UMS_USER_FUND
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;
    set n_Exec_Result = 0;

label_proc:begin

    if(
    (n_Game_ID             is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_ID        is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp_User_ID;
    label_loop:loop
        FETCH cur_Temp_User_ID into n_Temp_User_ID;
        if (n_Stop = 1) then
            leave label_loop;
        end if;

        /*合并余额*/
        select sum(amount)
        into n_Temp_Amount
        from UMS_USER_FUND
        where rating_id in (n_Dst_Gateway_ID, n_Src_Gateway_ID)
        and subject_id = n_Subject_ID
        and user_id = n_Temp_User_ID
        and game_id = n_Game_ID;

        call checksum(n_Temp_User_ID,n_Dst_Gateway_ID,n_Subject_ID,n_Temp_Amount,n_Temp_Checksum,n_Exec_Result);

        if (n_Exec_Result <> 1) then
            leave label_loop;
        end if;

        INSERT into UMS_USER_FUND
        (game_id,user_id,rating_id,subject_id,amount,checksum)
        VALUES
        (n_Game_ID,n_Temp_User_ID,n_Dst_Gateway_ID,n_Subject_ID,n_Temp_Amount,n_Temp_Checksum)
        ON DUPLICATE KEY update
        amount = n_Temp_Amount, checksum = n_Temp_Checksum;

        /*删除原服记录*/
        DELETE from UMS_USER_FUND
        where user_id = n_Temp_User_ID
        and rating_id = n_Src_Gateway_ID
        and subject_id = n_Subject_ID
        and game_id = n_Game_ID;    
    end loop label_loop;
    close cur_Temp_User_ID;

    select count(user_id)
    into n_Counter1
    from UMS_USER_FUND
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服账户余额：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
            concat('检测是否所还有残留的源服账户余额：XXX 失败；残留的源服账户余额记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(amount), 0)
    into n_Counter2
    from UMS_USER_FUND
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;
    select ifnull(sum(amount), 0)
    into n_Counter3
    from UMS_USER_FUND
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result,
        concat('查询网关总账户余额信息：',
            n_Counter2,' 源服总账户 ums_user_fund 金元宝余额，',
            n_Counter3,' 目标服总账户 ums_user_fund 金元宝余额，')
        );

end label_proc;
end$$

/*合并服务器--账户充值消耗明细转服*/
create procedure fund_detail_trans(
    in  n_Game_ID          integer, 
    in  n_Dst_Gateway_ID   integer, 
    in  n_Src_Gateway_ID   integer, 
    in  n_Subject_ID       integer, 
    out n_Exec_Result      integer  
)
begin
    declare n_Min_Fund_Detail_ID      integer;
    declare n_Max_Fund_Detail_ID      integer;
    declare n_Counter1                integer default 0;
    declare n_Counter2                integer default 0;
    declare n_Counter3                integer default 0;
    declare n_Stop                    integer default 0;
    declare n_Temp_Fund_Detail_ID     integer;
    declare n_Temp_User_ID            integer unsigned;
    declare n_Temp_Left_Mount         integer;

    declare cur_Temp cursor for
        select fund_detail_id, user_id, left_amount
        from UMS_USER_FUND_DETAIL
    where (rating_id = n_Src_Gateway_ID)
        and (subject_id = n_Subject_ID)
        and (fund_detail_id >= n_Min_Fund_Detail_ID)
        and (fund_detail_id < (n_Min_Fund_Detail_ID + 10000))
        and (game_id = n_Game_ID);

    declare continue handler for not found set n_Stop = 1;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID             is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_ID        is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    select min(fund_detail_id), max(fund_detail_id)
    into n_Min_Fund_Detail_ID, n_Max_Fund_Detail_ID
    from UMS_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (n_Min_Fund_Detail_ID is null) then
        set n_Min_Fund_Detail_ID = 1;
    end if;

    if (n_Max_Fund_Detail_ID is null) then
        set n_Max_Fund_Detail_ID = 0;
    end if;

    label_loop1:loop
        if(n_Min_Fund_Detail_ID > n_Max_Fund_Detail_ID) then
            leave label_loop1;
        end if;

        open cur_Temp;
        label_loop2:loop
            FETCH cur_Temp into n_Temp_Fund_Detail_ID,n_Temp_User_ID,n_Temp_Left_Mount;
            if (n_Stop = 1) then
                leave label_loop2;
            end if;

            call checksum(n_Temp_User_ID,n_Dst_Gateway_ID,n_Subject_ID,n_Temp_Left_Mount,n_Temp_Checksum,n_Exec_Result);

            update UMS_USER_FUND_DETAIL
            set rating_id = n_Dst_Gateway_id,checksum = n_Temp_Checksum
            where fund_detail_id = n_Temp_Fund_Detail_ID
            and game_id = n_Game_ID;
        end loop label_loop2;
        close cur_Temp;

        set n_Min_Fund_Detail_ID = n_Min_Fund_Detail_ID + 10000;
    end loop label_loop1;

    select count(fund_detail_id)
    into n_Counter1
    from UMS_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服充值明细：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的源服充值明细：XXX 失败；残留的源服充值明细记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(left_amount), 0)
    into n_Counter2
    from UMS_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(left_amount), 0)
    into n_Counter3
    from UMS_USER_FUND_DETAIL
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
        concat('查询网关账户充值明细信息：',
            n_Counter2,' 源服总账户 ums_user_fund_detail 金元宝余额，',
            n_Counter3,' 目标服总账户 ums_user_fund_detail 金元宝余额，')
        );

end label_proc;
end$$

/*合并服务器--充值日志转服*/
create procedure log_fund_detail_trans(
    in  n_Game_ID           integer,
    in  n_Dst_Gateway_ID    integer, 
    in  n_Src_Gateway_ID    integer, 
    in  n_Subject_ID        integer, 
    out n_Exec_Result       integer  
)
begin
    declare n_Temp_Log_ID          integer default 0;
    declare n_Temp_Charge_Amount    integer default 0;
    declare n_Counter1              integer default 0;
    declare n_Counter2              integer default 0;
    declare n_Counter3              integer default 0;
    declare n_Stop              integer default 0;
    declare n_Temp_User_ID        integer unsigned;
    declare n_Temp_Checksum        integer;

    declare cur_Temp cursor for
        select log_id, user_id, charge_amount
        from LOG_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;
    set n_Exec_Result = 0;  

label_proc:begin

    if(
    (n_Game_ID            is null) or
    (n_Dst_Gateway_ID     is null) or
    (n_Src_Gateway_ID     is null) or
    (n_Subject_id         is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp;
    label_loop:loop
        FETCH cur_Temp into n_Temp_Log_ID, n_Temp_User_ID,n_Temp_Charge_Amount;
        if (n_Stop = 1) then
            leave label_loop;
        end if;

        call checksum(n_Temp_User_ID,n_Dst_Gateway_ID,n_Subject_ID,n_Temp_Charge_Amount,n_Temp_Checksum,n_Exec_Result);

        update LOG_USER_FUND_DETAIL
        set rating_id = n_Dst_Gateway_ID, checksum = n_Temp_Checksum
        where rating_id = n_Src_Gateway_ID
        and subject_id = n_Subject_ID
        and game_id = n_Game_ID
        and log_id = n_Temp_Log_ID;
    end loop label_loop;
    close cur_Temp;

    select count(log_id)
    into n_Counter1
    from LOG_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服充值日志：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的源服充值日志：XXX 失败；残留的源服充值日志记录数为',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(charge_amount), 0)
    into n_Counter2
    from LOG_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter3
    from LOG_USER_FUND_DETAIL
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
            concat('查询网关充值日志的总额信息：',
                n_Counter2,' 源服 log_user_fund_detail 的金元宝充值总额，',
                n_Counter3,' 目标服 log_user_fund_detail 的金元宝充值总额，')
            );
 
end label_proc;
end$$

/*合并服务器--元宝流通日志转服*/
create procedure log_fund_exchange_trans(
    in  n_Game_ID        integer,
    in  n_Dst_Gateway_ID       integer, 
    in  n_Src_Gateway_ID       integer, 
    in  n_Subject_ID       integer,
    out n_Exec_Result       integer
)
begin
    declare n_Min_Log_ID        integer;
    declare n_Max_Log_ID        integer;
    declare n_Counter1          integer default 0;
    declare n_Counter2          integer default 0;
    declare n_Stop              integer default 0;
    declare n_Log_Amount        integer;
    declare n_Log_Checksum      integer;
    declare n_Temp_Log_ID       integer;
    declare n_Temp_Src_User_ID      integer unsigned;
    declare n_Temp_Dst_User_ID      integer unsigned;
    declare n_Temp_Amount           integer;
    declare n_Temp_Checksum         integer;

    declare cur_Temp  cursor 
    for
    select log_id, src_user_id, dst_user_id, amount
    from   LOG_USER_FUND_EXCHANGE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_subject_id
    and log_id >= n_Min_Log_ID
    and log_id < n_Min_Log_ID + 10000
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID            is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_id         is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    select min(log_id), max(log_id)
    into n_Min_Log_ID, n_Max_Log_ID
    from LOG_USER_FUND_EXCHANGE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (n_Min_Log_ID is null) then
        set n_Min_Log_ID = 1;
    end if;

    if (n_Max_Log_ID is null) then
        set n_Max_Log_ID = 0;
    end if;

    label_loop1:loop
        if(n_Min_Log_ID > n_Max_Log_ID) then
            leave label_loop1;
        end if;

        open cur_Temp;
        label_loop2:loop
            FETCH cur_Temp into n_Temp_Log_ID, n_Temp_Src_User_ID, n_Temp_Dst_User_ID, n_Temp_Amount;
            if (n_Stop = 1) then
                leave label_loop2;
            end if;

            call checksumCashExchange(n_Dst_Gateway_ID,n_Temp_Src_User_ID,n_Temp_Dst_User_ID,n_Subject_ID,n_Temp_Amount,n_Temp_Checksum,n_Exec_Result);

            update LOG_USER_FUND_EXCHANGE
            set rating_id = n_Dst_Gateway_ID, checksum = n_Temp_Checksum
            where log_id = n_Temp_Log_ID;

        end loop label_loop2;
        close cur_Temp;
        commit;

        set n_Stop = 0;
        set n_Min_Log_ID = n_Min_Log_ID + 10000;
    end loop label_loop1;

    select count(log_id)
    into n_Counter1
    from LOG_USER_FUND_EXCHANGE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服元宝流通日志：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的源服元宝流通日志：XXX 失败；残留的源服元宝流通日志记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(amount),0)
    into n_Counter1
    from LOG_USER_FUND_EXCHANGE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(amount),0)
    into n_Counter2
    from LOG_USER_FUND_EXCHANGE
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
            concat('查询元宝流通日志的总体信息：',
            n_Counter1,'源服 LOG_USER_FUND_EXCHANGE 元宝总量；',
            n_Counter2,'目标服 LOG_USER_FUND_EXCHANGE 元宝总量')
            );

end label_proc;
end$$

/*合并服务器--充值消息转服,数量极少不用分批提交*/
create procedure charge_info_trans(
    in  n_Game_ID        integer,
    in  n_Dst_Gateway_ID    integer,
    in  n_Src_Gateway_ID    integer,
    in  n_Subject_ID    integer,
    out n_Exec_Result    integer 
)
begin
    declare n_Counter1  integer default 0;
    declare n_Counter2  integer default 0;
    declare n_Counter3  integer default 0;
    declare n_Counter4  integer default 0;
    declare n_Counter5  integer default 0;
    declare n_Counter6  integer default 0;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID            is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_ID        is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    update SYS_USER_CHARGE_INFO
    set rating_id = n_Dst_Gateway_ID
    where rating_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    update SYS_USER_CHARGE_INFO_RECYCLE
    set rating_id = n_Dst_Gateway_ID
    where rating_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    select count(fund_log_id)
    into n_Counter1
    from SYS_USER_CHARGE_INFO_RECYCLE
    where rating_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服充值推送回收站表查询：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的源服充值推送回收站表查询：XXX 失败；残留的源服充值推送回收站表记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(charge_amount), 0)
    into n_Counter5
    from SYS_USER_CHARGE_INFO_RECYCLE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter6
    from SYS_USER_CHARGE_INFO_RECYCLE
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
        concat('查询网关充值推送回收站的总额信息：',
        n_Counter5,' 源服 sys_user_charge_info_recycle 的金元宝充值总额;',
        n_Counter6,' 目标服 sys_user_charge_info_recycle 的金元宝充值总额')
        );

    select count(fund_log_id)
    into n_Counter2
    from SYS_USER_CHARGE_INFO
    where rating_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter2) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服充值信息查询：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
            concat('检测是否所还有残留的源服充值信息查询：XXX 失败；残留的源服充值信息记录数为 ',n_Counter2));
        set n_Exec_Result = -1;
    end if;

    select ifnull(sum(charge_amount), 0)
    into n_Counter3
    from SYS_USER_CHARGE_INFO
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter4
    from SYS_USER_CHARGE_INFO
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result, 
        concat('查询网关充值推送表的总额信息：',
        n_Counter3,' 源服 sys_user_charge_info 的金元宝充值总额;',
        n_Counter4,' 目标服 sys_user_charge_info 的金元宝充值总额')
        );

end label_proc;
end$$

/*合并服务器--账户充值、消费、元宝流通总额转服*/
create procedure user_fund_summary_trans(
    in  n_Game_ID          integer, 
    in  n_Dst_Gateway_ID   integer, 
    in  n_Src_Gateway_ID   integer, 
    in  n_Subject_ID       integer,
    out n_Exec_Result      integer
)
begin
    declare n_total_charge        integer default 0;
    declare n_total_purchase        integer default 0;
    declare n_total_exchange_in     integer default 0;
    declare n_total_exchange_out    integer default 0;
    declare n_Counter1              integer default 0;
    declare n_Counter2              integer default 0;
    declare n_Counter3              integer default 0;
    declare n_Counter4              integer default 0;
    declare n_Counter5              integer default 0;
    declare n_Stop              integer default 0;
    declare n_Temp_User_ID        integer unsigned;

    declare cur_Temp_User_ID  cursor 
    for
    select distinct user_id
    from   UMS_USER_FUND_SUMMARY            
    where   rating_id = n_Src_Gateway_ID
        and   subject_id = n_Subject_ID
        and   game_id = n_Game_ID;

    declare  continue handler for not found set n_Stop=1;
    set n_Exec_Result = 0;

 label_proc:begin

    if(
    (n_Game_ID              is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_id           is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp_User_ID;
    label_loop:loop
        FETCH cur_Temp_User_ID into n_Temp_User_ID;
        if (n_Stop = 1) then
            leave label_loop;
        end if;

        select     sum(total_charge),
            sum(total_purchase),
            sum(total_exchange_in),
            sum(total_exchange_out)
        into     n_total_charge,
            n_total_purchase,
            n_total_exchange_in,
            n_total_exchange_out
        from UMS_USER_FUND_SUMMARY
        where rating_id in (n_Dst_Gateway_ID, n_Src_Gateway_ID)
        and subject_id = n_Subject_ID
        and user_id = n_Temp_User_ID
        and game_id = n_Game_ID;

        INSERT into UMS_USER_FUND_SUMMARY
        (
        game_id, user_id, rating_id, subject_id,
        total_charge, total_purchase, total_exchange_in,
        total_exchange_out, delay_msg
        )
        VALUES
        (
        n_Game_ID, n_Temp_User_ID, n_Dst_Gateway_ID, n_subject_id,
        n_total_charge, n_total_purchase, n_total_exchange_in,
        n_total_exchange_out, 0
        )
        ON DUPLICATE KEY update
        total_charge       = n_total_charge,
        total_purchase     = n_total_purchase,
        total_exchange_in  = n_total_exchange_in,
        total_exchange_out = n_total_exchange_out;

        /*删除原服记录*/
        DELETE from UMS_USER_FUND_SUMMARY
        where user_id = n_Temp_User_ID
        and rating_id = n_Src_Gateway_ID
        and subject_id = n_subject_id
        and game_id = n_Game_ID;
    end loop label_loop;
    close cur_Temp_User_ID;

    select count(user_id)
    into n_Counter1
    from UMS_USER_FUND_SUMMARY
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_subject_id
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的账户充值，消费，元宝流通总额查询：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
            concat('检测是否所还有残留的账户充值，消费，元宝流通总额查询：XXX 失败；残留的账户充值，消费，元宝流通总额记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select ifnull(sum(total_charge), 0), ifnull(sum(total_purchase), 0)
    into n_Counter2, n_Counter3
    from UMS_USER_FUND_SUMMARY
    where rating_id = n_Src_Gateway_ID
    and subject_id  = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(total_charge), 0), ifnull(sum(total_purchase), 0)
    into n_Counter4, n_Counter5
    from UMS_USER_FUND_SUMMARY
    where rating_id = n_Dst_Gateway_ID
    and subject_id  = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result,
            concat('查询网关充值日志的总额信息：',
                n_Counter2,' 源服 ums_user_fund_summary 的金元宝充值总额，',
                n_Counter3,' 金元宝消费总额,',
                n_Counter4,' 目标服 ums_user_fund_summary 的金元宝充值总额，',
                n_Counter5,' 金元宝消费总额,')
            );

end label_proc;
end$$

/*合并服务器--网关充值、消费、元宝流通总额转服*/
create procedure rating_fund_summary_trans(
    in  n_Game_ID        integer, 
    in  n_Dst_Gateway_ID       integer, 
    in  n_Src_Gateway_ID       integer, 
    in  n_Subject_ID       integer, 
    out n_Exec_Result       integer 
)
begin
    declare n_Src_Total_Charge      integer default 0;
    declare n_Src_Total_Purchase    integer default 0;
    declare n_Src_Total_Exchange    integer default 0;
    declare n_Counter1            integer;
    set n_Exec_Result = 0;
label_proc:begin
    if(
    (n_Game_ID        is null) or
    (n_Dst_Gateway_ID         is null) or
    (n_Src_Gateway_ID         is null) or
    (n_Subject_id           is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    select  total_charge, total_purchase, total_exchange
    into  n_Src_Total_Charge, n_Src_Total_Purchase, n_Src_Total_Exchange
    from  SYS_RATING_FUND_SUMMARY
    where  game_id = n_Game_ID
    and  rating_id  = n_Src_Gateway_ID
    and  subject_id = n_Subject_ID;

    update  SYS_RATING_FUND_SUMMARY
    set     total_charge   = total_charge + n_Src_Total_Charge,
    total_purchase = total_purchase + n_Src_Total_Purchase,
    total_exchange = total_exchange + n_Src_Total_Exchange
    where  game_id = n_Game_ID
    and  rating_id  = n_Dst_Gateway_ID
    and  subject_id = n_Subject_ID;

    DELETE from  SYS_RATING_FUND_SUMMARY
    where  game_id = n_Game_ID
    and  rating_id  = n_Src_Gateway_ID
    and  subject_id = n_Subject_ID;

    select count(rating_id)
    into n_Counter1
    from SYS_RATING_FUND_SUMMARY
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
        concat('科目',n_Subject_ID,':检测是否所还有残留的源服网关充值，消费，元宝流通总额查询：√√√ 通过'));
        set n_Exec_Result = 1;
    else
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, 
        concat('科目',n_Subject_ID,':检测是否所还有残留的源服网关充值，消费，元宝流通总额查询：XXX 失败；残留的源服网关充值，消费，元宝流通总额记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;
end label_proc;
end$$

/*合并服务器--购买明细转服*/
create procedure purchase_trans(
    in  n_Game_ID          integer,
    in  n_Dst_GateWay_ID   integer,
    in  n_Src_GateWay_ID   integer,
    out n_Exec_Result      integer
)
begin
    declare n_Counter1    integer default 0;
    declare n_Stop        integer default 0;
    declare n_Log_ID      integer;

    declare cur_Temp  cursor 
    for
    select  log_id
    from   UMS_USER_PURCHASE_DETAIL            
    where   gateway_id = n_Src_Gateway_ID
    and   subject_id in (3, 5)
    and   game_id = n_Game_ID;

    declare  continue handler for not found set n_Stop=1;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID              is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp;
    label_loop:loop
        FETCH cur_Temp into n_Log_ID;
        if (n_Stop = 1) then
            leave label_loop;
        end if;

        update ums_user_purchase_detail
        set rating_id = n_Dst_Gateway_ID, gateway_id = n_Dst_Gateway_ID
        where log_id = n_Log_ID;
    end loop label_loop;
    close cur_Temp;

    select count(log_id)
    into n_Counter1
    from UMS_USER_PURCHASE_DETAIL
    where gateway_id = n_Src_GateWay_ID
    and subject_id in (3, 5)
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服购买明细：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
                concat('检测是否所还有残留的源服购买明细：XXX 失败；残留的源服购买明细记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

end label_proc;
end$$

/*合并服务器--帐号奖励转服*/
create procedure item_trans(
    in  n_Game_ID          integer, 
    in  n_Dst_Gateway_ID   integer, 
    in  n_Src_Gateway_ID   integer,
    out n_Exec_Result      integer
)
begin

label_proc:begin

    set n_Exec_Result = 0;
    if(
    (n_Game_ID              is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    INSERT IGNORE into SYS_GATEWAY_UNITE
        (dest_gateway_id, src_gateway_id, game_id)
    VALUES
        (n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Game_ID);

    update  SYS_GATEWAY_UNITE
    set  dest_gateway_id = n_Dst_Gateway_ID
    where   dest_gateway_id = n_Src_Gateway_ID
    and   game_id   = n_Game_ID;

    call record_unite( n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测账号奖励转服：√√√ 通过');
    set n_Exec_Result = 1;

end label_proc;
end$$

/*合并服务器--转服杂项*/
create procedure misc_trans(
    in  n_Game_ID         integer, 
    in  n_Src_Gateway_ID  integer, 
    out n_Exec_Result     integer  
)
begin
    declare  n_Counter1    integer default 0;
    declare  n_Counter2    integer default 0;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID        is null) or
    (n_Src_Gateway_ID       is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    /*源网关在线人数统计信息删除*/
    DELETE from LOG_USER_ONLINE_COUNT
    where  gateway_id = n_Src_Gateway_ID
    and  game_id = n_Game_ID;

    select count(gateway_id)
    into n_Counter1
    from LOG_USER_ONLINE_COUNT
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite( n_Game_ID, 0, n_Src_Gateway_ID, 1, '检测LOG_USER_ONLINE_COUNT是否所还有残留的在线人数记录：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, 0, n_Src_Gateway_ID, 0, 
            concat('检测LOG_USER_ONLINE_COUNT是否所还有残留的在线人数记录：XXX 失败；残留的在线人数记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
        leave  label_proc;
    end if;

    DELETE from LOG_RT_USER_ONLINE_COUNT
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    select count(gateway_id)
    into n_Counter2
    from LOG_RT_USER_ONLINE_COUNT
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter2) then
        call record_unite( n_Game_ID, 0, n_Src_Gateway_ID, 1, '检测LOG_RT_USER_ONLINE_COUNT是否所还有残留的在线人数记录：√√√ 通过');
        set n_Exec_Result = 1;
    ELSE
        call record_unite( n_Game_ID, 0, n_Src_Gateway_ID, 0, 
            concat('检测LOG_RT_USER_ONLINE_COUNT是否所还有残留的在线人数记录：XXX 失败；残留的在线人数记录数为 ',n_Counter2));
        set n_Exec_Result = 0;
    end if;

    /*将源服的网关状态改为禁用(状态2为禁用)*/
    update SYS_GATEWAY
    set gateway_state = 2
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    call disable_gateway_setting(n_Game_ID, n_Src_Gateway_ID,n_Exec_Result);
    call record_unite( n_Game_ID, 0, n_Src_Gateway_ID, 1, '合服日志:转服杂项');

end label_proc;
end$$

-- 活动区组信息转服
CREATE PROCEDURE activity_gateway_trans(
    in  n_Game_ID              integer, 
    in  n_Dst_Gateway_ID       integer, 
    in  n_Src_Gateway_ID       integer,
    out n_Exec_Result          integer
)
begin
    declare n_Counter1         integer default 0;
    declare n_Counter2         integer default 0;
    declare n_Err_Status       integer default 0;
    declare n_Tmp_Gateway_Id   integer;

    declare cur_Activity_Gateway cursor
    for
    select gateway_id
    from sys_activity_gateway
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Err_Status = 1;
    declare continue handler for 1062 set n_Err_Status = 1062;
label_proc:begin
    set n_Exec_Result = 0;

    open cur_Activity_Gateway;
    label_loop:loop
        fetch cur_Activity_Gateway into n_Tmp_Gateway_Id;

        if (n_Err_Status = 1) then
            leave label_loop;
        end if;

        update sys_activity_gateway
        set gateway_id = n_Dst_Gateway_ID
        where gateway_id = n_Tmp_Gateway_Id
        and game_id = n_Game_ID;

        if(n_Err_Status = 1062) then
            delete from sys_activity_gateway
            where gateway_id = n_Src_Gateway_ID
            and game_id = n_Game_ID;
        end if;

    end loop label_loop;
    close cur_Activity_Gateway;

    select count(activity_id)
    into n_Counter1
    from sys_activity_gateway
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的活动区组信息记录:√√√ 通过');
        set n_Exec_Result = 1;
    else
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
                concat('检测是否所还有残留的活动区组信息记录:XXX 失败；残留的活动区组信息记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select count(gateway_id)
    into n_Counter2
    from sys_activity_gateway
    where gateway_id = n_Dst_Gateway_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result,
                     concat('查询源服及目标服活动区组数量',
                            n_Counter1,
                            ' 源服活动区组数量:',
                            n_Counter2,
                            ' 目标服活动区组数量')
                     );
end label_proc;
end$$

-- 活动标识信息转服
CREATE PROCEDURE activity_flag_trans(
    in  n_Game_ID              integer, 
    in  n_Dst_Gateway_ID       integer, 
    in  n_Src_Gateway_ID       integer,
    out n_Exec_Result          integer
)
begin
    declare n_RetCode          integer default 0;
    declare n_Counter1         integer default 0;
    declare n_Counter2         integer default 0;
    declare n_Err_Status       integer default 0;

    declare n_Tmp_User_Id      integer unsigned;
    declare n_Tmp_Gateway_Id   integer;
    declare b_Tmp_Mask         tinyblob;
    declare b_Tmp_In_Mask      tinyblob;
    declare b_Tmp_Out_Mask     tinyblob;

    declare cur_User_Activity_Flag cursor
    for
    select user_id, gateway_id, mask
    from ums_user_activity_flag
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Err_Status = 1;
    declare continue handler for 1062 set n_Err_Status = 1062;
label_proc:begin
    set n_Exec_Result = 0;

    open cur_User_Activity_Flag;
    label_loop:loop
        fetch cur_User_Activity_Flag into
        n_Tmp_User_Id, n_Tmp_Gateway_Id, b_Tmp_Mask;

        if (n_Err_Status = 1) then
            leave label_loop;
        end if;

        update ums_user_activity_flag
        set gateway_id = n_Dst_Gateway_ID
        where game_id = n_Game_ID
        and user_id = n_Tmp_User_Id
        and gateway_id = n_Tmp_Gateway_Id;

        if(n_Err_Status = 1062) then
            select mask
            into b_Tmp_In_Mask
            from ums_user_activity_flag
            where game_id = n_Game_ID
            and user_id = n_Tmp_User_Id
            and gateway_id = n_Dst_Gateway_ID;

            call copyMask(b_Tmp_In_Mask, b_Tmp_Mask, b_Tmp_Out_Mask, n_RetCode);
            if(n_RetCode <> 1) then
                set n_Exec_Result = 0;
                leave label_proc;
            end if;

            update ums_user_activity_flag
            set mask = b_Tmp_Out_Mask
            where game_id = n_Game_ID
            and user_id = n_Tmp_User_Id
            and gateway_id = n_Dst_Gateway_ID;

            delete from ums_user_activity_flag
            where game_id = n_Game_ID
            and user_id = n_Tmp_User_Id
            and gateway_id = n_Tmp_Gateway_Id;
        end if;
    end loop label_loop;
    close cur_User_Activity_Flag;

    select count(user_id)
    into n_Counter1
    from ums_user_activity_flag
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的活动标志信息：√√√ 通过');
        set n_Exec_Result = 1;
    else
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
                concat('检测是否所还有残留的活动标志信息：XXX 失败；残留的活动标识信息记录数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select count(user_id)
    into n_Counter2
    from ums_user_activity_flag
    where gateway_id = n_Dst_Gateway_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result,
                      concat( '查询源服及目标服活动标识数量:',
                      n_Counter1,' 源服活动标识数量;',
                      n_Counter2,' 目标服活动标识数量')
                 );
end label_proc;
end$$

/*合并服务器--团体转服*/
CREATE PROCEDURE group_trans(
    in  n_Game_ID              integer, 
    in  n_Dst_Gateway_ID       integer, 
    in  n_Src_Gateway_ID       integer,
    out n_Exec_Result          integer
)
begin
    declare n_Counter1         integer default 0;
    declare n_Counter2         integer default 0;
    declare n_Stop             integer default 0;
    declare n_Temp_Group_ID    integer;

    declare cur_Temp_Group     cursor
    for
    select group_id
    from UMS_GROUP
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;    
    set n_Exec_Result = 0;
label_proc:begin
    if(
    (n_Game_ID              is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;

    open cur_Temp_Group;
    label_loop:loop
        FETCH cur_Temp_Group into n_Temp_Group_ID;
                  if (n_Stop = 1) then
                    leave label_loop;
                  end if;
            
        update UMS_GROUP
        set gateway_id = n_Dst_Gateway_ID
        where group_id = n_Temp_Group_ID;
    end loop label_loop;
    close cur_Temp_Group;

    select count(group_id)
    into n_Counter1
    from UMS_GROUP
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    if (0 = n_Counter1) then
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, '检测是否所还有残留的源服团体：√√√ 通过');
        set n_Exec_Result = 1;
    else
        call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0,
                concat('检测是否所还有残留的源服团体：XXX 失败；残留的源服团体数为 ',n_Counter1));
        set n_Exec_Result = 0;
    end if;

    select count(group_id)
    into n_Counter2
    from UMS_GROUP
    where gateway_id = n_Dst_Gateway_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Exec_Result,
        concat( '查询源服及目标服团体数量：',
            n_Counter1,' 源服团体数量;',
            n_Counter2,' 目标服团体数量')
        );
end label_proc;
end$$

/*合并服务器--合并前的日志记录*/
create procedure pre_log_unite(
    in  n_Game_ID             integer,
    in  n_Dst_Gateway_ID      integer,
    in  n_Src_Gateway_ID      integer,
    in  n_Subject_ID          integer,
    out n_Exec_Result         integer
)
begin
    declare n_Counter1      integer default 0;
    declare n_Counter2      integer default 0;
    declare n_Counter3      integer default 0;
    declare n_Counter5      integer default 0;
    declare n_Counter6      integer default 0;
    set n_Exec_Result = 0;
label_proc:begin

    if(
    (n_Game_ID              is null) or
    (n_Dst_Gateway_ID       is null) or
    (n_Src_Gateway_ID       is null) or
    (n_Subject_ID           is null)
    ) then
        set n_Exec_Result = -100;
        leave label_proc;
    end if;
    
    /*角色数据迁移记录*/
    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1,
            concat('合服前日志开始：源服[',n_Src_Gateway_ID,']->目标服[',n_Dst_Gateway_ID,']'));

    select count(role_id)
    into n_Counter1
    from UMS_ROLE
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    select count(role_id)
    into n_Counter2
    from UMS_ROLE
    where gateway_id = n_Dst_Gateway_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
                      concat('合服前的源服及目标服角色数量: ',
                             n_Counter1,' 源服角色数量;',
                             n_Counter2,' 目标服角色数量')
                      );

    /*记录账户余额信息*/
    select ifnull(sum(amount), 0)
    into n_Counter1
    from UMS_USER_FUND
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(amount), 0)
    into n_Counter3
    from UMS_USER_FUND
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
                      concat('记录查询网关总账户余额信息: ',
                      n_Counter1,' 源服总账户 ums_user_fund 金元宝余额,',
                      n_Counter3,' 目标服总账户 ums_user_fund 金元宝余额,')
                      );

    /*记录网关充值日志的总额信息*/
    select ifnull(sum(charge_amount), 0)
    into n_Counter1
    from LOG_USER_FUND_DETAIL
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter3
    from LOG_USER_FUND_DETAIL
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
                      concat('记录网关充值日志的总额信息: ',
                             n_Counter1,' 源服 log_user_fund_detail 的金元宝充值总额,',
                             n_Counter3,' 目标服 log_user_fund_detail 的金元宝充值总额,')
                      );

    /*记录网关充值推送表的总额信息*/
    select ifnull(sum(charge_amount), 0)
    into n_Counter1
    from SYS_USER_CHARGE_INFO
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter2
    from SYS_USER_CHARGE_INFO
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1,
                      concat('记录网关充值推送表的总额信息: ' ,
                             n_Counter1,' 源服 sys_user_charge_info 的金元宝充值总额;',
                             n_Counter2,' 目标服 sys_user_charge_info 的金元宝充值总额')
                      );

    /*记录网关充值推送回收站的总额信息*/
    select ifnull(sum(charge_amount), 0)
    into n_Counter1
    from SYS_USER_CHARGE_INFO_RECYCLE
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(charge_amount), 0)
    into n_Counter2
    from SYS_USER_CHARGE_INFO_RECYCLE
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1,
                      concat('记录网关充值推送回收站的总额信息: ',
                             n_Counter1,' 源服 sys_user_charge_info_recycle 的金元宝充值总额;',
                             n_Counter2,' 目标服 sys_user_charge_info_recycle 的金元宝充值总额')
                      );

    /*记录网关总额表的总额信息*/
    select ifnull(sum(total_charge), 0), ifnull(sum(total_purchase), 0)
    into n_Counter1, n_Counter2
    from UMS_USER_FUND_SUMMARY
    where rating_id = n_Src_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    select ifnull(sum(total_charge), 0), ifnull(sum(total_purchase), 0)
    into n_Counter5, n_Counter6
    from UMS_USER_FUND_SUMMARY
    where rating_id = n_Dst_Gateway_ID
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1,
                      concat( '记录网关总额表的总额信息: ',
                              n_Counter1,' 源服 ums_user_fund_summary 的金元宝充值总额,',
                              n_Counter2,' 金元宝消费总额,',
                              n_Counter5,' 目标服 ums_user_fund_summary 的金元宝充值总额,',
                              n_Counter6,' 金元宝消费总额,')
                      );

    /*团体数据迁移记录*/
    select count(group_id)
    into n_Counter1
    from UMS_GROUP
    where gateway_id = n_Src_Gateway_ID
    and game_id = n_Game_ID;

    select count(group_id)
    into n_Counter2
    from UMS_GROUP
    where gateway_id = n_Dst_Gateway_ID
    and game_id = n_Game_ID;

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
                      concat('合服前的源服及目标服团体数量: ',
                             n_Counter1,' 源服团体数量;',
                             n_Counter2,' 目标服团体数量')
                      );

    call record_unite(n_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 1, 
                      concat('合服前日志结束：源服[',n_Src_Gateway_ID,
                             ']->目标服[',n_Dst_Gateway_ID,']')
                      );

    set n_Exec_Result = 1;

end label_proc;
end$$

create procedure check_checksum(
    in  n_Game_ID       integer,
    in  dst_gw_id       integer,
    in  src_gw_id       integer,
    out n_Exec_Result   integer
)
begin
    declare n_Stop          integer default 0;
    declare n_Subject_ID    integer;
    declare n_Count1        integer default 0;
    declare n_Count2        integer default 0;
    declare n_Result        integer default 0;
    declare s_Tmp_Value     varchar(32);

    declare n_temp_user_id          integer unsigned;
    declare n_temp_amout            integer;
    declare n_temp_check_sum        integer;
    declare n_temp_check_sum_des    integer;
    declare n_temp_log_id           integer;
    declare n_temp_src_user_id      integer unsigned;
    declare n_temp_dst_user_id      integer unsigned;

    declare cur_tmp_user_fund cursor
    for
    select user_id, amount, checksum
    from ums_user_fund
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    declare cur_tmp_log_user_fund_detail cursor
    for
    select user_id, charge_amount, checksum
    from log_user_fund_detail
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    declare cur_tmp_log_user_fund_exchange cursor
    for
    select log_id, src_user_id, dst_user_id, amount, checksum
    from log_user_fund_exchange
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    declare continue handler for not found set n_Stop = 1;
label_proc:begin
    set n_Exec_Result = 1;

    call getOptionValue(n_Game_ID, 'major_subject', null, s_Tmp_Value);
    select s_Tmp_Value into n_Subject_ID;
-- ums_user_fund

    select count(*)
    into n_Count2
    from ums_user_fund
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if(n_Count2 > 0) then
        open cur_tmp_user_fund;
        label_loop:loop
            fetch cur_tmp_user_fund
            into 
            n_temp_user_id, n_temp_amout, n_temp_check_sum_des;
    
            if(n_Stop = 1) then
                leave label_loop;
            end if;

            call checksum(n_temp_user_id,
                          dst_gw_id,
                          n_Subject_ID,
                          n_temp_amout,
                          n_temp_check_sum,
                          n_Result
                          );

            if(n_temp_check_sum <> n_temp_check_sum_des) then
                set n_Count1 = n_Count1 + 1;
                call record_unite(n_Game_ID,
                                  dst_gw_id,
                                  src_gw_id,
                                  0,
                                  concat('帐号 ',n_temp_user_id,' 验证失败')
                                  );
                set n_Exec_Result = 0;
            end if;
        end loop label_loop;
        close cur_tmp_user_fund;

        if (0 = n_Count1) then
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              1,
                              '验证 ums_user_fund 的校验位字段 成功'
                              );
        else
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              0,
                              concat('验证 ums_user_fund 的校验位字段 失败 ',n_Count1)
                              );
            set n_Exec_Result = 0;
        end if;
    end if;

-- log_user_fund_detail
    set n_Count1 = 0;
    set n_Count2 = 0;
    set n_Stop   = 0;

    select count(*)
    into n_Count2
    from log_user_fund_detail
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if(n_Count2 > 0) then
        open cur_tmp_log_user_fund_detail;
        label_loop2:loop
            fetch cur_tmp_log_user_fund_detail
            into
            n_temp_user_id, n_temp_amout, n_temp_check_sum_des;

            if(n_Stop = 1) then
                leave label_loop2;
            end if;

            call checksum(n_temp_user_id,
                          dst_gw_id,
                          n_Subject_ID,
                          n_temp_amout,
                          n_temp_check_sum,
                          n_Result
                          );

            if(n_temp_check_sum <> n_temp_check_sum_des) then
                set n_Count1 = n_Count1 + 1;
                call record_unite(n_Game_ID,
                                  dst_gw_id,
                                  src_gw_id,
                                  0,
                                  concat('帐号 ', n_temp_user_id, ' 验证失败')
                                  );
                set n_Exec_Result = 0;
            end if;

        end loop label_loop2;
        close cur_tmp_log_user_fund_detail;

        if (0 = n_Count1) then
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              1,
                              '验证 log_user_fund_detail 的校验位字段 成功'
                              );
        else
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              0,
                              concat('验证 log_user_fund_detail 的校验位字段 失败 ', n_Count1)
                              );
            set n_Exec_Result = 0;
        end if;
    end if;

-- log_user_fund_exchange
    set n_Count1 = 0;
    set n_Stop   = 0;
    set n_Count2 = 0;

    select count(*)
    into n_Count2
    from log_user_fund_exchange
    where rating_id = dst_gw_id
    and subject_id = n_Subject_ID
    and game_id = n_Game_ID;

    if(n_Count2 > 0) then
        open cur_tmp_log_user_fund_exchange;
        label_loop3:loop
            fetch 
                cur_tmp_log_user_fund_exchange
            into
                n_temp_log_id,
                n_temp_src_user_id,
                n_temp_dst_user_id,
                n_temp_amout,
                n_temp_check_sum_des;

            if(1 = n_Stop) then
                leave label_loop3;
            end if;

            call checksumCashExchange(dst_gw_id,
                                      n_temp_src_user_id,
                                      n_temp_dst_user_id,
                                      n_Subject_ID,
                                      n_temp_amout,
                                      n_temp_check_sum,
                                      n_Result
                                      );

            if(n_temp_check_sum <> n_temp_check_sum_des) then
                set n_Count1 = n_Count1 + 1;
                call record_unite(n_Game_ID,
                                  dst_gw_id,
                                  src_gw_id,
                                  0,
                                  concat('元宝流通从帐号 ',n_temp_src_user_id,'到账号',n_temp_dst_user_id,' 验证失败')
                                  );
                set n_Exec_Result = 0;
            end if;

        end loop label_loop3;
        close cur_tmp_log_user_fund_exchange;

        if (0 = n_Count1) then
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              1,
                              '验证 log_user_fund_exchange 的校验位字段 成功'
                              );
        else
            call record_unite(n_Game_ID,
                              dst_gw_id,
                              src_gw_id,
                              0,
                              concat('验证 log_user_fund_exchange 的校验位字段 失败 ', n_Count1)
                              );
            set n_Exec_Result = 0;
        end if;
    end if;

end label_proc;
end$$

/*合并服务器--执行所有转服的数据操作*/
CREATE PROCEDURE do_unite(
    in  n_Game_ID            integer,
    in  n_Dst_Gateway_ID     integer,
    in  n_Src_Gateway_ID     integer,
    out n_Result             integer
)
begin
    declare n_Subject_ID    integer;
    declare n_RetCode       integer default 0;
    declare n_cur_Game_ID           integer;
    declare n_Stop                  integer;
    declare cur_Game_ID_List cursor for
        select
            n_Game_ID
        union   
        select
            slave_game_id
        from
            sys_slave_games
        where
            game_id = n_Game_ID;

label_proc:begin
    declare continue handler for not found set n_Stop = 1;
    open cur_Game_ID_List;
    set n_Result = 0;
    if(
        (n_Game_ID             is null) or
        (n_Dst_Gateway_ID      is null) or
        (n_Src_Gateway_ID      is null)
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
            call isGatewayIDExisted(n_cur_Game_ID,n_Dst_Gateway_ID,n_RetCode);
            if(n_RetCode <> 1) then
                call record_unite( n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode, '目标网关不存在');
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call isGatewayIDExisted(n_cur_Game_ID,n_Src_Gateway_ID ,n_RetCode);
            if(n_RetCode <> 1) then
                call record_unite( n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode, '源网关不存在');
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call getOptionValue(n_cur_Game_ID,'major_subject',null,n_Subject_ID);
            if ( n_Subject_ID is null ) then
                call record_unite( n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 0, '配置表里没有配置MAJOR_SUBJECT');
                set n_Result = 0;
                leave label_proc;
            end if;

            call pre_log_unite(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Subject_ID, n_RetCode);

            call role_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call total_fund_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Subject_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call log_fund_detail_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Subject_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call log_fund_exchange_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, 5, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call charge_info_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID,n_Subject_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call user_fund_summary_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Subject_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call rating_fund_summary_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_Subject_ID, n_RetCode);
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call purchase_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call item_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode);
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call misc_trans(n_cur_Game_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call activity_gateway_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call activity_flag_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call group_trans(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call check_checksum(n_cur_Game_ID, n_Dst_Gateway_ID, n_Src_Gateway_ID, n_RetCode );
            if( n_RetCode <> 1 ) then
                set n_Result = n_RetCode;
                leave label_proc;
            end if;

            call record_unite(n_cur_Game_ID,n_Dst_Gateway_ID,n_Src_Gateway_ID,n_Result,
                concat('合服后日志结束：源服[',n_Src_Gateway_ID,']->目标服[',n_Dst_Gateway_ID,']'));
            call record_unite(n_cur_Game_ID,n_Dst_Gateway_ID,n_Src_Gateway_ID,n_Result,'RESULT_CODE_UNITE');
        end loop label_loop;
        set n_Result = 1;
    end label_proc;
    call record_unite(n_Game_ID,n_Dst_Gateway_ID,n_Src_Gateway_ID,n_Result,
                concat('合服后日志结束：源服[',n_Src_Gateway_ID,']->目标服[',n_Dst_Gateway_ID,']'));
    call record_unite(n_Game_ID,n_Dst_Gateway_ID,n_Src_Gateway_ID,n_Result,'RESULT_CODE_UNITE');
    close cur_Game_ID_List;
end$$

delimiter ;
