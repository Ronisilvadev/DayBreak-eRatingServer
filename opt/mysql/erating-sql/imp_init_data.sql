-- SYS_OPTION_INFO增加所有选项
-- 开关式
insert into SYS_OPTION_INFO values('beginner_activity',    '0',        '否');
insert into SYS_OPTION_INFO values('beginner_activity',    '1',        '是');

insert into SYS_OPTION_INFO values('active_beginner',      '0',        '禁止');
insert into SYS_OPTION_INFO values('active_beginner',      '1',        '允许');

insert into SYS_OPTION_INFO values('purchase_audit',       '0',        '禁用');
insert into SYS_OPTION_INFO values('purchase_audit',       '1',        '启用');

insert into SYS_OPTION_INFO values('special_username',     '0',        '否');
insert into SYS_OPTION_INFO values('special_username',     '1',        '是');

insert into SYS_OPTION_INFO values('gw_leave_game',        '0',        '否');
insert into SYS_OPTION_INFO values('gw_leave_game',        '1',        '是');

insert into SYS_OPTION_INFO values('global_recharge',      '0',        '否');
insert into SYS_OPTION_INFO values('global_recharge',      '1',        '是');

insert into SYS_OPTION_INFO values('default_adult',        '1',        '未成年');
insert into SYS_OPTION_INFO values('default_adult',        '0',        '成年');

insert into SYS_OPTION_INFO values('online_check',         '1',        '否');
insert into SYS_OPTION_INFO values('online_check',         '0',        '是');

insert into SYS_OPTION_INFO values('open_auth',            '0',        '否');
insert into SYS_OPTION_INFO values('open_auth',            '1',        '是');

insert into SYS_OPTION_INFO values('create_role_group',    '0',        '禁止');
insert into SYS_OPTION_INFO values('create_role_group',    '1',        '允许');

insert into SYS_OPTION_INFO values('allow_charge',         '0',        '禁用');
insert into SYS_OPTION_INFO values('allow_charge',         '1',        '启用');

insert into SYS_OPTION_INFO values('allow_mingle_realm',         '0',        '禁用');
insert into SYS_OPTION_INFO values('allow_mingle_realm',         '1',        '启用');

insert into SYS_OPTION_INFO values('role_gw_check',        '0',        '禁用');
insert into SYS_OPTION_INFO values('role_gw_check',        '1',        '启用');

insert into SYS_OPTION_INFO values('auto_draw_balance',        '0',        '禁用');
insert into SYS_OPTION_INFO values('auto_draw_balance',        '1',        '启用');

-- 类型式
insert into SYS_OPTION_INFO values('game_type',            'formal',        '正式区');
insert into SYS_OPTION_INFO values('game_type',            'trial',         '体验区');
insert into SYS_OPTION_INFO values('game_type',            'mingle_realm',  '混服');

insert into SYS_OPTION_INFO values('op_type',              'auto',          '自主运营');
insert into SYS_OPTION_INFO values('op_type',              'union',         '国内联运');
insert into SYS_OPTION_INFO values('op_type',              'oversea',       '海外联运');

insert into SYS_OPTION_INFO values('major_subject',        '3',             '3');
insert into SYS_OPTION_INFO values('major_subject',        '5',             '5');

insert into SYS_ZONE (zone_id, zone_code, zone_name, zone_state) values (0, 'sys_zone', 'System Zone', 1);
insert into SYS_ZONE (zone_id, zone_code, zone_name, zone_state) values (201, 'zone201', '电信一区', 1);
insert into SYS_ZONE (zone_id, zone_code, zone_name, zone_state) values (101, 'zone101', '联通一区', 1);
insert into SYS_ZONE (zone_id, zone_code, zone_name, zone_state) values (601, 'zone601', '双线一区', 1);

commit;


