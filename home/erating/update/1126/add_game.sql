-- SYS_OPTION增加配置项

set @n_Game_ID   = 1204;                       -- game_id
set @n_Master_Game_ID   = 8;                -- master_game_id,如果不是基于某个游戏的混服联运请勿配置此项
set @s_Game_Name = 'erating_lmzg_brazil';
set @s_Game_Type = 'formal';                -- ('formal', 'trial', 'mingle_realm')
set @s_Op_Type   = 'oversea';               -- ('auto', 'union', 'oversea')
set @s_Draw_Balance_Ratio = '100';
set @s_Charge_Ratio = '1';

insert into SYS_GAME_ID(game_id, game_name) values (@n_Game_ID,  @s_Game_Name);
insert into SYS_GATEWAY (
    game_id,            gateway_id,          zone_id,
    gateway_code,       gateway_password,    gateway_name,
    gateway_ip,         gateway_mac,         gateway_state
) values (
    @n_Game_ID,         0,                   0,
    'sys_gateway',      '0',                 'System Gateway',
    2130706433,         '00-00-00-00-00-00', 1
);

-- 领用时3兑换5的比例
insert ignore into SYS_OPTION_INFO values('draw_balance_ratio',   @s_Draw_Balance_Ratio,    @s_Draw_Balance_Ratio);

-- 充值时金币兑换元宝的比例
insert ignore into SYS_OPTION_INFO values('charge_ratio',   @s_Charge_Ratio,    @s_Charge_Ratio);

insert into SYS_OPTION values(@n_Game_ID, 'beginner_activity',    '新手礼',                   '1');
insert into SYS_OPTION values(@n_Game_ID, 'active_beginner',      '激活码激活新手卡',         '0');
insert into SYS_OPTION values(@n_Game_ID, 'purchase_audit',       '消费对账（旧）',           '1');
insert into SYS_OPTION values(@n_Game_ID, 'special_username',     '返回特殊账号',             '0');
insert into SYS_OPTION values(@n_Game_ID, 'gw_leave_game',        '网关登录登出',             '1');
insert into SYS_OPTION values(@n_Game_ID, 'global_recharge',      '全区全服充值',             '0');
insert into SYS_OPTION values(@n_Game_ID, 'default_adult',        '成年人',                   '1');
insert into SYS_OPTION values(@n_Game_ID, 'online_check',         '在线检测',                 '1');
insert into SYS_OPTION values(@n_Game_ID, 'open_auth',            '开放登录',                 '1');
insert into SYS_OPTION values(@n_Game_ID, 'create_role_group',    '创建角色和团队',           '1');
insert into SYS_OPTION values(@n_Game_ID, 'allow_charge',         '充值功能',                 '1');
insert into SYS_OPTION values(@n_Game_ID, 'allow_mingle_realm',   '混服功能',                 if(@s_Op_Type = 'auto','1','0'));
insert into SYS_OPTION values(@n_Game_ID, 'role_gw_check',        '角色网关检测',             '1');
insert into SYS_OPTION values(@n_Game_ID, 'major_subject',	      '主要货币类型',	            '5');
insert into SYS_OPTION values(@n_Game_ID, 'auto_draw_balance',	  '元宝自动兑换',	            '1');
insert into SYS_OPTION values(@n_Game_ID, 'role_dup_ret_true',	  '相同帐号角色重名时返回正确','0');
insert into SYS_OPTION values(@n_Game_ID, 'original_role_name',	  '是否保持原角色名',         '0');

insert into SYS_OPTION values(@n_Game_ID, 'draw_balance_ratio',   '领用时3兑换5的比例',       @s_Draw_Balance_Ratio);
insert into SYS_OPTION values(@n_Game_ID, 'charge_ratio',   '充值时金币兑换元宝的的比例',       @s_Charge_Ratio);

insert into SYS_OPTION values(@n_Game_ID, 'game_type',            '游戏类型',                 @s_Game_Type);
insert into SYS_OPTION values(@n_Game_ID, 'op_type',              '运营类型',                 @s_Op_Type);

insert into sys_slave_games values(if(@s_Game_Type='mingle_realm',@n_Master_Game_ID,@n_Game_ID), @n_Game_ID, @s_Game_Name);
delete from sys_slave_games where slave_game_id=game_id;
insert into LOG_VERSION values(sysdate(),'4.3.4.8');
