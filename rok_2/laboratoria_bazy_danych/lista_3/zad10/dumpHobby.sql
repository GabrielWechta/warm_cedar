-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: Hobby
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.18.04.4

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
-- Table structure for table `hasla`
--

DROP TABLE IF EXISTS `hasla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hasla` (
  `id` int(10) unsigned NOT NULL,
  `haslo` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasla`
--

LOCK TABLES `hasla` WRITE;
/*!40000 ALTER TABLE `hasla` DISABLE KEYS */;
INSERT INTO `hasla` VALUES (3,'8f997506cd6e9dbcb8e4ab9aa558f906ff10c641'),(4,'4fe4168bcfc7a27735d0ac539d8649dbf720af62'),(5,'9c3e0d161881d71dc8ac855322c357fd909d4cb7'),(23,'3970fc52a93686cde78e844dc8e488b151f316de'),(24,'d6ade867b4eacc4bc7f55dae0ac0fb3d2f435849'),(25,'72e6ac368792316ea51232a082a463ca184921ef'),(26,'85e924aa2beedfc65c62c6d073d30f993516e03b'),(27,'722ef90a9cedbae3ad642d211867a216a7bf5724'),(28,'e71304aa93e74cbe2132eb379129a3a14b11f99a'),(29,'8beb34dfdd9005efd20d15051ce43102a4a864b1'),(30,'68c97a0038960e57ece2f329766cbb881f90ef34'),(32,'427a77fc859ac26501b65aa6f84870b9c4e940f5'),(32,'427a77fc859ac26501b65aa6f84870b9c4e940f5');
/*!40000 ALTER TABLE `hasla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `hobbiesAndMultiplicity`
--

DROP TABLE IF EXISTS `hobbiesAndMultiplicity`;
/*!50001 DROP VIEW IF EXISTS `hobbiesAndMultiplicity`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `hobbiesAndMultiplicity` AS SELECT 
 1 AS `nazwa`,
 1 AS `mnogosc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `hobbiesAndNumber`
--

DROP TABLE IF EXISTS `hobbiesAndNumber`;
/*!50001 DROP VIEW IF EXISTS `hobbiesAndNumber`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `hobbiesAndNumber` AS SELECT 
 1 AS `nazwa`,
 1 AS `osoba`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hobby`
--

DROP TABLE IF EXISTS `hobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hobby` (
  `osoba` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `typ` enum('sport','nauka','inne') NOT NULL,
  PRIMARY KEY (`osoba`,`id`,`typ`),
  KEY `PersonAndIdAndType_index` (`osoba`,`id`,`typ`),
  CONSTRAINT `hobby_ibfk_1` FOREIGN KEY (`osoba`) REFERENCES `osoba` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hobby`
--

LOCK TABLES `hobby` WRITE;
/*!40000 ALTER TABLE `hobby` DISABLE KEYS */;
INSERT INTO `hobby` VALUES (3,11,'sport'),(23,1,'sport'),(24,2,'sport'),(25,3,'sport'),(25,12,'nauka'),(26,4,'sport'),(27,5,'sport'),(28,6,'sport'),(29,7,'sport'),(30,8,'sport'),(32,10,'sport');
/*!40000 ALTER TABLE `hobby` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER fillHobby AFTER INSERT ON hobby
FOR EACH ROW 
BEGIN
	IF (NEW.typ = "nauka") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM nauka) 
			THEN INSERT INTO nauka (id,nazwa) VALUES (NEW.id, "trigger_Made_Science");
		END IF;
	END IF;

	IF (NEW.typ = "sport") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM sport) 
			THEN INSERT INTO sport (id,nazwa,typ) VALUES (NEW.id, "trigger_Made_Sport",'druzynowy');
		END IF;
	END IF;

	IF (NEW.typ = "inne") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM inne) 
			THEN INSERT INTO inne (id,nazwa,towarzysze) VALUES (NEW.id, "trigger_Made_other", 1);
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER destroyHobby AFTER DELETE ON hobby
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE OLD.id = hobby.id AND typ = "sport";
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inne`
--

DROP TABLE IF EXISTS `inne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inne` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(20) NOT NULL,
  `lokacja` varchar(20) DEFAULT NULL,
  `towarzysze` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `NameAndId_index` (`nazwa`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7001 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inne`
--

LOCK TABLES `inne` WRITE;
/*!40000 ALTER TABLE `inne` DISABLE KEYS */;
INSERT INTO `inne` VALUES (1,'licze do1',NULL,1),(2,'licze do2',NULL,1),(3,'licze do3',NULL,1),(4,'licze do4',NULL,1),(5,'licze do5',NULL,1),(6,'licze do6',NULL,1),(7,'licze do7',NULL,1),(8,'licze do8',NULL,1),(9,'licze do9',NULL,1),(10,'licze do10',NULL,1),(11,'wow',NULL,1),(7000,'teksty',NULL,1);
/*!40000 ALTER TABLE `inne` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nauka`
--

DROP TABLE IF EXISTS `nauka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nauka` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(20) NOT NULL,
  `lokacja` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nauka`
--

LOCK TABLES `nauka` WRITE;
/*!40000 ALTER TABLE `nauka` DISABLE KEYS */;
INSERT INTO `nauka` VALUES (1,'1 Teoria mnogosci','PWR'),(2,'2 Teoria mnogosci','PWR'),(3,'3 Teoria mnogosci','PWR'),(4,'4 Teoria mnogosci','PWR'),(5,'5 Teoria mnogosci','PWR'),(6,'6 Teoria mnogosci','PWR'),(7,'7 Teoria mnogosci','PWR'),(8,'8 Teoria mnogosci','PWR'),(9,'9 Teoria mnogosci','PWR'),(10,'10 Teoria mnogosci','PWR'),(12,'trigger_Made_Science',NULL);
/*!40000 ALTER TABLE `nauka` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER destroyHobbyFromScienceAfterUpdate AFTER UPDATE ON nauka
FOR EACH ROW 
BEGIN
	IF (OLD.nazwa <> NEW.nazwa) THEN DELETE FROM hobby WHERE OLD.id = hobby.id AND typ = "nauka";
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER destroyHobbyFromScienceAfterDelete AFTER DELETE ON nauka
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE OLD.id = hobby.id AND typ = "nauka";
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `nazwyHobby`
--

DROP TABLE IF EXISTS `nazwyHobby`;
/*!50001 DROP VIEW IF EXISTS `nazwyHobby`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `nazwyHobby` AS SELECT 
 1 AS `osoba`,
 1 AS `nazwa`,
 1 AS `typ`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `osoba`
--

DROP TABLE IF EXISTS `osoba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osoba` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `imie` varchar(20) NOT NULL,
  `dataUrodzenia` date NOT NULL,
  `plec` char(1) NOT NULL,
  `nazwisko` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Name_index` (`imie`),
  KEY `Birth_index` (`dataUrodzenia`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osoba`
--

LOCK TABLES `osoba` WRITE;
/*!40000 ALTER TABLE `osoba` DISABLE KEYS */;
INSERT INTO `osoba` VALUES (3,'Harold','1980-03-02','m',NULL),(4,'Benny','1999-08-03','f',NULL),(5,'Gwen','1989-10-02','f',NULL),(23,'Gabi1','1999-10-26','m',NULL),(24,'Gabi2','1999-10-20','m',NULL),(25,'Gabi3','1999-10-31','m',NULL),(26,'Gabi4','1999-10-21','m',NULL),(27,'Gabi5','1999-10-25','m',NULL),(28,'Gabi6','1999-10-27','m',NULL),(29,'Gabi7','1999-10-30','m',NULL),(30,'Gabi8','1999-10-23','m',NULL),(32,'Gabi10','1999-10-29','m',NULL);
/*!40000 ALTER TABLE `osoba` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER age_trigger
BEFORE INSERT ON osoba
FOR EACH ROW 
BEGIN
IF (new.dataUrodzenia - CURDATE()) >= -180000
THEN 
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = "We are only adults here";
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER animalShelter AFTER DELETE ON osoba
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE hobby.osoba = OLD.id;
	UPDATE zwierzak SET ID = (SELECT ID FROM osoba LIMIT 1) WHERE ID = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `personAndHobbyAndAnimals`
--

DROP TABLE IF EXISTS `personAndHobbyAndAnimals`;
/*!50001 DROP VIEW IF EXISTS `personAndHobbyAndAnimals`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `personAndHobbyAndAnimals` AS SELECT 
 1 AS `imie`,
 1 AS `nazwisko`,
 1 AS `nazwa`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `personAndNUmber`
--

DROP TABLE IF EXISTS `personAndNUmber`;
/*!50001 DROP VIEW IF EXISTS `personAndNUmber`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `personAndNUmber` AS SELECT 
 1 AS `osoba`,
 1 AS `ilosc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `personAndNumberOfHobbies`
--

DROP TABLE IF EXISTS `personAndNumberOfHobbies`;
/*!50001 DROP VIEW IF EXISTS `personAndNumberOfHobbies`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `personAndNumberOfHobbies` AS SELECT 
 1 AS `osoba`,
 1 AS `ilosc`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `praca`
--

DROP TABLE IF EXISTS `praca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `praca` (
  `id_osoby` int(10) unsigned NOT NULL,
  `id_zawody` int(10) unsigned NOT NULL,
  `zarobki` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `praca`
--

LOCK TABLES `praca` WRITE;
/*!40000 ALTER TABLE `praca` DISABLE KEYS */;
INSERT INTO `praca` VALUES (3,1,950),(4,2,1900),(5,3,2700),(23,4,3800),(24,5,4700),(25,6,5600),(26,7,6500),(27,8,7400),(28,9,8300),(29,10,9900),(30,11,10100),(32,1,950),(32,2,1900);
/*!40000 ALTER TABLE `praca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sport`
--

DROP TABLE IF EXISTS `sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sport` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(20) NOT NULL,
  `typ` enum('indywidualny','druzynowy','mieszany') NOT NULL DEFAULT 'druzynowy',
  `lokacja` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IdAndName_index` (`id`,`nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport`
--

LOCK TABLES `sport` WRITE;
/*!40000 ALTER TABLE `sport` DISABLE KEYS */;
INSERT INTO `sport` VALUES (1,'szachy dla 1 osob','indywidualny',NULL),(2,'szachy dla 2 osob','indywidualny',NULL),(3,'szachy dla 3 osob','indywidualny',NULL),(4,'szachy dla 4 osob','indywidualny',NULL),(5,'szachy dla 5 osob','indywidualny',NULL),(6,'szachy dla 6 osob','indywidualny',NULL),(7,'szachy dla 7 osob','indywidualny',NULL),(8,'szachy dla 8 osob','indywidualny',NULL),(9,'szachy dla 9 osob','indywidualny',NULL),(10,'szachy dla 10 osob','indywidualny',NULL),(11,'bulle','druzynowy',NULL),(12,'flanki','druzynowy',NULL),(13,'calki na czas','druzynowy',NULL),(14,'calki ozn na czas','druzynowy',NULL),(15,'mal. grafu Caylaya','indywidualny','podziemia poli'),(16,'flanki abelowe','indywidualny','podziemia poli');
/*!40000 ALTER TABLE `sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zawody`
--

DROP TABLE IF EXISTS `zawody`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zawody` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) NOT NULL,
  `pensja_min` int(10) unsigned NOT NULL,
  `pensja_max` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zawody`
--

LOCK TABLES `zawody` WRITE;
/*!40000 ALTER TABLE `zawody` DISABLE KEYS */;
INSERT INTO `zawody` VALUES (1,'wykladowca na W1',900,1000),(2,'wykladowca na W2',1800,2000),(3,'wykladowca na W3',2700,3000),(4,'wykladowca na W4',3600,4000),(5,'wykladowca na W5',4500,5000),(6,'wykladowca na W6',5400,6000),(7,'wykladowca na W7',6300,7000),(8,'wykladowca na W8',7200,8000),(9,'wykladowca na W9',8100,9000),(10,'wykladowca na W10',9000,10000),(11,'wykladowca na W11',9900,11000);
/*!40000 ALTER TABLE `zawody` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zwierzak`
--

DROP TABLE IF EXISTS `zwierzak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zwierzak` (
  `name` varchar(20) DEFAULT NULL,
  `ID` int(10) unsigned DEFAULT NULL,
  `species` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `dataUrodzenia` varchar(20) NOT NULL,
  `plec` char(1) NOT NULL,
  KEY `ID` (`ID`),
  CONSTRAINT `zwierzak_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `osoba` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zwierzak`
--

LOCK TABLES `zwierzak` WRITE;
/*!40000 ALTER TABLE `zwierzak` DISABLE KEYS */;
INSERT INTO `zwierzak` VALUES ('Buffy',3,'dog','f','1989-05-13','1980-03-02','m'),('Fang',4,'dog','m','1990-08-27','1910-11-11','f'),('Chirpy',5,'bird','f','1998-09-11','1989-10-02','f'),('Whistler',5,'bird',NULL,'1997-12-09','1989-10-02','f'),('Slim',4,'snake','m','1996-04-29','1910-11-11','f');
/*!40000 ALTER TABLE `zwierzak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `hobbiesAndMultiplicity`
--

/*!50001 DROP VIEW IF EXISTS `hobbiesAndMultiplicity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `hobbiesAndMultiplicity` AS select `hobbiesAndNumber`.`nazwa` AS `nazwa`,count(0) AS `mnogosc` from `hobbiesAndNumber` group by `hobbiesAndNumber`.`nazwa` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `hobbiesAndNumber`
--

/*!50001 DROP VIEW IF EXISTS `hobbiesAndNumber`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `hobbiesAndNumber` AS select `nauka`.`nazwa` AS `nazwa`,`hobby`.`osoba` AS `osoba` from (`nauka` join `hobby` on((`nauka`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'nauka') union select `sport`.`nazwa` AS `nazwa`,`hobby`.`osoba` AS `osoba` from (`sport` join `hobby` on((`sport`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'sport') union select `inne`.`nazwa` AS `nazwa`,`hobby`.`osoba` AS `osoba` from (`inne` join `hobby` on((`inne`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'inne') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `nazwyHobby`
--

/*!50001 DROP VIEW IF EXISTS `nazwyHobby`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `nazwyHobby` AS select `hobby`.`osoba` AS `osoba`,`nauka`.`nazwa` AS `nazwa`,`hobby`.`typ` AS `typ` from (`hobby` join `nauka` on((`nauka`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'nauka') union select `hobby`.`osoba` AS `osoba`,`sport`.`nazwa` AS `nazwa`,`hobby`.`typ` AS `typ` from (`hobby` join `sport` on((`sport`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'sport') union select `hobby`.`osoba` AS `osoba`,`inne`.`nazwa` AS `nazwa`,`hobby`.`typ` AS `typ` from (`hobby` join `inne` on((`inne`.`id` = `hobby`.`id`))) where (`hobby`.`typ` = 'inne') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `personAndHobbyAndAnimals`
--

/*!50001 DROP VIEW IF EXISTS `personAndHobbyAndAnimals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `personAndHobbyAndAnimals` AS select `osoba`.`imie` AS `imie`,`osoba`.`nazwisko` AS `nazwisko`,`nazwyHobby`.`nazwa` AS `nazwa` from (`osoba` join `nazwyHobby` on((`osoba`.`id` = `nazwyHobby`.`osoba`))) union select `osoba`.`imie` AS `imie`,`osoba`.`nazwisko` AS `nazwisko`,`zwierzak`.`name` AS `nazwa` from (`osoba` join `zwierzak` on((`osoba`.`id` = `zwierzak`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `personAndNUmber`
--

/*!50001 DROP VIEW IF EXISTS `personAndNUmber`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `personAndNUmber` AS select `hobby`.`osoba` AS `osoba`,count(`hobby`.`osoba`) AS `ilosc` from `hobby` group by `hobby`.`osoba` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `personAndNumberOfHobbies`
--

/*!50001 DROP VIEW IF EXISTS `personAndNumberOfHobbies`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `personAndNumberOfHobbies` AS select `hobby`.`osoba` AS `osoba`,count(`hobby`.`osoba`) AS `ilosc` from `hobby` group by `hobby`.`osoba` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-20 21:57:01
