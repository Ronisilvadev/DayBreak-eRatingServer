/*
Navicat MySQL Data Transfer

Source Server         : 84_内网
Source Server Version : 50124
Source Host           : 192.168.41.84:3306
Source Database       : lmzg_intermodal

Target Server Type    : MYSQL
Target Server Version : 50124
File Encoding         : 65001

Date: 2013-03-04 11:21:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `intermodal_address`
-- ----------------------------
DROP TABLE IF EXISTS `intermodal_address`;
CREATE TABLE `intermodal_address` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `gameid` mediumint(8) NOT NULL COMMENT '游戏ID',
  `address` text NOT NULL COMMENT '联运地址',
  `dateline` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `gameidkey` (`gameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联运地址信息';

-- ----------------------------
-- Records of intermodal_address
-- ----------------------------

-- ----------------------------
-- Table structure for `intermodal_charging_order_info`
-- ----------------------------
DROP TABLE IF EXISTS `intermodal_charging_order_info`;
CREATE TABLE `intermodal_charging_order_info` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `unionCode` char(16) NOT NULL COMMENT '联运方代号',
  `orderId` varchar(32) NOT NULL COMMENT '订单ID',
  `userName` varchar(32) NOT NULL COMMENT '用户名称(唯一标识)',
  `chargeTime` varchar(16) NOT NULL COMMENT '充值时间',
  `chargeMoney` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额(人民币:元)',
  `chargeAmount` mediumint(8) NOT NULL DEFAULT '0' COMMENT '金币充值数量,默认充值比例:  1元(人民币)=10金币',
  `gatewayId` mediumint(6) NOT NULL DEFAULT '0' COMMENT '网关ID',
  `gameId` mediumint(4) NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `clientIp` int(16) NOT NULL COMMENT '客户端Ip',
  `chargeResult` char(10) NOT NULL COMMENT '充值结果',
  `dateline` int(10) NOT NULL DEFAULT '0' COMMENT '系统时间',
  PRIMARY KEY (`id`),
  KEY `game_key` (`gameId`),
  KEY `order_key` (`orderId`),
  KEY `gateway_key` (`gatewayId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值订单信息表';

-- ----------------------------
-- Records of intermodal_charging_order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `intermodal_server`
-- ----------------------------
DROP TABLE IF EXISTS `intermodal_server`;
CREATE TABLE `intermodal_server` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `gameid` mediumint(8) NOT NULL COMMENT '游戏ID',
  `serverid` varchar(16) NOT NULL COMMENT '服务器id',
  `gatewayid` bigint(20) NOT NULL DEFAULT '0' COMMENT '网关Id',
  `servername` varchar(128) NOT NULL COMMENT '服务器名称',
  `server` varchar(256) NOT NULL COMMENT '服务器信息(IP:端口)',
  `dateline` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `gameidkey` (`gameid`),
  KEY `serveridkey` (`serverid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联运服务器信息';

-- ----------------------------
-- Records of intermodal_server
-- ----------------------------

-- ----------------------------
-- Table structure for `intermodal_server_info`
-- ----------------------------
DROP TABLE IF EXISTS `intermodal_server_info`;
CREATE TABLE `intermodal_server_info` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(16) NOT NULL COMMENT '360 服务器Id',
  `server_name` varchar(64) NOT NULL COMMENT '区服名称',
  `gateway_id` mediumint(8) NOT NULL COMMENT '联运系统网关Id',
  `updatetime` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `dateline` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `server_key` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黎明之光360 联运区服与网关对照表';

-- ----------------------------
-- Records of intermodal_server_info
-- ----------------------------
