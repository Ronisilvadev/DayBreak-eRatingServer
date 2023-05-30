/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2013-9-29 9:51:37                            */
/*==============================================================*/

alter table LOG_USER_FUND_DETAIL drop foreign key LOG_USER_FUND_DETAIL_FK;

alter table SYS_BLACKLIST drop foreign key SYS_BLACKLIST_FK1;

alter table SYS_GATEWAY drop foreign key SYS_GATEWAY_FK1;

alter table SYS_GATEWAY_STATE drop foreign key SYS_GATEWAY_STATE_FK1;

alter table SYS_OPTION drop foreign key SYS_OPTION_FK1;

alter table SYS_OPTION drop foreign key SYS_OPTION_FK2;

alter table SYS_PRODUCT_PRICE drop foreign key SYS_PRODUCT_PRICE_FK1;

alter table UMS_USER_FUND drop foreign key UMS_USER_FUND_FK1;

drop index LOG_ACTIVITY_SNAPSHOT_IX on LOG_ACTIVITY_SNAPSHOT;

drop table if exists LOG_ACTIVITY_SNAPSHOT;

drop index LOG_APPSTORE_CHARGE_IX2 on LOG_APPSTORE_CHARGE;

drop index LOG_APPSTORE_CHARGE_IX1 on LOG_APPSTORE_CHARGE;

drop table if exists LOG_APPSTORE_CHARGE;

drop table if exists LOG_DAILY_LOGID;

drop table if exists LOG_ITEM_SEND;

drop table if exists LOG_NEVER_ENTER_USERS;

drop index LOG_RATING_FUND_AUDIT_IX on LOG_RATING_FUND_AUDIT;

drop table if exists LOG_RATING_FUND_AUDIT;

drop index LOG_RECORD_DETAIL_IX2 on LOG_RECORD_DETAIL;

drop index LOG_RECORD_DETAIL_IX1 on LOG_RECORD_DETAIL;

drop index LOG_RECORD_DETAIL_IX on LOG_RECORD_DETAIL;

drop table if exists LOG_RECORD_DETAIL;

drop table if exists LOG_RECORD_IDCARD;

drop table if exists LOG_RECORD_PLUGIN_INFO;

drop index LOG_ROLE_FIRST_LOGIN_IX2 on LOG_ROLE_FIRST_LOGIN;

drop index LOG_ROLE_FIRST_LOGIN_IX on LOG_ROLE_FIRST_LOGIN;

drop table if exists LOG_ROLE_FIRST_LOGIN;

drop table if exists LOG_RT_USER_ONLINE_COUNT;

drop index LOG_SERIAL_USE_IX on LOG_SERIAL_USE;

drop table if exists LOG_SERIAL_USE;

drop table if exists LOG_STAT_STATE;

drop index LOG_UNITE_IX1 on LOG_UNITE;

drop index LOG_UNITE_IX on LOG_UNITE;

drop table if exists LOG_UNITE;

drop table if exists LOG_USER_ACTIVITY_GIFT;

drop index LOG_USER_CONSUME_POINT_IX on LOG_USER_CONSUME_POINT;

drop table if exists LOG_USER_CONSUME_POINT;

drop index LOG_USER_FIRST_LOGIN_INFO_IX1 on LOG_USER_FIRST_LOGIN_INFO;

drop index LOG_USER_FIRST_LOGIN_INFO_IX on LOG_USER_FIRST_LOGIN_INFO;

drop table if exists LOG_USER_FIRST_LOGIN_INFO;

drop index LOG_USER_FUND_AUDIT_IX on LOG_USER_FUND_AUDIT;

drop table if exists LOG_USER_FUND_AUDIT;

drop index LOG_USER_FUND_DETAIL_IX1 on LOG_USER_FUND_DETAIL;

drop index LOG_USER_FUND_DETAIL_IX on LOG_USER_FUND_DETAIL;

drop table if exists LOG_USER_FUND_DETAIL;

drop index LOG_USER_FUND_EXCHANGE_IX2 on LOG_USER_FUND_EXCHANGE;

drop index LOG_USER_FUND_EXCHANGE_IX1 on LOG_USER_FUND_EXCHANGE;

drop index LOG_USER_FUND_EXCHANGE_IX on LOG_USER_FUND_EXCHANGE;

drop table if exists LOG_USER_FUND_EXCHANGE;

drop index LOG_USER_ITEM_IX1 on LOG_USER_ITEM;

drop index LOG_USER_ITEM_IX on LOG_USER_ITEM;

drop table if exists LOG_USER_ITEM;

drop table if exists LOG_USER_ONLINE_COUNT;

drop index LOG_USER_PURCHASE_DETAIL_IX1 on LOG_USER_PURCHASE_DETAIL;

drop index LOG_USER_PURCHASE_DETAIL_IX on LOG_USER_PURCHASE_DETAIL;

drop table if exists LOG_USER_PURCHASE_DETAIL;

drop table if exists LOG_USER_UNCHARGE_DETAIL;

drop table if exists LOG_VERSION;

drop table if exists STAT_CEO_INFO;

drop table if exists STAT_CEO_INFO_REGION;

drop table if exists STAT_CHARGE;

drop table if exists STAT_LOGIN_USER_COUNT;

drop table if exists STAT_LOGIN_USER_COUNT_REGION;

drop table if exists STAT_NEW_USER;

drop table if exists STAT_NEW_USER_REGION;

drop table if exists STAT_PRODUCT_SALE;

drop table if exists STAT_PRODUCT_SALE_REGION;

drop table if exists STAT_PURCHASE_REGION;

drop table if exists STAT_ROLE_LEVEL_STAGE;

drop table if exists STAT_USER_LOGIN_TIMES;

drop table if exists STAT_USER_ONLINE;

drop table if exists STAT_USER_ONLINE_REGION;

drop table if exists SYS_ACTIVITY_CONSUME_DETAIL;

drop index SYS_ACTIVITY_DETAIL_IX on SYS_ACTIVITY_DETAIL;

drop table if exists SYS_ACTIVITY_DETAIL;

drop table if exists SYS_ACTIVITY_GATEWAY;

drop index SYS_ACTIVITY_INFO_IX on SYS_ACTIVITY_INFO;

drop table if exists SYS_ACTIVITY_INFO;

drop table if exists SYS_ACTIVITY_PACKAGE;

drop table if exists SYS_ACTIVITY_PACKAGE_ID;

drop table if exists SYS_APPSTORE_PRODUCT;

drop table if exists SYS_AUTH_OPTION;

drop table if exists SYS_BLACKLIST;

drop table if exists SYS_FILTER_HARDWARE_SN;

drop table if exists SYS_FILTER_IP;

drop table if exists SYS_FILTER_MAC;

drop table if exists SYS_GAME_ID;

drop index SYS_GATEWAY_IX1 on SYS_GATEWAY;

drop table if exists SYS_GATEWAY;

drop index SYS_GATEWAY_SETTING_IX on SYS_GATEWAY_SETTING;

drop table if exists SYS_GATEWAY_SETTING;

drop table if exists SYS_GATEWAY_STATE;

drop table if exists SYS_GATEWAY_UNITE;

drop table if exists SYS_IP_AREA;

drop table if exists SYS_IP_BONUS;

drop index SYS_JOINT_PURCHASE_PUSH_IX on SYS_JOINT_PURCHASE_PUSH;

drop table if exists SYS_JOINT_PURCHASE_PUSH;

drop table if exists SYS_LEVEL_STAGE;

drop table if exists SYS_OPTION;

drop table if exists SYS_OPTION_INFO;

drop table if exists SYS_PAY_DETAIL_AUDIT;

drop index SYS_PRODUCT_IX1 on SYS_PRODUCT;

drop table if exists SYS_PRODUCT;

drop index SYS_PRODUCT_PRICE_IX on SYS_PRODUCT_PRICE;

drop table if exists SYS_PRODUCT_PRICE;

drop table if exists SYS_RATING_FUND_SUMMARY;

drop table if exists SYS_SERIAL_NO;

drop table if exists SYS_SLAVE_GAMES;

drop table if exists SYS_UNION_ORDER;

drop index SYS_USER_CHARGE_IX on SYS_USER_CHARGE_INFO;

drop table if exists SYS_USER_CHARGE_INFO;

drop index SYS_USER_CHARGE_RECYCLE_IX on SYS_USER_CHARGE_INFO_RECYCLE;

drop table if exists SYS_USER_CHARGE_INFO_RECYCLE;

drop table if exists SYS_USER_ID;

drop index SYS_ZONE_IX1 on SYS_ZONE;

drop table if exists SYS_ZONE;

drop index UMS_GROUP_IX on UMS_GROUP;

drop table if exists UMS_GROUP;

drop index UMS_ROLE_IX2 on UMS_ROLE;

drop index UMS_ROLE_IX on UMS_ROLE;

drop index UMS_ROLE_IX1 on UMS_ROLE;

drop table if exists UMS_ROLE;

drop index UMS_USER_IX1 on UMS_USER;

drop table if exists UMS_USER;

drop table if exists UMS_USER_ACTIVITY_FLAG;

drop table if exists UMS_USER_APP_MSG;

drop table if exists UMS_USER_CONSUME_POINT;

drop table if exists UMS_USER_FUND;

drop table if exists UMS_USER_FUND_SUMMARY;

drop table if exists UMS_USER_ITEM;

drop index UMS_USER_PURCHASE_DETAIL_IX1 on UMS_USER_PURCHASE_DETAIL;

drop index UMS_USER_PURCHASE_DETAIL_IX on UMS_USER_PURCHASE_DETAIL;

drop table if exists UMS_USER_PURCHASE_DETAIL;

drop table if exists UMS_USER_SECURITY_CODE;

/*==============================================================*/
/* Table: LOG_ACTIVITY_SNAPSHOT                                 */
/*==============================================================*/
create table LOG_ACTIVITY_SNAPSHOT
(
   log_id               bigint not null auto_increment comment '日志ID',
   game_id              integer not null comment '游戏ID',
   activity_id          bigint not null comment '活动ID',
   begin_time           datetime not null comment '活动开始时间',
   end_time             datetime not null comment '活动结束时间',
   detail_snapshot      text not null comment '活动快照信息',
   mask_snapshot        varchar(1025) not null comment '活动模型互斥掩码的快照',
   primary key (log_id)
)
auto_increment = 100001;

