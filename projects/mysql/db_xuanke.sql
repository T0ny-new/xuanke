/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.1.0 : Database - db_xuanke
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_xuanke` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_xuanke`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add colleges',7,'add_colleges'),
(26,'Can change colleges',7,'change_colleges'),
(27,'Can delete colleges',7,'delete_colleges'),
(28,'Can view colleges',7,'view_colleges'),
(29,'Can add grades',8,'add_grades'),
(30,'Can change grades',8,'change_grades'),
(31,'Can delete grades',8,'delete_grades'),
(32,'Can view grades',8,'view_grades'),
(33,'Can add majors',9,'add_majors'),
(34,'Can change majors',9,'change_majors'),
(35,'Can delete majors',9,'delete_majors'),
(36,'Can view majors',9,'view_majors'),
(37,'Can add projects',10,'add_projects'),
(38,'Can change projects',10,'change_projects'),
(39,'Can delete projects',10,'delete_projects'),
(40,'Can view projects',10,'view_projects'),
(41,'Can add users',11,'add_users'),
(42,'Can change users',11,'change_users'),
(43,'Can delete users',11,'delete_users'),
(44,'Can view users',11,'view_users'),
(45,'Can add teachers',12,'add_teachers'),
(46,'Can change teachers',12,'change_teachers'),
(47,'Can delete teachers',12,'delete_teachers'),
(48,'Can view teachers',12,'view_teachers'),
(49,'Can add work palns',13,'add_workpalns'),
(50,'Can change work palns',13,'change_workpalns'),
(51,'Can delete work palns',13,'delete_workpalns'),
(52,'Can view work palns',13,'view_workpalns'),
(53,'Can add students',14,'add_students'),
(54,'Can change students',14,'change_students'),
(55,'Can delete students',14,'delete_students'),
(56,'Can view students',14,'view_students'),
(57,'Can add select logs',15,'add_selectlogs'),
(58,'Can change select logs',15,'change_selectlogs'),
(59,'Can delete select logs',15,'delete_selectlogs'),
(60,'Can view select logs',15,'view_selectlogs');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$600000$ofwJC80cC2NLqJwljQeXti$zLztx+oMk+BVCyvxPVrT4wsgSq9s7e3eKdIqsABB7K0=','2024-01-17 14:33:58.358763',1,'admin','','','123456@qq.com',1,1,'2024-01-17 14:33:40.854183');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `colleges` */

DROP TABLE IF EXISTS `colleges`;

