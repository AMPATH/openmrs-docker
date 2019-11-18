-- MySQL dump 10.13  Distrib 5.6.43, for osx10.14 (x86_64)
--
-- Host: localhost    Database: amrsocl
-- ------------------------------------------------------
-- Server version	5.6.43

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
-- Table structure for table `muzima_setting`
--

DROP TABLE IF EXISTS `muzima_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `muzima_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `value_boolean` tinyint(4) DEFAULT NULL,
  `value_string` varchar(255) DEFAULT NULL,
  `setting_data_type` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `property` (`property`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_setting_creator` (`creator`),
  KEY `muzima_setting_changed_by` (`changed_by`),
  KEY `muzima_setting_retired_by` (`retired_by`),
  CONSTRAINT `muzima_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muzima_setting`
--

LOCK TABLES `muzima_setting` WRITE;
/*!40000 ALTER TABLE `muzima_setting` DISABLE KEYS */;
INSERT INTO `muzima_setting` VALUES (1,'AudioContentComplexObs.ConceptUuid','Concept Uuid for Complex Obs Audio Content','Specifies Concept Uuid for Complex Obs Audio Content',0,NULL,'STRING',1,'2018-07-17 11:56:00',NULL,NULL,0,NULL,NULL,NULL,'24caa622-691a-493b-b9ac-8ee70424ad47'),(2,'VideoContentComplexObs.ConceptUuid','Concept Uuid for Complex Obs Video Content','Specifies Concept Uuid for Complex Obs Video Content',0,NULL,'STRING',1,'2018-07-17 12:00:00',NULL,NULL,0,NULL,NULL,NULL,'eaf882a3-3360-45b3-b480-ee9e634bc74f'),(3,'ImageContentComplexObs.ConceptUuid','Concept Uuid for Complex Obs Image Content','Specifies Concept Uuid for Complex Obs Image Content',0,NULL,'STRING',1,'2018-07-17 12:02:00',NULL,NULL,0,NULL,NULL,NULL,'fd759595-6338-491b-ac37-62e699c1823c'),(4,'FileContentComplexObs.ConceptUuid','Concept Uuid for Complex Obs File Content','Specifies Concept Uuid for Complex Obs File Content',0,NULL,'STRING',1,'2018-07-17 12:07:00',NULL,NULL,0,NULL,NULL,NULL,'651fc189-127f-4b4c-98f3-121ed5ad182e');
/*!40000 ALTER TABLE `muzima_setting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-15 16:29:18
