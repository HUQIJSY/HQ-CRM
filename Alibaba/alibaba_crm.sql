/*
Navicat MySQL Data Transfer

Source Server         : HuQi
Source Server Version : 50642
Source Host           : localhost:3306
Source Database       : alibaba_crm

Target Server Type    : MYSQL
Target Server Version : 50642
File Encoding         : 65001

Date: 2019-02-15 17:29:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add campuses', '7', 'add_campuses');
INSERT INTO `auth_permission` VALUES ('20', 'Can change campuses', '7', 'change_campuses');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete campuses', '7', 'delete_campuses');
INSERT INTO `auth_permission` VALUES ('22', 'Can add class list', '8', 'add_classlist');
INSERT INTO `auth_permission` VALUES ('23', 'Can change class list', '8', 'change_classlist');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete class list', '8', 'delete_classlist');
INSERT INTO `auth_permission` VALUES ('25', 'Can add consult record', '9', 'add_consultrecord');
INSERT INTO `auth_permission` VALUES ('26', 'Can change consult record', '9', 'change_consultrecord');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete consult record', '9', 'delete_consultrecord');
INSERT INTO `auth_permission` VALUES ('28', 'Can add course record', '10', 'add_courserecord');
INSERT INTO `auth_permission` VALUES ('29', 'Can change course record', '10', 'change_courserecord');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete course record', '10', 'delete_courserecord');
INSERT INTO `auth_permission` VALUES ('31', 'Can add customer', '11', 'add_customer');
INSERT INTO `auth_permission` VALUES ('32', 'Can change customer', '11', 'change_customer');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete customer', '11', 'delete_customer');
INSERT INTO `auth_permission` VALUES ('34', 'Can add department', '12', 'add_department');
INSERT INTO `auth_permission` VALUES ('35', 'Can change department', '12', 'change_department');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete department', '12', 'delete_department');
INSERT INTO `auth_permission` VALUES ('37', 'Can add enrollment', '13', 'add_enrollment');
INSERT INTO `auth_permission` VALUES ('38', 'Can change enrollment', '13', 'change_enrollment');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete enrollment', '13', 'delete_enrollment');
INSERT INTO `auth_permission` VALUES ('40', 'Can add payment record', '14', 'add_paymentrecord');
INSERT INTO `auth_permission` VALUES ('41', 'Can change payment record', '14', 'change_paymentrecord');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete payment record', '14', 'delete_paymentrecord');
INSERT INTO `auth_permission` VALUES ('43', 'Can add study record', '15', 'add_studyrecord');
INSERT INTO `auth_permission` VALUES ('44', 'Can change study record', '15', 'change_studyrecord');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete study record', '15', 'delete_studyrecord');
INSERT INTO `auth_permission` VALUES ('46', 'Can add user profile', '16', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('47', 'Can change user profile', '16', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete user profile', '16', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('49', 'Can add menu', '17', 'add_menu');
INSERT INTO `auth_permission` VALUES ('50', 'Can change menu', '17', 'change_menu');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete menu', '17', 'delete_menu');
INSERT INTO `auth_permission` VALUES ('52', 'Can add permission', '18', 'add_permission');
INSERT INTO `auth_permission` VALUES ('53', 'Can change permission', '18', 'change_permission');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete permission', '18', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('55', 'Can add role', '19', 'add_role');
INSERT INTO `auth_permission` VALUES ('56', 'Can change role', '19', 'change_role');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete role', '19', 'delete_role');
INSERT INTO `auth_permission` VALUES ('58', 'Can add user', '20', 'add_user');
INSERT INTO `auth_permission` VALUES ('59', 'Can change user', '20', 'change_user');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete user', '20', 'delete_user');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$36000$wa1Uq0iiLswA$sfXHvPLr+aOG6l19hXUVlW3pNfpiFPHSYEQn3+eb5O0=', '2018-12-24 11:58:25.557217', '1', 'admin', '', '', '', '1', '1', '2018-12-17 07:28:09.144776');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `crm_campuses`
-- ----------------------------
DROP TABLE IF EXISTS `crm_campuses`;
CREATE TABLE `crm_campuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_campuses
-- ----------------------------
INSERT INTO `crm_campuses` VALUES ('1', '北京', '北京市昌平区沙河镇');
INSERT INTO `crm_campuses` VALUES ('2', '上海', '上海市徐汇区');
INSERT INTO `crm_campuses` VALUES ('3', '深圳', '深圳市南山区');

-- ----------------------------
-- Table structure for `crm_classlist`
-- ----------------------------
DROP TABLE IF EXISTS `crm_classlist`;
CREATE TABLE `crm_classlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course` varchar(64) NOT NULL,
  `semester` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `graduate_date` date DEFAULT NULL,
  `class_type` varchar(64) DEFAULT NULL,
  `campuses_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_classlist_course_semester_campuses_id_118b09f0_uniq` (`course`,`semester`,`campuses_id`),
  KEY `crm_classlist_campuses_id_34b62f4c_fk_crm_campuses_id` (`campuses_id`),
  CONSTRAINT `crm_classlist_campuses_id_34b62f4c_fk_crm_campuses_id` FOREIGN KEY (`campuses_id`) REFERENCES `crm_campuses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_classlist
-- ----------------------------
INSERT INTO `crm_classlist` VALUES ('1', 'PythonFullStack', '1', '20000', null, '2018-12-17', '2018-12-29', 'fulltime', '1');
INSERT INTO `crm_classlist` VALUES ('2', 'Linux', '1', '10000', null, '2019-07-30', '2019-10-30', null, '1');
INSERT INTO `crm_classlist` VALUES ('3', 'PythonFullStack', '1', '10000', null, '2018-10-01', null, null, '2');
INSERT INTO `crm_classlist` VALUES ('4', 'PythonFullStack', '2', '10000', null, '2019-01-01', '2019-10-01', 'fulltime', '2');

-- ----------------------------
-- Table structure for `crm_classlist_teachers`
-- ----------------------------
DROP TABLE IF EXISTS `crm_classlist_teachers`;
CREATE TABLE `crm_classlist_teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classlist_id` int(11) NOT NULL,
  `userprofile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_classlist_teachers_classlist_id_userprofile_id_fdeb6cf0_uniq` (`classlist_id`,`userprofile_id`),
  KEY `crm_classlist_teache_userprofile_id_4ba87056_fk_crm_userp` (`userprofile_id`),
  CONSTRAINT `crm_classlist_teache_userprofile_id_4ba87056_fk_crm_userp` FOREIGN KEY (`userprofile_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_classlist_teachers_classlist_id_4b676750_fk_crm_classlist_id` FOREIGN KEY (`classlist_id`) REFERENCES `crm_classlist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_classlist_teachers
-- ----------------------------
INSERT INTO `crm_classlist_teachers` VALUES ('4', '1', '4');
INSERT INTO `crm_classlist_teachers` VALUES ('2', '2', '4');
INSERT INTO `crm_classlist_teachers` VALUES ('3', '3', '5');
INSERT INTO `crm_classlist_teachers` VALUES ('5', '4', '3');

-- ----------------------------
-- Table structure for `crm_consultrecord`
-- ----------------------------
DROP TABLE IF EXISTS `crm_consultrecord`;
CREATE TABLE `crm_consultrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` longtext NOT NULL,
  `status` varchar(8) NOT NULL,
  `date` datetime(6) NOT NULL,
  `delete_status` tinyint(1) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `crm_consultrecord_consultant_id_0a04c00c_fk_crm_userprofile_id` (`consultant_id`),
  KEY `crm_consultrecord_customer_id_c1259023_fk_crm_customer_id` (`customer_id`),
  CONSTRAINT `crm_consultrecord_consultant_id_0a04c00c_fk_crm_userprofile_id` FOREIGN KEY (`consultant_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_consultrecord_customer_id_c1259023_fk_crm_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_consultrecord
-- ----------------------------
INSERT INTO `crm_consultrecord` VALUES ('1', 'efw', 'A', '2018-12-19 04:29:05.772494', '0', '4', '6');
INSERT INTO `crm_consultrecord` VALUES ('2', '挺好的', 'D', '2018-12-19 09:11:47.284396', '0', '5', '9');
INSERT INTO `crm_consultrecord` VALUES ('3', '打电话了', 'A', '2018-12-19 10:56:02.482403', '0', '5', '1');
INSERT INTO `crm_consultrecord` VALUES ('4', '要来了', 'B', '2018-12-19 10:57:17.555738', '0', '3', '9');
INSERT INTO `crm_consultrecord` VALUES ('5', '钱交了', 'G', '2018-12-19 11:09:44.398617', '0', '3', '16');
INSERT INTO `crm_consultrecord` VALUES ('6', '嗯嗯', 'F', '2018-12-19 11:09:57.476589', '0', '3', '1');
INSERT INTO `crm_consultrecord` VALUES ('7', 'haahahh', 'A', '2018-12-19 11:10:27.904107', '0', '3', '9');

-- ----------------------------
-- Table structure for `crm_courserecord`
-- ----------------------------
DROP TABLE IF EXISTS `crm_courserecord`;
CREATE TABLE `crm_courserecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day_num` int(11) NOT NULL,
  `date` date NOT NULL,
  `course_title` varchar(64) DEFAULT NULL,
  `course_memo` longtext,
  `has_homework` tinyint(1) NOT NULL,
  `homework_title` varchar(64) DEFAULT NULL,
  `homework_memo` longtext,
  `scoring_point` longtext,
  `re_class_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_courserecord_re_class_id_day_num_90a7cd93_uniq` (`re_class_id`,`day_num`),
  KEY `crm_courserecord_teacher_id_3ace9808_fk_crm_userprofile_id` (`teacher_id`),
  CONSTRAINT `crm_courserecord_re_class_id_f13402af_fk_crm_classlist_id` FOREIGN KEY (`re_class_id`) REFERENCES `crm_classlist` (`id`),
  CONSTRAINT `crm_courserecord_teacher_id_3ace9808_fk_crm_userprofile_id` FOREIGN KEY (`teacher_id`) REFERENCES `crm_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_courserecord
-- ----------------------------
INSERT INTO `crm_courserecord` VALUES ('1', '1', '2018-12-20', 'python基础', '', '1', 'hello world', '', '', '1', '3');
INSERT INTO `crm_courserecord` VALUES ('2', '2', '2018-12-20', 'python入门', '', '1', 'if else', '', '', '1', '3');
INSERT INTO `crm_courserecord` VALUES ('3', '1', '2018-12-20', 'Linux初识', '', '1', '安装系统', '', '', '2', '3');

-- ----------------------------
-- Table structure for `crm_customer`
-- ----------------------------
DROP TABLE IF EXISTS `crm_customer`;
CREATE TABLE `crm_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qq` varchar(64) NOT NULL,
  `qq_name` varchar(64) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `sex` varchar(16) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `source` varchar(64) NOT NULL,
  `course` varchar(21) NOT NULL,
  `class_type` varchar(64) NOT NULL,
  `customer_note` longtext,
  `status` varchar(64) NOT NULL,
  `network_consult_note` longtext,
  `date` datetime(6) NOT NULL,
  `last_consult_date` date NOT NULL,
  `next_date` date DEFAULT NULL,
  `consultant_id` int(11) DEFAULT NULL,
  `introduce_from_id` int(11) DEFAULT NULL,
  `network_consultant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qq` (`qq`),
  KEY `crm_customer_consultant_id_11f5298a_fk_crm_userprofile_id` (`consultant_id`),
  KEY `crm_customer_introduce_from_id_2ca323af_fk_crm_customer_id` (`introduce_from_id`),
  KEY `crm_customer_network_consultant_i_1b6675eb_fk_crm_userp` (`network_consultant_id`),
  CONSTRAINT `crm_customer_consultant_id_11f5298a_fk_crm_userprofile_id` FOREIGN KEY (`consultant_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_customer_introduce_from_id_2ca323af_fk_crm_customer_id` FOREIGN KEY (`introduce_from_id`) REFERENCES `crm_customer` (`id`),
  CONSTRAINT `crm_customer_network_consultant_i_1b6675eb_fk_crm_userp` FOREIGN KEY (`network_consultant_id`) REFERENCES `crm_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_customer
-- ----------------------------
INSERT INTO `crm_customer` VALUES ('1', '123123123', null, '王峰', 'male', '2018-12-17', null, 'WoM', 'PythonFullStack', 'fulltime', '', 'studying', '', '2018-12-17 07:46:05.732055', '2018-12-17', null, '3', null, null);
INSERT INTO `crm_customer` VALUES ('2', '456456456', null, null, 'female', '2018-12-02', null, 'office_direct', 'Linux,PythonFullStack', 'online', '', 'signed', '', '2018-12-17 07:47:26.163395', '2018-12-17', null, '5', null, null);
INSERT INTO `crm_customer` VALUES ('3', '789789789', null, null, 'male', '2018-12-03', null, 'public_class', 'Linux', 'weekend', '', 'studying', '', '2018-12-17 08:46:37.134928', '2018-12-17', null, '4', null, null);
INSERT INTO `crm_customer` VALUES ('4', '62728191', null, null, 'female', '2018-12-11', null, 'qq', 'PythonFullStack', 'fulltime', '', 'paid_in_full', '', '2018-12-17 08:47:10.056653', '2018-12-17', '2018-12-17', '5', null, null);
INSERT INTO `crm_customer` VALUES ('5', '122121212221', null, null, 'male', '2018-10-10', null, 'baidu_ads', 'Linux', 'online', '', 'studying', '', '2018-12-18 05:13:37.887981', '2018-12-18', null, '4', null, '3');
INSERT INTO `crm_customer` VALUES ('6', '19029103901', null, '小红', 'female', '2018-10-10', null, 'qq', 'Linux', 'fulltime', '', 'unregistered', '', '2018-12-18 08:35:59.030549', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('7', '0987654', null, null, 'female', null, null, 'baidu_ads', 'PythonFullStack', 'online', '', 'studying', '', '2018-12-18 08:36:30.866187', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('8', '12', null, null, 'male', null, null, 'qq', 'Linux', 'fulltime', '', 'unregistered', '', '2018-12-18 09:08:48.429185', '2018-12-18', null, '4', null, null);
INSERT INTO `crm_customer` VALUES ('9', '22222', null, '子怡', 'male', null, null, 'qq', 'PythonFullStack', 'fulltime', '', 'studying', '', '2018-12-18 09:09:18.810157', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('10', '876543456', null, '小孩字', 'female', null, null, 'website', 'PythonFullStack', 'online', '', 'unregistered', '', '2018-12-18 09:39:50.554143', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('11', '9876543', null, '小子', 'male', null, null, 'qq', 'Linux,PythonFullStack', 'online', '', 'unregistered', '', '2018-12-18 09:40:08.596246', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('12', '85027058', null, '小华', 'male', null, null, 'qq', 'PythonFullStack', 'fulltime', '', 'unregistered', '', '2018-12-18 11:21:29.645649', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('13', '76543', null, '小小', 'male', '2019-01-01', null, 'public_class', 'Linux,PythonFullStack', 'online', '', 'unregistered', '', '2018-12-18 12:51:12.026575', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('14', '111111', null, '小名', 'male', null, null, 'office_direct', 'PythonFullStack', 'online', '', 'studying', '', '2018-12-18 12:51:38.456079', '2018-12-18', null, null, null, null);
INSERT INTO `crm_customer` VALUES ('15', '82837292', null, '张一', 'female', null, null, 'website', 'Linux,PythonFullStack', 'weekend', '', 'signed', '', '2018-12-19 10:59:47.930409', '2018-12-19', null, '4', null, null);
INSERT INTO `crm_customer` VALUES ('16', '754544336', null, '道明', 'female', null, null, 'baidu_ads', 'PythonFullStack', 'fulltime', '', 'signed', '', '2018-12-19 11:05:53.190318', '2018-12-19', null, '4', null, null);

-- ----------------------------
-- Table structure for `crm_customer_class_list`
-- ----------------------------
DROP TABLE IF EXISTS `crm_customer_class_list`;
CREATE TABLE `crm_customer_class_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `classlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_customer_class_list_customer_id_classlist_id_965b57d6_uniq` (`customer_id`,`classlist_id`),
  KEY `crm_customer_class_l_classlist_id_d6308406_fk_crm_class` (`classlist_id`),
  CONSTRAINT `crm_customer_class_l_classlist_id_d6308406_fk_crm_class` FOREIGN KEY (`classlist_id`) REFERENCES `crm_classlist` (`id`),
  CONSTRAINT `crm_customer_class_list_customer_id_bd17a54f_fk_crm_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_customer_class_list
-- ----------------------------
INSERT INTO `crm_customer_class_list` VALUES ('1', '1', '1');
INSERT INTO `crm_customer_class_list` VALUES ('2', '2', '1');
INSERT INTO `crm_customer_class_list` VALUES ('3', '2', '2');
INSERT INTO `crm_customer_class_list` VALUES ('4', '3', '2');
INSERT INTO `crm_customer_class_list` VALUES ('5', '4', '1');
INSERT INTO `crm_customer_class_list` VALUES ('6', '5', '2');
INSERT INTO `crm_customer_class_list` VALUES ('7', '6', '2');
INSERT INTO `crm_customer_class_list` VALUES ('8', '7', '1');
INSERT INTO `crm_customer_class_list` VALUES ('9', '8', '2');
INSERT INTO `crm_customer_class_list` VALUES ('10', '9', '1');
INSERT INTO `crm_customer_class_list` VALUES ('11', '10', '1');
INSERT INTO `crm_customer_class_list` VALUES ('12', '11', '1');
INSERT INTO `crm_customer_class_list` VALUES ('13', '11', '2');
INSERT INTO `crm_customer_class_list` VALUES ('14', '12', '1');
INSERT INTO `crm_customer_class_list` VALUES ('15', '13', '1');
INSERT INTO `crm_customer_class_list` VALUES ('16', '13', '2');
INSERT INTO `crm_customer_class_list` VALUES ('17', '14', '1');
INSERT INTO `crm_customer_class_list` VALUES ('20', '15', '1');
INSERT INTO `crm_customer_class_list` VALUES ('18', '15', '2');
INSERT INTO `crm_customer_class_list` VALUES ('19', '16', '1');

-- ----------------------------
-- Table structure for `crm_department`
-- ----------------------------
DROP TABLE IF EXISTS `crm_department`;
CREATE TABLE `crm_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_department
-- ----------------------------

-- ----------------------------
-- Table structure for `crm_enrollment`
-- ----------------------------
DROP TABLE IF EXISTS `crm_enrollment`;
CREATE TABLE `crm_enrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `why_us` longtext,
  `your_expectation` longtext,
  `contract_agreed` tinyint(1) NOT NULL,
  `contract_approved` tinyint(1) NOT NULL,
  `enrolled_date` datetime(6) NOT NULL,
  `memo` longtext,
  `delete_status` tinyint(1) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `enrolment_class_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_enrollment_enrolment_class_id_customer_id_8283d1dd_uniq` (`enrolment_class_id`,`customer_id`),
  KEY `crm_enrollment_customer_id_4e9336cf_fk_crm_customer_id` (`customer_id`),
  KEY `crm_enrollment_school_id_b5e8c943_fk_crm_campuses_id` (`school_id`),
  CONSTRAINT `crm_enrollment_customer_id_4e9336cf_fk_crm_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`),
  CONSTRAINT `crm_enrollment_enrolment_class_id_8500dce0_fk_crm_classlist_id` FOREIGN KEY (`enrolment_class_id`) REFERENCES `crm_classlist` (`id`),
  CONSTRAINT `crm_enrollment_school_id_b5e8c943_fk_crm_campuses_id` FOREIGN KEY (`school_id`) REFERENCES `crm_campuses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_enrollment
-- ----------------------------
INSERT INTO `crm_enrollment` VALUES ('7', 'had鄂', '好', '1', '0', '2018-12-21 12:26:19.228481', '', '0', '1', '1', '3');
INSERT INTO `crm_enrollment` VALUES ('8', '0', '', '0', '0', '2018-12-21 12:34:23.984180', '', '0', '1', '2', '1');

-- ----------------------------
-- Table structure for `crm_paymentrecord`
-- ----------------------------
DROP TABLE IF EXISTS `crm_paymentrecord`;
CREATE TABLE `crm_paymentrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_type` varchar(64) NOT NULL,
  `paid_fee` int(11) NOT NULL,
  `note` longtext,
  `date` datetime(6) NOT NULL,
  `course` varchar(64) DEFAULT NULL,
  `class_type` varchar(64) DEFAULT NULL,
  `delete_status` tinyint(1) NOT NULL,
  `status` int(11) NOT NULL,
  `confirm_date` datetime(6) DEFAULT NULL,
  `confirm_user_id` int(11) DEFAULT NULL,
  `consultant_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `enrolment_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `crm_paymentrecord_confirm_user_id_e88e5f25_fk_crm_userprofile_id` (`confirm_user_id`),
  KEY `crm_paymentrecord_consultant_id_45289fb8_fk_crm_userprofile_id` (`consultant_id`),
  KEY `crm_paymentrecord_customer_id_cd6d33f2_fk_crm_customer_id` (`customer_id`),
  KEY `crm_paymentrecord_enrolment_class_id_36cbd119_fk_crm_class` (`enrolment_class_id`),
  CONSTRAINT `crm_paymentrecord_confirm_user_id_e88e5f25_fk_crm_userprofile_id` FOREIGN KEY (`confirm_user_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_paymentrecord_consultant_id_45289fb8_fk_crm_userprofile_id` FOREIGN KEY (`consultant_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_paymentrecord_customer_id_cd6d33f2_fk_crm_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`),
  CONSTRAINT `crm_paymentrecord_enrolment_class_id_36cbd119_fk_crm_class` FOREIGN KEY (`enrolment_class_id`) REFERENCES `crm_classlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_paymentrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `crm_studyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `crm_studyrecord`;
CREATE TABLE `crm_studyrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attendance` varchar(64) NOT NULL,
  `score` int(11) NOT NULL,
  `homework_note` varchar(255) DEFAULT NULL,
  `date` datetime(6) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `homework` varchar(100) DEFAULT NULL,
  `course_record_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_studyrecord_course_record_id_student_id_c1b4eb36_uniq` (`course_record_id`,`student_id`),
  KEY `crm_studyrecord_student_id_18b0c323_fk_crm_customer_id` (`student_id`),
  CONSTRAINT `crm_studyrecord_course_record_id_e3601e93_fk_crm_courserecord_id` FOREIGN KEY (`course_record_id`) REFERENCES `crm_courserecord` (`id`),
  CONSTRAINT `crm_studyrecord_student_id_18b0c323_fk_crm_customer_id` FOREIGN KEY (`student_id`) REFERENCES `crm_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_studyrecord
-- ----------------------------
INSERT INTO `crm_studyrecord` VALUES ('24', 'checked', '100', null, '2018-12-21 03:22:56.891125', null, '', '1', '1');
INSERT INTO `crm_studyrecord` VALUES ('25', 'checked', '100', null, '2018-12-21 03:22:56.891125', null, '', '1', '7');
INSERT INTO `crm_studyrecord` VALUES ('26', 'checked', '100', null, '2018-12-21 03:22:56.891125', null, '', '1', '9');
INSERT INTO `crm_studyrecord` VALUES ('27', 'checked', '100', null, '2018-12-21 03:22:56.891125', null, '', '1', '14');

-- ----------------------------
-- Table structure for `crm_userprofile`
-- ----------------------------
DROP TABLE IF EXISTS `crm_userprofile`;
CREATE TABLE `crm_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `name` varchar(32) NOT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `memo` longtext,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `crm_userprofile_department_id_b7469aef_fk_crm_department_id` (`department_id`),
  CONSTRAINT `crm_userprofile_department_id_b7469aef_fk_crm_department_id` FOREIGN KEY (`department_id`) REFERENCES `crm_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_userprofile
-- ----------------------------
INSERT INTO `crm_userprofile` VALUES ('3', 'alex@luffy.com', '25d55ad283aa400af464c76d713c07ad', 'alex', '18920112989', null, '2018-12-16 06:00:21.936578', '1', null);
INSERT INTO `crm_userprofile` VALUES ('4', 'wusir@luffy.com', '12345678', 'wusir', null, '', '2018-12-17 07:37:39.812611', '1', null);
INSERT INTO `crm_userprofile` VALUES ('5', 'eggon@luffy.com', '12345678', '蛋蛋', null, '', '2018-12-17 07:47:20.112801', '1', null);
INSERT INTO `crm_userprofile` VALUES ('6', 'haha@qq.com', '25d55ad283aa400af464c76d713c07ad', '蛋蛋', null, null, '2018-12-20 06:04:43.080890', '1', null);

-- ----------------------------
-- Table structure for `crm_userprofile_roles`
-- ----------------------------
DROP TABLE IF EXISTS `crm_userprofile_roles`;
CREATE TABLE `crm_userprofile_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_userprofile_roles_userprofile_id_role_id_cee8b0c7_uniq` (`userprofile_id`,`role_id`),
  KEY `crm_userprofile_roles_role_id_33eee41d_fk_rbac_role_id` (`role_id`),
  CONSTRAINT `crm_userprofile_role_userprofile_id_39ea736f_fk_crm_userp` FOREIGN KEY (`userprofile_id`) REFERENCES `crm_userprofile` (`id`),
  CONSTRAINT `crm_userprofile_roles_role_id_33eee41d_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crm_userprofile_roles
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2018-12-17 07:37:39.814588', '4', 'UserProfile object', '1', '[{\"added\": {}}]', '16', '1');
INSERT INTO `django_admin_log` VALUES ('2', '2018-12-17 07:38:58.396493', '1', 'Campuses object', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('3', '2018-12-17 07:39:19.457742', '2', 'Campuses object', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('4', '2018-12-17 07:39:30.452519', '3', 'Campuses object', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('5', '2018-12-17 07:44:45.292441', '1', 'PythonFullStack1(北京)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('6', '2018-12-17 07:45:26.899888', '2', 'Linux1(北京)', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('7', '2018-12-17 07:46:05.737035', '1', '123123123', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('8', '2018-12-17 07:47:20.113786', '5', '蛋蛋', '1', '[{\"added\": {}}]', '16', '1');
INSERT INTO `django_admin_log` VALUES ('9', '2018-12-17 07:47:26.289323', '2', '456456456', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('10', '2018-12-17 08:46:37.138945', '3', '789789789', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('11', '2018-12-17 08:47:10.180581', '4', '101010101', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('12', '2018-12-18 09:10:15.250473', '1', '123123123', '2', '[{\"changed\": {\"fields\": [\"consultant\"]}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('13', '2018-12-18 09:10:24.378381', '7', '0987654', '2', '[{\"changed\": {\"fields\": [\"consultant\"]}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('14', '2018-12-24 11:59:50.652678', '1', '公户展示', '1', '[{\"added\": {}}]', '18', '1');
INSERT INTO `django_admin_log` VALUES ('15', '2018-12-24 12:00:14.013696', '2', '私户展示', '1', '[{\"added\": {}}]', '18', '1');
INSERT INTO `django_admin_log` VALUES ('16', '2018-12-24 12:01:04.613849', '1', 'BOOS', '1', '[{\"added\": {}}]', '19', '1');
INSERT INTO `django_admin_log` VALUES ('17', '2018-12-24 12:01:20.681349', '2', '销售', '1', '[{\"added\": {}}]', '19', '1');
INSERT INTO `django_admin_log` VALUES ('18', '2018-12-24 12:02:09.270358', '3', '客户添加', '1', '[{\"added\": {}}]', '18', '1');
INSERT INTO `django_admin_log` VALUES ('19', '2018-12-24 12:02:36.807921', '4', '客户遍及', '1', '[{\"added\": {}}]', '18', '1');
INSERT INTO `django_admin_log` VALUES ('20', '2018-12-24 12:03:03.507223', '4', '客户编辑', '2', '[{\"changed\": {\"fields\": [\"title\"]}}]', '18', '1');
INSERT INTO `django_admin_log` VALUES ('21', '2018-12-24 12:03:17.015843', '2', '销售', '2', '[{\"changed\": {\"fields\": [\"permissions\"]}}]', '19', '1');
INSERT INTO `django_admin_log` VALUES ('22', '2018-12-24 12:03:20.803766', '1', 'BOOS', '2', '[{\"changed\": {\"fields\": [\"permissions\"]}}]', '19', '1');
INSERT INTO `django_admin_log` VALUES ('23', '2018-12-24 12:03:58.254176', '1', 'alex', '1', '[{\"added\": {}}]', '20', '1');
INSERT INTO `django_admin_log` VALUES ('24', '2018-12-24 12:04:11.395079', '2', 'wusir', '1', '[{\"added\": {}}]', '20', '1');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('7', 'crm', 'campuses');
INSERT INTO `django_content_type` VALUES ('8', 'crm', 'classlist');
INSERT INTO `django_content_type` VALUES ('9', 'crm', 'consultrecord');
INSERT INTO `django_content_type` VALUES ('10', 'crm', 'courserecord');
INSERT INTO `django_content_type` VALUES ('11', 'crm', 'customer');
INSERT INTO `django_content_type` VALUES ('12', 'crm', 'department');
INSERT INTO `django_content_type` VALUES ('13', 'crm', 'enrollment');
INSERT INTO `django_content_type` VALUES ('14', 'crm', 'paymentrecord');
INSERT INTO `django_content_type` VALUES ('15', 'crm', 'studyrecord');
INSERT INTO `django_content_type` VALUES ('16', 'crm', 'userprofile');
INSERT INTO `django_content_type` VALUES ('17', 'rbac', 'menu');
INSERT INTO `django_content_type` VALUES ('18', 'rbac', 'permission');
INSERT INTO `django_content_type` VALUES ('19', 'rbac', 'role');
INSERT INTO `django_content_type` VALUES ('20', 'rbac', 'user');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-12-15 08:16:36.045258');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2018-12-15 08:16:44.058253');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2018-12-15 08:16:45.591986');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2018-12-15 08:16:45.646050');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2018-12-15 08:16:46.411058');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2018-12-15 08:16:46.989833');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2018-12-15 08:16:47.615797');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2018-12-15 08:16:47.654792');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2018-12-15 08:16:48.035941');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2018-12-15 08:16:48.073919');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2018-12-15 08:16:48.146875');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2018-12-15 08:16:48.695709');
INSERT INTO `django_migrations` VALUES ('13', 'sessions', '0001_initial', '2018-12-15 08:16:49.144541');
INSERT INTO `django_migrations` VALUES ('14', 'crm', '0001_initial', '2018-12-15 08:19:03.071886');
INSERT INTO `django_migrations` VALUES ('15', 'crm', '0002_auto_20181224_1937', '2018-12-24 11:37:19.527206');
INSERT INTO `django_migrations` VALUES ('16', 'rbac', '0001_initial', '2018-12-24 11:37:23.771994');
INSERT INTO `django_migrations` VALUES ('17', 'rbac', '0002_delete_menu', '2018-12-24 11:46:50.577053');
INSERT INTO `django_migrations` VALUES ('18', 'crm', '0002_auto_20181228_2055', '2018-12-28 12:55:22.380064');
INSERT INTO `django_migrations` VALUES ('19', 'crm', '0002_auto_20181229_0950', '2018-12-29 02:01:53.083266');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('nt1ocwr0om2s1qblit9xeiopwqjti269', 'NjhhYmI0ZjhhYTgzYTNmZWU5NWQyNzcwODEyNzlkNWNjMzg1NTI1Mjp7InVzZXJfaWQiOjN9', '2019-01-11 13:46:13.749052');

-- ----------------------------
-- Table structure for `rbac_role`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role`;
CREATE TABLE `rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_role
-- ----------------------------
INSERT INTO `rbac_role` VALUES ('1', 'BOOS');
INSERT INTO `rbac_role` VALUES ('2', '销售');

-- ----------------------------
-- Table structure for `rbac_user`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_user`;
CREATE TABLE `rbac_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rbac_user
-- ----------------------------
INSERT INTO `rbac_user` VALUES ('1', 'alex', '123');
INSERT INTO `rbac_user` VALUES ('2', 'wusir', '123');