CREATE TABLE `colleges` (
  `id` varchar(13) NOT NULL,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `colleges` */

insert  into `colleges`(`id`,`name`,`create_time`) values 
('1705484541','文学院','2024-01-17 17:42:21'),
('1705484560','计算机科学学院','2024-01-17 17:42:40'),
('1705484575','生物科学学院','2024-01-17 17:42:55');

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(7,'app','colleges'),
(8,'app','grades'),
(9,'app','majors'),
(10,'app','projects'),
(15,'app','selectlogs'),
(14,'app','students'),
(12,'app','teachers'),
(11,'app','users'),
(13,'app','workpalns'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2024-01-17 14:32:09.628425'),
(2,'auth','0001_initial','2024-01-17 14:32:10.304225'),
(3,'admin','0001_initial','2024-01-17 14:32:10.448088'),
(4,'admin','0002_logentry_remove_auto_add','2024-01-17 14:32:10.448088'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-01-17 14:32:10.463747'),
(6,'app','0001_initial','2024-01-17 14:32:11.237118'),
(7,'contenttypes','0002_remove_content_type_name','2024-01-17 14:32:11.300096'),
(8,'auth','0002_alter_permission_name_max_length','2024-01-17 14:32:11.363699'),
(9,'auth','0003_alter_user_email_max_length','2024-01-17 14:32:11.383329'),
(10,'auth','0004_alter_user_username_opts','2024-01-17 14:32:11.398990'),
(11,'auth','0005_alter_user_last_login_null','2024-01-17 14:32:11.445817'),
(12,'auth','0006_require_contenttypes_0002','2024-01-17 14:32:11.461472'),
(13,'auth','0007_alter_validators_add_error_messages','2024-01-17 14:32:11.461472'),
(14,'auth','0008_alter_user_username_max_length','2024-01-17 14:32:11.523923'),
(15,'auth','0009_alter_user_last_name_max_length','2024-01-17 14:32:11.570787'),
(16,'auth','0010_alter_group_name_max_length','2024-01-17 14:32:11.586444'),
(17,'auth','0011_update_proxy_permissions','2024-01-17 14:32:11.602030'),
(18,'auth','0012_alter_user_first_name_max_length','2024-01-17 14:32:11.664513'),
(19,'sessions','0001_initial','2024-01-17 14:32:11.695756');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('55aj3fugab8jy4rdco7zl6wwg8lv4nrf','e30:1swzqm:Nf5s_L9BHZAhb-R8PLjFAys4gSG7vYPlxcv59mZYQwo','2024-10-19 16:09:16.672070'),
('97022f1xod503njv8fm4g1f5s5oygrfu','.eJxVjrtug0AQRf9lawvt--EyfdKmsYRmdsdA4oDFQmFZ_ncPMoXTnnPnzr2LFtalb9dKczsUcRRKHN4ZQv6lcRPlB8ZuavI0LvOAzRZpdlubz6nQ5WPP_ivoofZ8HX1J7owGCWQsKgVPUucco7SIGLBINFlCtj5pisYU42RGGXU2lvQZuXSrE8e7eM30JsqYXJI-qV1-wR-xugwdL2V2hVq_p7m8s_GVOa0-WDqtTitgCh1DGw6i4_3bFw4EZwKr5XZlpx6PJ04TXVw:1rQ77w:rI8mQtUeJ0QAH0SDfRoHuQI_7n_deH4arnN3B30tWkE','2024-01-31 22:42:48.676435'),
('hckw22r1msufmfradsz9oso78fyd9can','.eJwlzTEOgCAMBdC7dHaoQBE8hKsLC0aiDiIRGYzx7lZdOvz3f3pByWGH9oJlhBZqLQ0aSxa1Rag-7PwamNJ5zFsUQnCcfM79tn8LIRVpzuJfc6UZfM1XoXaFFBk2PzFJU8EU4vi-e2skG6bjTGx43w-XzicF:1sxgqz:CiMQy-GRwrpGk8JtzBNK1YLeck33JUK4qzuiaHgV7Kw','2024-10-21 14:04:21.424495');

/*Table structure for table `grades` */

DROP TABLE IF EXISTS `grades`;

CREATE TABLE `grades` (
  `id` varchar(13) NOT NULL,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `grades` */

insert  into `grades`(`id`,`name`,`create_time`) values 
('1705484664','18级汉语言文学一班','2024-01-17 17:44:24'),
('1705484672','18级汉语言文学二班','2024-01-17 17:44:32'),
('1705484714','19级计算机技术一班','2024-01-17 17:45:14'),
('1705484728','20级生物科学一班','2024-01-17 17:45:28');

/*Table structure for table `majors` */

DROP TABLE IF EXISTS `majors`;

CREATE TABLE `majors` (
  `id` varchar(13) NOT NULL,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `majors` */

insert  into `majors`(`id`,`name`,`create_time`) values 
('1705484592','汉语言文学','2024-01-17 17:43:12'),
('1705484623','计算机技术','2024-01-17 17:43:43'),
('1705484640','生物疫苗技术','2024-01-17 17:44:00');

/*Table structure for table `projects` */

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `id` varchar(13) NOT NULL,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `projects` */

insert  into `projects`(`id`,`name`,`create_time`) values 
('1705494401','古代汉语','2024-01-17 20:26:41'),
('1705494406','现代汉语','2024-01-17 20:26:46'),
('1705494417','中国古代诗词','2024-01-17 20:26:57'),
('1705494432','python开发基础','2024-01-17 20:27:12'),
('1705494462','动物医疗导论','2024-01-17 20:27:42');

/*Table structure for table `select_logs` */

DROP TABLE IF EXISTS `select_logs`;

CREATE TABLE `select_logs` (
  `id` varchar(13) NOT NULL,
  `plan_id` varchar(13) NOT NULL,
  `student_id` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `select_logs_plan_id_fda420ff_fk_work_palns_id` (`plan_id`),
  KEY `select_logs_student_id_3c6886d6_fk_students_id` (`student_id`),
  CONSTRAINT `select_logs_plan_id_fda420ff_fk_work_palns_id` FOREIGN KEY (`plan_id`) REFERENCES `work_palns` (`id`),
  CONSTRAINT `select_logs_student_id_3c6886d6_fk_students_id` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `select_logs` */

insert  into `select_logs`(`id`,`plan_id`,`student_id`) values 
('1705494933','1705494671','1638089590692'),
('1705494951','1705494886','1638089590694'),
('1705495292','1705494681','1638089590695'),
('1705495295','1705494671','1638089590695');

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `id` varchar(13) NOT NULL,
  `college_id` varchar(13) NOT NULL,
  `grade_id` varchar(13) NOT NULL,
  `major_id` varchar(13) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `students_college_id_c8d7be0c_fk_colleges_id` (`college_id`),
  KEY `students_grade_id_0af4093a_fk_grades_id` (`grade_id`),
  KEY `students_major_id_29b04427_fk_majors_id` (`major_id`),
  CONSTRAINT `students_college_id_c8d7be0c_fk_colleges_id` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`),
  CONSTRAINT `students_grade_id_0af4093a_fk_grades_id` FOREIGN KEY (`grade_id`) REFERENCES `grades` (`id`),
  CONSTRAINT `students_id_1214cad7_fk_users_id` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  CONSTRAINT `students_major_id_29b04427_fk_majors_id` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `students` */

insert  into `students`(`id`,`college_id`,`grade_id`,`major_id`) values 
('1638089590692','1705484541','1705484664','1705484592'),
('1638089590694','1705484575','1705484728','1705484640'),
('1638089590695','1705484541','1705484664','1705484592');

/*Table structure for table `teachers` */

DROP TABLE IF EXISTS `teachers`;

CREATE TABLE `teachers` (
  `id` varchar(13) NOT NULL,
  `record` varchar(8) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `address` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `teachers_id_21149ded_fk_users_id` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `teachers` */

insert  into `teachers`(`id`,`record`,`phone`,`address`) values 
('1638089590691','研究生','90291029301','外滩路566号'),
('1638089590693','研究生','90291029300','上海路22号');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` varchar(13) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `pass_word` varchar(32) NOT NULL,
  `name` varchar(20) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(4) NOT NULL,
  `type` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`user_name`,`pass_word`,`name`,`age`,`gender`,`type`) values 
('1638089590690','T0ny','123456','管理员',38,'男',0),
('1638089590691','ligang','ligang','李刚',47,'男',1),
('1638089590692','zhangsan','zhangsan','张三',18,'男',2),
('1638089590693','linxi','linxi','林溪',42,'女',1),
('1638089590694','lisi','lisi','李四',19,'女',2),
('1638089590695','hewei','hewei','何伟',20,'女',2);

/*Table structure for table `work_palns` */

DROP TABLE IF EXISTS `work_palns`;

CREATE TABLE `work_palns` (
  `id` varchar(13) NOT NULL,
  `grade_id` varchar(13) NOT NULL,
  `project_id` varchar(13) NOT NULL,
  `teacher_id` varchar(13) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `work_palns_grade_id_b27ef61c_fk_grades_id` (`grade_id`),
  KEY `work_palns_project_id_7f717ceb_fk_projects_id` (`project_id`),
  KEY `work_palns_teacher_id_c5828d9d_fk_teachers_id` (`teacher_id`),
  CONSTRAINT `work_palns_grade_id_b27ef61c_fk_grades_id` FOREIGN KEY (`grade_id`) REFERENCES `grades` (`id`),
  CONSTRAINT `work_palns_project_id_7f717ceb_fk_projects_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `work_palns_teacher_id_c5828d9d_fk_teachers_id` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `work_palns` */

insert  into `work_palns`(`id`,`grade_id`,`project_id`,`teacher_id`) values 
('1705494671','1705484664','1705494417','1638089590691'),
('1705494681','1705484664','1705494406','1638089590691'),
('1705494886','1705484728','1705494462','1638089590693');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