alter table LOG_ACTIVITY_SNAPSHOT comment '活动快照';

/*==============================================================*/
/* Index: LOG_ACTIVITY_SNAPSHOT_IX                              */
/*==============================================================*/
create index LOG_ACTIVITY_SNAPSHOT_IX on LOG_ACTIVITY_SNAPSHOT
(
   game_id,
   activity_id,
   begin_time
);

/*==============================================================*/
/* Table: LOG_APPSTORE_CHARGE                                   */
/*==============================================================*/
create table LOG_APPSTORE_CHARGE
(
   charge_detail_id     varchar(128) not null comment '充值订单号',
   user_name            varchar(128) not null comment '用户名',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关ID',
   product_id           varchar(128) not null comment '购买物品的product标示符,示例:arthur.linekong.hz1',
   quantity             integer not null comment '物品购买数量',
   app_item_id          varchar(128) not null comment '用于标识transaction中app的唯一性字符.在sandbox创建的receipt没有该字段',
   transaction_id       varchar(128) not null comment '购买物品的transaction(事务)标示符,为transaction的transactionIdentifier 属性, 示例:1000000063634947',
   purchase_date        varchar(128) not null comment 'transaction发生时间,为transaction的transactionDate 属性, 示例:2013-02-02 14:00:39 Etc/GMT',
   purchase_date_ms     varchar(128) not null,
   purchase_date_pst    varchar(128) not null,
   original_transaction_id varchar(128) not null comment '最初的transaction标示符， 示例： 1000000063634947',
   original_purchase_date varchar(128) not null comment '最初的购买时间, 示例:2013-02-02 14:00:39 Etc/GMT',
   original_purchase_date_ms varchar(128) not null,
   original_purchase_date_pst varchar(128) not null,
   unique_identifier    varchar(128) not null comment '设备的唯一标识',
   bid                  varchar(128) not null comment 'app的bundle identifier',
   bvrs                 varchar(128) not null comment 'app版本号',
   operate_time         datetime not null comment '操作时间',
   charge_amount        integer not null comment '单个产品所对应的游戏币',
   product_price        float not null comment '产品单价',
   all_charge_amount    integer not null comment '本次订单对应的游戏币',
   all_product_price    float not null comment '产品总价',
   primary key (charge_detail_id)
);

alter table LOG_APPSTORE_CHARGE comment 'APPSTORE 充值日志表';

/*==============================================================*/
/* Index: LOG_APPSTORE_CHARGE_IX1                               */
/*==============================================================*/
create index LOG_APPSTORE_CHARGE_IX1 on LOG_APPSTORE_CHARGE
(
   user_name
);

/*==============================================================*/
/* Index: LOG_APPSTORE_CHARGE_IX2                               */
/*==============================================================*/
create index LOG_APPSTORE_CHARGE_IX2 on LOG_APPSTORE_CHARGE
(
   game_id,
   product_id,
   operate_time
);

/*==============================================================*/
/* Table: LOG_DAILY_LOGID                                       */
/*==============================================================*/
create table LOG_DAILY_LOGID
(
   log_date             datetime not null comment '记录日期。',
   table_name           varchar(32) not null comment '表名',
   log_id               bigint not null comment '每日起始的log_id。',
   primary key (log_date, table_name)
);

alter table LOG_DAILY_LOGID comment '记录若干日志表的每日的起始log_id。 ';

/*==============================================================*/
/* Table: LOG_ITEM_SEND                                         */
/*==============================================================*/
create table LOG_ITEM_SEND
(
   game_id              integer not null comment '游戏ID',
   order_code           varchar(32) not null comment '道具赠送订单号。',
   send_time            datetime not null comment '赠送发起时间。',
   activity_id          integer not null comment '道具赠送活动号。',
   user_name            varchar(32) not null comment '受赠帐号名。',
   gateway_id           integer not null comment '赠送目标网关ID。',
   primary key (game_id, order_code)
);

alter table LOG_ITEM_SEND comment '联运平台道具赠送日志。';

/*==============================================================*/
/* Table: LOG_NEVER_ENTER_USERS                                 */
/*==============================================================*/
create table LOG_NEVER_ENTER_USERS
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。来源于SYS_PASSPORT中的passport_id。',
   gateway_id           integer not null comment '游戏区组ID。',
   authen_time          datetime not null comment '帐号认证时间。',
   primary key (game_id, user_id)
);

alter table LOG_NEVER_ENTER_USERS comment '只认证过但没有进入过游戏的帐号。';

