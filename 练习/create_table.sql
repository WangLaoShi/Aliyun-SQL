/*
 Navicat MySQL Data Transfer

 Source Server         : Magic
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : 天池sql题

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 17/01/2021 13:52:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ccf_offline_stage1_test_revised
-- ----------------------------
DROP TABLE IF EXISTS `ccf_offline_stage1_test_revised`;
CREATE TABLE `ccf_offline_stage1_test_revised`  (
  `User_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Merchant_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Coupon_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Discount_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Distance` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date_received` date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ccf_offline_stage1_train
-- ----------------------------
DROP TABLE IF EXISTS `ccf_offline_stage1_train`;
CREATE TABLE `ccf_offline_stage1_train`  (
  `User_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Merchant_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Coupon_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Discount_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Distance` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date_received` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ccf_online_stage1_train
-- ----------------------------
DROP TABLE IF EXISTS `ccf_online_stage1_train`;
CREATE TABLE `ccf_online_stage1_train`  (
  `User_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Merchant_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Coupon_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Discount_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Date_received` date NULL DEFAULT NULL,
  `Date` date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for company operating
-- ----------------------------
DROP TABLE IF EXISTS `company operating`;
CREATE TABLE `company operating`  (
  `SECURITY_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TICKER_SYMBOL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `INDIC_NAME_EN` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `END_DATE` date NULL DEFAULT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `UNIT_CD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for income statement
-- ----------------------------
DROP TABLE IF EXISTS `income statement`;
CREATE TABLE `income statement`  (
  `PARTY_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TICKER_SYMBOL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXCHANGE_CD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PUBLISH_DATE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `END_DATE_REP` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `END_DATE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REPORT_TYPE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FISCAL_PERIOD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `MERGED_FLAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `T_REVENUE` decimal(25, 0) NULL DEFAULT NULL,
  `REVENUE` decimal(25, 0) NULL DEFAULT NULL,
  `INT_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `PREM_EARNED` decimal(25, 0) NULL DEFAULT NULL,
  `COMMIS_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `SPEC_TOR` decimal(25, 0) NULL DEFAULT NULL,
  `ATOR` decimal(25, 0) NULL DEFAULT NULL,
  `T_COGS` decimal(25, 0) NULL DEFAULT NULL,
  `COGS` decimal(25, 0) NULL DEFAULT NULL,
  `INT_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `COMMIS_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `PREM_REFUND` decimal(25, 0) NULL DEFAULT NULL,
  `N_COMPENS_PAYOUT` decimal(25, 0) NULL DEFAULT NULL,
  `RESER_INSUR_CONTR` decimal(25, 0) NULL DEFAULT NULL,
  `POLICY_DIV_PAYT` decimal(25, 0) NULL DEFAULT NULL,
  `REINSUR_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `BIZ_TAX_SURCHG` decimal(25, 0) NULL DEFAULT NULL,
  `SELL_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `ADMIN_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `FINAN_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `ASSETS_IMPAIR_LOSS` decimal(25, 0) NULL DEFAULT NULL,
  `SPEC_TOC` decimal(25, 0) NULL DEFAULT NULL,
  `ATOC` decimal(25, 0) NULL DEFAULT NULL,
  `F_VALUE_CHG_GAIN` decimal(25, 0) NULL DEFAULT NULL,
  `INVEST_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `A_J_INVEST_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `FOREX_GAIN` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_OP` decimal(25, 0) NULL DEFAULT NULL,
  `ASSETS_DISP_GAIN` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_OP` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_GAIN` decimal(25, 0) NULL DEFAULT NULL,
  `OPERATE_PROFIT` decimal(25, 0) NULL DEFAULT NULL,
  `NOPERATE_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `NOPERATE_EXP` decimal(25, 0) NULL DEFAULT NULL,
  `NCA_DISPLOSS` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_TP` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_TP` decimal(25, 0) NULL DEFAULT NULL,
  `T_PROFIT` decimal(25, 0) NULL DEFAULT NULL,
  `INCOME_TAX` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_NP` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_NP` decimal(25, 0) NULL DEFAULT NULL,
  `N_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `GOING_CONCERN_NI` decimal(25, 0) NULL DEFAULT NULL,
  `QUIT_CONCERN_NI` decimal(25, 0) NULL DEFAULT NULL,
  `N_INCOME_ATTR_P` decimal(25, 0) NULL DEFAULT NULL,
  `N_INCOME_BMA` decimal(25, 0) NULL DEFAULT NULL,
  `MINORITY_GAIN` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_NPP` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_NPP` decimal(25, 0) NULL DEFAULT NULL,
  `BASIC_EPS` decimal(25, 0) NULL DEFAULT NULL,
  `DILUTED_EPS` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_COMPR_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_CI` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_CI` decimal(25, 0) NULL DEFAULT NULL,
  `T_COMPR_INCOME` decimal(25, 0) NULL DEFAULT NULL,
  `COMPR_INC_ATTR_P` decimal(25, 0) NULL DEFAULT NULL,
  `COMPR_INC_ATTR_M_S` decimal(25, 0) NULL DEFAULT NULL,
  `OTH_EFFECT_PCI` decimal(25, 0) NULL DEFAULT NULL,
  `AE_EFFECT_PCI` decimal(25, 0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for macro industry
-- ----------------------------
DROP TABLE IF EXISTS `macro industry`;
CREATE TABLE `macro industry`  (
  `indic_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FREQUENCY_CD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PERIOD_DATE` date NULL DEFAULT NULL,
  `DATA_VALUE` decimal(25, 5) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for market data
-- ----------------------------
DROP TABLE IF EXISTS `market data`;
CREATE TABLE `market data`  (
  `SECURITY_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TICKER_SYMBOL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `END_DATE` date NULL DEFAULT NULL,
  `CLOSE_PRICE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TURNOVER_VOL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TURNOVER_VALUE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `MARKET_VALUE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TYPE_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TYPE_NAME_EN` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TYPE_NAME_CN` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for winequality-red
-- ----------------------------
DROP TABLE IF EXISTS `winequality-red`;
CREATE TABLE `winequality-red`  (
  `fixed acidity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `volatile acidity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `citric acid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `residual sugar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `chlorides` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `free sulfur dioxide` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total sulfur dioxide` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `density` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pH` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sulphates` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alcohol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quality` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for winequality-white
-- ----------------------------
DROP TABLE IF EXISTS `winequality-white`;
CREATE TABLE `winequality-white`  (
  `fixed acidity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `volatile acidity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `citric acid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `residual sugar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `chlorides` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `free sulfur dioxide` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total sulfur dioxide` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `density` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pH` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sulphates` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alcohol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quality` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
