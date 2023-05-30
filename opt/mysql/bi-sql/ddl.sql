-- 1、注意修改充值和消耗比例
-- 2、级别分段
-- 3、更换用户直接替换ebi
DROP database IF EXISTS `ebi`;
create database ebi default COLLATE=utf8_general_ci;  -- 创建数据库
use ebi ;  -- 使用数据库
-- ----------------------------
-- Table structure for `bas_charging`
-- ----------------------------
DROP TABLE IF EXISTS `bas_charging`;
CREATE TABLE `bas_charging` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_time` datetime NOT NULL,
  `channel_id` decimal(3,0) NOT NULL,
  `charge_money` decimal(12,2) DEFAULT NULL,
  `charge_players` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for `bas_consume`
-- ----------------------------
DROP TABLE IF EXISTS `bas_consume`;
CREATE TABLE `bas_consume` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_time` datetime NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `subject_id` decimal(4,0) NOT NULL,
  `purchase_count` decimal(10,0) DEFAULT NULL,
  `cost_amount` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for `bas_consume_money_user`
-- ----------------------------
DROP TABLE IF EXISTS `bas_consume_money_user`;
CREATE TABLE `bas_consume_money_user` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` varchar(10) NOT NULL,
  `stat_type` varchar(16) NOT NULL,
  `consume_money` decimal(12,2) DEFAULT NULL,
  `consume_user` decimal(10,0) DEFAULT NULL,
  `avg_user_amount` decimal(10,0) DEFAULT NULL,
  `avg_peak_value` decimal(10,0) DEFAULT NULL,
  `charge_amount` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_consume_money_user
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_core_data`
-- ----------------------------
DROP TABLE IF EXISTS `bas_core_data`;
CREATE TABLE `bas_core_data` (
  `stat_date` date NOT NULL,
  `charge_money` decimal(12,2) DEFAULT '0.00',
  `peak_value_amount` decimal(10,0) DEFAULT '0',
  `avg_amount` decimal(10,0) DEFAULT '0',
  `login_role_amount` decimal(10,0) DEFAULT '0',
  `login_passport_amount` decimal(10,0) DEFAULT '0',
  `charge_players_amount` decimal(10,0) DEFAULT '0',
  `consume_money` decimal(12,2) DEFAULT '0.00',
  `avg_seconds` decimal(10,0) DEFAULT '0',
  `peak_value_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `new_role_amount` decimal(10,0) DEFAULT '0',
  `new_user_amount` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`stat_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_core_data
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_daily_data`
-- ----------------------------
DROP TABLE IF EXISTS `bas_daily_data`;
CREATE TABLE `bas_daily_data` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `stat_type` varchar(16) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_daily_data
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_daily_level_stage_count`
-- ----------------------------
DROP TABLE IF EXISTS `bas_daily_level_stage_count`;
CREATE TABLE `bas_daily_level_stage_count` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `level_stage` decimal(3,0) NOT NULL,
  `role_amount` decimal(10,0) DEFAULT NULL,
  `role_amount_1` decimal(10,0) DEFAULT NULL,
  `role_amount_7` decimal(10,0) DEFAULT NULL,
  `role_amount_28` decimal(10,0) DEFAULT NULL,
  `role_amount_30` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_daily_level_stage_count
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_login_amount`
-- ----------------------------
DROP TABLE IF EXISTS `bas_login_amount`;
CREATE TABLE `bas_login_amount` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_time` datetime NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_login_amount
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_login_user_level`
-- ----------------------------
DROP TABLE IF EXISTS `bas_login_user_level`;
CREATE TABLE `bas_login_user_level` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `stat_type` varchar(16) NOT NULL,
  `role_level` decimal(4,0) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_login_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_lost_user_level`
-- ----------------------------
DROP TABLE IF EXISTS `bas_lost_user_level`;
CREATE TABLE `bas_lost_user_level` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `stat_type` varchar(16) NOT NULL,
  `role_level` decimal(4,0) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_lost_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_new_login_amount`
-- ----------------------------
DROP TABLE IF EXISTS `bas_new_login_amount`;
CREATE TABLE `bas_new_login_amount` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_time` datetime NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_new_login_amount
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_product_sale`
-- ----------------------------
DROP TABLE IF EXISTS `bas_product_sale`;
CREATE TABLE `bas_product_sale` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `package_id` decimal(10,0) NOT NULL,
  `product_code` varchar(64) NOT NULL,
  `subject_id` decimal(4,0) NOT NULL,
  `level_stage` decimal(4,0) NOT NULL,
  `role_count` decimal(10,0) NOT NULL,
  `purchase_count` decimal(10,0) NOT NULL,
  `purchase_amount` decimal(12,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_product_sale
-- ----------------------------

-- ----------------------------
-- Table structure for `bas_role_occupation`
-- ----------------------------
DROP TABLE IF EXISTS `bas_role_occupation`;
CREATE TABLE `bas_role_occupation` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_date` date NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `occupation_id` decimal(2,0) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of bas_role_occupation
-- ----------------------------

-- ----------------------------
-- Table structure for `log_etl`
-- ----------------------------
DROP TABLE IF EXISTS `log_etl`;
CREATE TABLE `log_etl` (
  `etl_name` varchar(50) DEFAULT NULL,
  `from_object` varchar(30) DEFAULT NULL,
  `to_object` varchar(30) DEFAULT NULL,
  `etl_date` date DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `src_rows` decimal(10,0) DEFAULT NULL,
  `effect_rows` decimal(10,0) DEFAULT NULL,
  `message` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of log_etl
-- ----------------------------

-- ----------------------------
-- Table structure for `log_login_lost`
-- ----------------------------
DROP TABLE IF EXISTS `log_login_lost`;
CREATE TABLE `log_login_lost` (
  `passport_id` decimal(10,0) NOT NULL,
  `login_date` date NOT NULL,
  `is_first_login` decimal(1,0) NOT NULL,
  `login_id` decimal(15,0) DEFAULT '0',
  `role_id` decimal(10,0) DEFAULT NULL,
  `occupation` decimal(2,0) DEFAULT NULL,
  `gender` decimal(1,0) DEFAULT NULL,
  `gateway_id` decimal(6,0) DEFAULT NULL,
  `last_logout_time` datetime DEFAULT NULL,
  `role_level` decimal(4,0) NOT NULL,
  `day_lost` decimal(5,4) NOT NULL DEFAULT '2.0000',
  `week_lost` decimal(5,4) NOT NULL DEFAULT '2.0000',
  `month_lost` decimal(5,4) NOT NULL DEFAULT '2.0000',
  `quarter_lost` decimal(5,4) NOT NULL DEFAULT '2.0000',
  `halfyear_lost` decimal(5,4) NOT NULL DEFAULT '2.0000',
  `passport_type` decimal(4,0) DEFAULT '0',
  `sevenday_lost` decimal(5,4) DEFAULT '2.0000',
  `total_online_second` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`passport_id`,`login_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of log_login_lost
-- ----------------------------

-- ----------------------------
-- Table structure for `log_lost_user_temporay`
-- ----------------------------
DROP TABLE IF EXISTS `log_lost_user_temporay`;
CREATE TABLE `log_lost_user_temporay` (
  `level_stage` decimal(4,0) NOT NULL,
  `user_amount` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of log_lost_user_temporay
-- ----------------------------

-- ----------------------------
-- Table structure for `log_stat_time`
-- ----------------------------
DROP TABLE IF EXISTS `log_stat_time`;
CREATE TABLE `log_stat_time` (
  `task_name` varchar(255) NOT NULL,
  `step_name` varchar(255) NOT NULL,
  `step_start_time` datetime NOT NULL,
  `step_end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of log_stat_time
-- ----------------------------

-- ----------------------------
-- Table structure for `log_task_error`
-- ----------------------------
DROP TABLE IF EXISTS `log_task_error`;
CREATE TABLE `log_task_error` (
  `task_name` varchar(50) NOT NULL,
  `log_time` datetime NOT NULL,
  `message` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of log_task_error
-- ----------------------------

-- ----------------------------
-- Table structure for `stat_user_online`
-- ----------------------------
DROP TABLE IF EXISTS `stat_user_online`;
CREATE TABLE `stat_user_online` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `stat_time` datetime NOT NULL,
  `gateway_id` decimal(6,0) NOT NULL,
  `user_online_count` decimal(10,0) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of stat_user_online
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_level_interval`
-- ----------------------------
DROP TABLE IF EXISTS `sys_level_interval`;
CREATE TABLE `sys_level_interval` (
  `min_level` decimal(4,0) NOT NULL,
  `max_level` decimal(4,0) NOT NULL,
  PRIMARY KEY (`min_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of sys_level_interval
-- ----------------------------
insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (0, 1);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (2, 4);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (5, 9);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (10, 14);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (15, 19);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (20, 24);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (25, 29);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (30, 34);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (35, 39);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (40, 44);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (45, 49);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (50, 54);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (55, 59);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (60, 64);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (65, 69);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (70, 74);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (75, 79);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (80, 84);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (85, 89);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (90, 94);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (95, 99);

insert into sys_level_interval (MIN_LEVEL, MAX_LEVEL)
values (100, 999);
commit;

-- ----------------------------
-- Table structure for `sys_passport_temporay`
-- ----------------------------
DROP TABLE IF EXISTS `sys_passport_temporay`;
CREATE TABLE `sys_passport_temporay` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `log_record_detail_tmp` (
  `login_id` bigint(20) NOT NULL AUTO_INCREMENT ,
  `user_id` int(10) unsigned NOT NULL  ,
  `role_id` int(11) NOT NULL,
  `gateway_id` int(11) NOT NULL  ,
  `server_id` int(11) DEFAULT NULL  ,
  `role_level` mediumint(9) NOT NULL,
  `money1` int(11) NOT NULL  ,
  `money2` int(11) NOT NULL  ,
  `experience` bigint(20) NOT NULL ,
  `login_time` datetime NOT NULL ,
  `logout_time` datetime DEFAULT NULL  ,
  `login_ip` int(10) unsigned NOT NULL  ,
  `login_port` mediumint(9) NOT NULL,
  `stat_date` datetime DEFAULT NULL  ,
  `province_code` varchar(16) NOT NULL ,
  `city_code` varchar(16) NOT NULL ,
  `mac` varchar(16) DEFAULT NULL ,
  `hardware_sn1` varchar(32) DEFAULT NULL ,
  `hardware_sn2` varchar(32) DEFAULT NULL ,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
create index `log_record_detail_tmp_ix1` on log_record_detail_tmp(`user_id`);
create index `log_record_detail_tmp_ix2` on log_record_detail_tmp(`login_time`);

-- ----------------------------
-- Records of sys_passport_temporay
-- ----------------------------

-- ----------------------------
-- View structure for `log_daily_logid`
-- ----------------------------
DROP VIEW IF EXISTS `log_daily_logid`;
CREATE  VIEW `log_daily_logid` AS select `erating`.`log_daily_logid`.`log_date` AS `log_date`,`erating`.`log_daily_logid`.`table_name` AS `table_name`,`erating`.`log_daily_logid`.`log_id` AS `log_id` from `erating`.`log_daily_logid`;

-- ----------------------------
-- View structure for `log_record_detail`
-- ----------------------------
DROP VIEW IF EXISTS `log_record_detail`;
CREATE  VIEW `log_record_detail` AS select `erating`.`log_record_detail`.`login_id` AS `login_id`,`erating`.`log_record_detail`.`user_id` AS `user_id`,`erating`.`log_record_detail`.`role_id` AS `role_id`,`erating`.`log_record_detail`.`game_id` AS `game_id`,`erating`.`log_record_detail`.`gateway_id` AS `gateway_id`,`erating`.`log_record_detail`.`server_id` AS `server_id`,`erating`.`log_record_detail`.`role_level` AS `role_level`,`erating`.`log_record_detail`.`money1` AS `money1`,`erating`.`log_record_detail`.`money2` AS `money2`,`erating`.`log_record_detail`.`experience` AS `experience`,`erating`.`log_record_detail`.`login_time` AS `login_time`,`erating`.`log_record_detail`.`logout_time` AS `logout_time`,`erating`.`log_record_detail`.`login_ip` AS `login_ip`,`erating`.`log_record_detail`.`login_port` AS `login_port`,`erating`.`log_record_detail`.`stat_date` AS `stat_date`,`erating`.`log_record_detail`.`province_code` AS `province_code`,`erating`.`log_record_detail`.`city_code` AS `city_code`,`erating`.`log_record_detail`.`mac` AS `mac`,`erating`.`log_record_detail`.`hardware_sn1` AS `hardware_sn1`,`erating`.`log_record_detail`.`hardware_sn2` AS `hardware_sn2` from `erating`.`log_record_detail` where (`erating`.`log_record_detail`.`game_id` = 775);

-- ----------------------------
-- View structure for `log_role_first_login`
-- ----------------------------
DROP VIEW IF EXISTS `log_role_first_login`;
CREATE  VIEW `log_role_first_login` AS select `erating`.`log_role_first_login`.`log_id` AS `log_id`,`erating`.`log_role_first_login`.`game_id` AS `game_id`,`erating`.`log_role_first_login`.`role_id` AS `role_id`,`erating`.`log_role_first_login`.`user_id` AS `user_id`,`erating`.`log_role_first_login`.`gateway_id` AS `gateway_id`,`erating`.`log_role_first_login`.`first_login_time` AS `first_login_time`,`erating`.`log_role_first_login`.`first_login_ip` AS `first_login_ip`,`erating`.`log_role_first_login`.`province_code` AS `province_code`,`erating`.`log_role_first_login`.`city_code` AS `city_code`,`erating`.`log_role_first_login`.`first_role` AS `first_role`,`erating`.`log_role_first_login`.`mac` AS `mac` from `erating`.`log_role_first_login` where (`erating`.`log_role_first_login`.`game_id` = 775);

-- ----------------------------
-- View structure for `log_user_first_login_info`
-- ----------------------------
DROP VIEW IF EXISTS `log_user_first_login_info`;
CREATE  VIEW `log_user_first_login_info` AS select `erating`.`log_user_first_login_info`.`log_id` AS `log_id`,`erating`.`log_user_first_login_info`.`game_id` AS `game_id`,`erating`.`log_user_first_login_info`.`user_id` AS `user_id`,`erating`.`log_user_first_login_info`.`user_name` AS `user_name`,`erating`.`log_user_first_login_info`.`gateway_id` AS `gateway_id`,`erating`.`log_user_first_login_info`.`first_login_time` AS `first_login_time`,`erating`.`log_user_first_login_info`.`first_login_ip` AS `first_login_ip`,`erating`.`log_user_first_login_info`.`first_login_port` AS `first_login_port`,`erating`.`log_user_first_login_info`.`stat_date` AS `stat_date`,`erating`.`log_user_first_login_info`.`province_code` AS `province_code`,`erating`.`log_user_first_login_info`.`city_code` AS `city_code`,`erating`.`log_user_first_login_info`.`mac` AS `mac` from `erating`.`log_user_first_login_info` where (`erating`.`log_user_first_login_info`.`game_id` = 775);

-- ----------------------------
-- View structure for `log_user_fund_detail`
-- ----------------------------
DROP VIEW IF EXISTS `log_user_fund_detail`;
CREATE  VIEW `log_user_fund_detail` AS select `erating`.`log_user_fund_detail`.`log_id` AS `log_id`,`erating`.`log_user_fund_detail`.`game_id` AS `game_id`,`erating`.`log_user_fund_detail`.`user_id` AS `user_id`,`erating`.`log_user_fund_detail`.`rating_id` AS `rating_id`,`erating`.`log_user_fund_detail`.`subject_id` AS `subject_id`,`erating`.`log_user_fund_detail`.`charge_amount` AS `charge_amount`,`erating`.`log_user_fund_detail`.`channel_id` AS `channel_id`,`erating`.`log_user_fund_detail`.`discount` AS `discount`,`erating`.`log_user_fund_detail`.`charge_time` AS `charge_time`,`erating`.`log_user_fund_detail`.`charge_detail_id` AS `charge_detail_id`,`erating`.`log_user_fund_detail`.`charge_order_code` AS `charge_order_code`,`erating`.`log_user_fund_detail`.`charge_type` AS `charge_type`,`erating`.`log_user_fund_detail`.`promoter_id` AS `promoter_id`,`erating`.`log_user_fund_detail`.`checksum` AS `checksum` from `erating`.`log_user_fund_detail` where (`erating`.`log_user_fund_detail`.`game_id` = 775);

-- ----------------------------
-- View structure for `log_user_online_count`
-- ----------------------------
DROP VIEW IF EXISTS `log_user_online_count`;
CREATE  VIEW `log_user_online_count` AS select `erating`.`log_user_online_count`.`game_id` AS `game_id`,`erating`.`log_user_online_count`.`gateway_id` AS `gateway_id`,`erating`.`log_user_online_count`.`server_id` AS `server_id`,`erating`.`log_user_online_count`.`user_online_count` AS `user_online_count` from `erating`.`log_user_online_count` where (`erating`.`log_user_online_count`.`game_id` = 775);

-- ----------------------------
-- View structure for `stat_ceo_info`
-- ----------------------------
DROP VIEW IF EXISTS `stat_ceo_info`;
CREATE  VIEW `stat_ceo_info` AS select `erating`.`stat_ceo_info`.`stat_date` AS `stat_date`,`erating`.`stat_ceo_info`.`game_id` AS `game_id`,`erating`.`stat_ceo_info`.`gateway_id` AS `gateway_id`,`erating`.`stat_ceo_info`.`max_count` AS `max_count`,`erating`.`stat_ceo_info`.`max_count_time` AS `max_count_time`,`erating`.`stat_ceo_info`.`avg_count` AS `avg_count`,`erating`.`stat_ceo_info`.`avg_seconds` AS `avg_seconds` from `erating`.`stat_ceo_info` where (`erating`.`stat_ceo_info`.`game_id` = 775);

-- ----------------------------
-- View structure for `stat_new_user`
-- ----------------------------
DROP VIEW IF EXISTS `stat_new_user`;
CREATE  VIEW `stat_new_user` AS select `erating`.`stat_new_user`.`stat_date` AS `stat_date`,`erating`.`stat_new_user`.`game_id` AS `game_id`,`erating`.`stat_new_user`.`gateway_id` AS `gateway_id`,`erating`.`stat_new_user`.`user_count` AS `user_count`,`erating`.`stat_new_user`.`role_count` AS `role_count`,`erating`.`stat_new_user`.`authen_users` AS `authen_users` from `erating`.`stat_new_user` where (`erating`.`stat_new_user`.`game_id` = 775);

-- ----------------------------
-- View structure for `sys_gateway`
-- ----------------------------
DROP VIEW IF EXISTS `sys_gateway`;
CREATE  VIEW `sys_gateway` AS select `erating`.`sys_gateway`.`game_id` AS `game_id`,`erating`.`sys_gateway`.`gateway_id` AS `gateway_id`,`erating`.`sys_gateway`.`zone_id` AS `zone_id`,`erating`.`sys_gateway`.`gateway_code` AS `gateway_code`,`erating`.`sys_gateway`.`gateway_password` AS `gateway_password`,`erating`.`sys_gateway`.`gateway_name` AS `gateway_name`,`erating`.`sys_gateway`.`gateway_ip` AS `gateway_ip`,`erating`.`sys_gateway`.`gateway_mac` AS `gateway_mac`,`erating`.`sys_gateway`.`gateway_state` AS `gateway_state` from `erating`.`sys_gateway` where (`erating`.`sys_gateway`.`game_id` = 775);

-- ----------------------------
-- View structure for `sys_product`
-- ----------------------------
DROP VIEW IF EXISTS `sys_product`;
CREATE  VIEW `sys_product` AS select `erating`.`sys_product`.`game_id` AS `game_id`,`erating`.`sys_product`.`product_id` AS `product_id`,`erating`.`sys_product`.`product_code` AS `product_code`,`erating`.`sys_product`.`product_name` AS `product_name`,`erating`.`sys_product`.`product_class` AS `product_class`,`erating`.`sys_product`.`product_sub_class` AS `product_sub_class`,`erating`.`sys_product`.`product_level` AS `product_level`,`erating`.`sys_product`.`product_use_type` AS `product_use_type`,`erating`.`sys_product`.`product_period` AS `product_period`,`erating`.`sys_product`.`product_attributes` AS `product_attributes`,`erating`.`sys_product`.`product_state` AS `product_state`,`erating`.`sys_product`.`insert_time` AS `insert_time`,`erating`.`sys_product`.`effect_time` AS `effect_time`,`erating`.`sys_product`.`expire_time` AS `expire_time` from `erating`.`sys_product` where (`erating`.`sys_product`.`game_id` = 775);

-- ----------------------------
-- View structure for `sys_product_price`
-- ----------------------------
DROP VIEW IF EXISTS `sys_product_price`;
CREATE  VIEW `sys_product_price` AS select `erating`.`sys_product_price`.`price_id` AS `price_id`,`erating`.`sys_product_price`.`product_id` AS `product_id`,`erating`.`sys_product_price`.`subject_id` AS `subject_id`,`erating`.`sys_product_price`.`price_origin` AS `price_origin`,`erating`.`sys_product_price`.`price_discount` AS `price_discount`,`erating`.`sys_product_price`.`effect_time` AS `effect_time`,`erating`.`sys_product_price`.`expire_time` AS `expire_time` from `erating`.`sys_product_price`;

-- ----------------------------
-- View structure for `ums_role`
-- ----------------------------
DROP VIEW IF EXISTS `ums_role`;
CREATE  VIEW `ums_role` AS select `erating`.`ums_role`.`game_id` AS `game_id`,`erating`.`ums_role`.`role_id` AS `role_id`,`erating`.`ums_role`.`user_id` AS `user_id`,`erating`.`ums_role`.`role_name` AS `role_name`,`erating`.`ums_role`.`gateway_id` AS `gateway_id`,`erating`.`ums_role`.`nationality_id` AS `nationality_id`,`erating`.`ums_role`.`role_gender` AS `role_gender`,`erating`.`ums_role`.`role_occupation` AS `role_occupation`,`erating`.`ums_role`.`role_level` AS `role_level`,`erating`.`ums_role`.`role_state` AS `role_state`,`erating`.`ums_role`.`create_time` AS `create_time`,`erating`.`ums_role`.`delete_time` AS `delete_time`,`erating`.`ums_role`.`last_logout_time` AS `last_logout_time`,`erating`.`ums_role`.`total_online_second` AS `total_online_second`,`erating`.`ums_role`.`login_id` AS `login_id`,`erating`.`ums_role`.`money1` AS `money1`,`erating`.`ums_role`.`money2` AS `money2`,`erating`.`ums_role`.`experience` AS `experience`,`erating`.`ums_role`.`ad_id` AS `ad_id` from `erating`.`ums_role` where (`erating`.`ums_role`.`game_id` = 775);

-- ----------------------------
-- View structure for `vw_ums_user_product`
-- ----------------------------
DROP VIEW IF EXISTS `vw_ums_user_product`;
CREATE  VIEW `vw_ums_user_product` AS select `erating`.`ums_user_purchase_detail`.`gateway_id` AS `gateway_id`,`erating`.`ums_user_purchase_detail`.`package_id` AS `package_id`,if((`erating`.`ums_user_purchase_detail`.`product_code` = '0'),1,`erating`.`ums_user_purchase_detail`.`product_code`) AS `product_code`,`erating`.`ums_user_purchase_detail`.`log_id` AS `purchase_id`,`erating`.`ums_user_purchase_detail`.`user_id` AS `user_id`,`erating`.`ums_user_purchase_detail`.`purchase_time` AS `purchase_time`,`erating`.`ums_user_purchase_detail`.`log_time` AS `log_time`,(case `erating`.`ums_user_purchase_detail`.`subject_id` when 5 then 3 when 3 then 5 else `erating`.`ums_user_purchase_detail`.`subject_id` end) AS `subject_id`,`erating`.`ums_user_purchase_detail`.`product_num` AS `purchase_count`,`erating`.`ums_user_purchase_detail`.`cost_amount` AS `cost_amount`,`erating`.`ums_user_purchase_detail`.`role_level` AS `role_level`,`erating`.`ums_user_purchase_detail`.`role_id` AS `role_id` from `erating`.`ums_user_purchase_detail` where (`erating`.`ums_user_purchase_detail`.`game_id` = 775);

-- ----------------------------
-- Procedure structure for `etl_user_login`
-- ----------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `etl_user_login`;

CREATE  PROCEDURE `etl_user_login`(IN dt_etl_date datetime,OUT n_Result int(10))
BEGIN
    declare dt_start_time    datetime ;
    declare n_rows           decimal(10,0) default 0;
    declare n_src_rows       decimal(10,0) default 0;
    declare n_start_id       bigint(10);
    declare n_end_id         bigint(10);
    declare n_ret            int(10);
    declare n_done           int(10) default 0 ;
label_etl_user_login:begin
    declare continue handler for sqlexception set n_done = 1;/*Can't write, because of unique constraint*/
		set dt_start_time = sysdate();
    call getLogIdRange(dt_etl_date,dt_etl_date,'LOG_RECORD_DETAIL',n_start_id,n_end_id,n_ret);

     if(n_start_id > 0 and n_end_id > 0 and n_start_id < n_end_id)then
			insert into 
					 log_login_lost(passport_id, login_date, is_first_login,login_id, 
													role_id, gateway_id, last_logout_time, role_level) 
			select t1.user_id, date(dt_etl_date ), 2, t1.login_id, t1.role_id,t1.gateway_id,t1.logout_time,t1.role_level
				from log_record_detail t1,
					(select login_id
						from (select a.*, if(@name = user_id, @rank := @rank + 1, @rank := 1) as rank,@name := user_id
							from (
								select user_id,login_id, role_level
								from log_record_detail
                where login_id between n_start_id and n_end_id
								order by user_id, role_level desc, login_id desc) a)b
								where rank=1) t2
							where t1.login_id=t2.login_id;

      if n_done = 1 then
				call log_etl_result('etl_user_login',
                       'log_record_detail',
                       'log_login_lost',
                        date(dt_etl_date),
                        dt_start_time,
                        sysdate(),
                        n_src_rows,
                        n_rows,
                       'unique constraint');
         set n_Result = -500 ;
         leave label_etl_user_login ;
      end if;

			set n_rows = row_count();  /*row of insert*/

			call log_etl_result('etl_user_login',
							            'log_record_detail',
                          'log_login_lost',
                           date(dt_etl_date),
                           dt_start_time,
                           sysdate(),
                           n_src_rows,
                           n_rows,
                          'success');
		else
			set n_Result = -500 ;
      leave label_etl_user_login ;
    end if ;
end label_etl_user_login ;

END$$


-- ----------------------------
-- Procedure structure for `getAVGOnlineSeconds`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getAVGOnlineSeconds`;

CREATE  PROCEDURE `getAVGOnlineSeconds`(IN d_stat_date datetime,OUT n_avgonline_seconds bigint(20))
BEGIN
	declare n_min_log_id   bigint(20);
  declare n_max_log_id   bigint(20);
  declare s_table_name   varchar(64) default 'LOG_RECORD_DETAIL';
  declare n_done         int  default 0 ;
  declare n_ret          int       ;    
label_getAVGOnlineSeconds:begin
  declare continue handler for not found set n_done = 1 ;
  
  call  getLogIdRange(d_stat_date,
                      d_stat_date,
                      s_table_name,
                      n_min_log_id,
                      n_max_log_id,
                      n_ret
                      );

   if(n_min_log_id > 0 and n_max_log_id > 0 and n_max_log_id > n_min_log_id)then
       select
          sum(timestampdiff(second,login_time,logout_time)) / count(distinct role_id)
       from
          log_record_detail d
       where
         (d.login_id between n_min_log_id and n_max_log_id) and
         (d.logout_time is not null     )
       into
         n_avgonline_seconds ;

       if(n_done = 1)then
         set   n_avgonline_seconds    =  0 ;
         leave label_getAVGOnlineSeconds   ;
       end if;
   else
      set   n_avgonline_seconds    =  0 ;
      leave label_getAVGOnlineSeconds   ;
   end if;
  
end label_getAVGOnlineSeconds;

END$$


-- ----------------------------
-- Procedure structure for `getAVGUserCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getAVGUserCount`;

CREATE  PROCEDURE `getAVGUserCount`(IN d_stat_date datetime,OUT n_avg_user_count int(10))
BEGIN
  declare n_done int default 0 ;
label_getAVGUserCount:begin
  declare continue handler for not found set n_done = 1 ;

	   select
        sum(online_count)
     from
        (
          select
             gateway_id, ifnull(avg(user_online_count),0) online_count
          from
             stat_user_online
          where
             (stat_time >= date(d_stat_date)           ) and
             (stat_time <  adddate(date(d_stat_date),1))
          group by
             gateway_id
        ) t
     into
        n_avg_user_count ;
     leave label_getAVGUserCount ;
     if n_done = 1 then
        set n_avg_user_count = 0;
        leave label_getAVGUserCount ;
     end if;
end label_getAVGUserCount ;

END$$


-- ----------------------------
-- Procedure structure for `getCharge`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getCharge`;

CREATE  PROCEDURE `getCharge`(IN d_stat_date datetime,OUT n_charge_players numeric(10,0),OUT d_charge_money numeric(12,2))
BEGIN
    declare n_done         tinyint default 0 ;
label_getCharge:begin
    declare continue handler for not found set n_done = 1 ;
 
    select 
        sum(charge_amount)/10 charge_amount,count(distinct user_id) user_amount
    from 
        log_user_fund_detail
    where 
        (charge_type   =   1    )               and 
        (subject_id    =   3    )               and 
        (charge_time >= date(d_stat_date))      and 
        (charge_time <  adddate(date(d_stat_date),1))
    into d_charge_money,n_charge_players  ;
        
    if n_done = 1 then
      set d_charge_money     = 0 ;
      set n_charge_players  = 0 ;
      leave label_getCharge ;
    end if ;

end label_getCharge ;

END$$


-- ----------------------------
-- Procedure structure for `getConsumeMoney`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getConsumeMoney`;

CREATE  PROCEDURE `getConsumeMoney`(IN d_stat_date datetime,OUT d_consume_money numeric(12,2))
BEGIN
	declare n_min_log_id   bigint(20);
  declare n_max_log_id   bigint(20);
  declare s_table_name   varchar(64) default 'UMS_USER_PURCHASE_DETAIL';
  declare n_done         tinyint default 0 ;
  declare n_ret          int       ;

label_getConsumeMoney:begin
	declare continue handler for not found set n_done = 1 ;

  call getLogIdRange(
                   d_stat_date ,
                   d_stat_date ,
                   s_table_name,
                   n_min_log_id,
                   n_max_log_id,
                   n_ret
                   );

   select
       sum(cost_amount)/10 cost_amount 
   from 
       vw_ums_user_product
   where 
       purchase_id between n_min_log_id and n_max_log_id   and 
       subject_id=3
   into d_consume_money ;

   if n_done = 1 then
      set d_consume_money    = 0 ;
      leave label_getConsumeMoney ;
   end if ;
end label_getConsumeMoney ;

END$$


-- ----------------------------
-- Procedure structure for `getLogIdRange`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLogIdRange`;

CREATE  PROCEDURE `getLogIdRange`(in  dt_begin_date datetime,
			       in  dt_end_date   datetime,
			       in  s_table_name  varchar(64),
			       out n_start_id    bigint(20),
			       out n_end_id      bigint(20),
			       out n_result      int)
BEGIN
	declare n_done tinyint default 0 ;

label_getLogIdRange:begin
  declare continue handler for not found set n_done = 1 ; /*database error*/

	if (dt_begin_date is null or
            dt_end_date   is null or
            s_table_name  is null
        ) then
        set n_result = -100 ; /*procedure parametor error*/
        leave label_getLogIdRange ;
  end if ;
     
  select 
     ifnull(min(log_id),0)
  from 
     log_daily_logid 
  where 
     table_name = s_table_name             and 
     log_date   = date(dt_begin_date)  
  into n_start_id ;
   
  if (n_done = 1) then 
     set n_start_id = 0 ;
     set n_end_id   = 0 ;
     set n_result   = -200 ;  /*not data found*/
     leave label_getLogIdRange ;
  end if ;
  
  if (n_start_id > 0)then 
     select 
        ifnull(min(log_id),0)
     from 
        log_daily_logid t
     where 
        table_name = s_table_name                  and 
        log_date   = adddate(date(dt_end_date),1)  
     into n_end_id ; 

     if (n_end_id = 0) then
        set n_end_id = 999999999999999;
     else
        set n_end_id = n_end_id - 1 ;
		 end if ;
     set n_result = 1 ;
  else
     set n_end_id = 0 ;
     set n_result = -500 ; /*data exception*/
  end if;
  
end label_getLogIdRange ;

END$$


-- ----------------------------
-- Procedure structure for `getLoginAmount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLoginAmount`;

CREATE  PROCEDURE `getLoginAmount`(IN d_stat_date datetime,OUT n_user_count int(10),OUT n_role_count int(10))
BEGIN
	 declare n_min_log_id   bigint(20);
   declare n_max_log_id   bigint(20);
   declare s_table_name   varchar(64) default 'LOG_RECORD_DETAIL';
   declare n_ret          int(10);
   declare n_done         tinyint default 0 ;
label_getLoginAmount:begin
   declare continue handler for not found set n_done = 1 ;

   call getLogIdRange(d_stat_date , 
                      d_stat_date ,
                      s_table_name,
                      n_min_log_id,
                      n_max_log_id,
                      n_ret
                      );

   select 
       count(distinct role_id) role_count,count(distinct user_id) user_count
   from 
       LOG_RECORD_DETAIL 
   where 
       login_id between n_min_log_id and n_max_log_id
   into n_role_count  ,n_user_count  ;
   
   if n_done = 1 then
      set n_role_count  = 0 ;
      set n_user_count  = 0 ;
      leave label_getLoginAmount ;
   end if ;
end label_getLoginAmount;

END$$


-- ----------------------------
-- Procedure structure for `getNewComer`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getNewComer`;

CREATE  PROCEDURE `getNewComer`(IN d_stat_date datetime,OUT n_new_user int(10),OUT n_new_role int(10))
BEGIN
	  declare n_done int default 0 ;

label_getNewComer:begin
    declare continue handler for not found set n_done = 1 ;

    select 
       ifnull(sum(role_count),0) role_amount,ifnull(sum(user_count),0) user_amount
    from 
       stat_new_user
    where 
       gateway_id   >     0                 and 
       stat_date    =     date(d_stat_date) 
    into  n_new_role,n_new_user ;
    
    leave label_getNewComer ;
     if n_done = 1 then
        set  n_new_user  = 0;
        set  n_new_role  = 0;
        leave label_getNewComer ;
     end if;
    
end label_getNewComer ;

END$$

-- ----------------------------
-- Procedure structure for `getPeakValueInvolved`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getPeakValueInvolved`;

CREATE  PROCEDURE `getPeakValueInvolved`(IN d_stat_date datetime,OUT n_peak_value int(10),OUT dt_peak_value_time datetime)
BEGIN
	declare n_done int default 0;
label_getPeakValueInvolved:begin
	declare continue handler for not found set n_done = 1 ;
  
  select 
     max_count ,max_count_time
  from 
     stat_ceo_info
  where 
     gateway_id =  0               and 
     stat_date  = date(d_stat_date)
  into 
     n_peak_value,dt_peak_value_time ;
  
  leave label_getPeakValueInvolved ;

  if n_done = 1 then
     set n_peak_value = 0 ;
     set dt_peak_value_time = sysdate();
     leave label_getPeakValueInvolved ;
  end if ;

end label_getPeakValueInvolved;

END$$


-- ----------------------------
-- Procedure structure for `getStatTime`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getStatTime`;

CREATE  PROCEDURE `getStatTime`(IN dt_stat_time datetime,OUT dt_stat_date datetime,OUT dt_begin_time datetime,INOUT dt_end_time datetime)
BEGIN
  declare n_minute tinyint default 0 ;
label_getStatTime:begin
	declare exit handler for not found begin end ;

  set n_minute = minute(dt_stat_time);
  set dt_begin_time = date(dt_stat_time);
  
  if (n_minute >=0 and n_minute <30) then
       set dt_end_time  = addtime(date_format(dt_stat_time,'%Y-%m-%d %H:00:00'),'-00:30:00');
       set dt_stat_date = date_format(dt_stat_time,'%Y-%m-%d %H:00:00');
       
       if (hour(dt_stat_time) = 0) then
         set dt_begin_time = adddate(dt_stat_time,-1);
       end if;
  else
       set dt_end_time  = date_format(dt_stat_time,'%Y-%m-%d %H:00:00');
       set dt_stat_date = addtime(date_format(dt_stat_time,'%Y-%m-%d %H:00:00'),'00:30:00');
  end if;
  set dt_end_time = addtime(dt_end_time,'00:29:59'); 
end label_getStatTime;

END$$


-- ----------------------------
-- Procedure structure for `initLostUserTemporay`
-- ----------------------------
DROP PROCEDURE IF EXISTS `initLostUserTemporay`;

CREATE  PROCEDURE `initLostUserTemporay`(IN dt_login_date datetime,IN n_login_type tinyint,IN s_stat_type varchar(64),IN n_passport_type tinyint,OUT n_Result int(10))
BEGIN
	  declare n_level          decimal(4,0);
    declare n_amount         decimal(10,0);
    declare s_type           varchar(64);
    declare s_field          varchar(64);

label_initLostUserTemporary:begin
		declare exit handler for 1062 set n_Result = -500 ;
    /*get lost user cursor*/
		case s_stat_type
       when 'day' then
         set s_field = 'day_lost';
       when 'week' then
         set s_field = 'week_lost';
       when 'month' then
         set s_field = 'month_lost';
       when 'quarter' then
         set s_field = 'quarter_lost';
       when 'halfyear' then
         set s_field = 'halfyear_lost';
       when 'sevenday' then
         set s_field = 'sevenday_lost';
     end case;

     set @s_sql = 'insert into log_lost_user_temporay(level_stage,user_amount) 
                   select 
                      role_level,count(passport_id) amount
                   from
                     (select passport_id,role_level,';

     if (s_stat_type = 'day') then
       set @s_sql = concat(@s_sql,'case 
                                     when last_logout_time is null then 1
                                     when last_logout_time>=adddate(date(?),1) then 1
                                   else day_lost
                                   end lost');
     else
       set @s_sql = concat(@s_sql,s_field,' lost');
     end if;

     set @s_sql = concat(@s_sql,' from 
                                     log_login_lost
                                  where 
                                     login_date = date(?) and 
                                     login_id>0');

     if (n_login_type  = 1) then
       set @s_sql = concat(@s_sql,' and is_first_login=1');
     end if;
     
     if (n_passport_type = 1) then
       set @s_sql = concat(@s_sql,' and passport_type&2=2');
     elseif (n_passport_type =2) then
       set @s_sql = concat(@s_sql,' and passport_type&2=0');
     end if;

     set @s_sql = concat(@s_sql,')t1
                           where lost=2
                           group by role_level');

     
     if (s_stat_type = 'day') then
         set @login_date = dt_login_date ;
         PREPARE SQLSA FROM @s_sql ;
         execute SQLSA using @login_date,@login_date;
         DEALLOCATE PREPARE SQLSA ;
     else
         set @login_date = dt_login_date ;
         PREPARE SQLSA FROM @s_sql ;
         execute SQLSA using @login_date;
         DEALLOCATE PREPARE SQLSA ;
     end if;

     set n_Result = 1 ;
end label_initLostUserTemporary;

END$$


-- ----------------------------
-- Procedure structure for `log_etl_result`
-- ----------------------------
DROP PROCEDURE IF EXISTS `log_etl_result`;

CREATE  PROCEDURE `log_etl_result`(IN s_etl_name varchar(64),IN s_from_object varchar(64),IN s_toobject varchar(64),IN dt_etl_date datetime,IN dt_start_time datetime,IN dt_end_time datetime,IN n_src_rows int(10),IN n_rows int(10),IN s_message varchar(525))
BEGIN
	
label_log_etl_result:begin

	insert into log_etl(
                  etl_name,
                  from_object,
                  to_object,
                  etl_date,
                  start_time,
                  end_time,
                  src_rows,
                  effect_rows,
                  message
                  )
    values(s_etl_name,
           s_from_object,
           s_toobject,
           dt_etl_date,
           dt_start_time,
           dt_end_time,
           n_src_rows,
           n_rows,
           mid(s_message,1,512)
           );
    
end label_log_etl_result;

END$$


-- ----------------------------
-- Procedure structure for `statARPUDaily`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statARPUDaily`;

CREATE  PROCEDURE `statARPUDaily`(IN d_stat_date date)
BEGIN
	declare s_year   varchar(64) ;
  declare n_month  int(10);

lable_stat:begin

	call stat_consume_day_week(adddate(d_stat_date,-1),'day',@result);
  call stat_consume_day_week(adddate(d_stat_date,-7),'week',@result);
  if(date_format(d_stat_date,'%e') = 1)then
    set s_year = cast(date_format(adddate(d_stat_date,-1),'%Y') as char(4));
    set n_month = date_format(adddate(d_stat_date,-1),'%c');
    call stat_consume_month_quarter(s_year,n_month,'month',@result);
  end if;
end lable_stat;

END$$


-- ----------------------------
-- Procedure structure for `statChargingInterval`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statChargingInterval`;

CREATE  PROCEDURE `statChargingInterval`(IN dt_stat_time datetime,OUT n_Result int(10))
BEGIN
    declare dt_stat_date    datetime            ;
    declare dt_begin_time   datetime            ;
    declare dt_end_time     datetime            ; 
    declare n_done          int        default 0;
    declare d_charge_money  decimal(12,2)       ;
    declare n_charge_player decimal(10,0)       ;

label_statChargingInterval:begin
    declare continue handler for not found set n_done = 1;  /*nor data found error*/
     
    call getStatTime(dt_stat_time, dt_stat_date, dt_begin_time, dt_end_time);  /*get the stat time according to input parametor*/
    
    select 
        ifnull(sum(charge_amount) / 10, 0) charge_money,
        count(distinct(user_id)) charge_players
    from 
        log_user_fund_detail
    where 
        (charge_type = 1)     and 
        (subject_id  = 3)     and 
        (charge_time between dt_begin_time and dt_end_time)
    into 
      d_charge_money,n_charge_player;

    if n_done = 1 then
      set n_Result        = -500;
      set d_charge_money  = 0   ;
      set n_charge_player = 0   ;
    end if;
    insert into 
            bas_charging
               (stat_time,                    
                channel_id,
                charge_money,
                charge_players)
        values (dt_stat_date,
                -1,
                d_charge_money,
                n_charge_player);

    set n_Result = 1 ;
       
end label_statChargingInterval ;

END$$


-- ----------------------------
-- Procedure structure for `statConsumeInterval`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statConsumeInterval`;

CREATE  PROCEDURE `statConsumeInterval`(IN dt_stat_time datetime,OUT n_Result  int(10))
BEGIN
	   declare n_start_id      bigint(20) default 0;
     declare n_end_id        bigint(20) default 0;
     declare n_login_amount  int(12)    default 0;
     declare dt_stat_date    datetime            ;
     declare dt_begin_time   datetime            ;
     declare dt_end_time     datetime            ;
     declare dt_tmp_date     datetime            ; 
     declare n_done          int        default 0;
     declare n_ret           int                 ;
     declare n_gateway       mediumint(9)        ;
     declare n_purchase_count decimal(10,0)      ;
     declare n_cost          decimal(10,0)       ;
     declare gateCursor cursor for
             select 
                gateway_id
             from
                sys_gateway        ;
     
label_statConsumeInterval:begin
    declare continue handler for not found set n_done = 1;  /*nor data found error*/
     
    call getStatTime(dt_stat_time, dt_stat_date, dt_begin_time, dt_end_time);  /*get the stat time according to input parametor*/
     
    set dt_tmp_date = dt_stat_date;
     
    if (date_format(dt_stat_date,'%H%i%S') = '000000') then
      set dt_tmp_date = adddate(dt_tmp_date,-1);
    end if;
		/*
    open gateCursor ;
     gatewayLoop:loop
     fetch gateCursor into n_gateway ;

     if n_done = 1 then
        set n_done =  3   ;
        leave gatewayLoop ;
     end if;
     -- init subject = 3 
     insert into bas_consume(stat_time,gateway_id,subject_id,
                             purchase_count,cost_amount)
     values (dt_stat_date,n_gateway,3,0,0);
     -- init subject = 4
     insert into bas_consume(stat_time,gateway_id,subject_id,
                             purchase_count,cost_amount)
     values (dt_stat_date,n_gateway,4,0,0);
     end loop gatewayLoop ;
     close gateCursor ;
		 */
     call getLogIdRange(
                    dt_tmp_date,
                    dt_tmp_date,
                    'UMS_USER_PURCHASE_DETAIL',
                    n_start_id,
                    n_end_id,
                    n_ret);

     if (n_end_id > 0 and n_start_id >0 and n_start_id <= n_end_id) then

         insert into bas_consume(stat_time,gateway_id,subject_id,purchase_count,cost_amount)
         select 
            dt_stat_date ,gateway_id,subject_id,sum(purchase_count) ,sum(cost_amount) 
         from 
            vw_ums_user_product
         where 
						 (purchase_id      between n_start_id    and n_end_id      )      and 
             (log_time         between dt_begin_time and dt_end_time   )      and
             (gateway_id       >   0                                   )
         group by gateway_id,subject_id;
        /* 
				open gateCursor ;
         dataLoop:loop
         fetch gateCursor into n_gateway ;
         if(n_done = 1) then
            set n_done = 3    ;  
            leave dataLoop ;
         end if ;
				
         select 
             gateway_id,subject_id,sum(purchase_count) purchase_count,sum(cost_amount) cost_amount
         from  
             vw_ums_user_product
				 where 
						 (purchase_id      between n_start_id    and n_end_id      )      and 
             (log_time         between dt_begin_time and dt_end_time   )      and
             (gateway_id       =       n_gateway)                             and
             (subject_id       =       3)
         into n_purchase_count,n_cost;
				 
         if(n_done = 1) then
            set n_done           = 3 ;  
            set n_purchase_count = 0 ;
            set n_cost           = 0 ;
         end if ;

         update
             bas_consume
         set
             purchase_count =  n_purchase_count,
             cost_amount    =  n_cost
         where
             stat_time   = dt_stat_date       and
             gateway_id  = n_gateway          and
             subject     = 3 ;

         select 
             gateway_id,subject_id,sum(purchase_count) purchase_count,sum(cost_amount) cost_amount
         from  
             vw_ums_user_product
				 where 
						 (purchase_id      between n_start_id    and n_end_id      )      and 
             (log_time         between dt_begin_time and dt_end_time   )      and
             (gateway_id       =       n_gateway)                             and
             (subject_id       =       4)
         into n_purchase_count,n_cost;
				
         if(n_done = 1) then
            set n_done           = 3 ;  
            set n_purchase_count = 0 ;
            set n_cost           = 0 ;
         end if ;

         update
             bas_consume
         set
             purchase_count =  n_purchase_count,
             cost_amount    =  n_cost
         where
             stat_time   = dt_stat_date       and
             gateway_id  = n_gateway          and
             subject     = 4 ;
         
         insert into bas_consume(stat_time,gateway_id,subject_id,purchase_count,cost_amount)
         select 
            dt_stat_date ,gateway_id,subject_id,sum(purchase_count) ,sum(cost_amount) 
         from 
            vw_ums_user_product
         where 
						 (purchase_id      between n_start_id    and n_end_id      )      and 
             (log_time         between dt_begin_time and dt_end_time   )      and
             (subject_id       not in  (3,4)                           )      and
             (gateway_id       >   0                                   )
         group by gateway_id,subject_id;
         end loop dataLoop ;
         */
     else
         set n_login_amount = 0   ;
				 set n_Result       =-500 ;
     end if ;
     set n_Result = 1 ;
end label_statConsumeInterval ;

END$$


-- ----------------------------
-- Procedure structure for `statCoreData`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statCoreData`;

CREATE  PROCEDURE `statCoreData`(IN dt_stat_date date)
BEGIN

  declare n_login_amount                numeric(10,0);           -- 当日总登录角色
  declare n_login_user_amount           numeric(10,0);  -- 当日总登陆账号 
  declare n_charge_money                numeric(12,2);           -- 当日充值金额
  declare n_consume_money               numeric(12,2);          -- 当日消耗金额
  declare n_peak_value_amount           numeric(10,0);      -- 当日峰值人数
  declare n_avg_amount                  numeric(10,0);             -- 当日均值人数
  declare n_new_user_amount             numeric(10,0);       -- 当日新增登录人数
  declare n_new_role_amount             numeric(10,0);       -- 当日新增登录角色
  declare n_charge_players_amount       numeric(10,0);          -- 当日充值人数
  declare dt_peak_value_time            TIMESTAMP;        -- 当日峰值时刻
  declare n_avg_seconds                 numeric(10,0);

lable_stat:begin
  call getLoginAmount(dt_stat_date,n_login_user_amount,n_login_amount);
   
  call getCharge(dt_stat_date,n_charge_players_amount,n_charge_money);
     
  call getConsumeMoney(dt_stat_date,n_consume_money);
     
  call getAVGOnlineSeconds(dt_stat_date,n_avg_seconds);
     
  call getPeakValueInvolved(dt_stat_date,n_peak_value_amount,dt_peak_value_time);
     
  call getAVGUserCount(dt_stat_date,n_avg_amount);
     
  call getNewComer(dt_stat_date,n_new_user_amount,n_new_role_amount);

  delete from bas_core_data
  where stat_date = date(dt_stat_date);

  insert into bas_core_data(stat_date,login_role_amount,login_passport_amount,
                            charge_money,consume_money,peak_value_amount,
                            avg_amount,new_user_amount,new_role_amount,
                            charge_players_amount,peak_value_time,avg_seconds)
  values(date(dt_stat_date),n_login_amount,n_login_user_amount,
              n_charge_money,n_consume_money,n_peak_value_amount,
              n_avg_amount,n_new_user_amount,n_new_role_amount,          
              n_charge_players_amount,dt_peak_value_time,n_avg_seconds);
  commit;

end lable_stat;

END$$


-- ----------------------------
-- Procedure structure for `statDailyData`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statDailyData`;

CREATE  PROCEDURE `statDailyData`(IN dt_stat_date datetime,OUT n_Result int(10))
BEGIN
	declare n_start_id    bigint(20);
  declare n_end_id      bigint(20);
  declare n_ret         int ;
label_statDailyData:begin
  declare exit handler for 1062 set n_Result = -500;/*Can't write, because of unique constraint*/
	call getLogIdRange(dt_stat_date,dt_stat_date,'LOG_RECORD_DETAIL',n_start_id,n_end_id,n_ret);

  if(n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id)then
		 insert into 
          bas_daily_data(stat_date,stat_type,amount)
     select 
          date(dt_stat_date),'login',count(distinct user_id)
     from 
          log_record_detail
     where 
          login_id between n_start_id and n_end_id ;

  else
     set n_Result = -500 ;
  end if ;
  
	call getLogIdRange(dt_stat_date,dt_stat_date,'LOG_USER_FIRST_LOGIN_INFO',n_start_id,n_end_id,n_ret);
	if(n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id)then
		 insert into 
         bas_daily_data(stat_date,stat_type,amount)
     select 
         date(dt_stat_date),'new_login',count(distinct user_id)
     from 
         log_user_first_login_info 
     where 
         log_id between n_start_id and n_end_id;

  else
     set n_Result = -500 ;
     leave label_statDailyData ;
  end if ;
  
  set n_Result = 1 ;
end label_statDailyData ;

END$$

-- ----------------------------
-- Procedure structure for `statLevelDailyStage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statLevelDailyStage`;

CREATE  PROCEDURE `statLevelDailyStage`(IN dt_stat_date datetime,OUT n_Result int(10))
BEGIN
	 declare n_Ret_Code        int(10);
   declare n_role_amount     decimal(10,0);
   declare n_level           decimal(3,0);
   declare n_start_id        bigint(20);
   declare n_end_id          bigint(20);
   declare n_gateway         mediumint(9);
	 declare n_done            int(10) default 0;
   
   declare cur_gateway       cursor for  /*gateway cursor*/
           select 
             gateway_id
           from 
             sys_gateway
           order by 
             gateway_id asc;
   declare cur_role_amount   cursor for  /*role_amount cursor*/
           select 
             gateway_id,min_level,role_count
           from
           (select 
               r.gateway_id,l.min_level,count(*) role_count
            from 
               ums_role r,sys_level_interval l
            where
               (r.role_state = 1                                ) and
               (r.role_level between l.min_level and l.max_level) 
            group by r.gateway_id, l.min_level
            )t;
   declare cur_role_amount_day cursor  for
           select 
              t1.gateway_id,t2.min_level level_stage, 
              count(*) login_amount
           from 
             (select 
                 gateway_id, role_id, max(role_level) role_level
              from 
                 LOG_RECORD_DETAIL
              where 
                 login_id >= (select ifnull(log_id,0) from  log_daily_logid where log_date = date(dt_stat_date) and table_name = 'LOG_RECORD_DETAIL' )       and
                 login_id <  (select ifnull(log_id,999999999999999) from  log_daily_logid where log_date = adddate(date(dt_stat_date),1) and table_name = 'LOG_RECORD_DETAIL' )
              group by gateway_id, role_id) t1,
              sys_level_interval t2
          where t1.role_level between t2.min_level and t2.max_level
          group by gateway_id, t2.min_level;
   declare cur_role_amount_week cursor for   /*cursor for week cursor*/
           select 
             t.gateway_id,
             l.min_level,
             count(*)
           from 
             UMS_ROLE t, sys_level_interval l
           where 
             (t.role_state          = 1                               )  and 
             (t.last_logout_time    >= adddate(date(dt_stat_date),-6) ) and 
             (t.role_level between l.min_level and l.max_level        )
         group by t.gateway_id, l.min_level ;
    
   declare cur_role_amount_4week cursor for   /*cursor for 4 week cursor*/
           select 
             t.gateway_id,
             l.min_level,
             count(*)
           from 
             UMS_ROLE t, sys_level_interval l
           where 
             (t.role_state          = 1                               )  and 
             (t.last_logout_time    >= adddate(date(dt_stat_date),-27))  and 
             (t.role_level between l.min_level and l.max_level        )
         group by t.gateway_id, l.min_level ;

	 declare cur_role_amount_month cursor for   /*cursor for a month cursor*/
           select 
             t.gateway_id,
             l.min_level,
             count(*)
           from 
             UMS_ROLE t, sys_level_interval l
           where 
             (t.role_state          = 1                                                         ) and 
             (t.last_logout_time    >= adddate(date_add(date(dt_stat_date),INTERVAL -1 month),1)) and 
             (t.role_level between l.min_level and l.max_level                                  )
         group by t.gateway_id, l.min_level ;
   
label_statLevelDailyStage:begin

	declare continue handler for not found set n_done = 1 ;
  
	open cur_gateway ;
  gateway_loop:loop
  fetch cur_gateway into n_gateway;
  if (n_done = 1) then
     set n_done = 0 ;
		 leave gateway_loop ; 
  end if;	
  insert into      -- init gateway info
          bas_daily_level_stage_count
         (stat_date,gateway_id,level_stage,
          role_amount,role_amount_1,
          role_amount_7,role_amount_28,
          role_amount_30)
  select date(dt_stat_date),n_gateway,min_level,0,0,0,0,0 from sys_level_interval;
  end loop gateway_loop;

  open cur_role_amount ;
  role_amount_loop:loop
		fetch cur_role_amount into n_gateway,n_level,n_role_amount;
    if n_done = 1 then 
       set n_done = 0 ;
       leave role_amount_loop ;
    end if ;
    update 
       bas_daily_level_stage_count
    set 
       role_amount = n_role_amount
    where
       stat_date = date(dt_stat_date)        and
       level_stage = n_level                 and
       gateway_id  = n_gateway ;
  end loop role_amount_loop ;

	open cur_role_amount_day ;
  role_amount_day_loop:loop
		fetch cur_role_amount_day into n_gateway,n_level,n_role_amount;
    if n_done = 1 then 
       set n_done = 0 ;
       leave role_amount_day_loop ;
    end if ;
    update 
       bas_daily_level_stage_count
    set 
       role_amount_1 = n_role_amount
    where
       stat_date = date(dt_stat_date)        and
       level_stage = n_level                 and
       gateway_id  = n_gateway ;
  end loop role_amount_day_loop ;

  open cur_role_amount_week ;
  role_amount_week_loop:loop
		fetch cur_role_amount_week into n_gateway,n_level,n_role_amount;
    if n_done = 1 then 
       set n_done = 0 ;
       leave role_amount_week_loop ;
    end if ;
    update 
       bas_daily_level_stage_count
    set 
       role_amount_7 = n_role_amount
    where
       stat_date   = date(dt_stat_date)        and
       level_stage = n_level                   and
       gateway_id  = n_gateway ;
  end loop role_amount_week_loop ;

  open cur_role_amount_4week ;
  role_amount_4week_loop:loop
		fetch cur_role_amount_4week into n_gateway,n_level,n_role_amount;
    if n_done = 1 then 
       set n_done = 0 ;
       leave role_amount_4week_loop ;
    end if ;
    update 
       bas_daily_level_stage_count
    set 
       role_amount_28 = n_role_amount
    where
       stat_date   = date(dt_stat_date)        and
       level_stage = n_level                   and
       gateway_id  = n_gateway ;
  end loop role_amount_4week_loop ;
  
	open cur_role_amount_month ;
  role_amount_month_loop:loop
		fetch cur_role_amount_month into n_gateway,n_level,n_role_amount;
    if n_done = 1 then 
       set n_done = 0 ;
       leave role_amount_month_loop ;
    end if ;
    update 
       bas_daily_level_stage_count
    set 
       role_amount_30 = n_role_amount
    where
       stat_date   = date(dt_stat_date)        and
       level_stage = n_level                   and
       gateway_id  = n_gateway ;
  end loop role_amount_month_loop ;
  
end label_statLevelDailyStage ;
 
END$$


-- ----------------------------
-- Procedure structure for `statLevelStageDailyTask`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statLevelStageDailyTask`;

CREATE  PROCEDURE `statLevelStageDailyTask`(IN d_stat_date date)
BEGIN
	
lable_stat:begin
  call statLevelDailyStage(adddate(d_stat_date,-1),@result);
end lable_stat;

END$$


-- ----------------------------
-- Procedure structure for `statLoginAmountInterval`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statLoginAmountInterval`;

CREATE  PROCEDURE `statLoginAmountInterval`(IN dt_stat_time datetime,OUT n_Result int)
BEGIN
     declare n_start_id      bigint(20) default 0;
     declare n_end_id        bigint(20) default 0;
     declare n_login_amount  int(12)    default 0;
     declare dt_stat_date    datetime            ;
     declare dt_begin_time   datetime            ;
     declare dt_end_time     datetime            ;
     declare dt_tmp_date     datetime            ; 
     declare n_done          int        default 0;
     declare n_ret           int                 ;
label_statLoginAmountInterval:begin

     declare continue handler for not found set n_done = 1;  /*nor data found error*/
     
     call getStatTime(dt_stat_time, dt_stat_date, dt_begin_time, dt_end_time);  /*get the stat time according to input parametor*/
     
     set dt_tmp_date = dt_stat_date;
     
     if (date_format(dt_stat_date,'%H%i%S') = '000000') then
       set dt_tmp_date = adddate(dt_tmp_date,-1);
     end if;
     
     call getLogIdRange(
                    dt_tmp_date,
                    dt_tmp_date,
                    'LOG_RECORD_DETAIL',
                    n_start_id,
                    n_end_id,
                    n_ret);
     if (n_end_id > 0 and n_start_id >0 and n_start_id <= n_end_id) then
         select 
             ifnull(count(distinct user_id), 0) amount
				 from 
						 log_record_detail 
				 where 
						 (login_id   between n_start_id    and n_end_id      )      and 
             (login_time between dt_begin_time and dt_end_time   )
         into n_login_amount;

         if(n_done = 1)then
             set n_login_amount = 0   ;
             set n_Result       = -500;
         end if;
     else
         set n_login_amount = 0   ;
				 set n_Result       =-500 ;
     end if ;

     insert into
          bas_login_amount(stat_time,                    
                           amount)  
     values 
         (dt_stat_date,
          n_login_amount); 
end label_statLoginAmountInterval;

END$$


-- ----------------------------
-- Procedure structure for `statLoginUserLevel`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statLoginUserLevel`;

CREATE  PROCEDURE `statLoginUserLevel`(IN dt_stat_date datetime,IN n_login_type tinyint,IN n_passport_type tinyint,OUT n_Result int(10))
BEGIN
	  declare s_login_type varchar(64);

label_statLoginUserLevel:begin
    declare exit handler for sqlexception set n_Result = -500;
	  if (n_login_type =1) then
       set s_login_type = 'new_login';
    elseif (n_login_type =2) then
       set s_login_type = 'login';
    end if;
     
    if (n_passport_type<>-1) then
      set s_login_type = concat(s_login_type,'_',n_passport_type);
    end if;
	
    set @s_sql = 'insert into 
                      bas_login_user_level(stat_date,stat_type,role_level,amount)
                  select 
                     login_date,? stat_type,role_level,count(passport_id)
                  from 
                     log_login_lost
                  where 
                     login_date = ?';
        
     if (n_login_type = 1) then
       set @s_sql = concat(@s_sql,' and is_first_login=1');
     end if;
     if (n_passport_type=1) then
       set @s_sql = concat(@s_sql,' and passport_type&2 = 2');
     elseif (n_passport_type=2) then
       set @s_sql = concat(@s_sql,' and passport_type&2 = 0');
     end if;

     set @s_sql = concat(@s_sql,' group by login_date,role_level');
		 
     set @login_type = s_login_type ;
     set @stat_date = date(dt_stat_date);

     prepare SQLSA from @s_sql ;
     execute SQLSA using @login_type, @stat_date;

     set n_Result = 1 ;
end label_statLoginUserLevel;

END$$


-- ----------------------------
-- Procedure structure for `statLostUser`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statLostUser`;

CREATE  PROCEDURE `statLostUser`(IN dt_login_date datetime,IN n_login_type tinyint,IN s_stat_type varchar(64),IN n_passport_type tinyint,INOUT n_Result int)
BEGIN
	  declare n_level          decimal(4,0);
    declare n_amount         decimal(10,0);
    declare s_type           varchar(64);
    -- declare cur_level CURSOR FOR SQLSA ;
    declare n_done           tinyint default 0 ;
    declare cur_lost cursor for
                       select 
                          level_stage,user_amount 
                       from 
                          log_lost_user_temporay;
label_statLostUser:begin
		declare continue handler for not found set n_done = 1;
    declare exit     handler for 1062      set n_Result = -500 ;
    delete from log_lost_user_temporay ;

    call  initLostUserTemporay(dt_login_date,
                               n_login_type,
                               s_stat_type,
                               n_passport_type,
                               @result);

    select count(*) into @row_counts from log_lost_user_temporay ;
    
    if(@row_counts > 0)then
			 if (n_login_type = -1) then
         set s_type = concat(s_stat_type,'_2');
			 else
         set s_type = concat(s_stat_type,'_1');
       end if;
       
       if (n_passport_type <>-1) then
         set s_type = concat(s_type,'_',n_passport_type);
       end if;

       open cur_lost;
       lost_loop:loop
					fetch cur_lost into n_level,n_amount;
          if n_done = 1 then
						 set n_done = 0 ;
             leave lost_loop ;
          end if;
          insert into bas_lost_user_level(stat_date,stat_type,role_level,amount)
          values (date(dt_login_date),s_type,n_level,n_amount);
       end loop lost_loop;
    else
       set n_Result = -500 ;
       leave label_statLostUser ;
    end if;        
     
    set n_Result = 1 ;
end label_statLostUser ;

END$$


-- ----------------------------
-- Procedure structure for `statNewLoginInterval`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statNewLoginInterval`;

CREATE  PROCEDURE `statNewLoginInterval`(IN dt_stat_time datetime,OUT n_Result int(10))
BEGIN
     declare n_start_id      bigint(20) default 0;
     declare n_end_id        bigint(20) default 0;
     declare n_login_amount  int(12)    default 0;
     declare dt_stat_date    datetime            ;
     declare dt_begin_time   datetime            ;
     declare dt_end_time     datetime            ;
     declare dt_tmp_date     datetime            ; 
     declare n_done          int        default 0;
     declare n_ret           int                 ;
     declare n_gateway       mediumint(9)        ;
     declare gateCursor cursor for
             select 
                gateway_id
             from
                sys_gateway        ;
label_statLoginAmountInterval:begin

     declare continue handler for not found set n_done = 1;  /*nor data found error*/
     
     call getStatTime(dt_stat_time, dt_stat_date, dt_begin_time, dt_end_time);  /*get the stat time according to input parametor*/
     
     set dt_tmp_date = dt_stat_date;
     
     if (date_format(dt_stat_date,'%H%i%S') = '000000') then
       set dt_tmp_date = adddate(dt_tmp_date,-1);
     end if;
     
     /*init gateway*/
     open gateCursor ;
     gatewayLoop:loop
     fetch gateCursor into n_gateway ;
     
     if(n_done = 1) then
        set n_done = 2    ;  /*change the not found exception state*/
        leave gatewayLoop ;
     end if ;
         insert into 
               bas_new_login_amount (stat_time,                    
                                     gateway_id,
                                     amount)
         values (dt_stat_date,
                 n_gateway,
                 0);
     end loop gatewayLoop;  
     -- رα
     close gateCursor ;
   
     call getLogIdRange(
                    dt_tmp_date,
                    dt_tmp_date,
                    'LOG_USER_FIRST_LOGIN_INFO',
                    n_start_id,
                    n_end_id,
                    n_ret);
     if (n_end_id > 0 and n_start_id >0 and n_start_id <= n_end_id) then
         open gateCursor ;
         dataLoop:loop
         fetch gateCursor into n_gateway ;
         if(n_done = 1) then
            set n_done = 2    ;  /*change the not found exception state*/
            leave dataLoop ;
         end if ;

         select 
             ifnull(count(user_id), 0) amount
				 from 
						 log_user_first_login_info 
				 where 
						 (log_id         between n_start_id    and n_end_id      )      and 
             (first_login_time between dt_begin_time and dt_end_time   )      and
             (gateway_id       =       n_gateway)
         into n_login_amount;
				
         update
             bas_new_login_amount
         set
             amount =  n_login_amount
         where
             stat_time   = dt_stat_date       and
             gateway_id  = n_gateway ;

         if(n_done = 1)then
             set n_login_amount = 0   ;
             set n_Result       = -500;
         end if;
         end loop dataLoop ;
     else
         set n_login_amount = 0   ;
				 set n_Result       =-500 ;
     end if ;
     set n_Result = 1 ;
end label_statLoginAmountInterval;

END$$


-- ----------------------------
-- Procedure structure for `statPlayersLostState`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statPlayersLostState`;

CREATE  PROCEDURE `statPlayersLostState`(IN dt_stat_date datetime,OUT n_Result int(10))
BEGIN
	

label_statPlayerLostStat:begin
	  call updateLostState(dt_stat_date, 'day');                
       
    call updateLostState(dt_stat_date, 'sevenday');
       
    call updateLostState(dt_stat_date, 'week');
         
    call updateLostState(dt_stat_date, 'month');

    set n_Result = 1 ;

end label_statPlayerLostStat ;

END$$


-- ----------------------------
-- Procedure structure for `statPlayersLostUserDaily`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statPlayersLostUserDaily`;

CREATE  PROCEDURE `statPlayersLostUserDaily`(IN dt_stat_time date)
BEGIN
	
lable_task:begin
   call etl_user_login(adddate(dt_stat_time,-1),@result);
   call updateFirstLogin(adddate(dt_stat_time,-1),@result);
   call statLoginUserLevel(adddate(dt_stat_time,-1),1,-1,@result);
   call statLoginUserLevel(adddate(dt_stat_time,-1),2,-1,@result);
   call statPlayersLostState(adddate(dt_stat_time,-1),@result);
   -- day lost
   call statLostUser(adddate(dt_stat_time,-2),1,'day',-1,@result);
   call statLostUser(adddate(dt_stat_time,-2),-1,'day',-1,@result);
   -- sevenday lost
	 call statLostUser(adddate(dt_stat_time,-8),1,'sevenday',-1,@result);
   call statLostUser(adddate(dt_stat_time,-8),-1,'sevenday',-1,@result);
   -- week lost
   call statLostUser(adddate(dt_stat_time,-15),1,'week',-1,@result);
   call statLostUser(adddate(dt_stat_time,-15),-1,'week',-1,@result);
   -- month lost
   call statLostUser(adddate(dt_stat_time,-61),1,'month',-1,@result);
   call statLostUser(adddate(dt_stat_time,-61),-1,'month',-1,@result);

   -- daily login
   call statDailyData(adddate(dt_stat_time,-1),@result);
end lable_task;

END$$


-- ----------------------------
-- Procedure structure for `statProductSale`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statProductSale`;

CREATE  PROCEDURE `statProductSale`(IN d_stat_date datetime,OUT n_Result int(10))
BEGIN
	declare n_start_id    bigint(20);
  declare n_end_id      bigint(20);
  declare n_ret         int ;

lable_statProductSale:begin
	declare exit handler for 1062 set n_Result = -500;/*Can't write, because of unique constraint*/
	
	call getLogIdRange(d_stat_date,d_stat_date,'UMS_USER_PURCHASE_DETAIL',n_start_id,n_end_id,n_ret);
  
  if(n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id)then
		insert into bas_product_sale
				(stat_date,gateway_id,package_id,
				 product_code,subject_id,purchase_count,
				 purchase_amount,level_stage,role_count)
		select 
				 date(d_stat_date),p.gateway_id,p.package_id,
				 ifnull(p.product_code, 0) product_code,p.subject_id,
				 ifnull(sum(p.purchase_count),0) purchase_amount,
				 ifnull(sum(p.cost_amount),0) cost_amount,
				 l.min_level lv_stage,count(distinct p.role_id) role_amount
		from 
				 vw_ums_user_product p, sys_level_interval l
		where 
				 p.purchase_id between n_start_id and n_end_id      and 
         p.role_level between l.min_level and l.max_level
		group by p.gateway_id, p.package_id, p.product_code, p.subject_id, l.min_level  ;
    -- sum
		insert into bas_product_sale
				(stat_date,gateway_id,package_id,
				 product_code,subject_id,purchase_count,
				 purchase_amount,level_stage,role_count)
		select 
				 date(d_stat_date),p.gateway_id,p.package_id,
				 '0' product_code,p.subject_id,
				 ifnull(sum(p.purchase_count),0) purchase_amount,
				 ifnull(sum(p.cost_amount),0) cost_amount,
				 l.min_level lv_stage,count(distinct p.role_id) role_amount
		from 
				 vw_ums_user_product p, sys_level_interval l
		where 
				 p.purchase_id between n_start_id and n_end_id      and 
         p.role_level between l.min_level and l.max_level
		group by p.gateway_id, p.package_id, p.subject_id, l.min_level  ;
 
    set n_Result = 1 ;
    leave lable_statProductSale ;
  else
     set n_Result = -500 ;
     leave lable_statProductSale ;
  end if ;
    
end lable_statProductSale ;

END$$


-- ----------------------------
-- Procedure structure for `statPurchaseByCodeDaily`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statPurchaseByCodeDaily`;

CREATE  PROCEDURE `statPurchaseByCodeDaily`(IN dt_stat_date date)
BEGIN
	
lable_stat:begin
   call statProductSale(adddate(dt_stat_date,-1),@result);
end lable_stat;

END$$

-- ----------------------------
-- Procedure structure for `statRoleOccupation`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statRoleOccupation`;

CREATE  PROCEDURE `statRoleOccupation`(IN dt_stat_date datetime,OUT n_Result int(10))
BEGIN
	 -- declare n_done int default 0 ;

label_statRoleOccupation:begin
   declare exit handler for not found set n_Result  = -500 ;
  
   insert into 
      bas_role_occupation(stat_date,gateway_id,occupation_id,amount)
   select 
      date(dt_stat_date),gateway_id,role_occupation,count(role_occupation) amount
   from 
      ums_role
   group by 
      gateway_id, role_occupation ;
   
   set   n_Result = 1 ;
   leave label_statRoleOccupation ;
  
end label_statRoleOccupation ;

END$$


-- ----------------------------
-- Procedure structure for `statRoleOccupationDailyTask`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statRoleOccupationDailyTask`;

CREATE  PROCEDURE `statRoleOccupationDailyTask`(IN d_stat_date date)
BEGIN
lable_stat:begin

  call statRoleOccupation(adddate(d_stat_date,-1),@result);

end lable_stat;

END$$


-- ----------------------------
-- Procedure structure for `statUserOnline`
-- ----------------------------
DROP PROCEDURE IF EXISTS `statUserOnline`;

CREATE  PROCEDURE `statUserOnline`()
BEGIN
	declare dt_stat_time  datetime default now();

label_statUserOnline:begin

  -- set dt_stat_time = str_to_date(date_format(now(),'%Y-%m-%d %H:%i:00'),'%Y-%m-%d %H:%i:%S');
  set dt_stat_time = date_format(now(),'%Y-%m-%d %H:%i:00');
  insert into 
      stat_user_online(stat_time,gateway_id,user_online_count)
  select 
      dt_stat_time,gateway_id,sum(user_online_count) 
  from 
      log_user_online_count
  group by
      gateway_id ;
end label_statUserOnline ;

END$$


-- ----------------------------
-- Procedure structure for `stat_consume_day_week`
-- ----------------------------
DROP PROCEDURE IF EXISTS `stat_consume_day_week`;

CREATE  PROCEDURE `stat_consume_day_week`(IN dt_stat_date datetime,IN s_stat_type varchar(64),OUT n_Result int(10))
BEGIN
	
	   declare dt_begin_time    datetime default date(dt_stat_date);
     declare dt_end_time      datetime;
     declare s_stat_date      varchar(64); 
     declare n_money          decimal(12,2) default 0;
     declare n_user           decimal(10,0) default 0;
     declare n_avg_amount     decimal(10,0) default 0;
     declare n_avg_peak_value decimal(10,0) default 0;
     declare n_charge_amount  decimal(12,2) default 0;
     declare n_ret_code       int(10);
     declare n_start_id       bigint(20);
     declare n_end_id         bigint(20);
     declare n_done           int(10) default 0 ;

label_stat_arpu:begin
	   declare exit handler for 1062 set n_Result = -500;/*Can't write, because of unique constraint*/
     declare continue handler for not found set n_done = 1;/*Can't write, because of unique constraint*/

		 set s_stat_date = date_format(date(dt_stat_date),'%Y-%m-%d');
     if (s_stat_type = 'day') then
       set dt_end_time = addtime(date_format(dt_stat_date,'%Y-%m-%d 00:00:00'),'23:59:59');
     elseif(s_stat_type = 'week') then
       set dt_end_time = addtime(date_format(adddate(dt_stat_date,6),'%Y-%m-%d 00:00:00'),'23:59:59');
     else
        set n_Result = -500 ;
        leave label_stat_arpu ;
     end if;
     
		 call getLogIdRange(dt_stat_date,dt_stat_date,'UMS_USER_PURCHASE_DETAIL',n_start_id,n_end_id,n_ret_code);

     if(n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id)then
				select 
            ifnull(sum(cost_amount),0) / 10 consum_money,
					  ifnull(count(distinct user_id),0)  consum_user
        from 
            vw_ums_user_product
        where 
            purchase_id between n_start_id and n_end_id    and 
            subject_id=3                                   and 
            gateway_id>0
        into 
            n_money,n_user ;
        if(n_done = 1)then 
						set n_money = 0 ;
						set n_user  = 0 ;
            set n_done = 0 ;
        end if;
     else
				set n_money = 0 ;
        set n_user  = 0 ;
     end if;

     select 
        round(ifnull(avg(nullif(avg_amount, 0)), 0)) avg_amount, 
        round(ifnull(avg(nullif(peak_value_amount, 0)),0)) avg_peak_value,
        ifnull(sum(charge_money), 0) charge_amount
     from 
        bas_core_data
     where 
        stat_date between date(dt_begin_time) and date(dt_end_time)
     into
        n_avg_amount, n_avg_peak_value, n_charge_amount ;
     
     if(n_done = 1)then 
						set n_avg_amount = 0 ;
						set n_avg_peak_value  = 0 ;
            set n_charge_amount = 0 ;
     end if;
     
     insert into bas_consume_money_user(
                 stat_date,stat_type,consume_money,
                 consume_user,avg_user_amount,
                 avg_peak_value,charge_amount)
     values (s_stat_date,s_stat_type,
             n_money,n_user,n_avg_amount,
             n_avg_peak_value,n_charge_amount);

     set n_Result =  1 ;
end label_stat_arpu ;

END$$


-- ----------------------------
-- Procedure structure for `stat_consume_month_quarter`
-- ----------------------------
DROP PROCEDURE IF EXISTS `stat_consume_month_quarter`;

CREATE  PROCEDURE `stat_consume_month_quarter`(IN s_stat_year varchar(32),IN n_date_value int(10),IN s_stat_type varchar(64),OUT n_Result int(10))
BEGIN
	   declare dt_begin_time    datetime ;
     declare dt_end_time      datetime;
     declare s_stat_date      varchar(64); 
     declare n_money          decimal(12,2) default 0;
     declare n_user           decimal(10,0) default 0;
     declare n_avg_amount     decimal(10,0) default 0;
     declare n_avg_peak_value decimal(10,0) default 0;
     declare n_charge_amount  decimal(12,2) default 0;
     declare n_ret_code       int(10);
     declare n_start_id       bigint(20);
     declare n_end_id         bigint(20);
     declare n_done           int(10) default 0 ;

label_arpu_quarter:begin
    declare continue handler for not found set n_done = 1;/*Can't write, because of unique constraint*/
		declare exit handler for 1062 set n_Result = -500;/*Can't write, because of unique constraint*/
		if (s_stat_type = 'month') then
       case n_date_value
         when 1 then
           set dt_begin_time = concat(s_stat_year,'-01-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 2 then
           set dt_begin_time = concat(s_stat_year,'-02-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 3 then
           set dt_begin_time = concat(s_stat_year,'-03-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 4 then
           set dt_begin_time = concat(s_stat_year,'-04-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 5 then
           set dt_begin_time = concat(s_stat_year,'-05-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 6 then
           set dt_begin_time = concat(s_stat_year,'-06-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 7 then
           set dt_begin_time = concat(s_stat_year,'-07-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 8 then
           set dt_begin_time = concat(s_stat_year,'-08-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 9 then
           set dt_begin_time = concat(s_stat_year,'-09-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 10 then
           set dt_begin_time = concat(s_stat_year,'-10-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 11 then
           set dt_begin_time = concat(s_stat_year,'-11-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 12 then
           set dt_begin_time = concat(s_stat_year,'-12-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 1 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         else
           set n_Result = -500 ;
           leave label_arpu_quarter ;
       end case;
     elseif (s_stat_type = 'quarter') then
       case n_date_value
         when 1 then
           set dt_begin_time = concat(s_stat_year,'-01-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 3 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 2 then
           set dt_begin_time = concat(s_stat_year,'-04-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 3 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 3 then
           set dt_begin_time = concat(s_stat_year,'-07-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 3 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         when 4 then
           set dt_begin_time = concat(s_stat_year,'-10-01');
           set dt_end_time   = addtime(date_format(date_add(date(dt_begin_time),interval 3 month),'%Y-%m-%d 00:00:00'),'-00:00:01');
         else
           set n_Result = -500 ;
           leave label_arpu_quarter ;
       end case;
     else
       set n_Result = -500 ;
       leave label_arpu_quarter ;
     end if;

		 if(n_date_value<10)then
				set s_stat_date = concat(s_stat_year,0,n_date_value);
     else
        set s_stat_date = concat(s_stat_year,n_date_value);
     end if ;

     call getLogIdRange(dt_begin_time,dt_end_time,'UMS_USER_PURCHASE_DETAIL',n_start_id,n_end_id,n_ret_code);

     if(n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id)then
				select 
            ifnull(sum(cost_amount),0) / 10 consum_money,
					  ifnull(count(distinct user_id),0)  consum_user
        from 
            vw_ums_user_product
        where 
            purchase_id between n_start_id and n_end_id    and 
            subject_id=3                                   and 
            gateway_id>0
        into 
            n_money,n_user ;
        if(n_done = 1)then 
						set n_money = 0 ;
						set n_user  = 0 ;
            set n_done = 0 ;
        end if;
     else
				set n_money = 0 ;
        set n_user  = 0 ;
     end if;

     select 
        round(ifnull(avg(nullif(avg_amount, 0)), 0)) avg_amount, 
        round(ifnull(avg(nullif(peak_value_amount, 0)),0)) avg_peak_value,
        ifnull(sum(charge_money), 0) charge_amount
     from 
        bas_core_data
     where 
        stat_date between date(dt_begin_time) and date(dt_end_time)
     into
        n_avg_amount, n_avg_peak_value, n_charge_amount ;
     
     if(n_done = 1)then 
						set n_avg_amount = 0 ;
						set n_avg_peak_value  = 0 ;
            set n_charge_amount = 0 ;
     end if;
     
     insert into bas_consume_money_user(
                 stat_date,stat_type,consume_money,
                 consume_user,avg_user_amount,
                 avg_peak_value,charge_amount)
     values (s_stat_date,s_stat_type,
             n_money,n_user,n_avg_amount,
             n_avg_peak_value,n_charge_amount);

     set n_Result =  1 ;
end label_arpu_quarter ;

END$$


-- ----------------------------
-- Procedure structure for `updateFirstLogin`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateFirstLogin`;

CREATE  PROCEDURE `updateFirstLogin`(IN dt_stat_date datetime,OUT n_Result int(10))
BEGIN
	  declare n_start_id bigint(20);
    declare n_end_id   bigint(20);
    declare n_Ret      int(20);

label_updateFirstLogin:begin
    declare continue handler for sqlexception begin end ;
    
		call getLogIdRange(dt_stat_date,
                       dt_stat_date,
                       'LOG_USER_FIRST_LOGIN_INFO',
                       n_start_id,
                       n_end_id,
                       n_Ret);
    if n_start_id > 0 and n_end_id > 0 and n_start_id <= n_end_id then
				delete from sys_passport_temporay ;   /*delete template table*/
        insert into sys_passport_temporay
        select 
           user_id 
        from
           log_user_first_login_info
        where
           log_id between n_start_id and n_end_id ;

        update
          log_login_lost l
        set 
          is_first_login = 1
        where 
          exists
          (select 1 from sys_passport_temporay p where p.user_id = l.passport_id); 
    else
        set n_Result = -500 ;
        leave label_updateFirstLogin ;
    end if;
end label_updateFirstLogin ;

END$$

-- ----------------------------
-- Procedure structure for `updateLostState`
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateLostState`;

CREATE  PROCEDURE `updateLostState`(IN dt_stat_date datetime,IN s_stat_type varchar(64))
BEGIN
   declare  s_field          varchar(64);
   declare  dt_begin_date    datetime;
   declare  dt_end_date      datetime;

   case s_stat_type
       when 'day' then
         set s_field = 'day_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-1);
         set dt_end_date = adddate(date(dt_stat_date),-1);
       when 'week' then
         set s_field = 'week_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-14);
         set dt_end_date = adddate(date(dt_stat_date),-8);
       when 'month' then
         set s_field = 'month_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-60);
         set dt_end_date := adddate(date(dt_stat_date),-31);
       when 'quarter' then
         set s_field = 'quarter_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-120);
         set dt_end_date = adddate(date(dt_stat_date),-91);
       when 'halfyear' then
         set s_field = 'halfyear_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-210);
         set dt_end_date = adddate(date(dt_stat_date),-181);
       when 'sevenday' then
         set s_field = 'sevenday_lost';
         set dt_begin_date = adddate(date(dt_stat_date),-7);
         set dt_end_date = adddate(date(dt_stat_date),-1);
     end case;
label_updateLostState:begin
    declare exit handler for sqlexception begin end ;
     lost_loop:while (dt_begin_date<=dt_end_date)do
       set @begin_date = dt_begin_date;
       set @stat_date = date(dt_stat_date);
       set @s_sql = concat('update log_login_lost t1 set ',
                           s_field,'=1
                           where 
                              login_date= ?       and 
                              t1.passport_id in (select tem.passport_id from(
                                  select 
                                      passport_id
                                  from 
                                      log_login_lost
                                  where 
                                      login_date = ?
                                  and login_id>0)tem)  and 
                              t1.',s_field,'=2     and 
                              t1.login_id>0');
       prepare SQLSA from @s_sql ;
       execute SQLSA using @begin_date,@stat_date;
       set dt_begin_date = adddate(dt_begin_date,1);
     end while lost_loop;

end label_updateLostState;

END$$

DELIMITER ;
-- ----------------------------
-- Event structure for `event_chargingInterval`
-- ----------------------------
DROP EVENT IF EXISTS `event_chargingInterval`;

CREATE  EVENT `event_chargingInterval` ON SCHEDULE EVERY 30 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statChargingInterval(now(),@result)
;


-- ----------------------------
-- Event structure for `event_consumeInterval`
-- ----------------------------
DROP EVENT IF EXISTS `event_consumeInterval`;

CREATE  EVENT `event_consumeInterval` ON SCHEDULE EVERY 30 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statConsumeInterval(now(),@result)
;


-- ----------------------------
-- Event structure for `event_coreDataDailyTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_coreDataDailyTask`;

CREATE  EVENT `event_coreDataDailyTask` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 03:00:00' ENABLE DO call statCoreData(adddate(now(),-1))
;


-- ----------------------------
-- Event structure for `event_coreDataQuarterTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_coreDataQuarterTask`;

CREATE  EVENT `event_coreDataQuarterTask` ON SCHEDULE EVERY 15 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statCoreData(now())
;


-- ----------------------------
-- Event structure for `event_levelStageDailyTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_levelStageDailyTask`;

CREATE  EVENT `event_levelStageDailyTask` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 00:30:00' ENABLE DO call statLevelStageDailyTask(now())
;


-- ----------------------------
-- Event structure for `event_loginInterval`
-- ----------------------------
DROP EVENT IF EXISTS `event_loginInterval`;

CREATE  EVENT `event_loginInterval` ON SCHEDULE EVERY 30 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statLoginAmountInterval(now(),@result)
;


-- ----------------------------
-- Event structure for `event_newLoginInterval`
-- ----------------------------
DROP EVENT IF EXISTS `event_newLoginInterval`;

CREATE  EVENT `event_newLoginInterval` ON SCHEDULE EVERY 30 MINUTE STARTS '2011-01-01 01:01:00' ENABLE DO call statNewLoginInterval(now(),@result)
;


-- ----------------------------
-- Event structure for `event_roleOccupationDailyTask`
-- ----------------------------
DROP EVENT IF EXISTS `event_roleOccupationDailyTask`;

CREATE  EVENT `event_roleOccupationDailyTask` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 00:02:00' ENABLE DO call statRoleOccupationDailyTask(now())
;


-- ----------------------------
-- Event structure for `event_statARPU`
-- ----------------------------
DROP EVENT IF EXISTS `event_statARPU`;

CREATE  EVENT `event_statARPU` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 07:00:00' ENABLE DO call statARPUDaily(now())
;


-- ----------------------------
-- Event structure for `event_statPurchase`
-- ----------------------------
DROP EVENT IF EXISTS `event_statPurchase`;

CREATE  EVENT `event_statPurchase` ON SCHEDULE EVERY 1 DAY STARTS '2010-01-01 02:00:00' ENABLE DO call statPurchaseByCodeDaily(now())
;


-- ----------------------------
-- Event structure for `event_userLost`
-- ----------------------------
DROP EVENT IF EXISTS `event_userLost`;

CREATE  EVENT `event_userLost` ON SCHEDULE EVERY 1 DAY STARTS '2011-01-01 03:00:00' ENABLE DO call statPlayersLostUserDaily(now())
;


-- ----------------------------
-- Event structure for `event_userOnlineInterval`
-- ----------------------------
DROP EVENT IF EXISTS `event_userOnlineInterval`;

CREATE  EVENT `event_userOnlineInterval` ON SCHEDULE EVERY 5 MINUTE STARTS '2011-01-01 00:00:00' ENABLE DO call statUserOnline()
;