/*==============================================================*/
/* Table: LOG_RATING_FUND_AUDIT                                 */
/*==============================================================*/
create table LOG_RATING_FUND_AUDIT
(
   log_id               bigint not null auto_increment comment '日志ID',
   game_id              integer not null comment '游戏ID',
   rating_id            integer not null comment '收费唯一标志。0 - 忽略',
   subject_id           mediumint not null comment '科目ID，3 - 金元宝 5 - ?',
   audit_type           mediumint not null comment '比较类型：
            1 － eCharge充值总额 ＝ eRating充值总额
            2 － 账户余额 ＝ sum(账户明细余额)
            3 － 充值总额 ＝ sum(充值日志)
            4 － 消费总额 ＝ sum(消费明细)
            5 － 充值总额 ＝ 消费总额 + 余额
            [ subjectID = 5 时多了以下几种审计 ]
            6 － 充值总额 + 购入 ＝ 消费总额 + 余额 + 售出',
   diff_amount          integer not null comment '审计得到的差额，0－平，其它－差额',
   audit_time           datetime not null comment '审计时间',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_RATING_FUND_AUDIT comment '用户关系平衡·区组审计日志';

/*==============================================================*/
/* Index: LOG_RATING_FUND_AUDIT_IX                              */
/*==============================================================*/
create index LOG_RATING_FUND_AUDIT_IX on LOG_RATING_FUND_AUDIT
(
   game_id,
   rating_id,
   subject_id
);

/*==============================================================*/
/* Table: LOG_RECORD_DETAIL                                     */
/*==============================================================*/
create table LOG_RECORD_DETAIL
(
   login_id             bigint not null auto_increment comment '详单编号。',
   user_id              integer unsigned not null comment '玩家的帐号ID。',
   role_id              integer not null,
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '表示玩家当前登录时所在的网关编号。',
   server_id            integer comment '记录是哪个服务器进程上来的。命名规则为gateway_id + xx。',
   role_level           mediumint not null,
   money1               integer not null comment '当前下线时的金钱数1。',
   money2               integer not null comment '当前下线时的金钱数2。',
   experience           bigint not null comment '当前经验值。',
   login_time           datetime not null comment '本次登入时间。',
   logout_time          datetime comment '本次登出时间。',
   login_ip             integer unsigned not null comment '表示玩家当前登录的IP地址。',
   login_port           mediumint not null,
   stat_date            datetime comment '与login_time相同，但填入的是经圆整的yyyymmdd值，便于按日统计和建立索引。',
   province_code        varchar(16) comment '省代码',
   city_code            varchar(16) comment '市代码',
   country_code         varchar(16) not null comment '国家代码',
   mac                  varchar(16) comment '用户主机MAC。',
   hardware_sn1         varchar(32) comment '硬件序列号1',
   hardware_sn2         varchar(32) comment '硬件序列号2',
   client_type          integer not null,
   uddi                 varchar(64) comment '移动设备编号',
   primary key (login_id)
)
auto_increment = 100000;

alter table LOG_RECORD_DETAIL comment '玩家的登入登出详单信息表，该表可追踪玩家的登入登出行为。该表的压力非常大，需要考虑分区。';

/*==============================================================*/
/* Index: LOG_RECORD_DETAIL_IX                                  */
/*==============================================================*/
create index LOG_RECORD_DETAIL_IX on LOG_RECORD_DETAIL
(
   game_id,
   gateway_id
);

/*==============================================================*/
/* Index: LOG_RECORD_DETAIL_IX1                                 */
/*==============================================================*/
create index LOG_RECORD_DETAIL_IX1 on LOG_RECORD_DETAIL
(
   game_id,
   user_id
);

/*==============================================================*/
/* Index: LOG_RECORD_DETAIL_IX2                                 */
/*==============================================================*/
create index LOG_RECORD_DETAIL_IX2 on LOG_RECORD_DETAIL
(
   game_id,
   login_ip
);

/*==============================================================*/
/* Table: LOG_RECORD_IDCARD                                     */
/*==============================================================*/
create table LOG_RECORD_IDCARD
(
   id_code              varchar(32) not null,
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null,
   first_login_time     datetime not null,
   online_second_total  integer not null,
   offline_second_total integer not null,
   online_state         smallint not null,
   online_second_today  integer not null comment '当天在线时长',
   user_count           integer not null comment 'ID下在线用户数量',
   primary key (id_code, game_id, user_id)
);

alter table LOG_RECORD_IDCARD comment '以身份证信息绑定的登入记录。';

/*==============================================================*/
/* Table: LOG_RECORD_PLUGIN_INFO                                */
/*==============================================================*/
create table LOG_RECORD_PLUGIN_INFO
(
   log_id               bigint not null auto_increment comment '日志ID',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关ID',
   user_id              integer unsigned not null comment '帐号ID',
   role_id              integer unsigned not null comment '角色ID',
   log_time             datetime not null comment '记录时间',
   user_ip              integer unsigned not null comment '帐号所在IP',
   mac                  varchar(16) not null comment '帐号mac地址',
   message              varchar(128) not null comment '防外挂信息',
   type                 integer not null comment '信息类型',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_RECORD_PLUGIN_INFO comment '记录玩家外挂信息';

/*==============================================================*/
/* Table: LOG_ROLE_FIRST_LOGIN                                  */
/*==============================================================*/
create table LOG_ROLE_FIRST_LOGIN
(
   log_id               int not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   role_id              integer not null comment '角色ID。',
   user_id              integer unsigned not null comment '角色所属帐号ID。',
   gateway_id           integer not null comment '角色所属区组ID。',
   first_login_time     datetime not null comment '角色首次上线时间。',
   first_login_ip       integer unsigned not null comment '角色首次上线IP地址。',
   province_code        varchar(16) comment '省代码',
   city_code            varchar(16) comment '市代码',
   country_code         varchar(16) not null comment '国家代码',
   first_role           tinyint not null comment '是否所属帐号的第一个角色，1 - 是; 2 - 非。',
   mac                  varchar(16) comment '用户主机MAC。',
   client_type          integer not null,
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_ROLE_FIRST_LOGIN comment '记录角色首次进入游戏时的基本信息。';

/*==============================================================*/
/* Index: LOG_ROLE_FIRST_LOGIN_IX                               */
/*==============================================================*/
create unique index LOG_ROLE_FIRST_LOGIN_IX on LOG_ROLE_FIRST_LOGIN
(
   game_id,
   role_id
);

/*==============================================================*/
/* Index: LOG_ROLE_FIRST_LOGIN_IX2                              */
/*==============================================================*/
create index LOG_ROLE_FIRST_LOGIN_IX2 on LOG_ROLE_FIRST_LOGIN
(
   game_id,
   user_id
);

/*==============================================================*/
/* Table: LOG_RT_USER_ONLINE_COUNT                              */
/*==============================================================*/
create table LOG_RT_USER_ONLINE_COUNT
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关编号',
   server_id            integer not null comment '线编号',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '城市代码',
   user_online_count    integer not null comment '在线人数',
   primary key (game_id, province_code, city_code, gateway_id, server_id)
);

alter table LOG_RT_USER_ONLINE_COUNT comment '以网关、线、省、市做精确在线人数统计。';

/*==============================================================*/
/* Table: LOG_SERIAL_USE                                        */
/*==============================================================*/
create table LOG_SERIAL_USE
(
   log_id               integer not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '区组ID，0-全区全服。',
   serial_no            varchar(32) not null comment '序列号串',
   activity_id          integer not null comment '活动号',
   use_user_id          integer unsigned not null comment '被激活帐号ID。',
   use_time             datetime not null comment '激活时间。',
   use_ip               integer unsigned not null,
   province_code        varchar(16) not null comment '省代码',
   city_code            varchar(16) not null comment '市代码',
   primary key (log_id)
)
auto_increment = 100001;

alter table LOG_SERIAL_USE comment '序列号验证表。';

/*==============================================================*/
/* Index: LOG_SERIAL_USE_IX                                     */
/*==============================================================*/
create unique index LOG_SERIAL_USE_IX on LOG_SERIAL_USE
(
   game_id,
   gateway_id,
   serial_no,
   activity_id,
   use_user_id
);

/*==============================================================*/
/* Table: LOG_STAT_STATE                                        */
/*==============================================================*/
create table LOG_STAT_STATE
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   table_name           varchar(32) not null,
   stat_flag            tinyint not null comment '统计标志。0 - 未统计；1 - 已统计。',
   start_time           datetime comment '开始统计日期。',
   end_time             datetime comment '结束统计日期。',
   primary key (stat_date, table_name)
);

alter table LOG_STAT_STATE comment '统计状态标志。';

/*==============================================================*/
/* Table: LOG_UNITE                                             */
/*==============================================================*/
create table LOG_UNITE
(
   log_id               bigint not null auto_increment comment '日志唯一标识',
   game_id              integer not null comment '游戏ID',
   src_gateway_id       integer not null comment '被合服的网关ID',
   dst_gateway_id       integer not null comment '目标服的网关ID',
   exec_result          smallint not null comment '操作结果：
            1：成功
            0：失败',
   message              varchar(1024) not null comment '合并信息',
   exec_time            datetime not null comment '合服执行时间',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_UNITE comment '用于记录合服日志';

/*==============================================================*/
/* Index: LOG_UNITE_IX                                          */
/*==============================================================*/
create index LOG_UNITE_IX on LOG_UNITE
(
   src_gateway_id
);

/*==============================================================*/
/* Index: LOG_UNITE_IX1                                         */
/*==============================================================*/
create index LOG_UNITE_IX1 on LOG_UNITE
(
   dst_gateway_id
);

/*==============================================================*/
/* Table: LOG_USER_ACTIVITY_GIFT                                */
/*==============================================================*/
create table LOG_USER_ACTIVITY_GIFT
(
   log_id               bigint not null auto_increment comment '日志ID',
   game_id              integer not null comment '游戏ID',
   activity_id          integer not null comment '活动ID',
   user_id              integer unsigned not null comment '用户ID',
   role_id              integer not null comment '角色ID',
   gateway_id           integer not null comment '网关ID',
   send_time            datetime not null comment '从活动里得到礼品的时间',
   primary key (log_id)
)
auto_increment = 100001;

alter table LOG_USER_ACTIVITY_GIFT comment '保存用户从活动获得物品的时间';

/*==============================================================*/
/* Table: LOG_USER_CONSUME_POINT                                */
/*==============================================================*/
create table LOG_USER_CONSUME_POINT
(
   log_id               bigint not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '帐号ID。',
   amount               integer not null comment '积分:> 0 增加,< 0 减少',
   log_time             datetime not null comment '日志记录时间',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_USER_CONSUME_POINT comment '存储用户消费（购物）积分信息的日志表';

/*==============================================================*/
/* Index: LOG_USER_CONSUME_POINT_IX                             */
/*==============================================================*/
create index LOG_USER_CONSUME_POINT_IX on LOG_USER_CONSUME_POINT
(
   game_id,
   user_id
);

/*==============================================================*/
/* Table: LOG_USER_FIRST_LOGIN_INFO                             */
/*==============================================================*/
create table LOG_USER_FIRST_LOGIN_INFO
(
   log_id               bigint not null auto_increment,
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。来源于SYS_PASSPORT中的passport_id。',
   user_name            varchar(32) not null,
   gateway_id           integer not null comment '网关的唯一ID号。',
   first_login_time     datetime not null comment '首次登入时间。',
   first_login_ip       integer unsigned not null comment '首次登入IP地址。',
   first_login_port     mediumint not null comment '首次登入手',
   stat_date            datetime not null comment '为了方便统计。因为本表数据量极大，记录yyyyMMdd方便进行group by操作。 ',
   province_code        varchar(16) not null comment '省代码',
   city_code            varchar(16) not null comment '市代码',
   mac                  varchar(16) comment '用户主机MAC。',
   uddi                 varchar(64) comment '设备编号',
   primary key (log_id)
)
auto_increment = 100001;

alter table LOG_USER_FIRST_LOGIN_INFO comment '记录玩家首次上线时的基本信息。本表仅用于统计。';

/*==============================================================*/
/* Index: LOG_USER_FIRST_LOGIN_INFO_IX                          */
/*==============================================================*/
create unique index LOG_USER_FIRST_LOGIN_INFO_IX on LOG_USER_FIRST_LOGIN_INFO
(
   game_id,
   user_id
);

/*==============================================================*/
/* Index: LOG_USER_FIRST_LOGIN_INFO_IX1                         */
/*==============================================================*/
create unique index LOG_USER_FIRST_LOGIN_INFO_IX1 on LOG_USER_FIRST_LOGIN_INFO
(
   game_id,
   user_name
);

/*==============================================================*/
/* Table: LOG_USER_FUND_AUDIT                                   */
/*==============================================================*/
create table LOG_USER_FUND_AUDIT
(
   log_id               bigint not null auto_increment comment '日志ID',
   game_id              integer not null comment '游戏ID',
   rating_id            integer not null comment '收费唯一标志。0 - 忽略',
   user_id              integer unsigned not null comment '玩家唯一ID号',
   subject_id           mediumint not null comment '科目ID，3 - 蓝港币  5 - 金元宝',
   audit_type           mediumint not null comment '比较类型：
            1 － eCharge充值总额 ＝ eRating充值总额
            2 － 账户余额 ＝ sum(账户明细余额)
            3 － 充值总额 ＝ sum(充值日志)
            4 － 消费总额 ＝ sum(消费明细)
            5 － 充值总额 ＝ 消费总额 + 余额
            [ subjectID = 5 时多了以下几种审计 ]
            6 － 充值总额 + 购入 ＝ 消费总额 + 余额 + 售出',
   diff_amount          integer not null comment '审计得到的差额，0－平，其它－差额',
   audit_time           datetime not null comment '审计时间',
   primary key (log_id)
)
auto_increment = 100000;

/*==============================================================*/
/* Index: LOG_USER_FUND_AUDIT_IX                                */
/*==============================================================*/
create index LOG_USER_FUND_AUDIT_IX on LOG_USER_FUND_AUDIT
(
   game_id,
   rating_id,
   subject_id,
   user_id
);

/*==============================================================*/
/* Table: LOG_USER_FUND_DETAIL                                  */
/*==============================================================*/
create table LOG_USER_FUND_DETAIL
(
   log_id               bigint not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '帐号ID。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   subject_id           mediumint not null comment '科目ID，3 - 金元宝。',
   charge_amount        integer not null comment '充值额。',
   channel_id           mediumint not null comment '渠道ID。',
   discount             integer not null comment '折扣率。',
   charge_time          datetime not null comment '充值时刻。',
   charge_detail_id     bigint not null comment '充值流水号。',
   charge_order_code    varchar(32) not null,
   charge_type          tinyint not null comment '充值类型：1 - 充值，2 - 领用，3 - GM跨服转账。',
   promoter_id          integer not null comment '推广员帐号ID。',
   checksum             integer not null comment '校验位。',
   union_charge_time    datetime not null comment '联运方充值时间',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_USER_FUND_DETAIL comment '充值明细日志表。';

/*==============================================================*/
/* Index: LOG_USER_FUND_DETAIL_IX                               */
/*==============================================================*/
create index LOG_USER_FUND_DETAIL_IX on LOG_USER_FUND_DETAIL
(
   game_id,
   user_id,
   rating_id,
   subject_id
);

/*==============================================================*/
/* Index: LOG_USER_FUND_DETAIL_IX1                              */
/*==============================================================*/
create unique index LOG_USER_FUND_DETAIL_IX1 on LOG_USER_FUND_DETAIL
(
   game_id,
   charge_order_code,
   charge_type
);

/*==============================================================*/
/* Table: LOG_USER_FUND_EXCHANGE                                */
/*==============================================================*/
create table LOG_USER_FUND_EXCHANGE
(
   log_id               bigint not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   detail_id            bigint not null comment '交易流水号。',
   src_user_id          integer unsigned not null comment '源帐号ID。',
   src_role_id          integer not null comment '源角色ID。',
   dst_user_id          integer unsigned not null comment '目标帐号ID。',
   dst_role_id          integer not null comment '目标角色ID。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   subject_id           mediumint not null comment '货币类型：3-蓝港币；5-金元宝。',
   amount               integer not null comment '金额。',
   exchange_type        mediumint not null comment '交易类型。',
   exchange_time        datetime not null comment '交易时间。',
   checksum             integer not null,
   log_time             datetime not null comment '日志记录时间。',
   src_game_id          integer not null comment '源game_id',
   dst_game_id          integer not null comment '目标game_id',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_USER_FUND_EXCHANGE comment '元宝流通日志表。';

/*==============================================================*/
/* Index: LOG_USER_FUND_EXCHANGE_IX                             */
/*==============================================================*/
create unique index LOG_USER_FUND_EXCHANGE_IX on LOG_USER_FUND_EXCHANGE
(
   detail_id
);

/*==============================================================*/
/* Index: LOG_USER_FUND_EXCHANGE_IX1                            */
/*==============================================================*/
create index LOG_USER_FUND_EXCHANGE_IX1 on LOG_USER_FUND_EXCHANGE
(
   rating_id,
   src_user_id
);

/*==============================================================*/
/* Index: LOG_USER_FUND_EXCHANGE_IX2                            */
/*==============================================================*/
create index LOG_USER_FUND_EXCHANGE_IX2 on LOG_USER_FUND_EXCHANGE
(
   rating_id,
   dst_user_id
);

/*==============================================================*/
/* Table: LOG_USER_ITEM                                         */
/*==============================================================*/
create table LOG_USER_ITEM
(
   log_id               bigint not null auto_increment,
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。',
   role_id              integer not null comment '操作本记录的角色ID。若没有角色，请填入0。',
   gateway_id           integer not null comment '虚拟物品所在网关。',
   activity_id          integer not null comment '活动编号，',
   operation_code       char(1) not null comment '操作CODE：A - 增加；D - 减少；S - 设置。',
   item_code            varchar(32) not null comment '虚拟物品的接入码。',
   item_num             integer not null comment '虚拟物品数目。',
   send_order_code      varchar(32) comment '道具赠送订单号。',
   log_time             datetime not null comment '日志的记录时间。',
   primary key (log_id)
)
auto_increment = 100000;

alter table LOG_USER_ITEM comment '存储虚拟物品的信息的日志表。该表与游戏赠送有关。';

/*==============================================================*/
/* Index: LOG_USER_ITEM_IX                                      */
/*==============================================================*/
create index LOG_USER_ITEM_IX on LOG_USER_ITEM
(
   game_id,
   user_id
);

/*==============================================================*/
/* Index: LOG_USER_ITEM_IX1                                     */
/*==============================================================*/
create index LOG_USER_ITEM_IX1 on LOG_USER_ITEM
(
   game_id,
   log_time
);

/*==============================================================*/
/* Table: LOG_USER_ONLINE_COUNT                                 */
/*==============================================================*/
create table LOG_USER_ONLINE_COUNT
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关的唯一ID号。',
   server_id            integer not null,
   user_online_count    integer not null,
   primary key (game_id, gateway_id, server_id)
);

alter table LOG_USER_ONLINE_COUNT comment '记录网关下的在线人数信息。 ';

/*==============================================================*/
/* Table: LOG_USER_PURCHASE_DETAIL                              */
/*==============================================================*/
create table LOG_USER_PURCHASE_DETAIL
(
   log_id               bigint not null auto_increment comment '日志ID。',
   game_id              integer,
   purchase_id          bigint not null comment '订购产品的唯一编号。该编号将会被返回给游戏世界。',
   user_id              integer unsigned not null comment '玩家帐号ID。',
   role_id              integer not null comment '购买该IB道具的玩家角色ID号。',
   role_gender          tinyint not null comment '角色的性别。1 - 男，2 - 女，0 - 表示未定。',
   role_occupation      smallint not null comment '角色的职业/门派ID。',
   role_level           smallint not null comment '角色当前级别。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   gateway_id           integer not null comment '所在网关的ID号。',
   package_id           integer not null comment '若为0，表示单一产品，否则表示所从属的组合产品。',
   product_id           integer not null comment '本IB产品的唯一ID号。',
   product_code         varchar(32) not null comment 'IB代码',
   product_use_type     tinyint not null comment '产品使用类别：1 - 永久，2 - 分摊，3 - 按次，4 - 立即消耗（材料）。',
   product_num          integer not null comment '购买数量。',
   purchase_ip          integer unsigned not null comment '购买时玩家IP地址。',
   purchase_time        datetime not null comment '购买时间。',
   subject_id           mediumint not null comment '科目代号。3 - 金券, 4- 银券。',
   price_origin         integer comment '原始价格',
   price_discount       integer comment '折扣价格',
   cost_amount          integer not null comment '消费货币数。',
   promoter_id          integer not null comment '推广员的唯一ID号。',
   expire_time          datetime not null comment '道具过期时间。',
   use_user_id          integer unsigned not null comment '使用者帐号ID。',
   use_role_id          integer not null comment '使用者角色ID。',
   use_time             datetime comment '使用时间戳。',
   province_code        varchar(16) not null comment '省代号。',
   city_code            varchar(16) not null comment '市代号。',
   ad_id                bigint comment '广告ID。',
   log_time             datetime comment '记录时间',
   primary key (log_id)
);

alter table LOG_USER_PURCHASE_DETAIL comment '增值道具的购买记录详单 subject_id = 6';

/*==============================================================*/
/* Index: LOG_USER_PURCHASE_DETAIL_IX                           */
/*==============================================================*/
create index LOG_USER_PURCHASE_DETAIL_IX on LOG_USER_PURCHASE_DETAIL
(
   user_id
);

/*==============================================================*/
/* Index: LOG_USER_PURCHASE_DETAIL_IX1                          */
/*==============================================================*/
create unique index LOG_USER_PURCHASE_DETAIL_IX1 on LOG_USER_PURCHASE_DETAIL
(
   purchase_id
);

/*==============================================================*/
/* Table: LOG_USER_UNCHARGE_DETAIL                              */
/*==============================================================*/
create table LOG_USER_UNCHARGE_DETAIL
(
   charge_detail_id     bigint not null comment '充值流水号。',
   game_id              integer not null comment '游戏ID',
   uncharge_detail_id   bigint,
   uncharge_state       integer not null comment '操作状态：1-成功；2-已提交；X-错误码。',
   fund_log_id          bigint not null comment 'eChargeSvr反充值流水号。',
   src_rating_id        integer not null comment '源区组ID。',
   dst_rating_id        integer comment '目标区组ID。',
   operation_type       tinyint not null comment '操作类型：1-esales撤销，2-跨服转账。',
   uncharge_time        datetime not null,
   user_id              integer unsigned not null comment '帐号ID。',
   subject_id           mediumint not null comment '反充值科目：3-金元宝。',
   amount               integer not null comment '反充值金额。',
   uncharge_order_code  varchar(32),
   primary key (game_id, fund_log_id)
);

alter table LOG_USER_UNCHARGE_DETAIL comment '反充值（撤销、转账）日志表。';

/*==============================================================*/
/* Table: LOG_VERSION                                           */
/*==============================================================*/
create table LOG_VERSION
(
   deploy_time          datetime not null comment '部署时间',
   version              varchar(16) not null comment '版本号',
   primary key (deploy_time)
);

alter table LOG_VERSION comment '版本日志表';

/*==============================================================*/
/* Table: STAT_CEO_INFO                                         */
/*==============================================================*/
create table STAT_CEO_INFO
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '所在服编号。',
   max_count            integer not null comment '最大在线人数。',
   max_count_time       datetime not null comment '最大在线人数发生的时间点。',
   avg_count            integer not null comment '当日平均在线人数。',
   avg_seconds          integer not null comment '当日平均在线秒数',
   primary key (stat_date, game_id, gateway_id)
);

alter table STAT_CEO_INFO comment 'CEO统计信息，包括PCEO - 峰值在线人数和ACEO - 平均在线人数。';

/*==============================================================*/
/* Table: STAT_CEO_INFO_REGION                                  */
/*==============================================================*/
create table STAT_CEO_INFO_REGION
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '城市代码',
   max_count            integer not null comment '最大在线人数。',
   max_count_time       datetime not null comment '最大在线人数发生的时间点。',
   avg_count            integer not null comment '当日平均在线人数。',
   primary key (stat_date, game_id, province_code, city_code)
);

alter table STAT_CEO_INFO_REGION comment 'CEO统计信息，包括PCEO - 峰值在线人数和ACEO - 平均在线人数。';

/*==============================================================*/
/* Table: STAT_CHARGE                                           */
/*==============================================================*/
create table STAT_CHARGE
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   rating_id            integer not null comment '网关编号。',
   subject_id           mediumint not null comment '科目代号。3 - 表示金币。',
   channel_id           mediumint not null comment '渠道ID号。',
   charge_amount        integer not null comment '新增游戏“金币”充值数。',
   charge_amount_real   numeric(16,6) not null comment '折扣后的游戏“金币”数。',
   primary key (stat_date, game_id, rating_id, subject_id, channel_id)
);

alter table STAT_CHARGE comment '新增充值额统计。每日统计一次。';

/*==============================================================*/
/* Table: STAT_LOGIN_USER_COUNT                                 */
/*==============================================================*/
create table STAT_LOGIN_USER_COUNT
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '游戏区组ID。',
   role_count           integer not null comment '登录角色数。',
   user_count           integer not null comment '登录帐号数。',
   primary key (stat_date, game_id, gateway_id)
);

