-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `class_plan`
--

DROP TABLE IF EXISTS `class_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_plan` (
  `ID` varchar(45) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `ProjectLimitNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_plan`
--

LOCK TABLES `class_plan` WRITE;
/*!40000 ALTER TABLE `class_plan` DISABLE KEYS */;
INSERT INTO `class_plan` VALUES ('1','2017-09-13','2017-09-24',2);
/*!40000 ALTER TABLE `class_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grade` (
  `name` varchar(45) NOT NULL,
  `grade` varchar(45) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES ('优秀','80','1.在线编辑的排版问题，最好使用系统上的模板 （深入分析：本质上是标题 还有表格必须\r\n设置中心文本对齐）'),('合格','70','1.在线编辑的排版问题，最好使用系统上的模板 （深入分析：本质上是标题 还有表格必须设置中心文本对齐）'),('我们','60','vava'),('非常优秀','90','你的工作完成得非常完美');
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `ID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('1','孙艺','12345'),('2','程保中','12345');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_has_project`
--

DROP TABLE IF EXISTS `manager_has_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_has_project` (
  `manager_ID` varchar(45) NOT NULL,
  `project_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`manager_ID`,`project_ID`),
  KEY `fk_manager_has_project_project1_idx` (`project_ID`),
  KEY `fk_manager_has_project_manager_idx` (`manager_ID`),
  CONSTRAINT `fk_manager_has_project_manager` FOREIGN KEY (`manager_ID`) REFERENCES `manager` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_manager_has_project_project1` FOREIGN KEY (`project_ID`) REFERENCES `project` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_has_project`
--

LOCK TABLES `manager_has_project` WRITE;
/*!40000 ALTER TABLE `manager_has_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager_has_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_has_student`
--

DROP TABLE IF EXISTS `manager_has_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_has_student` (
  `manager_ID` varchar(45) NOT NULL,
  `student_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`manager_ID`,`student_ID`),
  KEY `fk_manager_has_student_student1_idx` (`student_ID`),
  KEY `fk_manager_has_student_manager1_idx` (`manager_ID`),
  CONSTRAINT `fk_manager_has_student_manager1` FOREIGN KEY (`manager_ID`) REFERENCES `manager` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_manager_has_student_student1` FOREIGN KEY (`student_ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_has_student`
--

LOCK TABLES `manager_has_student` WRITE;
/*!40000 ALTER TABLE `manager_has_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager_has_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `ID` varchar(45) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `TotalMark` varchar(45) DEFAULT NULL,
  `Report` mediumtext,
  `Headman` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('2015212100','企业管理',NULL,NULL,'2015212100');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_schedule`
--

DROP TABLE IF EXISTS `project_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_schedule` (
  `Date` date NOT NULL,
  `project_ID` varchar(45) NOT NULL,
  `Content` text,
  PRIMARY KEY (`Date`,`project_ID`),
  KEY `fk_project_schedule_project_idx` (`project_ID`),
  CONSTRAINT `fk_project_schedule_project` FOREIGN KEY (`project_ID`) REFERENCES `project` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_schedule`
--

LOCK TABLES `project_schedule` WRITE;
/*!40000 ALTER TABLE `project_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `ID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Report` mediumtext,
  `TotalMark` varchar(45) DEFAULT NULL,
  `project_ID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_student_project1_idx` (`project_ID`),
  CONSTRAINT `fk_student_project1` FOREIGN KEY (`project_ID`) REFERENCES `project` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2014212028','肖建国',NULL,NULL,NULL),('2014212040 ','田泸正',NULL,NULL,NULL),('2014212045','易东杨',NULL,NULL,NULL),('2014212048','妥生轩',NULL,NULL,NULL),('2015211973','明晔',NULL,NULL,NULL),('2015211974','贾玉鹏',NULL,NULL,NULL),('2015211975','杨佳宇',NULL,NULL,NULL),('2015211976','张帅',NULL,NULL,NULL),('2015211977','崔浩',NULL,NULL,NULL),('2015211978','韩瑞卿',NULL,NULL,NULL),('2015211979','钱晓锋',NULL,NULL,NULL),('2015211980','薛轶文',NULL,NULL,NULL),('2015211981','陆鹏威',NULL,NULL,NULL),('2015211985','邓渊康',NULL,NULL,NULL),('2015211986','周振靖',NULL,NULL,NULL),('2015211987','于瑞杰',NULL,NULL,NULL),('2015211988','吴碧波',NULL,NULL,NULL),('2015211989','熊昊',NULL,NULL,NULL),('2015211990','吴宏俊',NULL,NULL,NULL),('2015211991','梁夏华',NULL,NULL,NULL),('2015211992','卢冬冬',NULL,NULL,NULL),('2015211993','曾德亮',NULL,NULL,NULL),('2015211994','罗展翔',NULL,NULL,NULL),('2015211995','罗启帆',NULL,NULL,NULL),('2015211996','董丁溧',NULL,NULL,NULL),('2015211997','张敬渲',NULL,NULL,NULL),('2015211998','兰诗莹',NULL,NULL,NULL),('2015211999','孙婉婷',NULL,NULL,NULL),('2015212000','王想想',NULL,NULL,NULL),('2015212001','张懿蕾',NULL,NULL,NULL),('2015212002','吴迪',NULL,NULL,NULL),('2015212003','刘雨地',NULL,NULL,NULL),('2015212004','孙尧',NULL,NULL,NULL),('2015212005','杨天阳',NULL,NULL,NULL),('2015212007','刘鹏',NULL,NULL,NULL),('2015212008','马福辰',NULL,NULL,NULL),('2015212009','徐德鸿',NULL,NULL,NULL),('2015212010','李宇琦',NULL,NULL,NULL),('2015212011','陈兆伦',NULL,NULL,NULL),('2015212012','杨正昱',NULL,NULL,NULL),('2015212013','曾庆涛',NULL,NULL,NULL),('2015212014','徐玉琦',NULL,NULL,NULL),('2015212015','张钊',NULL,NULL,NULL),('2015212016','仝鑫',NULL,NULL,NULL),('2015212018','田展鸿',NULL,NULL,NULL),('2015212019','冯健豪',NULL,NULL,NULL),('2015212020','曾钰淇',NULL,NULL,NULL),('2015212021','向云枫',NULL,NULL,NULL),('2015212022','杨笑奇',NULL,NULL,NULL),('2015212023','刘波',NULL,NULL,NULL),('2015212024','何旭',NULL,NULL,NULL),('2015212025','韩欣容',NULL,NULL,NULL),('2015212026','薄德芳',NULL,NULL,NULL),('2015212027','陈曼菁',NULL,NULL,NULL),('2015212028','甘苑琳',NULL,NULL,NULL),('2015212030','崔云昊',NULL,NULL,NULL),('2015212031','回新宇',NULL,NULL,NULL),('2015212032','赵天昊',NULL,NULL,NULL),('2015212034','张清瑞',NULL,NULL,NULL),('2015212035','康冉昊',NULL,NULL,NULL),('2015212036','孙启明',NULL,NULL,NULL),('2015212037','杨卓',NULL,NULL,NULL),('2015212038','王涛',NULL,NULL,NULL),('2015212039','陈红云',NULL,NULL,NULL),('2015212040','张昕夏',NULL,NULL,NULL),('2015212043','何宽',NULL,NULL,NULL),('2015212044','曹锡鹏',NULL,NULL,NULL),('2015212045','邱力',NULL,NULL,NULL),('2015212046','谭上鸥',NULL,NULL,NULL),('2015212047','伍明昊',NULL,NULL,NULL),('2015212048','吴明耀',NULL,NULL,NULL),('2015212049','欧阳严龙',NULL,NULL,NULL),('2015212051','骆荣狄',NULL,NULL,NULL),('2015212052','常嘉伟',NULL,NULL,NULL),('2015212053','林纹漪',NULL,NULL,NULL),('2015212054','邓琪',NULL,NULL,NULL),('2015212055','杨霓虹',NULL,NULL,NULL),('2015212056','左佳璐',NULL,NULL,NULL),('2015212057','李博妍',NULL,NULL,NULL),('2015212058','杜恩博',NULL,NULL,NULL),('2015212059','王涵',NULL,NULL,NULL),('2015212060','李直根',NULL,NULL,NULL),('2015212061','杨溢',NULL,NULL,NULL),('2015212062','李龙寰',NULL,NULL,NULL),('2015212063','张永康',NULL,NULL,NULL),('2015212064','严渊蒙',NULL,NULL,NULL),('2015212065','陈启明',NULL,NULL,NULL),('2015212066','石文超',NULL,NULL,NULL),('2015212067','程逸涵',NULL,NULL,NULL),('2015212068','卢奕光',NULL,NULL,NULL),('2015212069','田智拓',NULL,NULL,NULL),('2015212070','高启飞',NULL,NULL,NULL),('2015212071','柯子鑫',NULL,NULL,NULL),('2015212072','李季杰',NULL,NULL,NULL),('2015212073','蔡仲谋',NULL,NULL,NULL),('2015212075','杜凌云',NULL,NULL,NULL),('2015212076','陈昱晓',NULL,NULL,NULL),('2015212077','黄志鹏',NULL,NULL,NULL),('2015212078','邹迪',NULL,NULL,NULL),('2015212079','祁麟',NULL,NULL,NULL),('2015212081','张展鸿',NULL,NULL,NULL),('2015212082','刘垚',NULL,NULL,NULL),('2015212083','来佳洁',NULL,NULL,NULL),('2015212084','苏翼涵',NULL,NULL,NULL),('2015212085','刘海伦',NULL,NULL,NULL),('2015212086','刘浩博',NULL,NULL,NULL),('2015212087','马鸿策',NULL,NULL,NULL),('2015212088','张振寰',NULL,NULL,NULL),('2015212089','相宝玉',NULL,NULL,NULL),('2015212090','杨远振',NULL,NULL,NULL),('2015212091','陈恺杰',NULL,NULL,NULL),('2015212092','闫晗',NULL,NULL,NULL),('2015212093','杨忠杰',NULL,NULL,NULL),('2015212094','徐祯辉',NULL,NULL,NULL),('2015212095','范新龙',NULL,NULL,NULL),('2015212097','熊浩',NULL,NULL,NULL),('2015212098','肖爽',NULL,NULL,NULL),('2015212100','李东山','<p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center; text-indent: 15.05pt;\"><b><span style=\"font-size: 15pt;\">软件学院实践报告（</span></b><b><span lang=\"EN-US\" style=\"font-size: 15pt;\">JAVA EE</span></b><b><span style=\"font-size: 15pt;\">）</span></b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 12pt 0cm; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>课程编号：<span lang=\"EN-US\">3152100441 </span></b><b>实践课程名称：</b><b><span lang=\"EN-US\" style=\"font-size: 15pt;\">JAVA EE</span><span lang=\"EN-US\"> </span></b><b>学年：<span lang=\"EN-US\">17  </span></b><b>学期：春</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><div align=\"center\" style=\"font-size: 13.3333px;\"><table class=\"MsoNormalTable\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-collapse: collapse; border: none;\"><tbody><tr style=\"height: 22.95pt;\"><td width=\"166\" colspan=\"2\" style=\"width: 99.75pt; border-width: 1.5pt 1pt 1pt 1.5pt; border-color: windowtext; border-style: solid; padding: 0cm 5.4pt; height: 22.95pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>学生姓名</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"239\" style=\"width: 143.25pt; border-top: 1.5pt solid windowtext; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 22.95pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><span lang=\"EN-US\"> </span></p></td><td width=\"106\" style=\"width: 63.75pt; border-top: 1.5pt solid windowtext; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 22.95pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>学号</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"239\" style=\"width: 143.25pt; border-top: 1.5pt solid windowtext; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 22.95pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><span lang=\"EN-US\"> </span></p></td></tr><tr style=\"height: 21.75pt;\"><td width=\"166\" colspan=\"2\" style=\"width: 99.75pt; border-top: none; border-left: 1.5pt solid windowtext; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 21.75pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>指导教师姓名</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"239\" style=\"width: 143.25pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 21.75pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\">程保中 孙艺<span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"106\" style=\"width: 63.75pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 21.75pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>起止时间</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"239\" style=\"width: 143.25pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 21.75pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><span lang=\"EN-US\">6.28-7.13<u1:p></u1:p></span></p></td></tr><tr style=\"height: 22.5pt;\"><td width=\"166\" colspan=\"2\" style=\"width: 99.75pt; border-top: none; border-left: 1.5pt solid windowtext; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 22.5pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>项目名称</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"584\" colspan=\"3\" style=\"width: 350.25pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 22.5pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><span lang=\"EN-US\"> </span></p></td></tr><tr style=\"height: 162.9pt;\"><td width=\"75\" style=\"width: 45pt; border-top: none; border-left: 1.5pt solid windowtext; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 162.9pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>项</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>目</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>内</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>容</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>（<span lang=\"EN-US\">200</span></b><b>字左右）</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"675\" colspan=\"4\" valign=\"top\" style=\"width: 405pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 162.9pt;\"></td></tr><tr style=\"height: 161.95pt;\"><td width=\"75\" style=\"width: 45pt; border-top: none; border-left: 1.5pt solid windowtext; border-bottom: 1pt solid windowtext; border-right: 1pt solid windowtext; padding: 0cm 5.4pt; height: 161.95pt;\"><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>结</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>论</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"center\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: center;\"><b>（<span lang=\"EN-US\">200</span></b><b>字左右）</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td><td width=\"675\" colspan=\"4\" valign=\"top\" style=\"width: 405pt; border-top: none; border-left: none; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 161.95pt;\"></td></tr><tr style=\"height: 147.55pt;\"><td width=\"750\" colspan=\"5\" valign=\"top\" style=\"width: 450pt; border-top: none; border-left: 1.5pt solid windowtext; border-bottom: 1pt solid windowtext; border-right: 1.5pt solid windowtext; padding: 0cm 5.4pt; height: 147.55pt;\"><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体;\"><b>评语<br/>我们<br/>vava</b><b><span style=\"font-family: \" times=\"\" new=\"\" roman\",=\"\" serif;\"=\"\"><span lang=\"EN-US\"><o:p></o:p></span></span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体;\"><b><br></b></p></td></tr><tr style=\"height: 64.1pt;\"><td width=\"750\" colspan=\"5\" valign=\"top\" style=\"width: 450pt; border-right: 1.5pt solid windowtext; border-bottom: 1.5pt solid windowtext; border-left: 1.5pt solid windowtext; border-image: initial; border-top: none; padding: 0cm 5.4pt; height: 64.1pt;\"><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体;\"><b>成绩（百分制）：60</b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-indent: 320.35pt;\"><b><span lang=\"EN-US\"> </span></b></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-indent: 271.05pt;\"><b>指导教师签字：</b><span lang=\"EN-US\"><u1:p></u1:p></span></p><p class=\"MsoNormal\" align=\"right\" style=\"margin: 0cm 0cm 0.0001pt; font-size: 12pt; font-family: 宋体; text-align: right; text-indent: 180.7pt;\"><b><span lang=\"EN-US\">     </span></b><b>年<span lang=\"EN-US\">    </span></b><b>月<span lang=\"EN-US\">    </span></b><b>日</b><span lang=\"EN-US\"><u1:p></u1:p></span></p></td></tr><tr height=\"0\"><td width=\"75\" style=\"border: none;\"></td><td width=\"86\" style=\"border: none;\"></td><td width=\"222\" style=\"border: none;\"></td><td width=\"106\" style=\"border: none;\"></td><td width=\"217\" style=\"border: none;\"></td></tr></tbody></table></div>','60','2015212100'),('2015212101','廖海峰',NULL,NULL,NULL),('2015212102','邓展鸿',NULL,NULL,NULL),('2015212103','胡航',NULL,NULL,NULL),('2015212104','肖圣康',NULL,NULL,NULL),('2015212105','陈润泽',NULL,NULL,NULL),('2015212106','王睿杰',NULL,NULL,NULL),('2015212107','童子豪',NULL,NULL,NULL),('2015212108','扎西南杰',NULL,NULL,NULL),('2015212109','原婷婷',NULL,NULL,NULL),('2015212110','毕月',NULL,NULL,NULL),('2015212111','张文珍',NULL,NULL,NULL),('2015212112','朱欣悦',NULL,NULL,NULL),('2015212113','赵妍',NULL,NULL,NULL),('2015522039','林安安',NULL,NULL,NULL),('2015522041','张可心',NULL,NULL,NULL),('2015522042','王宇',NULL,NULL,NULL),('2015522046','张一帆',NULL,NULL,NULL),('2015522047','富朝星',NULL,NULL,NULL),('2015522048','李梦捷',NULL,NULL,NULL),('2015522049','于若桐',NULL,NULL,NULL),('2015522050','白云龙',NULL,NULL,NULL),('2015522157','张英凯',NULL,NULL,NULL),('2015522158','刘博通',NULL,NULL,NULL),('2015522160','马晓晨',NULL,NULL,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_schedule`
--

DROP TABLE IF EXISTS `student_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_schedule` (
  `Date` date NOT NULL,
  `student_ID` varchar(45) NOT NULL,
  `Content` text,
  PRIMARY KEY (`Date`,`student_ID`),
  KEY `fk_student_schedule_student_idx` (`student_ID`),
  CONSTRAINT `fk_student_schedule_student` FOREIGN KEY (`student_ID`) REFERENCES `student` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_schedule`
--

LOCK TABLES `student_schedule` WRITE;
/*!40000 ALTER TABLE `student_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-25 16:26:17
