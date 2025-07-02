/*
 Navicat Premium Data Transfer

 Source Server         : FIRST
 Source Server Type    : MySQL
 Source Server Version : 80038 (8.0.38)
 Source Host           : localhost:3306
 Source Schema         : host_management

 Target Server Type    : MySQL
 Target Server Version : 80038 (8.0.38)
 File Encoding         : 65001

 Date: 02/07/2025 21:47:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 城市', 7, 'add_city');
INSERT INTO `auth_permission` VALUES (26, 'Can change 城市', 7, 'change_city');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 城市', 7, 'delete_city');
INSERT INTO `auth_permission` VALUES (28, 'Can view 城市', 7, 'view_city');
INSERT INTO `auth_permission` VALUES (29, 'Can add 机房', 8, 'add_computerroom');
INSERT INTO `auth_permission` VALUES (30, 'Can change 机房', 8, 'change_computerroom');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 机房', 8, 'delete_computerroom');
INSERT INTO `auth_permission` VALUES (32, 'Can view 机房', 8, 'view_computerroom');
INSERT INTO `auth_permission` VALUES (33, 'Can add 主机', 9, 'add_host');
INSERT INTO `auth_permission` VALUES (34, 'Can change 主机', 9, 'change_host');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 主机', 9, 'delete_host');
INSERT INTO `auth_permission` VALUES (36, 'Can view 主机', 9, 'view_host');
INSERT INTO `auth_permission` VALUES (37, 'Can add 主机密码', 10, 'add_hostpassword');
INSERT INTO `auth_permission` VALUES (38, 'Can change 主机密码', 10, 'change_hostpassword');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 主机密码', 10, 'delete_hostpassword');
INSERT INTO `auth_permission` VALUES (40, 'Can view 主机密码', 10, 'view_hostpassword');
INSERT INTO `auth_permission` VALUES (41, 'Can add 主机统计', 11, 'add_hostgroup');
INSERT INTO `auth_permission` VALUES (42, 'Can change 主机统计', 11, 'change_hostgroup');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 主机统计', 11, 'delete_hostgroup');
INSERT INTO `auth_permission` VALUES (44, 'Can view 主机统计', 11, 'view_hostgroup');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$600000$nMw3IpqjRXVRw4gmbWPiM6$txhl8Dl6U+Dqs45t2Ex/MalW9sRQPLs2VidE4ATz35U=', '2025-07-02 10:16:28.403442', 1, 'xq_sile', '', '', '2908582611@qq.com', 1, 1, '2025-07-02 10:14:52.708418');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2025-07-02 10:18:46.788593', '1', '深圳', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (2, '2025-07-02 10:19:04.725158', '1', '深圳-机房A', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (3, '2025-07-02 10:21:02.139712', '1', '主机A (192.168.91.80)', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (4, '2025-07-02 11:06:28.620423', '2', '主机B (192.168.91.74)', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (5, '2025-07-02 13:36:03.347434', '2', '主机B (192.168.91.133)', 2, '[{\"changed\": {\"fields\": [\"IP\\u5730\\u5740\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (6, '2025-07-02 13:42:57.384112', '1', '主机A (192.168.91.74)', 2, '[{\"changed\": {\"fields\": [\"IP\\u5730\\u5740\"]}}]', 9, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'hosts', 'city');
INSERT INTO `django_content_type` VALUES (8, 'hosts', 'computerroom');
INSERT INTO `django_content_type` VALUES (9, 'hosts', 'host');
INSERT INTO `django_content_type` VALUES (11, 'hosts', 'hostgroup');
INSERT INTO `django_content_type` VALUES (10, 'hosts', 'hostpassword');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-07-02 07:17:57.720462');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2025-07-02 07:17:59.099496');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2025-07-02 07:17:59.363803');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-07-02 07:17:59.374815');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-07-02 07:17:59.385776');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-07-02 07:17:59.504434');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-07-02 07:17:59.615432');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-07-02 07:17:59.645214');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-07-02 07:17:59.655249');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-07-02 07:17:59.751505');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-07-02 07:17:59.758999');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-07-02 07:17:59.771958');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-07-02 07:17:59.885102');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-07-02 07:17:59.996754');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-07-02 07:18:00.023660');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-07-02 07:18:00.035623');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-07-02 07:18:00.143939');
INSERT INTO `django_migrations` VALUES (18, 'hosts', '0001_initial', '2025-07-02 07:18:00.996990');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2025-07-02 07:18:01.073825');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('pox05q0eglmmvnarr8tqwmcl9cgajeoc', '.eJxVjDsOwjAQBe_iGlnr78aU9JzBWv9wANlSnFSIu0OkFNC-mXkv5mlbq99GXvyc2JkJdvrdAsVHbjtId2q3zmNv6zIHviv8oINfe8rPy-H-HVQa9Vs7SJOMxRirgURCBKcBktBaCUmyKFvQgFE5IGK0zk1ZkI5ki8whSsveH7PqNw8:1uWuVw:BpZoshsXv3hcTLnCHfmzP4VsrJr8phNHAtnklvJ5Z3o', '2025-07-16 10:16:28.412412');

-- ----------------------------
-- Table structure for hosts_city
-- ----------------------------
DROP TABLE IF EXISTS `hosts_city`;
CREATE TABLE `hosts_city`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hosts_city
-- ----------------------------
INSERT INTO `hosts_city` VALUES (1, '深圳', '', '2025-07-02 10:18:46.787594', '2025-07-02 10:18:46.787594');

-- ----------------------------
-- Table structure for hosts_computerroom
-- ----------------------------
DROP TABLE IF EXISTS `hosts_computerroom`;
CREATE TABLE `hosts_computerroom`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `city_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  UNIQUE INDEX `hosts_computerroom_city_id_name_b50a23d8_uniq`(`city_id` ASC, `name` ASC) USING BTREE,
  CONSTRAINT `hosts_computerroom_city_id_d415880d_fk_hosts_city_id` FOREIGN KEY (`city_id`) REFERENCES `hosts_city` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hosts_computerroom
-- ----------------------------
INSERT INTO `hosts_computerroom` VALUES (1, '机房A', '地址A', '2025-07-02 10:19:04.724161', '2025-07-02 10:19:04.724161', 1);

-- ----------------------------
-- Table structure for hosts_host
-- ----------------------------
DROP TABLE IF EXISTS `hosts_host`;
CREATE TABLE `hosts_host`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ip_address` char(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `os_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `computer_room_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  UNIQUE INDEX `ip_address`(`ip_address` ASC) USING BTREE,
  INDEX `hosts_host_computer_room_id_94350175_fk_hosts_computerroom_id`(`computer_room_id` ASC) USING BTREE,
  CONSTRAINT `hosts_host_computer_room_id_94350175_fk_hosts_computerroom_id` FOREIGN KEY (`computer_room_id`) REFERENCES `hosts_computerroom` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hosts_host
-- ----------------------------
INSERT INTO `hosts_host` VALUES (1, '主机A', '192.168.91.74', 'Windows', 'Active', '2025-07-02 10:21:02.138716', '2025-07-02 13:42:57.382473', 1);
INSERT INTO `hosts_host` VALUES (2, '主机B', '192.168.91.133', 'Linux', 'Active', '2025-07-02 11:06:28.615435', '2025-07-02 13:36:03.346437', 1);

-- ----------------------------
-- Table structure for hosts_hostgroup
-- ----------------------------
DROP TABLE IF EXISTS `hosts_hostgroup`;
CREATE TABLE `hosts_hostgroup`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `host_count` int NOT NULL,
  `date` date NOT NULL,
  `city_id` bigint NULL DEFAULT NULL,
  `computer_room_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hosts_hostgroup_city_id_group_type_date_71d3cef7_uniq`(`city_id` ASC, `group_type` ASC, `date` ASC) USING BTREE,
  UNIQUE INDEX `hosts_hostgroup_computer_room_id_group_type_date_0a0c0181_uniq`(`computer_room_id` ASC, `group_type` ASC, `date` ASC) USING BTREE,
  CONSTRAINT `hosts_hostgroup_city_id_350eded6_fk_hosts_city_id` FOREIGN KEY (`city_id`) REFERENCES `hosts_city` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hosts_hostgroup_computer_room_id_a8855c38_fk_hosts_com` FOREIGN KEY (`computer_room_id`) REFERENCES `hosts_computerroom` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hosts_hostgroup
-- ----------------------------
INSERT INTO `hosts_hostgroup` VALUES (1, 'City', 2, '2025-07-02', 1, NULL);
INSERT INTO `hosts_hostgroup` VALUES (2, 'ComputerRoom', 2, '2025-07-02', NULL, 1);

-- ----------------------------
-- Table structure for hosts_hostpassword
-- ----------------------------
DROP TABLE IF EXISTS `hosts_hostpassword`;
CREATE TABLE `hosts_hostpassword`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `root_password` longblob NOT NULL,
  `changed_at` datetime(6) NOT NULL,
  `expiration_time` datetime(6) NULL DEFAULT NULL,
  `host_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `host_id`(`host_id` ASC) USING BTREE,
  CONSTRAINT `hosts_hostpassword_host_id_3982395c_fk_hosts_host_id` FOREIGN KEY (`host_id`) REFERENCES `hosts_host` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hosts_hostpassword
-- ----------------------------
INSERT INTO `hosts_hostpassword` VALUES (1, 0x800000000068652CFB76986A5EF65388618834C4F4E2BADB8100477F6C973505075D1AD2927F0714CA1FB78F342ED4537F8D734FE4B3C75A3436700DA2B7B26DB9ECFE9403C4EF56C689B3C29FE9A53F7F3246B17E2A7D607A, '2025-07-02 12:58:35.932353', '2025-07-02 20:58:35.932353', 2);

SET FOREIGN_KEY_CHECKS = 1;