alter table STAT_LOGIN_USER_COUNT comment '每日登录用户、角色数统计。';

/*==============================================================*/
/* Table: STAT_LOGIN_USER_COUNT_REGION                          */
/*==============================================================*/
create table STAT_LOGIN_USER_COUNT_REGION
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '城市代码',
   role_count           integer not null comment '登录角色数。',
   user_count           integer not null comment '登录帐号数。',
   primary key (stat_date, game_id, province_code, city_code)
);

alter table STAT_LOGIN_USER_COUNT_REGION comment '每日登录用户数。';

/*==============================================================*/
/* Table: STAT_NEW_USER                                         */
/*==============================================================*/
create table STAT_NEW_USER
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '所在服编号。',
   user_count           integer not null comment '新增（进入）帐号数。',
   role_count           integer not null comment '新增角色数。',
   authen_users         integer not null comment '首登帐号数。',
   primary key (stat_date, game_id, gateway_id)
);

alter table STAT_NEW_USER comment '新增玩家统计。每日统计一次。';

/*==============================================================*/
/* Table: STAT_NEW_USER_REGION                                  */
/*==============================================================*/
create table STAT_NEW_USER_REGION
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省代码',
   city_code            varchar(16) not null comment '市代码',
   user_count           integer not null comment '新增帐户数。',
   role_count           integer not null comment '新增角色数。',
   primary key (stat_date, game_id, province_code, city_code)
);

