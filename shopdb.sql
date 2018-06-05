/*
Navicat MySQL Data Transfer

Source Server         : shopdb
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : shopdb

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-06-05 15:08:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goodid` int(11) NOT NULL AUTO_INCREMENT,
  `goodname` varchar(255) NOT NULL,
  `typeid` int(11) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`goodid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('2', '酷儿', '3', '3');
INSERT INTO `goods` VALUES ('3', '可乐', '3', '2.5');
INSERT INTO `goods` VALUES ('5', 'iPhone', '4', '4299');
INSERT INTO `goods` VALUES ('6', '三星S7', '4', '3999');
INSERT INTO `goods` VALUES ('7', '佳能m5', '5', '5488');
INSERT INTO `goods` VALUES ('8', '富士X-2', '5', '6400');

-- ----------------------------
-- Table structure for `goodstype`
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(255) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES ('3', '饮料');
INSERT INTO `goodstype` VALUES ('4', '手机');
INSERT INTO `goodstype` VALUES ('5', '相机');
