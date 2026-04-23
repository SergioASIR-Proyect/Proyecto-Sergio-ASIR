-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: sistema_seguridad
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `id_evento` int NOT NULL AUTO_INCREMENT,
  `tipo_evento` varchar(50) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  PRIMARY KEY (`id_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'PRUEBA','2026-04-02 17:03:53'),(2,'APERTURA_PUERTA','2026-04-02 17:38:42'),(3,'APERTURA_PUERTA','2026-04-02 17:43:39'),(4,'PRUEBA','2026-04-02 17:47:31'),(5,'PRUEBA MEDIANTE URL','2026-04-02 17:48:04'),(6,'APERTURA_PUERTA','2026-04-02 18:33:18'),(7,'APERTURA_PUERTA','2026-04-02 18:33:48'),(8,'PRUEBA URL','2026-04-02 18:34:34'),(9,'PRUEBA URL','2026-04-02 19:56:40'),(10,'APERTURA_PUERTA','2026-04-02 19:56:55'),(11,'APERTURA_PUERTA','2026-04-02 20:08:04'),(12,'APERTURA_PUERTA','2026-04-02 20:19:57'),(13,'APERTURA_PUERTA','2026-04-03 14:06:45'),(14,'APERTURA_PUERTA','2026-04-03 14:07:43'),(15,'APERTURA_PUERTA','2026-04-03 14:17:56'),(16,'PRUEBACONPABLO','2026-04-04 11:40:25'),(17,'APERTURA_PUERTA','2026-04-04 11:41:09'),(18,'APERTURA_PUERTA','2026-04-12 18:29:20'),(19,'APERTURA_PUERTA','2026-04-12 18:32:12'),(20,'APERTURA_PUERTA','2026-04-12 18:43:55'),(21,'APERTURA_PUERTA','2026-04-12 22:57:56'),(22,'APERTURA_PUERTA','2026-04-12 22:57:59'),(23,'APERTURA_PUERTA','2026-04-12 22:59:37'),(24,'APERTURA_PUERTA','2026-04-19 19:49:06'),(25,'APERTURA_PUERTA','2026-04-19 20:34:43'),(26,'APERTURA_PUERTA','2026-04-19 20:36:21'),(27,'APERTURA_PUERTA','2026-04-23 21:58:22');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grabaciones`
--

DROP TABLE IF EXISTS `grabaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grabaciones` (
  `id_grabacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `ruta` varchar(255) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `id_evento` int DEFAULT NULL,
  PRIMARY KEY (`id_grabacion`),
  UNIQUE KEY `id_evento` (`id_evento`),
  CONSTRAINT `grabaciones_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grabaciones`
--

LOCK TABLES `grabaciones` WRITE;
/*!40000 ALTER TABLE `grabaciones` DISABLE KEYS */;
INSERT INTO `grabaciones` VALUES (2,'grabacion_20260402_200658.mp4','videos/grabacion_20260402_200658.mp4','2026-04-02 20:07:08',2),(3,'grabacion_20260402_200804.mp4','videos/grabacion_20260402_200804.mp4','2026-04-02 20:08:15',11),(4,'grabacion_20260402_201957.mp4','videos/grabacion_20260402_201957.mp4','2026-04-02 20:20:07',12),(7,'grabacion_20260403_141756.mp4','videos/grabacion_20260403_141756.mp4','2026-04-03 14:18:07',15),(8,'grabacion_20260404_114109.mp4','videos/grabacion_20260404_114109.mp4','2026-04-04 11:41:20',17),(9,'grabacion_20260412_182920.mp4','videos/grabacion_20260412_182920.mp4','2026-04-12 18:29:31',18),(10,'grabacion_20260412_183212.mp4','videos/grabacion_20260412_183212.mp4','2026-04-12 18:32:22',19),(11,'grabacion_20260412_184356.mp4','videos/grabacion_20260412_184356.mp4','2026-04-12 18:44:06',20),(12,'grabacion_20260412_225759.mp4','videos/grabacion_20260412_225759.mp4','2026-04-12 22:57:59',22),(13,'grabacion_20260412_225756.mp4','videos/grabacion_20260412_225756.mp4','2026-04-12 22:58:07',21),(14,'grabacion_20260412_225937.mp4','videos/grabacion_20260412_225937.mp4','2026-04-12 22:59:48',23),(15,'grabacion_20260419_194906.mp4','videos/grabacion_20260419_194906.mp4','2026-04-19 19:49:17',24),(16,'grabacion_20260419_203443.mp4','videos/grabacion_20260419_203443.mp4','2026-04-19 20:34:54',25),(17,'grabacion_20260419_203622.mp4','videos/grabacion_20260419_203622.mp4','2026-04-19 20:36:32',26),(18,'grabacion_20260423_215822.mp4','videos/grabacion_20260423_215822.mp4','2026-04-23 21:58:34',27);
/*!40000 ALTER TABLE `grabaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_estado`
--

DROP TABLE IF EXISTS `log_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_estado` (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `estado_alarma` tinyint(1) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `log_estado_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_estado`
--

LOCK TABLES `log_estado` WRITE;
/*!40000 ALTER TABLE `log_estado` DISABLE KEYS */;
INSERT INTO `log_estado` VALUES (1,1,'2026-04-02 16:40:08',1),(2,0,'2026-04-03 18:07:20',1),(3,1,'2026-04-03 18:07:27',1),(4,0,'2026-04-04 11:38:17',1),(5,1,'2026-04-04 11:38:26',1),(6,0,'2026-04-04 11:42:51',1),(7,1,'2026-04-04 11:44:45',1),(8,0,'2026-04-12 18:28:06',1),(9,1,'2026-04-12 18:29:17',1),(10,0,'2026-04-12 18:33:33',1),(11,1,'2026-04-12 18:43:47',1),(12,0,'2026-04-12 23:03:37',1),(13,1,'2026-04-12 23:06:02',1);
/*!40000 ALTER TABLE `log_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','$2y$10$KfrZLdila4DBM9j8aqR15OSv6Fa4sP/UoxyiTG5pLW8AvlXtGukqe');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-23 22:08:41