alter table STAT_NEW_USER_REGION comment '新增玩家统计。每日统计一次。';

/*==============================================================*/
/* Table: STAT_PRODUCT_SALE                                     */
/*==============================================================*/
create table STAT_PRODUCT_SALE
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关编号。',
   package_id           integer not null comment '打包产品ID',
   product_id           integer not null comment '产品ID',
   subject_id           mediumint not null comment '科目代号。3 - 表示金币。',
   level_stage          mediumint not null,
   role_count           integer not null,
   purchase_count       integer not null comment '购买IB的数量。',
   purchase_amount      integer not null comment '所消耗的金币数。',
   primary key (stat_date, game_id, gateway_id, package_id, product_id, subject_id, level_stage)
);

alter table STAT_PRODUCT_SALE comment '每种IB购买数量、金额统计。
每日统计一次。
每种IB用户的级别段统计。';

/*==============================================================*/
/* Table: STAT_PRODUCT_SALE_REGION                              */
/*==============================================================*/
create table STAT_PRODUCT_SALE_REGION
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '生吃代码',
   package_id           integer not null comment '打包产品ID',
   product_id           integer not null comment '产品ID',
   subject_id           mediumint not null comment '科目代号。3 - 表示金币。',
   purchase_count       integer not null comment '购买IB的数量。',
   purchase_amount      integer not null comment '所消耗的金币数。',
   primary key (stat_date, game_id, province_code, city_code, package_id, product_id, subject_id)
);

alter table STAT_PRODUCT_SALE_REGION comment 'IB购买数量、金额统计。每日统计一次。';

/*==============================================================*/
/* Table: STAT_PURCHASE_REGION                                  */
/*==============================================================*/
create table STAT_PURCHASE_REGION
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '市代码',
   subject_id           mediumint not null comment '科目代号。3 - 表示金币。',
   purchase_amount      integer not null comment '消费金额。以金币为单位。',
   primary key (stat_date, game_id, province_code, city_code, subject_id)
);

alter table STAT_PURCHASE_REGION comment '玩家消费金额统计。每日统计一次。';

/*==============================================================*/
/* Table: STAT_ROLE_LEVEL_STAGE                                 */
/*==============================================================*/
create table STAT_ROLE_LEVEL_STAGE
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '所在服编号。',
   level_stage          mediumint not null comment '级别段，以该级别段的起始级别标识。',
   stat_period          smallint not null comment '统计周期以天为单位',
   login_count          integer not null comment '登录玩家数。',
   role_count           integer not null comment '角色总数',
   primary key (stat_date, game_id, gateway_id, level_stage, stat_period)
);

alter table STAT_ROLE_LEVEL_STAGE comment '按级别范围统计每日登录角色数，总角色数。';

/*==============================================================*/
/* Table: STAT_USER_LOGIN_TIMES                                 */
/*==============================================================*/
create table STAT_USER_LOGIN_TIMES
(
   stat_date            datetime not null comment '统计日期。yyyy-MM-dd。',
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '所在服编号。',
   server_id            integer not null,
   login_times          integer not null comment '登录次数。',
   primary key (stat_date, game_id, gateway_id, server_id)
);

alter table STAT_USER_LOGIN_TIMES comment '每日用户登录次数。';

/*==============================================================*/
/* Table: STAT_USER_ONLINE                                      */
/*==============================================================*/
create table STAT_USER_ONLINE
(
   stat_time            datetime not null,
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null,
   online_count         integer not null,
   primary key (stat_time, game_id, gateway_id)
);

alter table STAT_USER_ONLINE comment '在线玩家数统计。';

/*==============================================================*/
/* Table: STAT_USER_ONLINE_REGION                               */
/*==============================================================*/
create table STAT_USER_ONLINE_REGION
(
   stat_time            datetime not null comment '统计时间',
   game_id              integer not null comment '游戏ID',
   province_code        varchar(16) not null comment '省份代码',
   city_code            varchar(16) not null comment '城市代码',
   online_count         integer not null comment '在线人数',
   primary key (stat_time, game_id, province_code, city_code)
);

alter table STAT_USER_ONLINE_REGION comment '在线玩家数统计。';

/*==============================================================*/
/* Table: SYS_ACTIVITY_CONSUME_DETAIL                           */
/*==============================================================*/
create table SYS_ACTIVITY_CONSUME_DETAIL
(
   game_id              integer not null comment '游戏ID',
   activity_id          integer not null comment '活动ID。',
   limit_type           tinyint not null comment '条件类型：1  数量 、2 金额',
   subject_id           integer not null comment '科目代号。3 - 蓝港币 4- 银元宝 5-金元宝',
   product_code         varchar(32) not null comment '物品代码：',
   lower_limit          integer not null comment '条件下限',
   upper_limit          integer not null comment '条件上限',
   package_id           integer not null comment '礼品包ID',
   primary key (game_id, activity_id, product_code, lower_limit, upper_limit)
);

alter table SYS_ACTIVITY_CONSUME_DETAIL comment '消费促消活动详情';

/*==============================================================*/
/* Table: SYS_ACTIVITY_DETAIL                                   */
/*==============================================================*/
create table SYS_ACTIVITY_DETAIL
(
   package_id           integer not null comment '礼品包ID。',
   game_id              integer not null comment '游戏ID',
   activity_id          integer not null comment '活动ID。',
   lower_limit          integer not null comment '条件下限。',
   upper_limit          integer not null comment '条件上限。',
   primary key (game_id, activity_id, lower_limit, upper_limit)
);

alter table SYS_ACTIVITY_DETAIL comment '活动细节表';

/*==============================================================*/
/* Index: SYS_ACTIVITY_DETAIL_IX                                */
/*==============================================================*/
create unique index SYS_ACTIVITY_DETAIL_IX on SYS_ACTIVITY_DETAIL
(
   game_id,
   activity_id,
   lower_limit,
   upper_limit
);

/*==============================================================*/
/* Table: SYS_ACTIVITY_GATEWAY                                  */
/*==============================================================*/
create table SYS_ACTIVITY_GATEWAY
(
   game_id              integer not null comment '游戏ID',
   activity_id          integer not null comment '活动ID。',
   gateway_id           integer not null comment '区组ID。0 代表 全区全服。',
   primary key (game_id, activity_id, gateway_id)
);

alter table SYS_ACTIVITY_GATEWAY comment '活动网关';

/*==============================================================*/
/* Table: SYS_ACTIVITY_INFO                                     */
/*==============================================================*/
create table SYS_ACTIVITY_INFO
(
   game_id              integer not null comment '游戏ID',
   activity_id          integer not null comment '活动编号',
   flag_bit             integer comment '标志位的bit位数',
   activity_name        varchar(64) not null comment '活动名称。',
   activity_type        tinyint not null comment '活动类型 1激活码 2新手礼 3冲级赛 4渠道 5首次消费 6累计消费 7每日消费 8特定IP登陆道具发送 9每日最大兑换 10每日累计兑换 11期间累计兑换 12首次兑换',
   begin_time           datetime not null comment '活动开始时间',
   end_time             datetime not null comment '活动结束时间',
   activity_state       tinyint not null comment '活动状态：0-N/A；1-开启；2-关闭。',
   gift_begin_time      datetime comment '礼品领取时间下限。',
   effect_period        integer comment '礼品领取有效期。',
   role_begin_time      datetime comment '角色创建时间下限。',
   role_end_time        datetime comment '角色创建时间上限。',
   mask                 tinyblob not null comment '此活动的互斥情况',
   activity_times_limit integer not null default 1 comment '活动次数限制',
   primary key (game_id, activity_id)
);

alter table SYS_ACTIVITY_INFO comment '活动总表';

/*==============================================================*/
/* Index: SYS_ACTIVITY_INFO_IX                                  */
/*==============================================================*/
create index SYS_ACTIVITY_INFO_IX on SYS_ACTIVITY_INFO
(
   game_id,
   begin_time,
   end_time
);

/*==============================================================*/
/* Table: SYS_ACTIVITY_PACKAGE                                  */
/*==============================================================*/
create table SYS_ACTIVITY_PACKAGE
(
   package_id           integer not null comment '礼品包ID。',
   item_code            varchar(32) not null comment '物品代码。',
   item_name            varchar(32) not null comment '物品名称。',
   item_num             integer not null comment '赠送数量。',
   primary key (package_id, item_code)
);

alter table SYS_ACTIVITY_PACKAGE comment '赠送的道具明细表';

/*==============================================================*/
/* Table: SYS_ACTIVITY_PACKAGE_ID                               */
/*==============================================================*/
create table SYS_ACTIVITY_PACKAGE_ID
(
   package_id           integer not null auto_increment comment '活动包的ID',
   primary key (package_id)
)
auto_increment = 100001;

alter table SYS_ACTIVITY_PACKAGE_ID comment '保存活动对应包的ID';

/*==============================================================*/
/* Table: SYS_APPSTORE_PRODUCT                                  */
/*==============================================================*/
create table SYS_APPSTORE_PRODUCT
(
   game_id              integer not null comment '游戏id',
   product_id           varchar(128) not null comment '购买物品的product标示符， 示例： arthur.linekong.hz1',
   charge_amount        integer not null comment '单个产品所对应的游戏币',
   product_price        float not null comment '产品单价(单位:美元)',
   primary key (game_id, product_id)
);

