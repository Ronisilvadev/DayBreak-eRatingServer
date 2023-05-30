/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.9-log : Database - egamemaster_mysql
*********************************************************************
*/
  SET NAMES utf8;

  SET SQL_MODE='';

  create database if not exists `egamemaster`;
	
  USE `egamemaster`;

  SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

/*Table structure for table `bak_sys_trustee_ip` */

DROP TABLE IF EXISTS `bak_sys_trustee_ip`;

CREATE TABLE `bak_sys_trustee_ip` (
  `GAME_ID` int(3) NOT NULL,
  `GATEWAY_TYPE` int(4) NOT NULL,
  `IP_ID` int(6) NOT NULL,
  `IP_NAME` varchar(32) NOT NULL,
  `TRUSTEE_IP` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bak_sys_trustee_ip` */

LOCK TABLES `bak_sys_trustee_ip` WRITE;

UNLOCK TABLES;

/*Table structure for table `hb_sys_roles_parent` */

DROP TABLE IF EXISTS `hb_sys_roles_parent`;

CREATE TABLE `hb_sys_roles_parent` (
  `PARENT_ROLE_ID` int(10) NOT NULL,
  `ROLE_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hb_sys_roles_parent` */

LOCK TABLES `hb_sys_roles_parent` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_activity` */

DROP TABLE IF EXISTS `log_activity`;

CREATE TABLE `log_activity` (
  `ACTIVITY_ID` int(8) NOT NULL,
  `ACTIVITY_NAME` varchar(500) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `START_CMD` varchar(500) NOT NULL,
  `END_CMD` varchar(500) NOT NULL,
  `CIRCLEDAY` int(8) NOT NULL,
  PRIMARY KEY (`ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_activity` */

LOCK TABLES `log_activity` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_activity_code` */

DROP TABLE IF EXISTS `log_activity_code`;

CREATE TABLE `log_activity_code` (
  `LOG_ID` int(10) NOT NULL COMMENT 'id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `PLAN_GEN_NO` int(6) NOT NULL COMMENT '计划生成的激活码数量',
  `SUCCESS_GEN_NO` int(6) NOT NULL COMMENT '成功生成的激活码数量',
  `FILE_PATH` varchar(2048) NOT NULL COMMENT '生成的文件的全路径',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作人名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录激活码生成日志';

/*Data for the table `log_activity_code` */

LOCK TABLES `log_activity_code` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_activity_setting` */

DROP TABLE IF EXISTS `log_activity_setting`;

CREATE TABLE `log_activity_setting` (
  `ACTIVITY_ID` int(8) NOT NULL COMMENT '活动ID',
  `ACTIVITY_NAME` varchar(500) NOT NULL COMMENT '活动名称',
  `ACTIVITY_KEYWORD` varchar(500) NOT NULL COMMENT '活动关键字',
  `ACTIVITY_CMD` varchar(500) DEFAULT NULL COMMENT '命令行参数',
  `GAME_ID` int(8) DEFAULT NULL COMMENT '游戏ID',
  `ISRESTART` varchar(1) NOT NULL COMMENT '是否是周循环活动',
  `ACTIVIRYNUM` varchar(500) DEFAULT NULL COMMENT '活动编码',
  `CIRCLE` varchar(1) DEFAULT NULL COMMENT '星期',
  `STARTTIME` varchar(100) DEFAULT NULL COMMENT '开始时间',
  `ENDTIME` varchar(100) DEFAULT NULL COMMENT '结束时间',
  `ISRESERVATION` varchar(1) DEFAULT NULL COMMENT '是否预约',
  PRIMARY KEY (`ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_activity_setting` */

LOCK TABLES `log_activity_setting` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_additem_comp` */

DROP TABLE IF EXISTS `log_additem_comp`;

CREATE TABLE `log_additem_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `GATEWAY_ID` int(10) NOT NULL COMMENT '网关ID,0-全区全服',
  `SERVER_ID` int(10) NOT NULL COMMENT '所在线',
  `ROLE_ID` int(10) NOT NULL COMMENT '角色ID',
  `ROLE_NAME` varchar(500) NOT NULL COMMENT '角色名称',
  `ITEM_ID` varchar(500) NOT NULL COMMENT '装备ID',
  `ITEM_NUM` int(10) NOT NULL COMMENT '数目',
  `STAR` int(10) NOT NULL COMMENT '装备星级',
  `ITEM_LEVEL` int(10) NOT NULL COMMENT '装备强化级别',
  `BIND` int(10) NOT NULL COMMENT '装备是否绑定,0-不绑定,1-绑定',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) unsigned NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) unsigned NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` date NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='装备补偿日志表';

/*Data for the table `log_additem_comp` */

LOCK TABLES `log_additem_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_additem_comp_approval` */

DROP TABLE IF EXISTS `log_additem_comp_approval`;

CREATE TABLE `log_additem_comp_approval` (
  `LOG_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '技能补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_ADDITEM_COMP_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_ADDITEM_COMP_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_additem_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='技能补偿审批日志表';

/*Data for the table `log_additem_comp_approval` */

LOCK TABLES `log_additem_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_award_comp` */

DROP TABLE IF EXISTS `log_award_comp`;

CREATE TABLE `log_award_comp` (
  `COMPENSATE_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `ACTIVITY_ID` int(10) NOT NULL COMMENT '活动编号，10位数字',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID,0-全区全服',
  `ITEM_LIST` varchar(4000) NOT NULL COMMENT '物品编号列表，物品编码和数量，以逗号（,）分隔。每行一条信息。\n            例如：\n            i-88001,5\n            i-88002,3',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `BEGIN_TIME` datetime NOT NULL COMMENT '开始时间',
  `END_TIME` datetime NOT NULL COMMENT '结束时间',
  `STATE` int(3) unsigned NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3)  NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  `PASSPORT_NAME_LIST` text NOT NULL,
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET=utf8 COMMENT='活动奖品补偿日志表';

/*Data for the table `log_award_comp` */

LOCK TABLES `log_award_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_award_comp_approval` */

DROP TABLE IF EXISTS `log_award_comp_approval`;

CREATE TABLE `log_award_comp_approval` (
  `LOG_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '活动奖品补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_AWAR_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_AWAR_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_award_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动奖品补偿审批日志表';

/*Data for the table `log_award_comp_approval` */

LOCK TABLES `log_award_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_bind_email` */

DROP TABLE IF EXISTS `log_bind_email`;

CREATE TABLE `log_bind_email` (
  `CHANGE_ID` int(10) NOT NULL COMMENT '日志id',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '绑定帐号名',
  `NEW_EMAIL` varchar(64) NOT NULL COMMENT '新邮箱地址',
  `STATE` int(3) unsigned NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) unsigned NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `REASON` varchar(1024) NOT NULL COMMENT '修改原因',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='修改绑定邮箱日志表';

/*Data for the table `log_bind_email` */

LOCK TABLES `log_bind_email` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_bind_email_approval` */

DROP TABLE IF EXISTS `log_bind_email_approval`;

CREATE TABLE `log_bind_email_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `CHANGE_ID` int(10) NOT NULL COMMENT '修改绑定邮箱日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_BIND_APPROVAL` (`CHANGE_ID`),
  CONSTRAINT `FK_LOG_BIND_APPROVAL` FOREIGN KEY (`CHANGE_ID`) REFERENCES `log_bind_email` (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='修改绑定邮箱审批日志表';

/*Data for the table `log_bind_email_approval` */

LOCK TABLES `log_bind_email_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_bulletin_approval` */

DROP TABLE IF EXISTS `log_bulletin_approval`;

CREATE TABLE `log_bulletin_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '技能补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='技能补偿审批日志表';

/*Data for the table `log_bulletin_approval` */

LOCK TABLES `log_bulletin_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_bulletin_info` */

DROP TABLE IF EXISTS `log_bulletin_info`;

CREATE TABLE `log_bulletin_info` (
  `BULLETIN_ID` int(10) NOT NULL COMMENT '公告id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `TITLE` varchar(512) NOT NULL COMMENT '公告标题',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `START_TIME` datetime NOT NULL COMMENT '开始时间',
  `END_TIME` datetime NOT NULL COMMENT '结束时间',
  `INTERVALS` int(10) NOT NULL COMMENT '发送时间间隔',
  `CONTENT` varchar(2048) NOT NULL COMMENT '公告内容',
  `TOTAL_TIMES` int(10) NOT NULL COMMENT '总共执行次数',
  `STATE` int(3) NOT NULL COMMENT '1-公告未被gmserver接收，2-公告已被gmserver接收，3-执行中，4-公告已执行完毕，5-公告已撤销',
  `CANCEL_TIME` datetime DEFAULT NULL COMMENT '撤销时间',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '添加人名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '添加时间',
  `CANCEL_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '撤销人名称',
  `BOOKING` varchar(5) NOT NULL DEFAULT '-1' COMMENT '即时预约',
  `APPROVAL_RESULT` int(3) NOT NULL DEFAULT '-1' COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPER_STATE` int(3) NOT NULL DEFAULT '-1' COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  PRIMARY KEY (`BULLETIN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录发布公告日志';

/*Data for the table `log_bulletin_info` */

LOCK TABLES `log_bulletin_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_bulletin_detail` */

DROP TABLE IF EXISTS `log_bulletin_detail`;

CREATE TABLE `log_bulletin_detail` (
  `BULLETIN_ID` int(10) NOT NULL COMMENT '公告id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `EXECUTIVE_TIMES` int(10) NOT NULL COMMENT '执行次数',
  `SUCCESS_TIMES` int(10) NOT NULL COMMENT '成功次数',
  `LAST_EXECUTE_TIME` datetime DEFAULT NULL COMMENT '上一次执行的时间',
  `STATE` int(3) DEFAULT NULL COMMENT '1-公告未被gmserver接收，2-公告已被gmserver接收，3-执行中，4-公告已执行完毕，5-公告已撤销',
  `CANCEL_TIME` datetime DEFAULT NULL COMMENT '同步目标游戏',
  PRIMARY KEY (`BULLETIN_ID`,`SERVER_ID`,`GATEWAY_ID`),
  CONSTRAINT `FK_BULL_INFO_BULL_DTL` FOREIGN KEY (`BULLETIN_ID`) REFERENCES `log_bulletin_info` (`BULLETIN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏公告详情';

/*Data for the table `log_bulletin_detail` */

LOCK TABLES `log_bulletin_detail` WRITE;

UNLOCK TABLES;


/*Table structure for table `log_change_amount` */

DROP TABLE IF EXISTS `log_change_amount`;

CREATE TABLE `log_change_amount` (
  `CHANGE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID,0-全区全服',
  `SERVER_ID` int(8) NOT NULL COMMENT '线ID',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '玩家账号名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `ROLE_ID` int(10) NOT NULL COMMENT '角色id',
  `CHANGE_TYPE` int(3) NOT NULL COMMENT '补偿类型，1-经验，2-金钱，3-三元点，4-悟性',
  `CHANGE_AMOUNT` int(10) NOT NULL COMMENT '补偿的数量',
  `REMAIN_AMOUNT` int(10) NOT NULL COMMENT '角色在操作成功后的剩余数量，若为-1，表示未知。',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(4) unsigned NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据修改日志表，包括金钱，经验，三元点，悟性';

/*Data for the table `log_change_amount` */

LOCK TABLES `log_change_amount` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_change_amount_approval` */

DROP TABLE IF EXISTS `log_change_amount_approval`;

CREATE TABLE `log_change_amount_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `CHANGE_ID` int(10) NOT NULL COMMENT '活动奖品补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_CHANGE_APPROVAL` (`CHANGE_ID`),
  CONSTRAINT `FK_LOG_CHANGE_APPROVAL` FOREIGN KEY (`CHANGE_ID`) REFERENCES `log_change_amount` (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据修改审批日志表';

/*Data for the table `log_change_amount_approval` */

LOCK TABLES `log_change_amount_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_change_sys_resources` */

DROP TABLE IF EXISTS `log_change_sys_resources`;

CREATE TABLE `log_change_sys_resources` (
  `OPERETOR` varchar(16) DEFAULT NULL COMMENT '修改者',
  `IP_ADDRESS` varchar(50) DEFAULT NULL COMMENT '修改者登录IP',
  `CHANGE_TIME` datetime NOT NULL COMMENT '修改时间',
  `ACTION` varchar(8) NOT NULL COMMENT '修改类型',
  `OLD_RES_URL` varchar(1024) DEFAULT NULL COMMENT '修改前的资源连接',
  `NEW_RES_URL` varchar(1024) DEFAULT NULL COMMENT '修改后的资源连接'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录表sys_resources被修改时间的日志';

/*Data for the table `log_change_sys_resources` */

LOCK TABLES `log_change_sys_resources` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_clean_package` */

DROP TABLE IF EXISTS `log_clean_package`;

CREATE TABLE `log_clean_package` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `ROLE_ID` int(10) NOT NULL COMMENT '角色id',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '角色所属账号',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作人',
  `INSERT_TIME` datetime NOT NULL COMMENT '操作时间',
  `RESON` varchar(1024) NOT NULL COMMENT '详细描述',
  `DETAIL` varchar(4000) NOT NULL COMMENT '清空的物品记录',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清空玩家包裹日志表';

/*Data for the table `log_clean_package` */

LOCK TABLES `log_clean_package` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_clearpoint_comp` */

DROP TABLE IF EXISTS `log_clearpoint_comp`;

CREATE TABLE `log_clearpoint_comp` (
  `COMPENSATE_ID` int(8) NOT NULL COMMENT '日志id',
  `GAME_ID` int(8) NOT NULL COMMENT '游戏编号',
  `REASON` varchar(4000) NOT NULL COMMENT '原因',
  `STATE` int(8) unsigned NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(8) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。',
  `OPERATOR_NAME` varchar(100) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  `POINTTYPE` int(8) NOT NULL COMMENT '积分类型',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清除充值积分日志表';

/*Data for the table `log_clearpoint_comp` */

LOCK TABLES `log_clearpoint_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_clearpoint_comp_approval` */

DROP TABLE IF EXISTS `log_clearpoint_comp_approval`;

CREATE TABLE `log_clearpoint_comp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '技能补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_CLEARPOINT_COMP_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_CLEARPOINT_COMP_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_clearpoint_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清除充值积分审批日志表';

/*Data for the table `log_clearpoint_comp_approval` */

LOCK TABLES `log_clearpoint_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_close_pass_card` */

DROP TABLE IF EXISTS `log_close_pass_card`;

CREATE TABLE `log_close_pass_card` (
  `PASSPORT_ID` int(10) NOT NULL,
  `CHANGE_ID` int(10) NOT NULL COMMENT '日志id',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '绑定帐号名',
  `PLAYER_NAME` varchar(64) NOT NULL COMMENT '玩家姓名',
  `PRIVATE_ID` varchar(32) NOT NULL COMMENT '身份证号码',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `REASON` varchar(1024) NOT NULL COMMENT '修改原因',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='密保卡解绑日志表';

/*Data for the table `log_close_pass_card` */

LOCK TABLES `log_close_pass_card` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_close_pass_card_approval` */

DROP TABLE IF EXISTS `log_close_pass_card_approval`;

CREATE TABLE `log_close_pass_card_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `CHANGE_ID` int(10) NOT NULL COMMENT '修改绑定邮箱日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_CLOS_REFERENCE_LOG_CLOS` (`CHANGE_ID`),
  CONSTRAINT `FK_LOG_CLOS_REFERENCE_LOG_CLOS` FOREIGN KEY (`CHANGE_ID`) REFERENCES `log_close_pass_card` (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='密保卡解绑审批日志表';

/*Data for the table `log_close_pass_card_approval` */

LOCK TABLES `log_close_pass_card_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_egmserver_command` */

DROP TABLE IF EXISTS `log_egmserver_command`;

CREATE TABLE `log_egmserver_command` (
  `RECORD_ID` int(10) NOT NULL COMMENT '在web db中的标识',
  `CMD_TYPE` int(8) NOT NULL,
  `SERVER_ID` int(8) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `CMD_PARAM` varchar(2048) NOT NULL COMMENT '命令参数',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏id',
  `GATEWAY_ID` int(6) DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `TOTAL_NUM` int(8) NOT NULL COMMENT '执行总数',
  `EXECUTED_NUM` int(8) NOT NULL COMMENT '当前执行次数',
  `BE_DONE` int(8) DEFAULT '0',
  `CMD_ID` int(10) NOT NULL,
  PRIMARY KEY (`CMD_ID`),
  KEY `LOG_EGMSERVER_COMMAND_IX` (`RECORD_ID`,`CMD_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='eGMServer 命令体验业务表-包含所有稍后执行命令，如发布公告，双倍等';

/*Data for the table `log_egmserver_command` */

LOCK TABLES `log_egmserver_command` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_end_fight_state` */

DROP TABLE IF EXISTS `log_end_fight_state`;

CREATE TABLE `log_end_fight_state` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '角色所属账号',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作人',
  `INSERT_TIME` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结束玩家战斗状态日志表';

/*Data for the table `log_end_fight_state` */

LOCK TABLES `log_end_fight_state` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_end_task` */

DROP TABLE IF EXISTS `log_end_task`;

CREATE TABLE `log_end_task` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '角色所属账号',
  `TASK_NAME` varchar(128) NOT NULL COMMENT '任务名称',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作人',
  `INSERT_TIME` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结束任务日志表';

/*Data for the table `log_end_task` */

LOCK TABLES `log_end_task` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_freeze_account` */

DROP TABLE IF EXISTS `log_freeze_account`;

CREATE TABLE `log_freeze_account` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `PASSPORT_ID` int(10) NOT NULL COMMENT 'passport编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0=体验区，1=正式区',
  `STATE` int(3) NOT NULL COMMENT '状态,1=冻结中,2=已恢复',
  `FREEZE_TIME` datetime NOT NULL COMMENT '冻结时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT '恢复时间',
  `LAST_SECONDS` int(10) NOT NULL COMMENT '冻结帐号持续时间，单位为秒',
  `REASON` varchar(1024) DEFAULT NULL COMMENT '冻结原因',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '冻结操作员名称',
  `RESTORE_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '恢复时，操作员的名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录冻结帐号日志';

/*Data for the table `log_freeze_account` */

LOCK TABLES `log_freeze_account` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_freeze_account_detail` */

DROP TABLE IF EXISTS `log_freeze_account_detail`;

CREATE TABLE `log_freeze_account_detail` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-执行完毕，5-人工停止',
  `FREEZE_TIME` datetime DEFAULT NULL COMMENT 'gm执行的时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT 'gm成功停止时间',
  PRIMARY KEY (`LOG_ID`,`GATEWAY_ID`),
  CONSTRAINT `FK_LOG_FREE_REFERENCE_LOG_FREE` FOREIGN KEY (`LOG_ID`) REFERENCES `log_freeze_account` (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='冻结账号详情';

/*Data for the table `log_freeze_account_detail` */

LOCK TABLES `log_freeze_account_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_freeze_mac` */

DROP TABLE IF EXISTS `log_freeze_mac`;

CREATE TABLE `log_freeze_mac` (
  `LOG_ID` int(8) NOT NULL COMMENT '记录ID',
  `GAME_ID` int(8) NOT NULL COMMENT '游戏ID',
  `GATEWAY_ID` int(8) NOT NULL COMMENT '网关ID',
  `MAC` varchar(64) NOT NULL COMMENT 'MAC地址',
  `START_TIME` varchar(64) NOT NULL COMMENT '开始时间',
  `PERIOD` int(8) NOT NULL COMMENT '冻结时长',
  `OPER_TYPE` int(8) NOT NULL COMMENT '操作类型',
  `OPER` varchar(64) NOT NULL COMMENT '操作人',
  `REASON` varchar(4000) NOT NULL COMMENT '操作原因',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_freeze_mac` */

LOCK TABLES `log_freeze_mac` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_gold_comp` */

DROP TABLE IF EXISTS `log_gold_comp`;

CREATE TABLE `log_gold_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `SERIAL_NUMBER` int(12) NOT NULL COMMENT '编号，12位数字',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID,0-全区全服',
  `SUBJECT_ID` int(4) DEFAULT NULL,
  `COMPENSATE_CONTENT` varchar(4000) NOT NULL COMMENT '补偿列表',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='金券补偿日志表';

/*Data for the table `log_gold_comp` */

LOCK TABLES `log_gold_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_gold_comp_approval` */

DROP TABLE IF EXISTS `log_gold_comp_approval`;

CREATE TABLE `log_gold_comp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '金券补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_GOLD_REFERENCE_LOG_GOLD` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_GOLD_REFERENCE_LOG_GOLD` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_gold_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='金券补偿审批日志表';

/*Data for the table `log_gold_comp_approval` */

LOCK TABLES `log_gold_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_multi_exp` */

DROP TABLE IF EXISTS `log_multi_exp`;

CREATE TABLE `log_multi_exp` (
  `CHANGE_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0-体验区，1-正式区',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `EXP_TYPE` varchar(64) NOT NULL COMMENT '加倍经验类型',
  `EXP_RATE` int(6) NOT NULL COMMENT '经验加倍的倍率',
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `STOP_TIME` datetime DEFAULT NULL COMMENT '人工停止时间',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-执行完毕，5-人工停止',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '操作时间',
  `STOP_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '结束操作员名称',
  `REASON` varchar(2048) NOT NULL,
  `EXP_TYPE_CODE` varchar(32) NOT NULL COMMENT '加倍经验类型code',
  `BOOKING` int(3) NOT NULL DEFAULT '-1' COMMENT '即时预约',
  `APPROVAL_RESULT` int(3) NOT NULL DEFAULT '-1' COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPER_STATE` int(3) NOT NULL DEFAULT '-1' COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  PRIMARY KEY (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录设置双倍经验日志';

/*Data for the table `log_multi_exp` */

LOCK TABLES `log_multi_exp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_multi_exp_approval` */

DROP TABLE IF EXISTS `log_multi_exp_approval`;

CREATE TABLE `log_multi_exp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '双倍经验日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL,
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_MULTI_EXP_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_MULTI_EXP_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_multi_exp` (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='双倍经验审批日志表';

/*Data for the table `log_multi_exp_approval` */

LOCK TABLES `log_multi_exp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_multi_exp_detail` */

DROP TABLE IF EXISTS `log_multi_exp_detail`;

CREATE TABLE `log_multi_exp_detail` (
  `CHANGE_ID` int(10) NOT NULL COMMENT '双倍经验设置id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-执行完毕，5-人工停止',
  `EXECUTIVE_TIME` datetime DEFAULT NULL COMMENT 'gm执行的时间',
  `STOP_TIME` datetime DEFAULT NULL COMMENT 'gm成功停止时间',
  PRIMARY KEY (`CHANGE_ID`,`SERVER_ID`,`GATEWAY_ID`),
  CONSTRAINT `FK_LOG_MULT_REFERENCE_LOG_MULT` FOREIGN KEY (`CHANGE_ID`) REFERENCES `log_multi_exp` (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多倍经验设置详情';

/*Data for the table `log_multi_exp_detail` */

LOCK TABLES `log_multi_exp_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_news` */

DROP TABLE IF EXISTS `log_news`;

CREATE TABLE `log_news` (
  `NEWS_ID` int(10) NOT NULL COMMENT '新闻id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `TITLE` varchar(512) NOT NULL COMMENT '标题',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `START_TIME` datetime NOT NULL COMMENT '开始时间',
  `END_TIME` datetime NOT NULL COMMENT '结束时间',
  `INTERVALS` int(10) NOT NULL COMMENT '发送时间间隔',
  `CONTENT` varchar(2048) NOT NULL COMMENT '内容',
  `TOTAL_TIMES` int(10) NOT NULL COMMENT '总共执行次数',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-已执行完毕，5-已撤销',
  `CANCEL_TIME` datetime DEFAULT NULL COMMENT '撤销时间',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '添加人名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '添加时间',
  `CANCEL_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '撤销人名称',
  PRIMARY KEY (`NEWS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录发布新闻日志';

/*Data for the table `log_news` */

LOCK TABLES `log_news` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_news_detail` */

DROP TABLE IF EXISTS `log_news_detail`;

CREATE TABLE `log_news_detail` (
  `NEWS_ID` int(10) NOT NULL COMMENT '新闻id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `SERVER_ID` int(8) NOT NULL COMMENT '线id',
  `EXECUTIVE_TIMES` int(10) NOT NULL COMMENT '执行次数',
  `SUCCESS_TIMES` int(10) NOT NULL COMMENT '成功次数',
  `LAST_EXECUTE_TIME` datetime DEFAULT NULL COMMENT '上一次执行的时间',
  `STATE` decimal(3,0) DEFAULT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-已执行完毕，5-已撤销',
  `CANCEL_TIME` datetime DEFAULT NULL COMMENT 'gm成功撤销时间',
  PRIMARY KEY (`NEWS_ID`,`GATEWAY_ID`,`SERVER_ID`),
  CONSTRAINT `FK_LOG_NEWS_REFERENCE_LOG_NEWS` FOREIGN KEY (`NEWS_ID`) REFERENCES `log_news` (`NEWS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏详情';

/*Data for the table `log_news_detail` */

LOCK TABLES `log_news_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_online_gm` */

DROP TABLE IF EXISTS `log_online_gm`;

CREATE TABLE `log_online_gm` (
  `GM_ID` int(10) NOT NULL,
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '从passport系统读取',
  `REAL_NAME` varchar(64) NOT NULL COMMENT '真实名称',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `LOGIN_IP` varchar(1024) DEFAULT NULL COMMENT '绑定的登录ip',
  `EMAIL` varchar(128) NOT NULL COMMENT '电子邮箱',
  `ACOUNT_TYPE` int(10) DEFAULT '0' COMMENT '甯愬彿绫诲瀷',
  PRIMARY KEY (`GM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_online_gm` */

LOCK TABLES `log_online_gm` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_paymoneyall_comp` */

DROP TABLE IF EXISTS `log_paymoneyall_comp`;

CREATE TABLE `log_paymoneyall_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `GATEWAY_ID` int(10) NOT NULL COMMENT '网关ID,0-全区全服',
  `SERVER_ID` int(10) NOT NULL COMMENT '所在线',
  `MONEY_TYPE` int(10) NOT NULL COMMENT '金钱类型',
  `MONEY_NUM` int(10) NOT NULL COMMENT '金钱数目',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全区性质金钱补偿表';

/*Data for the table `log_paymoneyall_comp` */

LOCK TABLES `log_paymoneyall_comp` WRITE;

UNLOCK TABLES;


/*Table structure for table `log_paymoneyall_approval` */

DROP TABLE IF EXISTS `log_paymoneyall_approval`;

CREATE TABLE `log_paymoneyall_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '技能补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_PAYMONEYALL_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_PAYMONEYALL_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_paymoneyall_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全区性质金钱补偿审批日志表';

/*Data for the table `log_paymoneyall_approval` */

LOCK TABLES `log_paymoneyall_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_pet_comp` */

DROP TABLE IF EXISTS `log_pet_comp`;

CREATE TABLE `log_pet_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `MENU_VALUE_ID` int(12) NOT NULL COMMENT '动态菜单值id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关ID,0-全区全服',
  `SERVER_ID` int(8) NOT NULL COMMENT '线ID',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '玩家账号名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `ROLE_ID` int(10) NOT NULL COMMENT '角色id',
  `OPER_TYPE` varchar(16) NOT NULL COMMENT '操作类型，添加或者修改',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='随处补偿日志表';

/*Data for the table `log_pet_comp` */

LOCK TABLES `log_pet_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_pet_comp_approval` */

DROP TABLE IF EXISTS `log_pet_comp_approval`;

CREATE TABLE `log_pet_comp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='随处补偿审批日志表';

/*Data for the table `log_pet_comp_approval` */

LOCK TABLES `log_pet_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_pet_menu_value` */

DROP TABLE IF EXISTS `log_pet_menu_value`;

CREATE TABLE `log_pet_menu_value` (
  `MENU_VALUE_ID` int(12) NOT NULL COMMENT '动态菜单值id',
  `ITEM_NAME` varchar(16) NOT NULL COMMENT '菜单项名称',
  `ITEM_VALUE` varchar(32) DEFAULT NULL COMMENT '菜单值',
  PRIMARY KEY (`MENU_VALUE_ID`,`ITEM_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录随处补偿生成时动态菜单的值';

/*Data for the table `log_pet_menu_value` */

LOCK TABLES `log_pet_menu_value` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_product` */

DROP TABLE IF EXISTS `log_product`;

CREATE TABLE `log_product` (
  `PRODUCT_ID` int(10) NOT NULL COMMENT '道具id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `PRODUCT_CODE` varchar(32) NOT NULL COMMENT '道具编号',
  `PRODUCT_NAME` varchar(32) NOT NULL COMMENT '道具名称',
  `PRODUCT_SUB_CLASS` int(4) NOT NULL COMMENT '道具子类',
  `PRODUCT_LEVEL` int(3) NOT NULL COMMENT '道具等级',
  `PRODUCT_USE_TYPE` int(1) NOT NULL COMMENT '道具使用类型',
  `PRODUCT_PERIOD` int(10) NOT NULL COMMENT '道具期限',
  `PRODUCT_ATTRIBUTES` varchar(64) DEFAULT NULL COMMENT '道具属性',
  `PRODUCT_CLASS` int(2) NOT NULL COMMENT '道具类别',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `PRODUCT_DESC` varchar(4000) NOT NULL COMMENT '道具描述',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-未激活，4-已激活，5-已禁用',
  `INSERT_OPERATOR_NAME` varchar(32) NOT NULL COMMENT '添加人名称',
  `START_OPERATOR_NAME` varchar(32) DEFAULT NULL COMMENT '开始人',
  `INSERT_TIME` datetime NOT NULL COMMENT '添加时间',
  `END_OPERATOR_NAME` varchar(32) DEFAULT NULL COMMENT '撤销人名称',
  PRIMARY KEY (`PRODUCT_ID`),
  UNIQUE KEY `INDEX_1` (`GAME_ID`,`GATEWAY_TYPE`,`PRODUCT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录添加道具日志';

/*Data for the table `log_product` */

LOCK TABLES `log_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_product_price` */

DROP TABLE IF EXISTS `log_product_price`;

CREATE TABLE `log_product_price` (
  `PRICE_ID` int(10) NOT NULL COMMENT '价格id',
  `PRODUCT_ID` int(10) NOT NULL COMMENT '道具id',
  `SUBJECT_ID` int(4) NOT NULL COMMENT '货币类型',
  `PRICE_ORIGIN` int(10) NOT NULL COMMENT '原价',
  `PRICE_DISCOUNT` int(10) NOT NULL COMMENT '折扣价',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-未激活，4-已激活，5-已禁用',
  `INSERT_OPERATOR_NAME` varchar(32) NOT NULL COMMENT '添加人名称',
  `START_OPERATOR_NAME` varchar(32) DEFAULT NULL COMMENT '开始人',
  `INSERT_TIME` datetime NOT NULL COMMENT '添加时间',
  `END_OPERATOR_NAME` varchar(32) DEFAULT NULL COMMENT '撤销人名称',
  `ERATING_PRICE_ID` int(10) DEFAULT NULL COMMENT 'erating价格id',
  `LIMITNUM` int(8) DEFAULT NULL COMMENT '限量数量',
  `LIMITDATE` datetime DEFAULT NULL COMMENT '限时时间',
  PRIMARY KEY (`PRICE_ID`),
  KEY `FK_LOG_PROD_REF_LOG_PROD2` (`PRODUCT_ID`),
  CONSTRAINT `FK_LOG_PROD_REF_LOG_PROD2` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `log_product` (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录添加道具价格日志';

/*Data for the table `log_product_price` */

LOCK TABLES `log_product_price` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_comp` */

DROP TABLE IF EXISTS `log_role_comp`;

CREATE TABLE `log_role_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `COMPENSATE_TYPE` int(3) NOT NULL COMMENT '补偿类型： 1-积分补偿',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(10) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `GATEWAY_ID` int(3) DEFAULT '-1' COMMENT '网关id，若对应的sys_role_comp_type表中的为1 的时候， 才有用',
  `SERVICE_ID` int(10) NOT NULL COMMENT '玩家ID',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '玩家账号名称',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  `DIVIDED_TYPE` int(3) NOT NULL COMMENT '改补偿所属的分类(0表示该补偿下面没有分类)',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色补偿日志表';

/*Data for the table `log_role_comp` */

LOCK TABLES `log_role_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_comp_approval` */

DROP TABLE IF EXISTS `log_role_comp_approval`;

CREATE TABLE `log_role_comp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='随处补偿审批日志表';

/*Data for the table `log_role_comp_approval` */

LOCK TABLES `log_role_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_comp_menu_value` */

DROP TABLE IF EXISTS `log_role_comp_menu_value`;

CREATE TABLE `log_role_comp_menu_value` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '所属的补偿编号',
  `ITEM_NAME` varchar(16) NOT NULL COMMENT '菜单项名称',
  `ITEM_VALUE` varchar(32) DEFAULT NULL COMMENT '菜单值',
  PRIMARY KEY (`COMPENSATE_ID`,`ITEM_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录角色补偿生成时动态菜单的值';

/*Data for the table `log_role_comp_menu_value` */

LOCK TABLES `log_role_comp_menu_value` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_kickoff` */

DROP TABLE IF EXISTS `log_role_kickoff`;

CREATE TABLE `log_role_kickoff` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0=体验区，1=正式区',
  `PASSPORT_NAME` varchar(32) DEFAULT NULL COMMENT '通行证名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `SERVER_ID` int(8) NOT NULL COMMENT '线编号',
  `STATE` int(3) NOT NULL COMMENT '状态，1 - 已踢下线；2-已恢复',
  `KICKOFF_TIME` datetime NOT NULL COMMENT '下线时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT '恢复时间',
  `LAST_SECONDS` int(10) NOT NULL COMMENT '下线持续时间，单位为秒\n            1分钟，5分钟，10分钟，30分钟，1小时，2小时，5小时，12小时\n            ，24小时，2天，三天，一周，一个月，！打入地狱！',
  `REASON` varchar(256) NOT NULL COMMENT '踢下线的简短原因。由下拉框选择。\n            选择项：\n            辱骂/诽谤/淫谈悖说\n            非法小广告\n            恶意刷钱/装备',
  `DESCRIPTION` varchar(1024) DEFAULT NULL COMMENT '踢下线的详细描述',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `RESTORE_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '恢复时，操作员的名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录踢人日志';

/*Data for the table `log_role_kickoff` */

LOCK TABLES `log_role_kickoff` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_kickoff2` */

DROP TABLE IF EXISTS `log_role_kickoff2`;

CREATE TABLE `log_role_kickoff2` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0=体验区，1=正式区',
  `PASSPORT_NAME` varchar(32) DEFAULT NULL COMMENT '通行证名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `SERVER_ID` int(8) NOT NULL COMMENT '线编号',
  `KICKOFF_TIME` datetime NOT NULL COMMENT '下线时间',
  `REASON` varchar(256) NOT NULL COMMENT '踢下线的简短原因。由下拉框选择。\n            选择项：\n            辱骂/诽谤/淫谈悖说\n            非法小广告\n            恶意刷钱/装备',
  `DESCRIPTION` varchar(1024) DEFAULT NULL COMMENT '踢下线的详细描述',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录踢人日志,该踢人不冻结角色';

/*Data for the table `log_role_kickoff2` */

LOCK TABLES `log_role_kickoff2` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_move` */

DROP TABLE IF EXISTS `log_role_move`;

CREATE TABLE `log_role_move` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0=体验区，1=正式区',
  `PASSPORT_NAME` varchar(32) DEFAULT NULL COMMENT '通行证名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `SERVER_ID` int(8) NOT NULL COMMENT '线编号',
  `SCENE_NAME` varchar(64) NOT NULL COMMENT '场景名称',
  `MOVE_TIME` datetime NOT NULL COMMENT '拉人操作时间',
  `STATE` int(3) NOT NULL COMMENT '1-拉人成功，2-拉人失败',
  `REASON` varchar(256) NOT NULL COMMENT '拉人的简短原因。由下拉框选择。\n            选择项：\n            角色被卡\n             其他',
  `DESCRIPTION` varchar(1024) DEFAULT NULL COMMENT '拉人的详细描述',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录拉人日志';

/*Data for the table `log_role_move` */

LOCK TABLES `log_role_move` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_operation` */

DROP TABLE IF EXISTS `log_role_operation`;

CREATE TABLE `log_role_operation` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(4) NOT NULL COMMENT '游戏编号',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `OPERATE_DESC` varchar(2048) DEFAULT NULL COMMENT '拉人的详细描述',
  `RESULT_CODE` int(4) NOT NULL COMMENT '0',
  `OPERATE_TYPE` int(4) NOT NULL COMMENT '操作类型',
  `OPERATE_TIME` datetime NOT NULL COMMENT '操作时间',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录对角色的所有操作日志';

/*Data for the table `log_role_operation` */

LOCK TABLES `log_role_operation` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_role_shutup` */

DROP TABLE IF EXISTS `log_role_shutup`;

CREATE TABLE `log_role_shutup` (
  `LOG_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型，0=体验区，1=正式区',
  `PASSPORT_NAME` varchar(32) DEFAULT NULL COMMENT '通行证名称',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `SERVER_ID` int(8) NOT NULL COMMENT '线编号',
  `STATE` int(3) NOT NULL COMMENT '状态，1 - 已禁言；2- 已恢复',
  `CHANNEL` varchar(64) NOT NULL COMMENT '禁言频道，下拉框选择',
  `SHUTUP_TIME` datetime NOT NULL COMMENT '执行禁言的时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT '恢复时间',
  `LAST_SECONDS` int(10) NOT NULL COMMENT '禁言持续时间，单位为秒\n            1分钟，5分钟，10分钟，30分钟，1小时，2小时，5小时，12小时\n            ，24小时，2天，三天，一周，一个月，！打入地狱！',
  `REASON` varchar(256) NOT NULL COMMENT '禁言的简短原因。由下拉框选择。\n            选择项：\n            辱骂/诽谤/淫谈悖说\n            非法小广告\n            恶意刷钱/装备',
  `DESCRIPTION` varchar(1024) DEFAULT NULL COMMENT '禁言的详细描述',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `RESTORE_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '恢复时，操作员的名称',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录禁言日志';

/*Data for the table `log_role_shutup` */

LOCK TABLES `log_role_shutup` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_serialcode` */

DROP TABLE IF EXISTS `log_serialcode`;

CREATE TABLE `log_serialcode` (
  `LOG_ID` int(8) NOT NULL COMMENT '日志ID',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏ID',
  `ACTIVITY_ID` int(8) NOT NULL COMMENT '活动号',
  `MEDIA_NAME` varchar(200) NOT NULL COMMENT '媒体名称',
  `USE_LIMIT` int(8) NOT NULL COMMENT '使用限制',
  `SERIAL_NUM` int(8) NOT NULL COMMENT '生成数量',
  `PASSPORT_NAME` varchar(200) NOT NULL COMMENT '操作人',
  `OPER_TIME` datetime NOT NULL COMMENT '操作时间',
  `FILE_PATH` varchar(200) NOT NULL COMMENT 'LOG文件路径',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_serialcode` */

LOCK TABLES `log_serialcode` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_skill_comp` */

DROP TABLE IF EXISTS `log_skill_comp`;

CREATE TABLE `log_skill_comp` (
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `ROLE_ID` int(10) NOT NULL COMMENT '角色ID',
  `ROLE_NAME` varchar(500) NOT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(10) NOT NULL COMMENT '网关ID,0-全区全服',
  `SERVER_ID` int(10) NOT NULL COMMENT '所在线',
  `SKILL_ID` int(10) NOT NULL COMMENT '技能ID',
  `SKILL_NAME` varchar(500) NOT NULL COMMENT '技能名称',
  `SKILL_LEVEL` int(10) NOT NULL COMMENT '技能等级',
  `REASON` varchar(1024) NOT NULL COMMENT '补偿原因',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='技能补偿日志表';

/*Data for the table `log_skill_comp` */

LOCK TABLES `log_skill_comp` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_skill_comp_approval` */

DROP TABLE IF EXISTS `log_skill_comp_approval`;

CREATE TABLE `log_skill_comp_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `COMPENSATE_ID` int(10) NOT NULL COMMENT '技能补偿日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`),
  KEY `FK_LOG_SKILL_COMP_APPROVAL` (`COMPENSATE_ID`),
  CONSTRAINT `FK_LOG_SKILL_COMP_APPROVAL` FOREIGN KEY (`COMPENSATE_ID`) REFERENCES `log_skill_comp` (`COMPENSATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='技能补偿审批日志表';

/*Data for the table `log_skill_comp_approval` */

LOCK TABLES `log_skill_comp_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_syn_charge_activity` */

DROP TABLE IF EXISTS `log_syn_charge_activity`;

CREATE TABLE `log_syn_charge_activity` (
  `ACTIVITY_ID` int(10) NOT NULL,
  `GAME_ID` int(3) NOT NULL,
  `SRC_ACTIVITY_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值活动同步记录表';

/*Data for the table `log_syn_charge_activity` */

LOCK TABLES `log_syn_charge_activity` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_syn_charge_give_item` */

DROP TABLE IF EXISTS `log_syn_charge_give_item`;

CREATE TABLE `log_syn_charge_give_item` (
  `ACTIVITY_ID` int(10) DEFAULT NULL,
  `GAME_ID` int(3) DEFAULT NULL,
  `SRC_ACTIVITY_TYPE_ID` int(10) DEFAULT NULL,
  `SRC_GAME_ID` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站活动同步记录表';

/*Data for the table `log_syn_charge_give_item` */

LOCK TABLES `log_syn_charge_give_item` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_syn_oper` */

DROP TABLE IF EXISTS `log_syn_oper`;

CREATE TABLE `log_syn_oper` (
  `LOG_ID` int(8) NOT NULL COMMENT '操作日志id',
  `LOG_OPER_TYPE` int(8) NOT NULL COMMENT '操作类型(1表示同步网关,2表示同步服务器,3表示同步passport)',
  `LOG_OPER_ID` int(8) NOT NULL COMMENT '操作人员',
  `LOG_TIME` datetime DEFAULT NULL COMMENT '操作时间',
  `LOG_SOURCE_GAME_ID` int(6) NOT NULL COMMENT '同步源游戏',
  `LOG_TARGET_GAME_ID` int(6) NOT NULL,
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='同步操作详情';

/*Data for the table `log_syn_oper` */

LOCK TABLES `log_syn_oper` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_transfer` */

DROP TABLE IF EXISTS `log_transfer`;

CREATE TABLE `log_transfer` (
  `CHANGE_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '区服类型,0-体验区,1-正式区',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '帐号名',
  `FROM_GATEWAY_ID` int(6) NOT NULL COMMENT '转出的网关id',
  `TO_GATEWAY_ID` int(6) NOT NULL COMMENT '转入的网关id',
  `ORDER_ID` int(15) NOT NULL COMMENT '转账金额',
  `STATE` int(3) NOT NULL COMMENT '状态,0 - 草稿，1 - 已提交审批,等待审批一；2- 等待审批二；100 - 通过审批；101 - 已执行操作。-1 - 表示删除。',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。-1-未进行审批.1- 通过。2 - 驳回；3 - 直接取消。若state=101时，200 - 表示执行成功；201 - 表示执行失败。',
  `REASON` varchar(1024) NOT NULL COMMENT '修改原因',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '操作员名称',
  `INSERT_TIME` datetime NOT NULL COMMENT '记录插入时间',
  PRIMARY KEY (`CHANGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账日志表';

/*Data for the table `log_transfer` */

LOCK TABLES `log_transfer` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_transfer_approval` */

DROP TABLE IF EXISTS `log_transfer_approval`;

CREATE TABLE `log_transfer_approval` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志编号',
  `CHANGE_ID` int(10) NOT NULL COMMENT '转账日志编号',
  `APPROVAL_NUM` int(3) NOT NULL COMMENT '审批步骤,1-1次审批,2-2次审批,100-执行',
  `APPROVAL_TIME` datetime NOT NULL COMMENT '审批时间',
  `APPROVAL_COMMENT` varchar(1024) NOT NULL COMMENT '审批意见',
  `APPROVAL_RESULT` int(3) NOT NULL COMMENT '审批结果。1- 通过。2 - 驳回；3 - 直接取消。若approval_num =100时，200 - 表示执行成功；201- 表示执行失败。',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '审批人姓名',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账审批日志表';

/*Data for the table `log_transfer_approval` */

LOCK TABLES `log_transfer_approval` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_trustee_account` */

DROP TABLE IF EXISTS `log_trustee_account`;

CREATE TABLE `log_trustee_account` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(3) NOT NULL COMMENT '网关类型，0-体验区，1-正式区',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT 'passport_name',
  `TRUSTEE_TIME` datetime NOT NULL COMMENT '托管时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT '恢复时间',
  `REASON` varchar(256) NOT NULL COMMENT '托管原因',
  `ALLOW_IP` varchar(32) NOT NULL COMMENT '登陆ip',
  `TRUSTEE_TYPE` int(3) NOT NULL COMMENT '托管类型，0- 登录托管，1-登录和二级密码同时托管',
  `STATE` int(3) NOT NULL COMMENT '状态，1-托管中，2-已恢复',
  `OPERATOR_NAME` varchar(32) NOT NULL COMMENT '托管操作人',
  `RESTORE_OPER_NAME` varchar(32) DEFAULT NULL COMMENT '恢复操作人',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='托管帐号日志';

/*Data for the table `log_trustee_account` */

LOCK TABLES `log_trustee_account` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_trustee_account_detail` */

DROP TABLE IF EXISTS `log_trustee_account_detail`;

CREATE TABLE `log_trustee_account_detail` (
  `LOG_ID` int(10) NOT NULL COMMENT '日志id',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关id',
  `STATE` int(3) NOT NULL COMMENT '1-未被gmserver接收，2-已被gmserver接收，3-执行中，4-执行完毕，5-人工停止',
  `TRUSTEE_TIME` datetime DEFAULT NULL COMMENT 'gm执行的时间',
  `RESTORE_TIME` datetime DEFAULT NULL COMMENT '成功停止时间',
  PRIMARY KEY (`LOG_ID`,`GATEWAY_ID`),
  CONSTRAINT `FK_LOG_TRUS_REFERENCE_LOG_TRUS` FOREIGN KEY (`LOG_ID`) REFERENCES `log_trustee_account` (`LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='托管账号详情';

/*Data for the table `log_trustee_account_detail` */

LOCK TABLES `log_trustee_account_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_union_gateway` */

DROP TABLE IF EXISTS `log_union_gateway`;

CREATE TABLE `log_union_gateway` (
  `OLD_GATEWAY_ID` int(6) NOT NULL COMMENT '要被合并的网关id',
  `OLD_GATEWAY_NAME` varchar(256) DEFAULT NULL COMMENT '要被合并的网关名称',
  `NEW_GATEWAY_ID` int(6) NOT NULL COMMENT '新的合并的网关id',
  `NEW_GATEWAY_NAME` varchar(256) DEFAULT NULL COMMENT '新的合并的网关名称',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏id',
  `BEGIN_TIME` datetime DEFAULT NULL COMMENT '合服开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '合服结束时间',
  `STATE` int(2) DEFAULT '-1' COMMENT '合服状态：-1 未执行。 0 正在执行。1 合服任务成功结束  2合服任务异常结束',
  `OPERATOR` varchar(32) DEFAULT NULL COMMENT '操作人的passportName',
  `INSERT_TIME` datetime DEFAULT NULL COMMENT '任务插入时间',
  `INSERT_OPERATOR` varchar(32) DEFAULT NULL COMMENT '插入人的passportName',
  `TASK_ID` int(6) NOT NULL DEFAULT '-1' COMMENT '所属的合服计划id',
  PRIMARY KEY (`OLD_GATEWAY_ID`,`NEW_GATEWAY_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网关合服表';

/*Data for the table `log_union_gateway` */

LOCK TABLES `log_union_gateway` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_union_gateway_task` */

DROP TABLE IF EXISTS `log_union_gateway_task`;

CREATE TABLE `log_union_gateway_task` (
  `TASK_ID` int(6) NOT NULL,
  `TASK_NAME` varchar(256) NOT NULL COMMENT '合服计划名称',
  `LAST_BACK_TIME_BEGIN` datetime DEFAULT NULL COMMENT '合服计划上一次  备份开始时间',
  `LAST_BACK_TIME_END` datetime DEFAULT NULL COMMENT '合服计划 上一次 备份结束时间',
  `BACK_STATUS` int(2) DEFAULT '-1' COMMENT '备份状态',
  `EXE_STATUS` int(2) DEFAULT '-1' COMMENT '执行状态',
  `BACK_TIME_BEGIN` datetime DEFAULT NULL COMMENT '当前备份最后开始时间',
  `BACK_TIME_END` datetime DEFAULT NULL COMMENT '当前备份最后结束时间',
  `BACK_OPERATOR` varchar(32) DEFAULT NULL COMMENT '备份人',
  `EXE_OPERATOR` varchar(32) DEFAULT NULL COMMENT '执行人',
  `EXE_TIME_BEGIN` datetime DEFAULT NULL COMMENT '执行的开始时间',
  `EXE_TIME_END` datetime DEFAULT NULL COMMENT '执行的结束时间',
  `GAME_ID` int(3) NOT NULL,
  `INSERT_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`TASK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_union_gateway_task` */

LOCK TABLES `log_union_gateway_task` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_user_operations` */

DROP TABLE IF EXISTS `log_user_operations`;

CREATE TABLE `log_user_operations` (
  `LOG_ID` int(15) NOT NULL AUTO_INCREMENT COMMENT '序列',
  `PASSPORT_ID` int(10) NOT NULL COMMENT 'passport ID',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT 'passport帐号名',
  `OPER_REAL_NAME` varchar(64) DEFAULT NULL COMMENT '操作员真名',
  `OPER_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `OPER_IP` varchar(32) DEFAULT NULL COMMENT '操作者的IP',
  `RESULT_CODE` int(3) NOT NULL COMMENT '执行结果，1-成功，2-失败',
  `OPER_DESC` varchar(2048) NOT NULL COMMENT '操作描述',
  `OPER_TYPE` varchar(64) NOT NULL COMMENT '操作类型',
  `GAME_ID` int(8) DEFAULT NULL COMMENT '游戏ID',
  `PLAYER_NAME` varchar(50) DEFAULT NULL COMMENT '玩家帐号',
  `ROLE_NAME` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `GATEWAY_ID` int(8) DEFAULT NULL COMMENT '网关ID',
  `GATEWAY_NAME` varchar(1024) DEFAULT NULL COMMENT '网关名称',
  `REASON` varchar(500) DEFAULT NULL COMMENT '原因',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `log_user_operations` */

LOCK TABLES `log_user_operations` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_user_operations_091022` */

DROP TABLE IF EXISTS `log_user_operations_091022`;

CREATE TABLE `log_user_operations_091022` (
  `LOG_ID` int(15) NOT NULL,
  `PASSPORT_ID` int(10) NOT NULL,
  `PASSPORT_NAME` varchar(32) NOT NULL,
  `OPER_REAL_NAME` varchar(64) DEFAULT NULL,
  `OPER_DATE` datetime NOT NULL,
  `OPER_IP` varchar(32) DEFAULT NULL,
  `RESULT_CODE` int(3) NOT NULL,
  `OPER_DESC` varchar(2048) NOT NULL,
  `OPER_TYPE` varchar(64) NOT NULL,
  `GAME_ID` int(8) DEFAULT NULL,
  `PLAYER_NAME` varchar(50) DEFAULT NULL,
  `ROLE_NAME` varchar(50) DEFAULT NULL,
  `GATEWAY_ID` int(8) DEFAULT NULL,
  `GATEWAY_NAME` varchar(100) DEFAULT NULL,
  `REASON` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_user_operations_091022` */

LOCK TABLES `log_user_operations_091022` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_channel` */

DROP TABLE IF EXISTS `sys_channel`;

CREATE TABLE `sys_channel` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `CHANNEL_CODE` varchar(32) NOT NULL COMMENT '频道编号',
  `CHANNEL_NAME` varchar(64) NOT NULL COMMENT '频道名称',
  PRIMARY KEY (`GAME_ID`,`CHANNEL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏频道信息表';

/*Data for the table `sys_channel` */

LOCK TABLES `sys_channel` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_dictionary` */

DROP TABLE IF EXISTS `sys_dictionary`;

CREATE TABLE `sys_dictionary` (
  `DICTIONARY_ID` int(10) NOT NULL,
  `DICT_TYPE` varchar(32) DEFAULT NULL COMMENT '字典类型，物品-item，游戏频道-channel，游戏场景-scene，职业-occupation，联盟-league',
  `GAME_ID` int(3) DEFAULT NULL COMMENT '游戏编号',
  `DICT_CODE` varchar(32) DEFAULT NULL COMMENT '代码',
  `DICT_NAME` varchar(64) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`DICTIONARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

/*Data for the table `sys_dictionary` */

LOCK TABLES `sys_dictionary` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_exp_type` */

DROP TABLE IF EXISTS `sys_exp_type`;

CREATE TABLE `sys_exp_type` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `EXP_TYPE_CODE` varchar(32) NOT NULL COMMENT '类型代码',
  `EXP_TYPE_NAME` varchar(64) NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`GAME_ID`,`EXP_TYPE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加倍经验类型';

/*Data for the table `sys_exp_type` */

LOCK TABLES `sys_exp_type` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_game` */

DROP TABLE IF EXISTS `sys_game`;

CREATE TABLE `sys_game` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏代码',
  `GAME_NAME` varchar(64) NOT NULL COMMENT '游戏名称',
  `OWNER_TYPE` int(1) DEFAULT '0' COMMENT '所属版本类型 1、自主版  2、联运版',
  PRIMARY KEY (`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_game` */

LOCK TABLES `sys_game` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_gateway` */

DROP TABLE IF EXISTS `sys_gateway`;

CREATE TABLE `sys_gateway` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `GATEWAY_TYPE` int(4) NOT NULL COMMENT '区服类型，0-体验区，1-正式区',
  `GATEWAY_PROVIDER` int(3) NOT NULL COMMENT '网关提供商，1-电信，2-网通',
  `GATEWAY_NAME` varchar(512) NOT NULL COMMENT '网关的名称。',
  `URL` varchar(1024) NOT NULL COMMENT 'gm_server服务器url',
  PRIMARY KEY (`GAME_ID`,`GATEWAY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储网关信息表。';

/*Data for the table `sys_gateway` */

LOCK TABLES `sys_gateway` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_game_server` */

DROP TABLE IF EXISTS `sys_game_server`;

CREATE TABLE `sys_game_server` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_ID` int(6) NOT NULL COMMENT '网关编号',
  `SERVER_ID` int(8) NOT NULL,
  `SERVER_NAME` varchar(64) NOT NULL,
  `URL` varchar(1024) NOT NULL COMMENT 'gm_server连接游戏世界的url',
  `GROUP_ID` int(2) NOT NULL,
  PRIMARY KEY (`GAME_ID`,`GATEWAY_ID`,`SERVER_ID`),
  CONSTRAINT `FK_SYS_GAME_REFERENCE_SYS_GATE` FOREIGN KEY (`GAME_ID`, `GATEWAY_ID`) REFERENCES `sys_gateway` (`GAME_ID`, `GATEWAY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏服务器信息表。';

/*Data for the table `sys_game_server` */

LOCK TABLES `sys_game_server` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_game_server1` */

DROP TABLE IF EXISTS `sys_game_server1`;

CREATE TABLE `sys_game_server1` (
  `GAME_ID` int(3) NOT NULL,
  `GATEWAY_ID` int(6) NOT NULL,
  `SERVER_ID` int(8) NOT NULL,
  `SERVER_NAME` varchar(64) NOT NULL,
  `URL` varchar(1024) NOT NULL,
  `GROUP_ID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_game_server1` */

LOCK TABLES `sys_game_server1` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_item` */

DROP TABLE IF EXISTS `sys_item`;

CREATE TABLE `sys_item` (
  `ITEM_CODE` varchar(32) NOT NULL COMMENT '物品编号',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `ITEM_NAME` varchar(64) NOT NULL COMMENT '物品名称',
  PRIMARY KEY (`ITEM_CODE`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动奖品信息表';

/*Data for the table `sys_item` */

LOCK TABLES `sys_item` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_league` */

DROP TABLE IF EXISTS `sys_league`;

CREATE TABLE `sys_league` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `LEAGUE_CODE` varchar(32) NOT NULL COMMENT '联盟代码',
  `LEAGUE_NAME` varchar(64) NOT NULL COMMENT '联盟名称',
  PRIMARY KEY (`GAME_ID`,`LEAGUE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联盟信息表';

/*Data for the table `sys_league` */

LOCK TABLES `sys_league` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_occupation` */

DROP TABLE IF EXISTS `sys_occupation`;

CREATE TABLE `sys_occupation` (
  `GAME_ID` int(3) NOT NULL,
  `OCCUPATION_CODE` varchar(32) NOT NULL,
  `OCCUPATION_NAME` varchar(64) NOT NULL,
  PRIMARY KEY (`GAME_ID`,`OCCUPATION_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职业信息表';

/*Data for the table `sys_occupation` */

LOCK TABLES `sys_occupation` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_operators` */

DROP TABLE IF EXISTS `sys_operators`;

CREATE TABLE `sys_operators` (
  `OPER_ID` int(10) NOT NULL COMMENT '操作员passport_id',
  `PASSPORT_NAME` varchar(32) NOT NULL COMMENT '从passport系统读取',
  `OPER_REAL_NAME` varchar(64) NOT NULL COMMENT '真实名称',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `LAST_LOGIN_IP` varchar(16) DEFAULT NULL COMMENT '最近登录ip',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最近登录时间',
  `OPER_EMAIL` varchar(128) NOT NULL COMMENT '电子邮箱',
  `LOGIN_COUNT` int(10) NOT NULL DEFAULT '0' COMMENT '登录次数,默认为0',
  `SUPERIOR_OPER` int(10) NOT NULL DEFAULT '0' COMMENT '上级用户',
  `OPER_LEVEL` int(2) NOT NULL DEFAULT '0' COMMENT '用户级别：  0 是普通管理员 10是GM上线人员 11是pfwork  20 客服总监  30游戏管理员',
  `GAME_ID` int(3) NOT NULL DEFAULT '0' COMMENT '-1 对应所有游戏(当 用户级别 为10 和11时)有效，正数对应相应的游戏',
  PRIMARY KEY (`OPER_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_operators` */

LOCK TABLES `sys_operators` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_outer_resource` */

DROP TABLE IF EXISTS `sys_outer_resource`;

CREATE TABLE `sys_outer_resource` (
  `RES_ID` int(6) NOT NULL,
  `GAME_ID` int(4) NOT NULL,
  `RES_NAME` varchar(32) NOT NULL,
  `RES_DESC` varchar(256) DEFAULT NULL,
  `RES_URL` varchar(128) DEFAULT NULL COMMENT '资源url',
  `RES_TYPE` int(2) NOT NULL DEFAULT '0',
  `RES_PID` int(6) NOT NULL DEFAULT '0' COMMENT '父资源id',
  `RES_ORDER_NO` int(4) NOT NULL DEFAULT '0' COMMENT '排序id',
  `RES_UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `RES_VISIT_TIME` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`RES_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外部资源表';

/*Data for the table `sys_outer_resource` */

LOCK TABLES `sys_outer_resource` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_pet_menu` */

DROP TABLE IF EXISTS `sys_pet_menu`;

CREATE TABLE `sys_pet_menu` (
  `ITEM_ID` int(6) NOT NULL COMMENT '菜单项id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏id',
  `ITEM_NAME` varchar(16) NOT NULL COMMENT '菜单项名称',
  `ITEM_LABEL` varchar(32) NOT NULL COMMENT '菜单项显示名称',
  `ITEM_TYPE` int(1) NOT NULL COMMENT '菜单类型，1-文本框，2，下拉菜单',
  `ITEM_COMMENT` varchar(128) DEFAULT NULL COMMENT '菜单项注释',
  `OPTION_ID` int(3) DEFAULT NULL COMMENT '对应的下拉菜单id',
  `REQUIRED` int(1) NOT NULL COMMENT '是否必须，1-必须，2-不必须',
  `ORDER_NUMBER` int(2) NOT NULL COMMENT '排序号',
  `MENU_TYPE` int(1) NOT NULL,
  PRIMARY KEY (`ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='随从补偿与修改动态菜单配置表';

/*Data for the table `sys_pet_menu` */

LOCK TABLES `sys_pet_menu` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_pet_menu_option` */

DROP TABLE IF EXISTS `sys_pet_menu_option`;

CREATE TABLE `sys_pet_menu_option` (
  `OPTION_ID` int(3) NOT NULL COMMENT '下拉菜单id',
  `OPTION_LABEL` varchar(100) NOT NULL COMMENT '下拉菜单显示名称',
  `OPTION_VALUE` varchar(100) NOT NULL COMMENT '下拉菜单值',
  `CHECKED` int(1) NOT NULL COMMENT '是否默认选项,1-默认，2-不默认',
  `ORDER_NUMBER` int(2) NOT NULL COMMENT '排序号',
  PRIMARY KEY (`OPTION_ID`,`OPTION_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='随从补偿与修改动态菜单里的下拉菜单配置表';

/*Data for the table `sys_pet_menu_option` */

LOCK TABLES `sys_pet_menu_option` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_querydictionary` */

DROP TABLE IF EXISTS `sys_querydictionary`;

CREATE TABLE `sys_querydictionary` (
  `DICTIONARY_ID` int(8) NOT NULL COMMENT '字典ID',
  `DICTIONARY_TYPE` int(8) NOT NULL COMMENT '字典类型',
  `OPTION_VALUE` varchar(200) NOT NULL COMMENT '选项值',
  `OPTION_TEXT` varchar(400) NOT NULL COMMENT '选项显示内容',
  `GAME_ID` int(8) NOT NULL COMMENT '游戏ID',
  `ORDER_NUM` int(8) DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`DICTIONARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_querydictionary` */

LOCK TABLES `sys_querydictionary` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_res_relation` */

DROP TABLE IF EXISTS `sys_res_relation`;

CREATE TABLE `sys_res_relation` (
  `RES_ID` int(6) NOT NULL COMMENT '资源id',
  `REL_RES_ID` int(6) NOT NULL COMMENT '关联资源的id',
  PRIMARY KEY (`RES_ID`,`REL_RES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源关联表';

/*Data for the table `sys_res_relation` */

LOCK TABLES `sys_res_relation` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_resources` */

DROP TABLE IF EXISTS `sys_resources`;

CREATE TABLE `sys_resources` (
  `RES_ID` int(6) NOT NULL COMMENT '资源id，如果表中无记录，id=1，否则id=max(id) + 1',
  `RES_NAME` varchar(64) NOT NULL COMMENT '资源名称',
  `RES_DESC` varchar(256) DEFAULT NULL COMMENT '资源描述',
  `RES_URL` varchar(1024) DEFAULT NULL COMMENT '资源链接',
  `RES_PID` int(6) NOT NULL DEFAULT '0' COMMENT '父资源id，没有为0',
  `RES_TYPE` int(2) NOT NULL COMMENT '资源类型，0=菜单，1=系统资源\n            2=sree资源, 3=后台资源',
  `RES_ORDER_NO` int(3) NOT NULL COMMENT '同级排序编号',
  `RES_UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `RES_VISIT_TIME` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`RES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_resources` */

LOCK TABLES `sys_resources` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_game_resources` */

DROP TABLE IF EXISTS `sys_game_resources`;

CREATE TABLE `sys_game_resources` (
  `GAME_RES_ID` int(10) NOT NULL COMMENT '如果表中无记录，id=1，否则id=max(id) + 1',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号，-1资源对应于所有游戏(只能给开发人员使用)',
  `RES_ID` int(6) NOT NULL COMMENT '资源编号',
  PRIMARY KEY (`GAME_RES_ID`),
  KEY `FK_RES_GAME_RES` (`RES_ID`),
  CONSTRAINT `FK_RES_GAME_RES` FOREIGN KEY (`RES_ID`) REFERENCES `sys_resources` (`RES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏与资源关系表';

/*Data for the table `sys_game_resources` */

LOCK TABLES `sys_game_resources` WRITE;


UNLOCK TABLES;


/*Table structure for table `sys_role_comp_menu` */

DROP TABLE IF EXISTS `sys_role_comp_menu`;

CREATE TABLE `sys_role_comp_menu` (
  `ITEM_ID` int(6) NOT NULL COMMENT '菜单项id',
  `GAME_ID` int(3) NOT NULL COMMENT '游戏id',
  `COMPENSATE_TYPE` int(3) NOT NULL COMMENT '补偿类型： 1-积分补偿',
  `ITEM_NAME` varchar(16) NOT NULL COMMENT '菜单项名称(在同一个游戏和统一补偿类型下，是不允许有相同的菜单项名称)',
  `ITEM_LABEL` varchar(32) NOT NULL COMMENT '菜单项显示名称',
  `ITEM_TYPE` int(1) NOT NULL COMMENT '菜单类型，1-文本框，2，下拉菜单',
  `ITEM_COMMENT` varchar(128) DEFAULT NULL COMMENT '菜单项注释',
  `OPTION_ID` int(3) DEFAULT NULL COMMENT '对应的下拉菜单id',
  `REQUIRED` int(1) NOT NULL COMMENT '是否必须，1-必须，2-不必须',
  `ORDER_NUMBER` int(2) NOT NULL COMMENT '排序号',
  `DIVIDED_TYPE` int(3) NOT NULL COMMENT '菜单所属的划分类型，0表示所有类型公用的，其他表示该类型特有的菜单',
  PRIMARY KEY (`ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色补偿的动态菜单配置表';

/*Data for the table `sys_role_comp_menu` */

LOCK TABLES `sys_role_comp_menu` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_role_comp_menu_option` */

DROP TABLE IF EXISTS `sys_role_comp_menu_option`;

CREATE TABLE `sys_role_comp_menu_option` (
  `OPTION_ID` int(3) NOT NULL COMMENT '下拉菜单id',
  `GAME_ID` int(3) NOT NULL,
  `COMPENSATE_TYPE` int(3) NOT NULL,
  `OPTION_LABEL` varchar(100) NOT NULL COMMENT '下拉菜单显示名称',
  `OPTION_VALUE` varchar(100) NOT NULL COMMENT '下拉菜单值',
  `CHECKED` int(1) NOT NULL COMMENT '是否默认选项,1-默认，2-不默认',
  `ORDER_NUMBER` int(2) NOT NULL COMMENT '排序号',
  PRIMARY KEY (`OPTION_ID`,`OPTION_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色补偿的动态菜单的下拉菜单配置表';

/*Data for the table `sys_role_comp_menu_option` */

LOCK TABLES `sys_role_comp_menu_option` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_role_comp_type` */

DROP TABLE IF EXISTS `sys_role_comp_type`;

CREATE TABLE `sys_role_comp_type` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏id(请保证类型在每个游戏下面是一致)',
  `COMPENSATE_TYPE` int(3) NOT NULL COMMENT '补偿类型： 1',
  `COMPENSATE_DESC` varchar(255) DEFAULT NULL COMMENT '补偿类型的描述：比如 1代表-积分补偿',
  `DIVIDED_TYPE` int(3) NOT NULL COMMENT '对该角色补偿菜单项的划分， 0 公共的类型(该类型下所有的菜单都可以公用)；若该菜单项没有分类，则用0；否则直接用分类编号',
  `DIVIDED_NAME` varchar(32) DEFAULT NULL COMMENT '该类型的名称(主要是命令的时候所显示的名称),比如 type=creatPet',
  `DIVIDED_DESC` varchar(32) DEFAULT NULL COMMENT '该类型的名称(主要是前台显示的名称),比如 创建宠物',
  `GATEWAY_NEEDED` int(3) NOT NULL COMMENT '该补偿的的该类型下是否需要网关',
  PRIMARY KEY (`GAME_ID`,`COMPENSATE_TYPE`,`DIVIDED_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色补偿类型表';

/*Data for the table `sys_role_comp_type` */

LOCK TABLES `sys_role_comp_type` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_role_game` */

DROP TABLE IF EXISTS `sys_role_game`;

CREATE TABLE `sys_role_game` (
  `ROLE_ID` int(4) NOT NULL COMMENT '角色ID',
  `GAME_ID` int(4) NOT NULL COMMENT '游戏ID',
  PRIMARY KEY (`ROLE_ID`,`GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和游戏关联表，记录游戏管理员';

/*Data for the table `sys_role_game` */

LOCK TABLES `sys_role_game` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_role_outer_res` */

DROP TABLE IF EXISTS `sys_role_outer_res`;

CREATE TABLE `sys_role_outer_res` (
  `ROLE_ID` int(6) NOT NULL,
  `GAME_ID` int(4) NOT NULL,
  `RES_ID` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和外部资源的关联表';

/*Data for the table `sys_role_outer_res` */

LOCK TABLES `sys_role_outer_res` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_roles` */

DROP TABLE IF EXISTS `sys_roles`;

CREATE TABLE `sys_roles` (
  `ROLE_ID` int(6) NOT NULL COMMENT '角色id，如果表中无记录，id=1，否则id=max(id) + 1',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `ROLE_DESC` varchar(256) DEFAULT NULL COMMENT '角色描述',
  `SUPERIOR_OPER` int(10) NOT NULL DEFAULT '0' COMMENT '上级用户(此列将被废弃，不在被使用)',
  `ROLE_CREATOR_LEVEL` int(2) NOT NULL DEFAULT '0' COMMENT '角色创建者的级别， 20客服总监 30游戏管理员',
  `ROLE_GAME` int(4) NOT NULL DEFAULT '0' COMMENT '角色所属的游戏 (对应的游戏id)',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_roles` */

LOCK TABLES `sys_roles` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_oper_role` */

DROP TABLE IF EXISTS `sys_oper_role`;

CREATE TABLE `sys_oper_role` (
  `OPER_ID` int(10) NOT NULL COMMENT '操作员id',
  `ROLE_ID` int(6) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`OPER_ID`,`ROLE_ID`),
  KEY `SYS_OPER_ROLE_FK1` (`ROLE_ID`),
  CONSTRAINT `SYS_OPER_ROLE_FK1` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_roles` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_oper_role` */

LOCK TABLES `sys_oper_role` WRITE;


UNLOCK TABLES;

/*Table structure for table `sys_role_resources` */

DROP TABLE IF EXISTS `sys_role_resources`;

CREATE TABLE `sys_role_resources` (
  `GAME_RES_ID` int(10) NOT NULL COMMENT '资源id',
  `ROLE_ID` int(6) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`GAME_RES_ID`,`ROLE_ID`),
  CONSTRAINT `FK_GAME_RES_ROLE_RES` FOREIGN KEY (`GAME_RES_ID`) REFERENCES `sys_game_resources` (`GAME_RES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与资源关系表';

/*Data for the table `sys_role_resources` */

LOCK TABLES `sys_role_resources` WRITE;

UNLOCK TABLES;


/*Table structure for table `sys_scene` */

DROP TABLE IF EXISTS `sys_scene`;

CREATE TABLE `sys_scene` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `SCENE_CODE` varchar(64) NOT NULL COMMENT '场景标识',
  `SCENE_NAME` varchar(64) NOT NULL COMMENT '场景名称',
  PRIMARY KEY (`GAME_ID`,`SCENE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏场景信息表';

/*Data for the table `sys_scene` */

LOCK TABLES `sys_scene` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_secretkey` */

DROP TABLE IF EXISTS `sys_secretkey`;

CREATE TABLE `sys_secretkey` (
  `SESSION_ID` int(10) NOT NULL,
  `SK_CONTENT` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SecretKey';

/*Data for the table `sys_secretkey` */

LOCK TABLES `sys_secretkey` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_secretkey_bak` */

DROP TABLE IF EXISTS `sys_secretkey_bak`;

CREATE TABLE `sys_secretkey_bak` (
  `SESSION_ID` int(10) NOT NULL,
  `SK_CONTENT` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_secretkey_bak` */

LOCK TABLES `sys_secretkey_bak` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_syn_game_relation` */

DROP TABLE IF EXISTS `sys_syn_game_relation`;

CREATE TABLE `sys_syn_game_relation` (
  `SOURCE_GAME_ID` int(3) NOT NULL,
  `TARGET_GAME_ID` int(3) NOT NULL,
  PRIMARY KEY (`SOURCE_GAME_ID`,`TARGET_GAME_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_syn_game_relation` */

LOCK TABLES `sys_syn_game_relation` WRITE;

UNLOCK TABLES;

/*Table structure for table `sys_trustee_ip` */

DROP TABLE IF EXISTS `sys_trustee_ip`;

CREATE TABLE `sys_trustee_ip` (
  `GAME_ID` int(3) NOT NULL COMMENT '游戏编号',
  `GATEWAY_TYPE` int(4) NOT NULL COMMENT '区服类型，0-体验区，1-正式区',
  `IP_ID` int(6) NOT NULL,
  `IP_NAME` varchar(32) NOT NULL COMMENT 'ip描述',
  `TRUSTEE_IP` varchar(32) NOT NULL COMMENT 'ip',
  PRIMARY KEY (`IP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏托管ip';

/*Data for the table `sys_trustee_ip` */

LOCK TABLES `sys_trustee_ip` WRITE;

UNLOCK TABLES;

/* Procedure structure for procedure `createSecretKey` */

/*!50003 DROP PROCEDURE IF EXISTS  `createSecretKey` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `createSecretKey`(
OUT n_session_id INTEGER, 
OUT s_sk_content VARCHAR(20)
)
BEGIN
  DECLARE num INT DEFAULT 0;
  
  SET n_session_id = ROUND(ROUND(RAND(),9)*1000000000);	
  
  SET s_sk_content = CONCAT(
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0'),
	LPAD(CONV(RAND()*100000,10,36),4,'0')
	); 
  
  SELECT COUNT(*) INTO num FROM sys_secretkey WHERE session_id = n_session_id;
  IF (num = 0) THEN
	INSERT INTO sys_secretkey(session_id, sk_content) VALUES (n_session_id, s_sk_content);
  END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `deleteSecretkey` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteSecretkey` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSecretkey`(n_session_id INTEGER, OUT ret_code INTEGER)
BEGIN
  SET ret_code = 1;
  DELETE FROM sys_secretkey WHERE session_id = n_session_id; 
  IF (ROW_COUNT() = 0) THEN
    SET ret_code = -1821;
  END IF;
END */$$
DELIMITER ;

alter table log_transfer change change_id change_id int(10) not null auto_increment;
alter table log_transfer_approval change log_id log_id int(10) not null auto_increment;
alter table log_transfer  modify column order_id varchar(32);
DELIMITER ;
