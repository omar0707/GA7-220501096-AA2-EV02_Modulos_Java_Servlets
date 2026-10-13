-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: peluqueria_canina_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Current Database: `peluqueria_canina_db`
--

/*!40000 DROP DATABASE IF EXISTS `peluqueria_canina_db`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `peluqueria_canina_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `peluqueria_canina_db`;

--
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `id_mascota` int DEFAULT NULL,
  `fecha_cita` datetime DEFAULT NULL,
  `estado` varchar(50) DEFAULT 'PENDIENTE',
  PRIMARY KEY (`id_cita`),
  KEY `id_mascota` (`id_mascota`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id_mascota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita_fotos`
--

DROP TABLE IF EXISTS `cita_fotos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita_fotos` (
  `id_foto` int NOT NULL AUTO_INCREMENT,
  `id_cita` int NOT NULL,
  `cloudinary_public_id` varchar(255) DEFAULT '',
  `tamano_bytes` bigint DEFAULT '0',
  `mime_type` varchar(50) DEFAULT 'image/jpeg',
  `subido_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_foto`),
  KEY `id_cita` (`id_cita`),
  CONSTRAINT `cita_fotos_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita_fotos`
--

LOCK TABLES `cita_fotos` WRITE;
/*!40000 ALTER TABLE `cita_fotos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cita_fotos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_mascota` int NOT NULL,
  `id_servicio` int NOT NULL,
  `id_peluquero` int DEFAULT '1',
  `id_usuario` int DEFAULT '1',
  `fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(50) DEFAULT 'PENDIENTE',
  `valor_total` decimal(10,2) DEFAULT '35000.00',
  `descuento_aplicado` decimal(10,2) DEFAULT '0.00',
  `token_acceso` varchar(64) DEFAULT 'tok_demo12345',
  `observaciones_recepcion` text,
  `observaciones_entrega` text,
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cita`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_mascota` (`id_mascota`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_mascota`) REFERENCES `mascotas` (`id_mascota`),
  CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,1,1,1,1,'2026-10-13 19:15:35','PENDIENTE',35000.00,0.00,'tok_demo12345','Corte higiÃ©nico y baÃ±o general',NULL,'2026-10-13 19:15:35','2026-10-13 19:15:35'),(2,10,10,1,NULL,1,'2026-10-13 09:34:00','PENDIENTE',40000.00,0.00,'afb5764e-1eb2-49dc-87f3-b0d75489e4d9','fsfsfsf',NULL,'2026-10-13 19:34:15','2026-10-13 19:34:15');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_telefonos`
--

DROP TABLE IF EXISTS `cliente_telefonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_telefonos` (
  `id_telefono` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `numero_telefono` varchar(20) NOT NULL,
  `tipo` varchar(20) DEFAULT 'MOVIL',
  `es_principal` tinyint(1) DEFAULT '1',
  `verificado` tinyint(1) DEFAULT '1',
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_telefono`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `cliente_telefonos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_telefonos`
--

LOCK TABLES `cliente_telefonos` WRITE;
/*!40000 ALTER TABLE `cliente_telefonos` DISABLE KEYS */;
INSERT INTO `cliente_telefonos` VALUES (1,1,'3109876543','MOVIL',1,1,'2026-10-13 19:24:54'),(2,2,'3118765432','MOVIL',1,1,'2026-10-13 19:24:54'),(3,3,'3127654321','MOVIL',1,1,'2026-10-13 19:24:54'),(4,4,'3136543210','MOVIL',1,1,'2026-10-13 19:24:54'),(5,5,'3145432109','MOVIL',1,1,'2026-10-13 19:24:54'),(6,6,'3154321098','MOVIL',1,1,'2026-10-13 19:24:54'),(7,7,'3163210987','MOVIL',1,1,'2026-10-13 19:24:54'),(8,8,'3172109876','MOVIL',1,1,'2026-10-13 19:24:54'),(9,9,'3181098765','MOVIL',1,1,'2026-10-13 19:24:54'),(10,10,'3190987654','MOVIL',1,1,'2026-10-13 19:24:54');
/*!40000 ALTER TABLE `cliente_telefonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT '1',
  `tipo_documento` varchar(10) DEFAULT 'CC',
  `numero_documento` varchar(20) DEFAULT '1020304050',
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) DEFAULT 'PÃ©rez',
  `correo` varchar(100) DEFAULT 'carlos@demo.com',
  `email` varchar(100) DEFAULT 'carlos@demo.com',
  `direccion` varchar(150) DEFAULT 'Carrera 15 # 45-20',
  `ciudad` varchar(50) DEFAULT 'BogotÃ¡',
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `observaciones` text,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,1,'CC','1020304050','Carlos','Pérez','carlos.perez@demo.com','carlos.perez@demo.com','Carrera 15 # 45-20','Bogotá','ACTIVO','Cliente frecuente','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(2,1,'CC','1030405060','Mariana','Gómez','mariana.g@demo.com','mariana.g@demo.com','Calle 72 # 11-34','Bogotá','ACTIVO','Puntual','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(3,1,'CC','1040506070','Andrés','Rodríguez','andres.r@demo.com','andres.r@demo.com','Avenida Boyacá # 68-10','Bogotá','ACTIVO','Atento a promociones','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(4,1,'CC','1050607080','Laura','Martínez','laura.m@demo.com','laura.m@demo.com','Transversal 23 # 94-15','Bogotá','ACTIVO','Mascota nerviosa','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(5,1,'CC','1060708090','Felipe','Hernández','felipe.h@demo.com','felipe.h@demo.com','Calle 134 # 19-40','Bogotá','ACTIVO','Prefiere corte bajo','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(6,1,'CC','1070809010','Valentina','López','valentina.l@demo.com','valentina.l@demo.com','Carrera 7 # 120-80','Bogotá','ACTIVO','Solicita perfume suave','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(7,1,'CC','1080901020','Diego','Ramírez','diego.r@demo.com','diego.r@demo.com','Diagonal 45 # 54-12','Bogotá','ACTIVO','Horario de tarde','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(8,1,'CC','1090102030','Camila','Torres','camila.t@demo.com','camila.t@demo.com','Calle 80 # 70-55','Bogotá','ACTIVO','Cliente recomendada','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(9,1,'CC','1101203040','Santiago','Vargas','santiago.v@demo.com','santiago.v@demo.com','Carrera 50 # 100-20','Bogotá','ACTIVO','Trae premios','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54'),(10,1,'CC','1112304050','Natalia','Castro','natalia.c@demo.com','natalia.c@demo.com','Calle 140 # 9-60','Bogotá','ACTIVO','Requiere factura','2026-10-13 19:24:54','2026-10-13 19:24:54','2026-10-13 19:24:54');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota`
--

DROP TABLE IF EXISTS `mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota` (
  `id_mascota` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `raza` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_mascota`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota`
--

LOCK TABLES `mascota` WRITE;
/*!40000 ALTER TABLE `mascota` DISABLE KEYS */;
/*!40000 ALTER TABLE `mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascotas`
--

DROP TABLE IF EXISTS `mascotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascotas` (
  `id_mascota` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_raza` int DEFAULT '1',
  `nombre` varchar(100) NOT NULL,
  `genero` varchar(10) DEFAULT 'MACHO',
  `edad_anos` int DEFAULT '2',
  `peso_kg` decimal(5,2) DEFAULT '12.00',
  `color` varchar(50) DEFAULT 'Dorado',
  `alergias_condiciones` varchar(255) DEFAULT 'Ninguna',
  `agresivo` tinyint(1) DEFAULT '0',
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mascota`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_raza` (`id_raza`),
  CONSTRAINT `mascotas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `mascotas_ibfk_2` FOREIGN KEY (`id_raza`) REFERENCES `razas` (`id_raza`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascotas`
--

LOCK TABLES `mascotas` WRITE;
/*!40000 ALTER TABLE `mascotas` DISABLE KEYS */;
INSERT INTO `mascotas` VALUES (1,1,1,'Max','MACHO',3,26.50,'Dorado','Ninguna',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(2,2,2,'Luna','HEMBRA',2,6.20,'Blanco','Sensible en oÃ­dos',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(3,3,3,'Rocky','MACHO',4,8.40,'Sal y Pimienta','Ninguna',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(4,4,4,'Zeus','MACHO',1,11.00,'Atigrado','RespiraciÃ³n corta',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(5,5,5,'Bella','HEMBRA',3,5.80,'Caramelo y Blanco','Ninguna',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(6,6,6,'Toby','MACHO',5,3.50,'Negro y Fuego','Sensible al secador',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(7,7,7,'Kira','HEMBRA',4,30.00,'Negro y CafÃ©','Ninguna',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(8,8,8,'Bruno','MACHO',2,8.90,'Leonado','Alergia a champÃº',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(9,9,9,'Milo','MACHO',3,12.30,'Tricolor','Ninguna',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10'),(10,10,10,'Sasha','HEMBRA',2,22.00,'Gris y Blanco','Muda activa',0,'ACTIVO','2026-10-13 19:30:10','2026-10-13 19:30:10');
/*!40000 ALTER TABLE `mascotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `razas`
--

DROP TABLE IF EXISTS `razas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `razas` (
  `id_raza` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `nombre_raza` varchar(100) NOT NULL,
  `tipo_pelo` varchar(50) DEFAULT 'CORTO',
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_raza`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `razas`
--

LOCK TABLES `razas` WRITE;
/*!40000 ALTER TABLE `razas` DISABLE KEYS */;
INSERT INTO `razas` VALUES (1,'Golden Retriever','Golden Retriever','LARGO','Manto denso y largo'),(2,'Poodle / Caniche','Poodle / Caniche','RIZADO','Corte con tijera'),(3,'Schnauzer','Schnauzer','DURO','Corte de raza con faldas'),(4,'Bulldog FrancÃ©s','Bulldog FrancÃ©s','CORTO','Cuidado de pliegues'),(5,'Shih Tzu','Shih Tzu','LARGO','Cepillado y corte'),(6,'Yorkshire Terrier','Yorkshire Terrier','FINO','Deslanado y peinado'),(7,'Pastor AlemÃ¡n','Pastor AlemÃ¡n','DOBLE','Deslanado profundo'),(8,'Pug','Pug','CORTO','Limpieza facial'),(9,'Beagle','Beagle','CORTO','BaÃ±o desodorizante'),(10,'Husky Siberiano','Husky Siberiano','DOBLE','Tratamiento de muda');
/*!40000 ALTER TABLE `razas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `nombre_rol` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN','Administrador del sistema','ADMIN'),(2,'RECEPCIONISTA','GestiÃ³n de turnos y clientes','RECEPCIONISTA'),(3,'PELUQUERO','AtenciÃ³n de mascotas','PELUQUERO');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id_servicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT '35000.00',
  `precio_base` decimal(10,2) NOT NULL DEFAULT '35000.00',
  `duracion_minutos` int DEFAULT '60',
  `estado` varchar(20) DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Baño y Corte General','Baño y Corte General','Baño completo con champú hipoalergénico y corte estilizado',40000.00,40000.00,60,'ACTIVO'),(2,'Baño Antipulgas y Garrapatas','Baño Antipulgas y Garrapatas','Tratamiento dérmico antiparasitario y secado rápido',45000.00,45000.00,50,'ACTIVO'),(3,'Corte de Raza Especializado','Corte de Raza Especializado','Perfilado tijera y máquina según el estándar de raza',55000.00,55000.00,90,'ACTIVO'),(4,'Deslanado Profundo y Cepillado','Deslanado Profundo y Cepillado','Remoción de pelo muerto para razas de doble manto',50000.00,50000.00,75,'ACTIVO'),(5,'Corte Higiénico y Vaciado Plantar','Corte Higiénico y Vaciado Plantar','Limpieza de zona perianal, vientre y almohadillas',25000.00,25000.00,30,'ACTIVO'),(6,'Corte y Limado de Uñas','Corte y Limado de Uñas','Mantenimiento preventivo de garras con cauterizador',15000.00,15000.00,20,'ACTIVO'),(7,'Limpieza Ótica y Dental Básica','Limpieza Ótica y Dental Básica','Higiene de pabellón auricular y spray enzimático bucal',20000.00,20000.00,25,'ACTIVO'),(8,'Hidratación con Mascarilla de Argán','Hidratación con Mascarilla de Argán','Tratamiento reconstructor para mantos maltratados o secos',35000.00,35000.00,45,'ACTIVO'),(9,'Spa Relajante con Ozonoterapia','Spa Relajante con Ozonoterapia','Baño tibio con hidromasaje y aromaterapia relajante',60000.00,60000.00,60,'ACTIVO'),(10,'Paquete CanStyling Premium VIP','Paquete CanStyling Premium VIP','Servicio integral: corte, spa, deslanado, uñas y perfume',75000.00,75000.00,120,'ACTIVO');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `telefonos`
--

DROP TABLE IF EXISTS `telefonos`;
/*!50001 DROP VIEW IF EXISTS `telefonos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `telefonos` AS SELECT 
 1 AS `id_telefono`,
 1 AS `id_cliente`,
 1 AS `numero_telefono`,
 1 AS `tipo`,
 1 AS `es_principal`,
 1 AS `verificado`,
 1 AS `creado_en`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `rol` varchar(50) DEFAULT 'ADMIN',
  `rol_id` int DEFAULT '1',
  `id_rol` int DEFAULT '1',
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `creado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT '',
  `telefono` varchar(20) DEFAULT '3001234567',
  `direccion` varchar(150) DEFAULT 'Sede Principal',
  `documento` varchar(20) DEFAULT '12345678',
  `ultimo_login` datetime DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `otp_code` varchar(10) DEFAULT NULL,
  `otp_expiracion` datetime DEFAULT NULL,
  `actualizado_en` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Administrador','admin@canstyling.com','admin@canstyling.com','Admin123*','Admin123*','ADMIN',1,1,'ACTIVO','2026-10-13 18:43:52','Administrador','','3001234567','Sede Principal','12345678',NULL,NULL,NULL,NULL,'2026-10-13 18:58:25');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `peluqueria_canina_db`
--

USE `peluqueria_canina_db`;

--
-- Final view structure for view `telefonos`
--

/*!50001 DROP VIEW IF EXISTS `telefonos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `telefonos` AS select `cliente_telefonos`.`id_telefono` AS `id_telefono`,`cliente_telefonos`.`id_cliente` AS `id_cliente`,`cliente_telefonos`.`numero_telefono` AS `numero_telefono`,`cliente_telefonos`.`tipo` AS `tipo`,`cliente_telefonos`.`es_principal` AS `es_principal`,`cliente_telefonos`.`verificado` AS `verificado`,`cliente_telefonos`.`creado_en` AS `creado_en` from `cliente_telefonos` */;
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

-- Dump completed on 2026-10-13 19:36:47