alter table SYS_APPSTORE_PRODUCT comment 'APPSTORE物品表';

/*==============================================================*/
/* Table: SYS_AUTH_OPTION                                       */
/*==============================================================*/
create table SYS_AUTH_OPTION
(
   game_id              integer not null,
   option_code          varchar(32) not null,
   option_name          varchar(64),
   option_value         varchar(129) not null,
   primary key (game_id, option_code)
);

alter table SYS_AUTH_OPTION comment '认证配置。';

/*==============================================================*/
/* Table: SYS_BLACKLIST                                         */
/*==============================================================*/
create table SYS_BLACKLIST
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '用户ID',
   user_type            integer not null comment '用户类型',
   primary key (game_id, user_id, user_type)
);

alter table SYS_BLACKLIST comment '黑名单(测试用户)';

/*==============================================================*/
/* Table: SYS_FILTER_HARDWARE_SN                                */
/*==============================================================*/
create table SYS_FILTER_HARDWARE_SN
(
   game_id              integer not null comment '游戏ID',
   serial_no            varchar(32) not null,
   primary key (game_id, serial_no)
);

/*==============================================================*/
/* Table: SYS_FILTER_IP                                         */
/*==============================================================*/
create table SYS_FILTER_IP
(
   game_id              integer not null comment '游戏ID',
   ip                   integer unsigned not null,
   is_valid             tinyint not null comment '0 - 无效 1 - 有效',
   primary key (game_id, ip)
);

alter table SYS_FILTER_IP comment 'IP地址过滤表';

/*==============================================================*/
/* Table: SYS_FILTER_MAC                                        */
/*==============================================================*/
create table SYS_FILTER_MAC
(
   game_id              integer not null comment '游戏ID',
   mac                  varchar(16) not null comment '被封停的MAC地址。',
   primary key (game_id, mac)
);

alter table SYS_FILTER_MAC comment 'MAC地址过滤表';

/*==============================================================*/
/* Table: SYS_GAME_ID                                           */
/*==============================================================*/
create table SYS_GAME_ID
(
   game_id              integer not null comment '游戏ID',
   game_name            varchar(20) not null comment '游戏名称',
   primary key (game_id)
);

alter table SYS_GAME_ID comment '此数据库支持的game_id';

/*==============================================================*/
/* Table: SYS_GATEWAY                                           */
/*==============================================================*/
create table SYS_GATEWAY
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关的唯一序列号，高三位为区号，低三位为服号码，例如001002，001为区号，002为服号。',
   zone_id              smallint not null comment '本网关所在的逻辑区。',
   gateway_code         varchar(32) not null comment '网关的登入接入码。',
   gateway_password     varchar(32) not null comment '网关的登入密码。',
   gateway_name         varchar(32) not null comment '网关的名称。',
   gateway_ip           integer unsigned not null comment '网关的IP地址。',
   gateway_mac          varchar(18) not null comment '网关的MAC地址。格式为xx-xx-xx-xx-xx-xx。',
   gateway_state        tinyint not null comment '0 - 未开启；1 - 已开启；2 - 禁用。',
   primary key (game_id, gateway_id)
);

alter table SYS_GATEWAY comment '存储网关信息表。
数量级：200条。';

/*==============================================================*/
/* Index: SYS_GATEWAY_IX1                                       */
/*==============================================================*/
create unique index SYS_GATEWAY_IX1 on SYS_GATEWAY
(
   game_id,
   gateway_code
);

/*==============================================================*/
/* Table: SYS_GATEWAY_SETTING                                   */
/*==============================================================*/
create table SYS_GATEWAY_SETTING
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关的唯一序列号',
   gateway_type         tinyint not null comment '新增网关处理类型
            1. 消费对账
            2. 元宝流通对账
            3. 充值推送',
   gateway_code         varchar(32) not null comment '网关的登入接入码。',
   gateway_password     varchar(32) not null comment '网关的登入密码。',
   gateway_ip           varchar(16) not null comment '相应网关的对账程序IP地址。',
   gateway_port         mediumint not null comment '相应网关的对账程序端口。',
   state                tinyint not null comment '配置项状态
            1、正常
            2、新增
            3、修改
            4、禁用
            5、无效',
   primary key (game_id, gateway_id, gateway_type)
);

alter table SYS_GATEWAY_SETTING comment 'eChargeServer网关配置表。
数量级：200条。';

/*==============================================================*/
/* Index: SYS_GATEWAY_SETTING_IX                                */
/*==============================================================*/
create unique index SYS_GATEWAY_SETTING_IX on SYS_GATEWAY_SETTING
(
   game_id,
   gateway_code,
   gateway_type
);

/*==============================================================*/
/* Table: SYS_GATEWAY_STATE                                     */
/*==============================================================*/
create table SYS_GATEWAY_STATE
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '网关的唯一序列号。',
   last_active_time     datetime comment '上次活动时间。',
   last_logout_time     datetime comment '上次网关下线时间。',
   connect_id           integer not null comment '当前网关的总连接数。若为0，表示没有连接。',
   primary key (game_id, gateway_id)
);

alter table SYS_GATEWAY_STATE comment '存储网关的在线/下线状态码。';

/*==============================================================*/
/* Table: SYS_GATEWAY_UNITE                                     */
/*==============================================================*/
create table SYS_GATEWAY_UNITE
(
   dest_gateway_id      integer not null comment '目的网关id',
   src_gateway_id       integer not null comment '源网状id',
   game_id              integer not null comment '游戏ID',
   primary key (dest_gateway_id, src_gateway_id, game_id)
);

alter table SYS_GATEWAY_UNITE comment '记录合服信息';

/*==============================================================*/
/* Table: SYS_IP_AREA                                           */
/*==============================================================*/
create table SYS_IP_AREA
(
   id                   integer unsigned not null auto_increment,
   province             varchar(32),
   city                 varchar(32),
   country              varchar(32) not null,
   start_ip             integer unsigned not null,
   end_ip               integer unsigned not null,
   primary key (id)
)
auto_increment = 1;

alter table SYS_IP_AREA comment 'IP库';

/*==============================================================*/
/* Table: SYS_IP_BONUS                                          */
/*==============================================================*/
create table SYS_IP_BONUS
(
   user_ip              varchar(20) not null comment '用户IP',
   exp_bonus            integer not null comment '此IP经验加成百分比',
   tao_bonus            integer not null comment '此IP道行加成百分比',
   primary key (user_ip)
);

alter table SYS_IP_BONUS comment 'IP收益表';

/*==============================================================*/
/* Table: SYS_JOINT_PURCHASE_PUSH                               */
/*==============================================================*/
create table SYS_JOINT_PURCHASE_PUSH
(
   game_id              integer not null,
   detail_id            bigint unsigned not null,
   result_code          integer,
   user_id              integer unsigned,
   rating_id            integer,
   ib_code              varchar(32),
   ib_count             integer,
   subject_id           integer,
   discount_price       integer,
   send_times           integer,
   primary key (game_id, detail_id)
);

/*==============================================================*/
/* Index: SYS_JOINT_PURCHASE_PUSH_IX                            */
/*==============================================================*/
create index SYS_JOINT_PURCHASE_PUSH_IX on SYS_JOINT_PURCHASE_PUSH
(
   game_id,
   rating_id
);

/*==============================================================*/
/* Table: SYS_LEVEL_STAGE                                       */
/*==============================================================*/
create table SYS_LEVEL_STAGE
(
   game_id              integer not null comment '游戏ID',
   level_stage          integer not null comment 'LK对应等级',
   bgn_level            integer not null comment '开始级别',
   end_level            integer not null comment '结束级别',
   primary key (game_id, level_stage)
);

alter table SYS_LEVEL_STAGE comment 'level stage';

/*==============================================================*/
/* Table: SYS_OPTION                                            */
/*==============================================================*/
create table SYS_OPTION
(
   game_id              integer not null comment '游戏ID',
   option_code          varchar(32) not null comment '配置项名称',
   option_name          varchar(64) not null comment '配置项简短说明',
   option_value         varchar(32) not null comment '配置项值',
   primary key (game_id, option_code)
);

alter table SYS_OPTION comment '系统配置项，功能开关';

/*==============================================================*/
/* Table: SYS_OPTION_INFO                                       */
/*==============================================================*/
create table SYS_OPTION_INFO
(
   option_code          varchar(32) not null comment 'SYS_OPTION.key',
   option_value         varchar(32) not null comment '值',
   description          varchar(256) comment '值含义',
   primary key (option_code, option_value)
);

/*==============================================================*/
/* Table: SYS_PAY_DETAIL_AUDIT                                  */
/*==============================================================*/
create table SYS_PAY_DETAIL_AUDIT
(
   game_id              integer not null comment '游戏ID',
   gateway_id           integer not null comment '所在网关的ID号。',
   audit_type           tinyint not null comment '对账类型
            1. 消费对账
            2. 元宝流通对账',
   subject_id           mediumint not null comment '3 – 表示蓝港币；
            4 – 表示体验币或免费币；
            5 – 表示已兑换/领取元宝；',
   begin_purchase_id    bigint not null comment '审计的初始购买ID',
   audit_time           datetime not null comment '最后成功审计的时间',
   primary key (game_id, gateway_id, audit_type, subject_id)
);

/*==============================================================*/
/* Table: SYS_PRODUCT                                           */
/*==============================================================*/
create table SYS_PRODUCT
(
   product_id           integer not null auto_increment comment '产品的唯一序列号。',
   game_id              integer not null comment '游戏ID',
   product_code         varchar(32) not null comment '本产品的代码。该编号应该由游戏世界提供。',
   product_name         varchar(256) not null comment '本产品的名称。',
   product_class        smallint not null comment '产品分类',
   product_sub_class    smallint not null comment '表示产品子类。',
   product_level        smallint not null comment '产品的级别，默认为0。可任意设定。',
   product_use_type     tinyint not null comment '产品使用类别：1 - 永久，2 - 分摊，3 - 按次，4 - 立即消耗（材料）。',
   product_period       integer not null comment '产品有效时长，单位为秒。',
   product_attributes   varchar(64),
   product_state        tinyint not null comment '1 - 正常；2 - 无效。',
   insert_time          datetime not null comment '首次插入时间。',
   effect_time          datetime not null comment '生效日期。',
   expire_time          datetime not null comment '失效日期。',
   primary key (product_id, game_id)
)
auto_increment = 100001;

