-- MySQL dump 10.13  Distrib 5.7.18, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: epmprojbank
-- ------------------------------------------------------
-- Server version	5.1.49-community

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id_account` int(11) NOT NULL AUTO_INCREMENT,
  `number` bigint(20) DEFAULT NULL,
  `is_blocked` tinyint(1) DEFAULT '0',
  `balance` decimal(9,2) DEFAULT '0.00',
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id_account`),
  UNIQUE KEY `accounts_id_account_uindex` (`id_account`),
  KEY `fk_accounts_clients1_idx` (`client_id`),
  CONSTRAINT `fk_accounts_clients1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,26206432082001,1,0.00,1),(2,26003654789987,0,0.00,2),(3,263014528796,1,0.00,3),(4,262536521478,0,0.00,3),(5,26253652147894,1,0.00,3),(7,6,0,0.00,4),(8,7,1,0.00,5),(9,8,0,0.00,6),(10,10101010,1,0.00,6),(23,2600,1,0.00,5),(24,2600,1,0.00,5);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cards` (
  `id_card` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` decimal(16,0) DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `fee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id_card`,`fee_id`,`account_id`),
  KEY `fk_cards_fees1_idx` (`fee_id`),
  KEY `fk_cards_accounts1_idx` (`account_id`),
  CONSTRAINT `fk_cards_accounts1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id_account`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cards_fees1` FOREIGN KEY (`fee_id`) REFERENCES `fees` (`id_fee`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards`
--

LOCK TABLES `cards` WRITE;
/*!40000 ALTER TABLE `cards` DISABLE KEYS */;
INSERT INTO `cards` VALUES (1,5555444433332222,'2017-10-31',1,1),(2,9,'0178-10-12',1,2),(3,2,'0473-12-29',0,0),(4,6,'1025-11-23',0,0),(5,8,'0001-01-01',0,0),(6,1,'1240-02-10',0,0),(7,3,'1682-05-14',0,0),(8,4,'1491-07-28',0,0),(9,7,'0631-10-27',0,0),(11,4444555566667777,NULL,1,1),(24,4444555566667777,'2019-04-30',2,2),(25,4444555506045857,'2019-04-30',2,2),(26,4444555527188827,'2019-04-30',2,2),(27,4444555573106871,'2019-04-30',2,2);
/*!40000 ALTER TABLE `cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(42) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `role` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Ton Chief','1','1',7),(2,'Alex Mike','2@2.2','2',4),(3,'Greg Tripple','com@com.com ','3',9),(4,'XW71VBB64X8AENS4BDANEM9S1FIQJT9YBES9TVQ3PQ','FNBUV2PPRVMROPNCI0HIO7QT7T8NH ','',6),(5,'NPUBJX5SLIPL4 1U7XG5OHF88D6YQBLTHF9LOTV498','3SUT2YN8V1SEPWC6IB43GQP ','FOR8EYNN ',3),(6,'6FD0BU6AM5YCAVQAPEK47 H3BOJIG5XSLVC8FIR0DN','HO6Q7Q7KDX  9D1','HL0CHUA',8),(7,'OMUGJR6JSM1AOSXQ8QDYHODLMQ22 J2JA6SN3MY4LQ','I8FBPDHXFY0BIQWID7QH9E','25YJ44SLLB',1),(8,'OHTSI8JCJLPN17H3W JROVXPHOH37XJS3T1NY8QMY2','Q197MS3ANE9W7GPMP2A50D2XE63','56546546',5),(9,'SJYKU5S4BSPKT6MYNVHQSEBH3P020YUNIG3G CSFB3','WSLL04A17RXD2K2NRTJ26VFN ','56544645',0),(30,'Anton Shevchenko','2@2.2','2',0);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fees` (
  `id_fee` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `trans_fee` double DEFAULT NULL,
  `newcard_fee` double DEFAULT NULL,
  `apr` double DEFAULT NULL,
  PRIMARY KEY (`id_fee`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,'Visa Debet ',5.5,0,-10),(2,'Visa Classic',2,20,48),(3,'Visa Gold  ',1,200,36),(4,'Visa Infinite',0,1000,30),(5,'MC Gold',1,20,36);
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id_trans` int(11) NOT NULL AUTO_INCREMENT,
  `cr_account` bigint(20) DEFAULT NULL,
  `amount` decimal(9,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id_trans`,`account_id`),
  KEY `fk_transactions_accounts1_idx` (`account_id`),
  CONSTRAINT `fk_transactions_accounts1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id_account`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,5,0.00,'1373-09-02',NULL,0),(5,4,8.00,'1491-02-17',NULL,0),(6,9,5.00,'0615-09-25',NULL,0),(8,1,1.00,'0207-02-09',NULL,0),(9,8,3.00,'0800-02-05',NULL,0),(10,3,9.00,'1663-04-20',NULL,0);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-30 21:38:19
