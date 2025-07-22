/*
 Navicat Premium Data Transfer

 Source Server         : navi-big-screen
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : vssr

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 21/07/2025 01:12:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blood_pressure_monitor
-- ----------------------------
DROP TABLE IF EXISTS `blood_pressure_monitor`;
CREATE TABLE `blood_pressure_monitor`  (
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `record_date` date NULL DEFAULT NULL,
  `heart_rate` json NULL,
  `systolic_pressure` json NULL,
  `diastolic_pressure` json NULL,
  PRIMARY KEY (`patient_id`) USING BTREE,
  CONSTRAINT `fk_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blood_pressure_monitor
-- ----------------------------
INSERT INTO `blood_pressure_monitor` VALUES ('10000', '2025-07-13', '[85, 88, 90, 92, 95, 98, 100, 105, 108, 110, 108, 105, 102, 100, 98, 96, 95, 93, 90, 88, 86, 84, 82, 80]', '[140, 142, 145, 148, 150, 155, 158, 160, 162, 165, 163, 160, 158, 155, 152, 150, 148, 145, 142, 140, 138, 136, 134, 132]', '[85, 86, 88, 90, 92, 94, 96, 98, 100, 102, 100, 98, 96, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74]');
INSERT INTO `blood_pressure_monitor` VALUES ('10001', '2025-07-13', '[100, 105, 110, 115, 118, 120, 122, 118, 115, 110, 108, 105, 102, 100, 98, 96, 95, 92, 90, 88, 86, 84, 82, 80]', '[170, 168, 165, 162, 160, 158, 155, 152, 150, 148, 145, 142, 140, 138, 135, 132, 130, 128, 125, 122, 120, 118, 115, 112]', '[95, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 72, 70, 68, 66, 64, 62, 60, 58, 56, 54, 52, 50]');
INSERT INTO `blood_pressure_monitor` VALUES ('10002', '2025-07-13', '[75, 78, 80, 82, 85, 88, 90, 92, 90, 88, 85, 82, 80, 78, 76, 75, 74, 73, 72, 71, 70, 72, 74, 75]', '[140, 138, 135, 132, 130, 128, 130, 132, 135, 138, 140, 142, 138, 135, 132, 130, 128, 126, 124, 122, 120, 118, 120, 122]', '[85, 84, 82, 80, 78, 76, 78, 80, 82, 84, 85, 86, 84, 82, 80, 78, 76, 74, 72, 70, 68, 70, 72, 74]');
INSERT INTO `blood_pressure_monitor` VALUES ('10003', '2025-07-13', '[105, 108, 110, 112, 115, 118, 120, 122, 120, 118, 115, 112, 110, 108, 106, 104, 102, 100, 98, 96, 94, 92, 90, 88]', '[180, 178, 175, 172, 170, 168, 165, 162, 160, 158, 155, 152, 150, 148, 145, 142, 140, 138, 135, 132, 130, 128, 125, 122]', '[100, 98, 96, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 72, 70, 68, 66, 64, 62, 60, 58, 56, 54]');
INSERT INTO `blood_pressure_monitor` VALUES ('10004', '2025-07-13', '[85, 88, 90, 92, 95, 98, 100, 102, 100, 98, 95, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 76, 78, 80]', '[150, 148, 145, 142, 140, 138, 135, 132, 130, 128, 130, 132, 135, 138, 140, 142, 138, 135, 132, 130, 128, 130, 132, 135]', '[95, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 72, 70, 68, 66, 64, 62, 60, 58, 56, 58, 60, 62]');
INSERT INTO `blood_pressure_monitor` VALUES ('10005', '2025-07-13', '[85, 88, 90, 92, 95, 98, 100, 102, 100, 98, 95, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 76, 78, 80]', '[150, 148, 145, 142, 140, 138, 135, 132, 130, 128, 130, 132, 135, 138, 140, 142, 138, 135, 132, 130, 128, 130, 132, 135]', '[95, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74, 72, 70, 68, 66, 64, 62, 60, 58, 56, 58, 60, 62]');

-- ----------------------------
-- Table structure for daily_assessments
-- ----------------------------
DROP TABLE IF EXISTS `daily_assessments`;
CREATE TABLE `daily_assessments`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '患者ID，关联patients(id)',
  `assessment_date` date NOT NULL DEFAULT (curdate()) COMMENT '评估日期',
  `S5Q` tinyint UNSIGNED NOT NULL COMMENT '5项简版量表(0-100)',
  `RASS` tinyint UNSIGNED NOT NULL COMMENT '镇静躁动评分(0-100)',
  `MMASA` tinyint UNSIGNED NOT NULL COMMENT '曼恩吞咽能力评估(0-100)',
  `MRCsum` tinyint UNSIGNED NOT NULL COMMENT '肌力评分总和(0-100)',
  `BBS_sit_to_stand` tinyint UNSIGNED NOT NULL COMMENT '坐站平衡(0-100)',
  `BBS_standing` tinyint UNSIGNED NOT NULL COMMENT '站立平衡(0-100)',
  `BBS_sitting` tinyint UNSIGNED NOT NULL COMMENT '坐位平衡(0-100)',
  `FOIS` tinyint UNSIGNED NOT NULL COMMENT '功能性经口摄食量表(0-100)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_assessment`(`patient_id` ASC, `assessment_date` ASC) USING BTREE,
  INDEX `idx_patient_id`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `chk_BBS_sit_to_stand` CHECK (`BBS_sit_to_stand` between 0 and 100),
  CONSTRAINT `chk_BBS_sitting` CHECK (`BBS_sitting` between 0 and 100),
  CONSTRAINT `chk_BBS_standing` CHECK (`BBS_standing` between 0 and 100),
  CONSTRAINT `chk_FOIS` CHECK (`FOIS` between 0 and 100),
  CONSTRAINT `chk_MMASA` CHECK (`MMASA` between 0 and 100),
  CONSTRAINT `chk_MRCsum` CHECK (`MRCsum` between 0 and 100),
  CONSTRAINT `chk_RASS` CHECK (`RASS` between 0 and 100),
  CONSTRAINT `chk_S5Q` CHECK (`S5Q` between 0 and 100)
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '每日评估表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_assessments
-- ----------------------------
INSERT INTO `daily_assessments` VALUES (1, '10000', '2025-07-13', 65, 60, 55, 70, 40, 65, 75, 70);
INSERT INTO `daily_assessments` VALUES (2, '10001', '2025-07-13', 50, 40, 35, 45, 25, 30, 40, 45);
INSERT INTO `daily_assessments` VALUES (3, '10002', '2025-07-13', 75, 70, 65, 60, 50, 55, 80, 70);
INSERT INTO `daily_assessments` VALUES (4, '10003', '2025-07-13', 30, 35, 25, 30, 15, 20, 25, 30);
INSERT INTO `daily_assessments` VALUES (5, '10004', '2025-07-13', 70, 75, 65, 60, 55, 60, 75, 80);

-- ----------------------------
-- Table structure for doctors
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医生姓名',
  `department` enum('理疗科','康复科','作业科','言语科','神经科','心理科','针灸科','推拿科') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室',
  `today_schedule` json NOT NULL COMMENT '当天排班小时数组，如[0,1,2,3]，空数组表示未排班',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生及当天排班信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctors
-- ----------------------------
INSERT INTO `doctors` VALUES (1, '冯思思', '心理科', '[0]');
INSERT INTO `doctors` VALUES (2, '韩静', '针灸科', '[1]');
INSERT INTO `doctors` VALUES (3, '杨明', '推拿科', '[2]');
INSERT INTO `doctors` VALUES (4, '林华', '理疗科', '[3]');
INSERT INTO `doctors` VALUES (5, '郭敏', '康复科', '[4]');
INSERT INTO `doctors` VALUES (6, '曾伟', '作业科', '[10]');
INSERT INTO `doctors` VALUES (7, '苏婷', '言语科', '[11]');
INSERT INTO `doctors` VALUES (8, '彭强', '神经科', '[12]');
INSERT INTO `doctors` VALUES (9, '董思', '心理科', '[13]');
INSERT INTO `doctors` VALUES (10, '谢静', '针灸科', '[14]');
INSERT INTO `doctors` VALUES (11, '曹明', '推拿科', '[5]');
INSERT INTO `doctors` VALUES (12, '王晓明', '理疗科', '[15]');
INSERT INTO `doctors` VALUES (13, '李婷婷', '康复科', '[16]');
INSERT INTO `doctors` VALUES (14, '张伟华', '作业科', '[8]');
INSERT INTO `doctors` VALUES (15, '陈思琪', '言语科', '[18]');
INSERT INTO `doctors` VALUES (16, '赵建国', '神经科', '[17]');
INSERT INTO `doctors` VALUES (17, '孙雅静', '心理科', '[]');
INSERT INTO `doctors` VALUES (18, '周宏伟', '针灸科', '[]');
INSERT INTO `doctors` VALUES (19, '吴丽华', '推拿科', '[]');
INSERT INTO `doctors` VALUES (20, '郑志强', '理疗科', '[19]');
INSERT INTO `doctors` VALUES (21, '钱晓芳', '康复科', '[9]');
INSERT INTO `doctors` VALUES (22, '林宇航', '作业科', '[6]');
INSERT INTO `doctors` VALUES (23, '刘美玲', '言语科', '[21]');
INSERT INTO `doctors` VALUES (24, '黄国强', '神经科', '[22]');
INSERT INTO `doctors` VALUES (25, '徐雅琴', '心理科', '[]');
INSERT INTO `doctors` VALUES (26, '马建军', '针灸科', '[]');
INSERT INTO `doctors` VALUES (27, '朱丽君', '推拿科', '[]');
INSERT INTO `doctors` VALUES (28, '胡志明', '理疗科', '[20]');
INSERT INTO `doctors` VALUES (29, '高晓雯', '康复科', '[23]');
INSERT INTO `doctors` VALUES (30, '宋宇航', '作业科', '[]');
INSERT INTO `doctors` VALUES (31, '韩美琪', '言语科', '[]');
INSERT INTO `doctors` VALUES (32, '彭国华', '神经科', '[]');
INSERT INTO `doctors` VALUES (33, '董雅诗', '心理科', '[7]');
INSERT INTO `doctors` VALUES (34, '谢建军', '针灸科', '[]');
INSERT INTO `doctors` VALUES (35, '曹丽娜', '推拿科', '[]');

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '患者ID，主键，字符串自增（如10000、10001）',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `age` tinyint UNSIGNED NOT NULL COMMENT '年龄（0-120）',
  `admission_date` date NOT NULL COMMENT '入院日期',
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室',
  `hospital_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '住院编号，唯一',
  `attending_physician` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主治医生',
  `head_nurse` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主管护士',
  `diagnosis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '病情诊断',
  `rehabilitation_doctor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '康复医生',
  `rehab_count` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '康复训练次数',
  `completion_rate` tinyint UNSIGNED NOT NULL COMMENT '平均康复完成率(%)',
  `physical_recovery` tinyint UNSIGNED NOT NULL COMMENT '当前体力恢复(%)',
  `NIHSS_score` tinyint UNSIGNED NOT NULL COMMENT '卒中量表评分(NIHSS)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_hospital_number`(`hospital_number` ASC) USING BTREE,
  INDEX `idx_admission_date`(`admission_date` ASC) USING BTREE,
  INDEX `idx_department`(`department` ASC) USING BTREE,
  CONSTRAINT `chk_age` CHECK (`age` between 0 and 120),
  CONSTRAINT `chk_completion_rate` CHECK (`completion_rate` between 0 and 100),
  CONSTRAINT `chk_NIHSS_score` CHECK (`NIHSS_score` between 0 and 42),
  CONSTRAINT `chk_physical_recovery` CHECK (`physical_recovery` between 0 and 100)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '患者信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES ('10000', '张三', '男', 65, '2025-06-15', '神经内科重症监护室', 'ZY20250615001', '李华', '王芳', '脑卒中恢复期（左侧偏瘫）', '赵明', 12, 78, 65, 8);
INSERT INTO `patients` VALUES ('10001', '李秀英', '女', 72, '2025-07-01', '神经康复科', 'ZY20250701002', '陈建国', '张敏', '急性缺血性脑卒中（右侧偏瘫）', '刘红梅', 8, 65, 50, 12);
INSERT INTO `patients` VALUES ('10002', '王刚', '男', 45, '2025-07-05', '神经外科ICU', 'ZY20250705003', '孙建国', '李静', '右侧基底节区脑出血术后', '陈志强', 18, 92, 75, 15);
INSERT INTO `patients` VALUES ('10003', '陈桂芳', '女', 82, '2025-06-20', '老年神经科', 'ZY20250620004', '王志强', '周梅', '多发腔隙性脑梗死（双侧）、血管性痴呆', '张丽华', 6, 55, 40, 18);
INSERT INTO `patients` VALUES ('10004', '杨宇航', '男', 38, '2025-07-08', '神经内科', 'ZY20250708005', '刘建明', '周晓雯', '复发性脑梗死（左侧大脑中动脉区域）', '吴振华', 15, 85, 70, 10);
INSERT INTO `patients` VALUES ('10005', '张三', '男', 65, '2025-06-15', '神经内科重症监护室', 'ZY20250615101', '李华', '王芳', '脑卒中恢复期（左侧偏瘫）', '赵明', 12, 78, 65, 8);

-- ----------------------------
-- Table structure for physiological_risks
-- ----------------------------
DROP TABLE IF EXISTS `physiological_risks`;
CREATE TABLE `physiological_risks`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '患者ID',
  `d_dimer` decimal(5, 2) NOT NULL COMMENT 'D-二聚体值',
  `d_dimer_suggestions` json NOT NULL COMMENT 'D-二聚体建议',
  `nutrition_score` tinyint UNSIGNED NOT NULL COMMENT '营养评估量表得分',
  `nutrition_suggestions` json NOT NULL COMMENT '营养建议',
  `blood_sugar` decimal(4, 1) NOT NULL COMMENT '血糖值',
  `blood_sugar_suggestions` json NOT NULL COMMENT '血糖建议',
  `physiological_problems` json NOT NULL COMMENT '生理问题列表',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `patient_id`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `physiological_risks_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `physiological_risks_chk_1` CHECK (`d_dimer` >= 0),
  CONSTRAINT `physiological_risks_chk_2` CHECK (`nutrition_score` between 0 and 10),
  CONSTRAINT `physiological_risks_chk_3` CHECK (`blood_sugar` between 0 and 30)
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of physiological_risks
-- ----------------------------
INSERT INTO `physiological_risks` VALUES (1, '10000', 1.25, '[\"低分子肝素抗凝治疗\", \"下肢气压治疗\", \"定期复查凝血功能\"]', 4, '[\"高蛋白饮食\", \"口服营养补充剂\", \"监测血清白蛋白\"]', 8.7, '[\"糖尿病饮食\", \"餐前胰岛素注射\", \"每日4次血糖监测\"]', '[\"高血压\", \"2型糖尿病\", \"肺部感染风险\", \"深静脉血栓风险\"]');
INSERT INTO `physiological_risks` VALUES (2, '10001', 2.80, '[\"加强抗凝治疗\", \"下肢气压治疗每日3次\", \"避免长时间卧床\"]', 3, '[\"高蛋白流质饮食\", \"肠内营养支持\", \"监测前白蛋白\"]', 11.2, '[\"胰岛素泵治疗\", \"糖尿病饮食控制\", \"每小时血糖监测\"]', '[\"心房颤动\", \"高血压3级\", \"2型糖尿病\", \"营养不良\", \"深静脉血栓高风险\"]');
INSERT INTO `physiological_risks` VALUES (3, '10002', 0.90, '[\"早期下床活动\", \"踝泵运动每小时10次\", \"观察下肢肿胀\"]', 6, '[\"高蛋白饮食\", \"维生素补充\", \"监测体重变化\"]', 6.5, '[\"常规糖尿病筛查\", \"均衡饮食\"]', '[\"脑出血术后\", \"颅内压增高风险\", \"癫痫风险\", \"肺部感染预防\"]');
INSERT INTO `physiological_risks` VALUES (4, '10003', 1.50, '[\"加强抗血小板治疗\", \"定期凝血功能检测\", \"增加活动量\"]', 7, '[\" Mediterranean diet\", \"控制钠盐摄入\", \"增加ω-3脂肪酸\"]', 5.8, '[\"定期血糖监测\", \"均衡饮食\"]', '[\"高血压\", \"高脂血症\", \"复发性脑卒中风险\", \"工作压力相关风险\"]');
INSERT INTO `physiological_risks` VALUES (5, '10004', 1.20, '[\"加强抗血小板治疗\", \"定期凝血功能检测\", \"增加活动量\"]', 7, '[\"地中海饮食\", \"控制钠盐摄入\", \"增加ω-3脂肪酸\"]', 5.8, '[\"定期血糖监测\", \"均衡饮食\"]', '[\"高血压\", \"高脂血症\", \"复发性脑卒中风险\", \"工作压力相关风险\"]');

-- ----------------------------
-- Table structure for rehabilitation_pathways
-- ----------------------------
DROP TABLE IF EXISTS `rehabilitation_pathways`;
CREATE TABLE `rehabilitation_pathways`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `part` int NULL DEFAULT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `subcategory` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `items` json NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rp_fk_patient`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `rp_fk_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rehabilitation_pathways
-- ----------------------------
INSERT INTO `rehabilitation_pathways` VALUES (1, '10000', 1, '康复评估', '物理评估', '[\"S5Q\", \"MRC\", \"BBS\"]');
INSERT INTO `rehabilitation_pathways` VALUES (2, '10000', 1, '康复评估', '作业评估', '[\"RASS\"]');
INSERT INTO `rehabilitation_pathways` VALUES (3, '10000', 1, '康复评估', '吞咽评估', '[\"MMASA\", \"FOIS\"]');
INSERT INTO `rehabilitation_pathways` VALUES (4, '10000', 1, '康复训练', '物理治疗', '[\"床上被动运动\", \"体位管理\", \"平衡训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (5, '10000', 2, '康复评估', '物理评估', '[\"关节活动度\", \"肌力测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (6, '10000', 2, '康复评估', '作业评估', '[\"日常生活能力评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (7, '10000', 2, '康复评估', '吞咽评估', '[\"饮水测试\", \"食物稠度测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (8, '10000', 2, '康复训练', '物理治疗', '[\"坐位平衡训练\", \"床边站立训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (9, '10000', 3, '康复评估', '物理评估', '[\"步态分析\", \"耐力测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (10, '10000', 3, '康复评估', '作业评估', '[\"手功能评估\", \"认知功能测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (11, '10000', 3, '康复评估', '吞咽评估', '[\"咽部敏感度测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (12, '10000', 3, '康复训练', '物理治疗', '[\"步行训练\", \"上下楼梯训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (13, '10001', 1, '康复评估', '物理评估', '[\"肌张力评估\", \"关节活动度\"]');
INSERT INTO `rehabilitation_pathways` VALUES (14, '10001', 1, '康复评估', '作业评估', '[\"意识状态评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (15, '10001', 1, '康复评估', '吞咽评估', '[\"口腔功能检查\"]');
INSERT INTO `rehabilitation_pathways` VALUES (16, '10001', 1, '康复训练', '物理治疗', '[\"被动关节活动\", \"体位摆放\", \"呼吸训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (17, '10001', 2, '康复评估', '物理评估', '[\"平衡功能初评\", \"转移能力\"]');
INSERT INTO `rehabilitation_pathways` VALUES (18, '10001', 2, '康复评估', '作业评估', '[\"注意力评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (19, '10001', 2, '康复评估', '吞咽评估', '[\"吞咽造影准备\"]');
INSERT INTO `rehabilitation_pathways` VALUES (20, '10001', 2, '康复训练', '物理治疗', '[\"床边坐位训练\", \"助力转移训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (21, '10001', 3, '康复评估', '物理评估', '[\"步态分析\", \"耐力测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (22, '10001', 3, '康复评估', '作业评估', '[\"手功能评估\", \"日常生活能力\"]');
INSERT INTO `rehabilitation_pathways` VALUES (23, '10001', 3, '康复评估', '吞咽评估', '[\"食物稠度测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (24, '10001', 3, '康复训练', '物理治疗', '[\"站立平衡训练\", \"助行器使用\"]');
INSERT INTO `rehabilitation_pathways` VALUES (25, '10002', 1, '康复评估', '物理评估', '[\"格拉斯哥昏迷评分\", \"肌张力评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (26, '10002', 1, '康复评估', '作业评估', '[\"意识状态评估\", \"疼痛评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (27, '10002', 1, '康复评估', '吞咽评估', '[\"床边吞咽筛查\"]');
INSERT INTO `rehabilitation_pathways` VALUES (28, '10002', 1, '康复训练', '物理治疗', '[\"被动关节活动\", \"呼吸训练\", \"体位管理\"]');
INSERT INTO `rehabilitation_pathways` VALUES (29, '10002', 2, '康复评估', '物理评估', '[\"平衡功能评估\", \"转移能力\"]');
INSERT INTO `rehabilitation_pathways` VALUES (30, '10002', 2, '康复评估', '作业评估', '[\"认知功能筛查\", \"手功能评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (31, '10002', 2, '康复评估', '吞咽评估', '[\"VFSS吞咽造影\"]');
INSERT INTO `rehabilitation_pathways` VALUES (32, '10002', 2, '康复训练', '物理治疗', '[\"坐位平衡训练\", \"床边站立训练\", \"步态训练准备\"]');
INSERT INTO `rehabilitation_pathways` VALUES (33, '10002', 3, '康复评估', '物理评估', '[\"步态分析\", \"耐力测试\", \"日常生活能力\"]');
INSERT INTO `rehabilitation_pathways` VALUES (34, '10002', 3, '康复评估', '作业评估', '[\"工具使用能力\", \"职业能力评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (35, '10002', 3, '康复评估', '吞咽评估', '[\"食物适应性测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (36, '10002', 3, '康复训练', '物理治疗', '[\"步行训练\", \"上下楼梯训练\", \"社区行走训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (37, '10004', 1, '康复评估', '物理评估', '[\"运动功能评估\", \"平衡能力初评\"]');
INSERT INTO `rehabilitation_pathways` VALUES (38, '10004', 1, '康复评估', '作业评估', '[\"认知功能筛查\", \"情绪状态评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (39, '10004', 1, '康复评估', '吞咽评估', '[\"床边吞咽筛查\"]');
INSERT INTO `rehabilitation_pathways` VALUES (40, '10004', 1, '康复训练', '物理治疗', '[\"主动辅助运动\", \"坐位平衡训练\", \"呼吸训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (41, '10004', 2, '康复评估', '物理评估', '[\"步态分析\", \"耐力测试\"]');
INSERT INTO `rehabilitation_pathways` VALUES (42, '10004', 2, '康复评估', '作业评估', '[\"职业能力评估\", \"驾驶能力评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (43, '10004', 2, '康复评估', '吞咽评估', '[\"进食效率评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (44, '10004', 2, '康复训练', '物理治疗', '[\"步行训练\", \"上下楼梯训练\", \"社区行走训练\"]');
INSERT INTO `rehabilitation_pathways` VALUES (45, '10004', 3, '康复评估', '物理评估', '[\"心血管耐力\", \"运动风险评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (46, '10004', 3, '康复评估', '作业评估', '[\"压力管理能力\", \"生活方式评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (47, '10004', 3, '康复评估', '吞咽评估', '[\"长期吞咽安全评估\"]');
INSERT INTO `rehabilitation_pathways` VALUES (48, '10004', 3, '康复训练', '物理治疗', '[\"有氧运动训练\", \"抗阻训练\", \"家庭运动计划\"]');

-- ----------------------------
-- Table structure for rehabilitation_plan_details
-- ----------------------------
DROP TABLE IF EXISTS `rehabilitation_plan_details`;
CREATE TABLE `rehabilitation_plan_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tips_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tips_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sections` json NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_template_patient`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `fk_template_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rehabilitation_plan_details
-- ----------------------------
INSERT INTO `rehabilitation_plan_details` VALUES (1, '10000', '康复方案', 'Tips1：', '请仔细检查病人是否有严重的感染性疾病、近期心肌梗死、未控制的癫痫发作、大面积脑卒中急性期等康复训练禁忌症', '[{\"items\": [\"平衡训练（单腿站立、闭目站立，每次保持 10 - 15 秒，重复 8 - 10 次，一日 3 次）\", \"步行训练（借助平行杠、助行器逐步过渡到独立行走，每次 30 分钟，一日 2 - 3 次）\", \"关节活动度训练（上肢、下肢各关节的屈伸、旋转，每个动作保持 15 - 30 秒，重复 10 - 15 次，一日 3 次）\", \"肌力训练（利用弹力带、哑铃进行抗阻训练，根据肌力等级选择合适重量和重复次数，一般 3 - 4 组，每组 8 - 12 次，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"手功能训练（捏橡皮泥、穿珠子、拧瓶盖等精细动作，每次 20 - 30 分钟，一日 2 - 3 次）\", \"认知训练（记忆游戏、数字排序、找不同等，根据认知水平调整难度，每次 20 - 30 分钟，一日 2 次）\", \"日常生活活动训练（穿衣、进食、洗漱等模拟训练，结合实际情况进行个性化的指导和辅助，每次 30 - 45 分钟，一日 2 - 3 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"口腔按摩（对唇部、颊部、舌部等部位进行轻柔按摩，每次 5 - 10 分钟，一日 3 次）\", \"冰刺激（用冰棉签刺激软腭、咽壁等部位，每次 10 - 15 分钟，一日 2 - 3 次）\", \"空吞咽训练（在进食前进行多次空吞咽，以提高吞咽反射的敏感度，每次 10 - 15 次，一日 3 - 5 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (2, '10001', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的高血压、糖尿病急性并发症等康复训练禁忌症', '[{\"items\": [\"床上移动训练（翻身、坐起训练，每次 10 - 15 分钟，一日 3 次）\", \"站立平衡训练（依靠扶持物进行站立平衡练习，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的手部抓握训练（利用小皮球等器材，每次抓握保持 3 - 5 秒，重复 10 - 15 次，一日 3 次）\", \"注意力集中训练（如看图找物，每次 5 - 10 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"唇部闭合练习（吹气练习，每次 5 - 10 分钟，一日 3 次）\", \"吞咽动作模拟训练（空吞咽配合点头动作，每次 10 - 15 次，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (3, '10002', '康复方案', 'Tips1：', '请仔细检查病人是否有不稳定性骨折、急性手术、精神不稳定、不稳定性心律失常、活动性出血、气道不安全等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\", \"电刺激（使用低频电刺激仪刺激咽喉部肌肉，根据耐受程度调整强度，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (4, '10003', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心力衰竭、严重的肺部疾病、意识障碍等康复训练禁忌症', '[{\"items\": [\"下肢肌肉按摩（促进血液循环，每次 10 - 15 分钟，一日 2 次）\", \"坐位平衡训练（在椅子上进行简单的左右、前后重心转移训练，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的拼图游戏（锻炼认知和手眼协调能力，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"舌部运动训练（伸舌、舔唇等动作，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (5, '10004', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心律不齐、心肺复苏、心电 irregular 等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (6, '10000', '康复方案', 'Tips1：', '请仔细检查病人是否有严重的感染性疾病、近期心肌梗死、未控制的癫痫发作、大面积脑卒中急性期等康复训练禁忌症', '[{\"items\": [\"平衡训练（单腿站立、闭目站立，每次保持 10 - 15 秒，重复 8 - 10 次，一日 3 次）\", \"步行训练（借助平行杠、助行器逐步过渡到独立行走，每次 30 分钟，一日 2 - 3 次）\", \"关节活动度训练（上肢、下肢各关节的屈伸、旋转，每个动作保持 15 - 30 秒，重复 10 - 15 次，一日 3 次）\", \"肌力训练（利用弹力带、哑铃进行抗阻训练，根据肌力等级选择合适重量和重复次数，一般 3 - 4 组，每组 8 - 12 次，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"手功能训练（捏橡皮泥、穿珠子、拧瓶盖等精细动作，每次 20 - 30 分钟，一日 2 - 3 次）\", \"认知训练（记忆游戏、数字排序、找不同等，根据认知水平调整难度，每次 20 - 30 分钟，一日 2 次）\", \"日常生活活动训练（穿衣、进食、洗漱等模拟训练，结合实际情况进行个性化的指导和辅助，每次 30 - 45 分钟，一日 2 - 3 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"口腔按摩（对唇部、颊部、舌部等部位进行轻柔按摩，每次 5 - 10 分钟，一日 3 次）\", \"冰刺激（用冰棉签刺激软腭、咽壁等部位，每次 10 - 15 分钟，一日 2 - 3 次）\", \"空吞咽训练（在进食前进行多次空吞咽，以提高吞咽反射的敏感度，每次 10 - 15 次，一日 3 - 5 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (7, '10001', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的高血压、糖尿病急性并发症等康复训练禁忌症', '[{\"items\": [\"床上移动训练（翻身、坐起训练，每次 10 - 15 分钟，一日 3 次）\", \"站立平衡训练（依靠扶持物进行站立平衡练习，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的手部抓握训练（利用小皮球等器材，每次抓握保持 3 - 5 秒，重复 10 - 15 次，一日 3 次）\", \"注意力集中训练（如看图找物，每次 5 - 10 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"唇部闭合练习（吹气练习，每次 5 - 10 分钟，一日 3 次）\", \"吞咽动作模拟训练（空吞咽配合点头动作，每次 10 - 15 次，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (8, '10002', '康复方案', 'Tips1：', '请仔细检查病人是否有不稳定性骨折、急性手术、精神不稳定、不稳定性心律失常、活动性出血、气道不安全等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\", \"电刺激（使用低频电刺激仪刺激咽喉部肌肉，根据耐受程度调整强度，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (9, '10003', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心力衰竭、严重的肺部疾病、意识障碍等康复训练禁忌症', '[{\"items\": [\"下肢肌肉按摩（促进血液循环，每次 10 - 15 分钟，一日 2 次）\", \"坐位平衡训练（在椅子上进行简单的左右、前后重心转移训练，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的拼图游戏（锻炼认知和手眼协调能力，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"舌部运动训练（伸舌、舔唇等动作，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (10, '10004', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心律不齐、心肺复苏、心电 irregular 等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (11, '10000', '康复方案', 'Tips1：', '请仔细检查病人是否有严重的感染性疾病、近期心肌梗死、未控制的癫痫发作、大面积脑卒中急性期等康复训练禁忌症', '[{\"items\": [\"平衡训练（单腿站立、闭目站立，每次保持 10 - 15 秒，重复 8 - 10 次，一日 3 次）\", \"步行训练（借助平行杠、助行器逐步过渡到独立行走，每次 30 分钟，一日 2 - 3 次）\", \"关节活动度训练（上肢、下肢各关节的屈伸、旋转，每个动作保持 15 - 30 秒，重复 10 - 15 次，一日 3 次）\", \"肌力训练（利用弹力带、哑铃进行抗阻训练，根据肌力等级选择合适重量和重复次数，一般 3 - 4 组，每组 8 - 12 次，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"手功能训练（捏橡皮泥、穿珠子、拧瓶盖等精细动作，每次 20 - 30 分钟，一日 2 - 3 次）\", \"认知训练（记忆游戏、数字排序、找不同等，根据认知水平调整难度，每次 20 - 30 分钟，一日 2 次）\", \"日常生活活动训练（穿衣、进食、洗漱等模拟训练，结合实际情况进行个性化的指导和辅助，每次 30 - 45 分钟，一日 2 - 3 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"口腔按摩（对唇部、颊部、舌部等部位进行轻柔按摩，每次 5 - 10 分钟，一日 3 次）\", \"冰刺激（用冰棉签刺激软腭、咽壁等部位，每次 10 - 15 分钟，一日 2 - 3 次）\", \"空吞咽训练（在进食前进行多次空吞咽，以提高吞咽反射的敏感度，每次 10 - 15 次，一日 3 - 5 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (12, '10001', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的高血压、糖尿病急性并发症等康复训练禁忌症', '[{\"items\": [\"床上移动训练（翻身、坐起训练，每次 10 - 15 分钟，一日 3 次）\", \"站立平衡训练（依靠扶持物进行站立平衡练习，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的手部抓握训练（利用小皮球等器材，每次抓握保持 3 - 5 秒，重复 10 - 15 次，一日 3 次）\", \"注意力集中训练（如看图找物，每次 5 - 10 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"唇部闭合练习（吹气练习，每次 5 - 10 分钟，一日 3 次）\", \"吞咽动作模拟训练（空吞咽配合点头动作，每次 10 - 15 次，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (13, '10002', '康复方案', 'Tips1：', '请仔细检查病人是否有不稳定性骨折、急性手术、精神不稳定、不稳定性心律失常、活动性出血、气道不安全等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\", \"电刺激（使用低频电刺激仪刺激咽喉部肌肉，根据耐受程度调整强度，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (14, '10003', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心力衰竭、严重的肺部疾病、意识障碍等康复训练禁忌症', '[{\"items\": [\"下肢肌肉按摩（促进血液循环，每次 10 - 15 分钟，一日 2 次）\", \"坐位平衡训练（在椅子上进行简单的左右、前后重心转移训练，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"物理康复：\"}, {\"items\": [\"简单的拼图游戏（锻炼认知和手眼协调能力，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"舌部运动训练（伸舌、舔唇等动作，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');
INSERT INTO `rehabilitation_plan_details` VALUES (15, '10004', '康复方案', 'Tips1：', '请仔细检查病人是否有未控制的心律不齐、心肺复苏、心电 irregular 等康复训练禁忌症', '[{\"items\": [\"被动运动训练（对上肢、下肢各关节进行缓慢的被动屈伸运动，每个关节活动 10 - 15 次，一日 3 次）\", \"气道廓清技术（通过深呼吸、有效咳嗽等方法清除气道分泌物，每次练习 5 - 10 分钟，一日 3 次）\", \"体位训练（保持良肢位，每 2 小时翻身一次，并进行适当的肢体摆放）\"], \"title\": \"物理康复：\"}, {\"items\": [\"多感官刺激（视觉、听觉、触觉等多种感官刺激，如看图、听音乐、触摸不同材质的物品，每次 15 - 20 分钟，一日 2 次）\", \"情感支持（渐进式放松、冥想，每次 10 - 15 分钟，一日 2 次）\"], \"title\": \"作业康复：\"}, {\"items\": [\"感官刺激（对唇、颊、舌等部位进行软毛刷轻刷刺激，每次 5 - 10 分钟，一日 3 次）\"], \"title\": \"吞咽康复：\"}]');

-- ----------------------------
-- Table structure for rehabilitation_plan_templates
-- ----------------------------
DROP TABLE IF EXISTS `rehabilitation_plan_templates`;
CREATE TABLE `rehabilitation_plan_templates`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tips_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tips_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sections` json NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rehabilitation_plan_templates
-- ----------------------------

-- ----------------------------
-- Table structure for rehabilitation_plans
-- ----------------------------
DROP TABLE IF EXISTS `rehabilitation_plans`;
CREATE TABLE `rehabilitation_plans`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_date` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rehabilitation_plans
-- ----------------------------

-- ----------------------------
-- Table structure for vital_signs
-- ----------------------------
DROP TABLE IF EXISTS `vital_signs`;
CREATE TABLE `vital_signs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `record_time` datetime NULL DEFAULT NULL,
  `HR` int NULL DEFAULT NULL,
  `SBP` int NULL DEFAULT NULL,
  `ICP` int NULL DEFAULT NULL,
  `MAP` int NULL DEFAULT NULL,
  `temperature` decimal(3, 1) NULL DEFAULT NULL,
  `RR` int NULL DEFAULT NULL,
  `SpO2` int NULL DEFAULT NULL,
  `PEEP` int NULL DEFAULT NULL,
  `FiO2` decimal(3, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `vital_fk_patient`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `vital_fk_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vital_signs
-- ----------------------------
INSERT INTO `vital_signs` VALUES (1, '10000', '2025-07-13 00:58:30', 88, 145, 15, 92, 36.8, 18, 96, 8, 0.35);
INSERT INTO `vital_signs` VALUES (2, '10001', '2025-07-13 01:02:44', 102, 160, 18, 98, 37.2, 22, 94, 5, 0.28);
INSERT INTO `vital_signs` VALUES (3, '10002', '2025-07-13 01:11:27', 76, 135, 20, 90, 37.5, 16, 97, 6, 0.30);
INSERT INTO `vital_signs` VALUES (4, '10003', '2025-07-13 01:14:18', 110, 170, 14, 110, 36.9, 24, 92, 7, 0.40);
INSERT INTO `vital_signs` VALUES (5, '10004', '2025-07-13 05:58:18', 92, 150, 12, 100, 36.7, 18, 96, 5, 0.25);
INSERT INTO `vital_signs` VALUES (7, '10005', '2025-07-13 00:58:30', 88, 145, 15, 92, 36.8, 18, 96, 8, 0.35);
INSERT INTO `vital_signs` VALUES (8, '10005', '2025-07-13 00:58:30', 88, 145, 15, 92, 36.8, 18, 96, 8, 0.35);

-- ----------------------------
-- Table structure for weekly_assessments
-- ----------------------------
DROP TABLE IF EXISTS `weekly_assessments`;
CREATE TABLE `weekly_assessments`  (
  `patient_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '患者ID',
  `week_start` date NOT NULL COMMENT '周起始日期',
  `SQ5` json NOT NULL COMMENT '7天S5Q得分',
  `MRC` json NOT NULL COMMENT '7天肌力评分',
  `FOIS` json NOT NULL COMMENT '7天吞咽功能',
  `RASS` json NOT NULL COMMENT '7天镇静躁动',
  `MMASA` json NOT NULL COMMENT '7天吞咽能力',
  `BBS1` json NOT NULL COMMENT '7天平衡量表1',
  `BBS2` json NOT NULL COMMENT '7天平衡量表2',
  `BBS3` json NOT NULL COMMENT '7天平衡量表3',
  PRIMARY KEY (`patient_id`) USING BTREE,
  CONSTRAINT `weekly_assessments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `weekly_assessments_chk_1` CHECK ((json_length(`SQ5`) = 7) and (json_length(`MRC`) = 7) and (json_length(`FOIS`) = 7) and (json_length(`RASS`) = 7) and (json_length(`MMASA`) = 7) and (json_length(`BBS1`) = 7) and (json_length(`BBS2`) = 7) and (json_length(`BBS3`) = 7))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of weekly_assessments
-- ----------------------------
INSERT INTO `weekly_assessments` VALUES ('10000', '2025-07-05', '[60, 62, 65, 63, 68, 70, 72]', '[55, 58, 60, 62, 65, 67, 70]', '[50, 55, 58, 60, 63, 65, 70]', '[45, 50, 52, 55, 58, 60, 60]', '[40, 45, 48, 50, 52, 55, 55]', '[30, 35, 38, 40, 42, 45, 40]', '[40, 45, 50, 55, 60, 65, 65]', '[50, 55, 60, 65, 70, 75, 75]');
INSERT INTO `weekly_assessments` VALUES ('10001', '2025-06-28', '[35, 38, 40, 42, 45, 48, 50]', '[25, 28, 30, 32, 35, 38, 45]', '[20, 25, 28, 30, 32, 35, 45]', '[25, 30, 32, 35, 36, 38, 40]', '[20, 22, 25, 28, 30, 32, 35]', '[15, 18, 20, 22, 24, 25, 25]', '[20, 22, 24, 25, 26, 28, 30]', '[25, 28, 30, 32, 35, 38, 40]');
INSERT INTO `weekly_assessments` VALUES ('10002', '2025-06-28', '[45, 50, 55, 60, 65, 70, 75]', '[30, 35, 40, 45, 50, 55, 60]', '[40, 45, 50, 55, 60, 65, 70]', '[40, 50, 55, 60, 65, 68, 70]', '[35, 40, 45, 50, 55, 60, 65]', '[20, 25, 30, 35, 40, 45, 50]', '[30, 35, 40, 45, 50, 53, 55]', '[50, 55, 60, 65, 70, 75, 80]');
INSERT INTO `weekly_assessments` VALUES ('10003', '2025-06-21', '[20, 22, 24, 25, 26, 28, 30]', '[15, 18, 20, 22, 24, 25, 30]', '[15, 18, 20, 22, 24, 25, 30]', '[20, 22, 24, 25, 26, 28, 35]', '[15, 18, 20, 22, 24, 25, 25]', '[10, 12, 14, 15, 16, 18, 15]', '[12, 14, 15, 16, 18, 20, 20]', '[15, 18, 20, 22, 24, 25, 25]');
INSERT INTO `weekly_assessments` VALUES ('10004', '2025-07-01', '[55, 58, 60, 62, 65, 68, 70]', '[45, 48, 50, 52, 55, 58, 60]', '[65, 68, 70, 72, 75, 78, 80]', '[60, 65, 68, 70, 72, 74, 75]', '[50, 55, 58, 60, 62, 64, 65]', '[40, 45, 48, 50, 52, 54, 55]', '[45, 50, 52, 55, 57, 59, 60]', '[60, 65, 68, 70, 72, 74, 75]');

SET FOREIGN_KEY_CHECKS = 1;