alter table SYS_PRODUCT comment '产品信息，';

/*==============================================================*/
/* Index: SYS_PRODUCT_IX1                                       */
/*==============================================================*/
create unique index SYS_PRODUCT_IX1 on SYS_PRODUCT
(
   game_id,
   product_code
);

/*==============================================================*/
/* Table: SYS_PRODUCT_PRICE                                     */
/*==============================================================*/
create table SYS_PRODUCT_PRICE
(
   price_id             integer not null auto_increment,
   game_id              integer not null,
   product_id           integer not null comment '产品的唯一序列号。',
   subject_id           mediumint not null comment '1 - 计点；2 - 包时；3 - 金币；4 - 体验币；5 - 积分',
   price_origin         integer not null comment '产品的标准价格。在初期，价格由游戏世界传入，本处仅供参考。单位为分。',
   price_discount       integer not null comment '折扣后价格。',
   effect_time          datetime not null comment '生效日期。',
   expire_time          datetime not null comment '失效日期。',
   primary key (price_id, game_id)
)
auto_increment = 100001;

alter table SYS_PRODUCT_PRICE comment '产品价格信息表。';

/*==============================================================*/
/* Index: SYS_PRODUCT_PRICE_IX                                  */
/*==============================================================*/
create unique index SYS_PRODUCT_PRICE_IX on SYS_PRODUCT_PRICE
(
   effect_time,
   game_id,
   product_id
);

/*==============================================================*/
/* Table: SYS_RATING_FUND_SUMMARY                               */
/*==============================================================*/
create table SYS_RATING_FUND_SUMMARY
(
   game_id              integer not null comment '游戏ID',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   subject_id           mediumint not null comment '货币代码。3  - 蓝港币；5-元宝。',
   total_charge         integer not null comment '充值总额。',
   total_purchase       integer not null comment '消费总额。',
   total_exchange       integer not null comment '交易总额',
   primary key (game_id, rating_id, subject_id)
);

/*==============================================================*/
/* Table: SYS_SERIAL_NO                                         */
/*==============================================================*/
create table SYS_SERIAL_NO
(
   game_id              integer not null comment '游戏ID',
   serial_no            varchar(32) not null comment '序列号串',
   activity_id          integer not null comment '活动号。',
   media_name           varchar(32) not null comment '媒体名称。',
   use_limit            integer not null comment '使用次数限制： 0 - 无限；1 - 普通；2 - 情侣。',
   serial_state         integer not null comment '状态：0 - 未使用、>=1 - 已使用。',
   create_time          datetime,
   primary key (game_id, serial_no)
);

alter table SYS_SERIAL_NO comment '激活码表。';

/*==============================================================*/
/* Table: SYS_SLAVE_GAMES                                       */
/*==============================================================*/
create table SYS_SLAVE_GAMES
(
   game_id              integer not null comment '游戏ID',
   slave_game_id        integer not null comment '游戏ID',
   slave_game_name      varchar(20) not null comment '游戏名称',
   primary key (slave_game_id, game_id)
);

alter table SYS_SLAVE_GAMES comment '允许跨game_id进行元宝流通的游戏列表,通过主库game_id查询从库game_id';

/*==============================================================*/
/* Table: SYS_UNION_ORDER                                       */
/*==============================================================*/
create table SYS_UNION_ORDER
(
   game_id              integer not null,
   lk_order             varchar(32) not null,
   union_order          varchar(150) not null,
   create_time          datetime,
   primary key (union_order)
);

/*==============================================================*/
/* Table: SYS_USER_CHARGE_INFO                                  */
/*==============================================================*/
create table SYS_USER_CHARGE_INFO
(
   fund_log_id          bigint not null comment '充值日志ID。',
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '用户ID。',
   rating_id            integer not null comment '充值目标区组ID。',
   subject_id           mediumint not null comment '科目ID，3 - 金元宝。',
   charge_amount        integer not null comment '充值金额。',
   charge_time          datetime not null comment '充值时间。',
   retry_times          mediumint not null comment '推送重试次数。',
   primary key (fund_log_id)
);

alter table SYS_USER_CHARGE_INFO comment '充值信息推送业务表。';

/*==============================================================*/
/* Index: SYS_USER_CHARGE_IX                                    */
/*==============================================================*/
create index SYS_USER_CHARGE_IX on SYS_USER_CHARGE_INFO
(
   game_id,
   user_id,
   rating_id,
   subject_id
);

/*==============================================================*/
/* Table: SYS_USER_CHARGE_INFO_RECYCLE                          */
/*==============================================================*/
create table SYS_USER_CHARGE_INFO_RECYCLE
(
   fund_log_id          bigint not null comment '充值日志ID。',
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '用户ID。',
   rating_id            integer not null comment '充值目标区组ID。',
   subject_id           mediumint not null comment '科目ID，3 - 金元宝。',
   charge_amount        integer not null comment '充值金额。',
   charge_time          datetime not null comment '充值时间。',
   retry_times          mediumint not null comment '推送重试次数。',
   primary key (fund_log_id)
);

alter table SYS_USER_CHARGE_INFO_RECYCLE comment '充值信息推送业务表。保存超过最大推送重试次数的充值信息。';

/*==============================================================*/
/* Index: SYS_USER_CHARGE_RECYCLE_IX                            */
/*==============================================================*/
create index SYS_USER_CHARGE_RECYCLE_IX on SYS_USER_CHARGE_INFO_RECYCLE
(
   game_id,
   user_id,
   rating_id,
   subject_id
);

/*==============================================================*/
/* Table: SYS_USER_ID                                           */
/*==============================================================*/
create table SYS_USER_ID
(
   user_id              integer unsigned not null auto_increment comment '联运方user_id',
   primary key (user_id)
)
auto_increment = 1500000000;

alter table SYS_USER_ID comment '存放联运方user_id';

/*==============================================================*/
/* Table: SYS_ZONE                                              */
/*==============================================================*/
create table SYS_ZONE
(
   zone_id              mediumint not null comment '区的唯一编号。',
   zone_code            varchar(32) not null comment '逻辑区的接入码，该字段暂时预留。',
   zone_name            varchar(32) not null comment '区的名称。如电信一区等。',
   zone_state           tinyint not null comment '0 - 免费；1 - 收费；2 - 禁用；3 - 临时状态。',
   primary key (zone_id)
);

alter table SYS_ZONE comment '本表中保存区的信息。
数量级：50';

/*==============================================================*/
/* Index: SYS_ZONE_IX1                                          */
/*==============================================================*/
create unique index SYS_ZONE_IX1 on SYS_ZONE
(
   zone_code
);

/*==============================================================*/
/* Table: UMS_GROUP                                             */
/*==============================================================*/
create table UMS_GROUP
(
   game_id              integer not null comment '游戏ID',
   group_id             integer not null auto_increment comment '团体ID。',
   group_name           varchar(32) not null comment '团体名称，例如“义和团”。',
   group_type           mediumint not null comment '团体类型。游戏自定义。',
   gateway_id           integer not null comment '团体所在区组ID。',
   founder_id           integer unsigned not null comment '创始人角色ID。',
   owner_id             integer unsigned not null comment '拥有者角色ID。',
   group_state          tinyint not null comment '团体的状态，例如，1 - 正常， 2 - 已删除。',
   create_time          datetime not null comment '创建时间。',
   delete_time          datetime comment '删除时间。',
   primary key (group_id)
)
auto_increment = 100001;

alter table UMS_GROUP comment '游戏各类团体信息存储表。';

/*==============================================================*/
/* Index: UMS_GROUP_IX                                          */
/*==============================================================*/
create unique index UMS_GROUP_IX on UMS_GROUP
(
   game_id,
   group_name
);

/*==============================================================*/
/* Table: UMS_ROLE                                              */
/*==============================================================*/
create table UMS_ROLE
(
   game_id              integer not null comment '游戏ID',
   role_id              integer not null auto_increment comment '角色唯一编号。',
   user_id              integer unsigned not null comment '角色所属的帐号ID。',
   role_name            varchar(32) not null comment '角色名称。',
   gateway_id           integer not null comment '角色所在的注册网关。',
   nationality_id       smallint not null comment '社区ID。',
   role_gender          tinyint not null comment '角色的性别。1 - 男，2 - 女，0 - 表示未定。',
   role_occupation      smallint not null comment '角色的职业/门派ID。',
   role_level           mediumint not null comment '角色当前级别。',
   role_state           tinyint not null comment '角色状态。1 - 正常，2 - 禁用，3 - 删除。',
   create_time          datetime not null comment '角色创建时间。',
   delete_time          datetime comment '角色删除时间。',
   last_logout_time     datetime comment '最近一次登出时间。',
   total_online_second  integer not null comment '总共累计在线秒数。',
   login_id             integer not null comment '登入ID号。',
   money1               integer not null comment '当前未绑定金钱数。',
   money2               integer not null comment '当前已绑定金钱数。',
   experience           bigint not null comment '当前经验数。',
   ad_id                bigint comment '广告ID',
   primary key (role_id)
)
auto_increment = 100001;

alter table UMS_ROLE comment '存储游戏帐号库。';

/*==============================================================*/
/* Index: UMS_ROLE_IX1                                          */
/*==============================================================*/
create unique index UMS_ROLE_IX1 on UMS_ROLE
(
   game_id,
   role_name
);

/*==============================================================*/
/* Index: UMS_ROLE_IX                                           */
/*==============================================================*/
create index UMS_ROLE_IX on UMS_ROLE
(
   game_id,
   user_id,
   role_state
);

/*==============================================================*/
/* Index: UMS_ROLE_IX2                                          */
/*==============================================================*/
create index UMS_ROLE_IX2 on UMS_ROLE
(
   game_id,
   gateway_id,
   role_state,
   login_id
);

/*==============================================================*/
/* Table: UMS_USER                                              */
/*==============================================================*/
create table UMS_USER
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null auto_increment comment '玩家的唯一ID号。来源于SYS_PASSPORT中的passport_id。',
   user_name            varchar(32) not null comment '玩家登录帐号。',
   password             varchar(32) not null comment '玩家的登录密码。',
   user_type            smallint not null comment '玩家类别。1 - 普通玩家；2 - 新手卡未添加安全信息帐号；3 - 新手卡已添加安全信息帐号。',
   gateway_id           integer not null comment '玩家的在线标志。> 0 - 实际的网关编号；0 - 表示离线。-1 - 表示已被冻结或禁用。',
   server_id            integer comment '特定游戏服务器的ID标识。',
   user_point           integer not null comment '玩家当前的积分，该字段暂时预留。',
   user_class           smallint not null comment '玩家的级别。该字段预留。',
   promoter_id          integer not null comment '对应的推广员ID号，若为0，表示没有推广员关联。',
   birthday             datetime comment '玩家的法定生日。',
   id_code              varchar(32) comment '身份证的唯一标识。',
   id_verify_flag       tinyint not null comment '身份证验证标志。0 - 表示未通过验证；1 - 表示已通过验证。',
   user_flag            integer not null comment '特殊标记。例如：禁言标志等。需要由跨区控制的状态量都由此维护。',
   user_state           smallint not null comment '用户临时状态。',
   ad_id                bigint comment '广告ID',
   primary key (user_id, game_id)
);

alter table UMS_USER comment '存储游戏帐号库。
数量级：4000万。';

/*==============================================================*/
/* Index: UMS_USER_IX1                                          */
/*==============================================================*/
create unique index UMS_USER_IX1 on UMS_USER
(
   game_id,
   user_name
);

/*==============================================================*/
/* Table: UMS_USER_ACTIVITY_FLAG                                */
/*==============================================================*/
create table UMS_USER_ACTIVITY_FLAG
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '帐号ID。',
   gateway_id           integer not null comment '区组ID。',
   mask                 tinyblob not null comment '赠送礼品标志。',
   primary key (game_id, user_id, gateway_id)
);

alter table UMS_USER_ACTIVITY_FLAG comment '活动标识总表';

/*==============================================================*/
/* Table: UMS_USER_APP_MSG                                      */
/*==============================================================*/
create table UMS_USER_APP_MSG
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。来源于SYS_PASSPORT中的passport_id。',
   client_type          integer not null comment '客户端类型',
   app_regist_id        varchar(256) not null comment '应用程序在三方平台的注册编号',
   primary key (game_id, user_id, client_type)
);

alter table UMS_USER_APP_MSG comment '记录与用户相关的APP相关信息';

/*==============================================================*/
/* Table: UMS_USER_CONSUME_POINT                                */
/*==============================================================*/
create table UMS_USER_CONSUME_POINT
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '用户ID',
   amount               integer not null comment '消费购物积分',
   primary key (game_id, user_id)
);

alter table UMS_USER_CONSUME_POINT comment '消费（购物）积分表';

/*==============================================================*/
/* Table: UMS_USER_FUND                                         */
/*==============================================================*/
create table UMS_USER_FUND
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的帐号ID。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   subject_id           mediumint not null comment '玩家科目代码。3  - 表示金币。',
   amount               integer not null comment '当前网关下的余额。',
   checksum             integer not null comment '校验位。',
   primary key (game_id, rating_id, user_id, subject_id)
);

alter table UMS_USER_FUND comment '余额信息表。';

/*==============================================================*/
/* Table: UMS_USER_FUND_SUMMARY                                 */
/*==============================================================*/
create table UMS_USER_FUND_SUMMARY
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的帐号ID。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   subject_id           mediumint not null comment '玩家科目代码。3  - 表示金币。',
   total_charge         integer not null comment '冲值总额。',
   total_purchase       integer not null comment '消费总额。',
   total_exchange_in    integer not null comment '元宝流通中账户流入元宝总额。',
   total_exchange_out   integer not null comment '元宝流通中账户流出元宝总额。',
   delay_msg            mediumint not null comment '延迟消息个数。',
   primary key (game_id, rating_id, user_id, subject_id)
);

alter table UMS_USER_FUND_SUMMARY comment '余额信息表。';

/*==============================================================*/
/* Table: UMS_USER_ITEM                                         */
/*==============================================================*/
create table UMS_USER_ITEM
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。',
   role_id              integer not null comment '角色ID',
   gateway_id           integer not null comment '虚拟物品所在网关。',
   activity_id          integer not null comment '活动编号，',
   item_code            varchar(32) not null comment '虚拟物品的接入码。',
   item_num             integer not null comment '虚拟物品数目。',
   begin_time           datetime not null comment '开始生效日期。',
   end_time             datetime not null comment '虚拟物品过期时间。若为无限使用，则填入一极大值。',
   primary key (game_id, user_id, role_id, gateway_id, activity_id, item_code, begin_time, end_time)
);

alter table UMS_USER_ITEM comment '存储虚拟物品的信息。该表与游戏赠送有关。';

/*==============================================================*/
/* Table: UMS_USER_PURCHASE_DETAIL                              */
/*==============================================================*/
create table UMS_USER_PURCHASE_DETAIL
(
   log_id               bigint not null auto_increment comment '日志ID。',
   game_id              integer not null comment '游戏ID',
   purchase_id          bigint not null comment '订购产品的唯一编号。该编号将会被返回给游戏世界。',
   user_id              integer unsigned not null comment '玩家帐号ID。',
   role_id              integer not null comment '购买该IB道具的玩家角色ID号。',
   role_gender          tinyint not null comment '角色的性别。1 - 男，2 - 女，0 - 表示未定。',
   role_occupation      smallint not null comment '角色的职业/门派ID。',
   role_level           smallint not null comment '角色当前级别。',
   rating_id            integer not null comment '收费唯一标志。0 - 表示在帐号上。',
   gateway_id           integer not null comment '所在网关的ID号。',
   package_id           integer not null comment '若为0，表示单一产品，否则表示所从属的组合产品。',
   product_id           integer not null comment '本IB产品的唯一ID号。',
   product_code         varchar(32) not null comment 'IB代码',
   product_use_type     tinyint not null comment '产品使用类别：1 - 永久，2 - 分摊，3 - 按次，4 - 立即消耗（材料）。',
   product_num          integer not null comment '购买数量。',
   purchase_ip          integer unsigned not null comment '购买时玩家IP地址。',
   purchase_time        datetime not null comment '购买时间。',
   subject_id           mediumint not null comment '科目代号。3 - 金券, 4- 银券。',
   price_origin         integer comment '原始价格',
   price_discount       integer comment '折扣价格',
   cost_amount          integer not null comment '消费货币数。',
   promoter_id          integer not null comment '推广员的唯一ID号。',
   expire_time          datetime not null comment '道具过期时间。',
   use_user_id          integer unsigned not null comment '使用者帐号ID。',
   use_role_id          integer not null comment '使用者角色ID。',
   use_time             datetime comment '使用时间戳。',
   province_code        varchar(16) not null comment '省代号。',
   city_code            varchar(16) not null comment '市代号。',
   ad_id                bigint comment '广告ID。',
   log_time             datetime comment '记录时间',
   primary key (log_id)
)
auto_increment = 100000;

alter table UMS_USER_PURCHASE_DETAIL comment '增值道具的购买记录详单。';

/*==============================================================*/
/* Index: UMS_USER_PURCHASE_DETAIL_IX                           */
/*==============================================================*/
create index UMS_USER_PURCHASE_DETAIL_IX on UMS_USER_PURCHASE_DETAIL
(
   game_id,
   user_id
);

/*==============================================================*/
/* Index: UMS_USER_PURCHASE_DETAIL_IX1                          */
/*==============================================================*/
create unique index UMS_USER_PURCHASE_DETAIL_IX1 on UMS_USER_PURCHASE_DETAIL
(
   game_id,
   purchase_id
);

/*==============================================================*/
/* Table: UMS_USER_SECURITY_CODE                                */
/*==============================================================*/
create table UMS_USER_SECURITY_CODE
(
   game_id              integer not null comment '游戏ID',
   user_id              integer unsigned not null comment '玩家的唯一ID号。',
   security_type        smallint not null comment '目前用到的类型为：1 - GM托管的IP地址限制；2 - 表示GM托管的临时密码；100 - 仓库及道具锁密码；101 - 商城金券密码。',
   security_code        varchar(32) not null comment '表示安全防护的属性值。若为MAC地址，则这里存入MAC地址。若为财产密码，则这里存入财产密码值。',
   effect_time          datetime not null comment '开始生效日期。',
   expire_time          datetime not null comment '过期日期。若需要表示无限期使用，则填入一极大值。',
   checksum             integer not null comment '校验位。',
   primary key (game_id, user_id, security_type)
);

alter table UMS_USER_SECURITY_CODE comment '玩家安全属性表。与增值业务有关。';

alter table LOG_USER_FUND_DETAIL add constraint LOG_USER_FUND_DETAIL_FK foreign key (user_id, game_id)
      references UMS_USER (user_id, game_id) on delete restrict on update restrict;

alter table SYS_BLACKLIST add constraint SYS_BLACKLIST_FK1 foreign key (user_id, game_id)
      references UMS_USER (user_id, game_id) on delete restrict on update restrict;

alter table SYS_GATEWAY add constraint SYS_GATEWAY_FK1 foreign key (game_id)
      references SYS_GAME_ID (game_id) on delete restrict on update restrict;

alter table SYS_GATEWAY_STATE add constraint SYS_GATEWAY_STATE_FK1 foreign key (game_id, gateway_id)
      references SYS_GATEWAY (game_id, gateway_id) on delete restrict on update restrict;

alter table SYS_OPTION add constraint SYS_OPTION_FK1 foreign key (option_code, option_value)
      references SYS_OPTION_INFO (option_code, option_value) on delete restrict on update restrict;

alter table SYS_OPTION add constraint SYS_OPTION_FK2 foreign key (game_id)
      references SYS_GAME_ID (game_id) on delete restrict on update restrict;

alter table SYS_PRODUCT_PRICE add constraint SYS_PRODUCT_PRICE_FK1 foreign key (product_id, game_id)
      references SYS_PRODUCT (product_id, game_id) on delete restrict on update restrict;

alter table UMS_USER_FUND add constraint UMS_USER_FUND_FK1 foreign key (user_id, game_id)
      references UMS_USER (user_id, game_id) on delete restrict on update restrict;

