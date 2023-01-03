-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: quanlynhasach
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Khoa Học'),(2,'Lịch Sử'),(3,'Truyện Tranh'),(4,'Văn hóa');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'Quá đỉnh shop ơi!!!',4,1,'2022-01-15 12:07:58','2022-01-15 12:07:58'),(2,'Sách quá hay!!!',4,2,'2022-01-15 12:53:58','2022-01-15 12:53:58'),(3,'Gút chóp!!!',4,3,'2022-01-15 12:53:58','2022-01-15 12:53:58'),(4,'Hết nước chấm!!!',4,4,'2022-01-15 12:53:58','2022-01-15 12:53:58'),(5,'Truyện hay quá man!!!',4,1,'2022-01-15 15:05:37','2022-01-15 15:05:37'),(6,'Hay',4,1,'2022-01-15 15:39:36','2022-01-15 15:39:36'),(7,'Hay',4,1,'2022-01-15 15:39:36','2022-01-15 15:39:36'),(8,'Hay',4,1,'2022-01-15 15:39:36','2022-01-15 15:39:36'),(9,'5 sao',4,2,'2022-01-16 07:32:33','2022-01-16 07:32:33'),(10,'Vip',4,4,'2022-01-16 07:32:33','2022-01-16 07:32:33'),(11,'quá đỉnh shop ơi',1,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(12,'bổ ích quá',2,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(13,'tuyệt vời',3,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(14,'rất ý nghĩa',5,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(15,'quá hay luôn',6,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(16,'đắt quá shop',7,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(17,'5 sao',8,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(18,'có cho mua trả góp ko shop',67,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(19,'cạn lời',68,1,'2022-01-16 11:22:18','2022-01-16 11:22:18'),(20,'!!!!!!!!!!!!!!!!!!',69,1,'2022-01-16 11:22:18','2022-01-16 11:22:18');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` float DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'7 Bài học hay vật lý','Mục Lục Vật Lý Lớp 7! Tại đây bạn sẽ tìm được những thứ mới về quang học, âm học, điện học. Một khái niệm hoàn toàn mới so với chương trình vật lý lớp 6, bạn sẽ tìm hiểu kiến thức liên quan đến ánh sáng, phản xạ ánh sáng, vì sao thấy chính mình trong....',30000,1,'images/vatlyhoc.jpg','2022-01-13 00:12:55',1),(2,'Hóa học 8','Sách Giáo Khoa Hóa Học Lớp 8 được Bộ Giáo Dục và Đào Tạo biên soạn.Sách gồm 6 chương:Chất – Nguyên Tử – Phân Tử, Phản Ứng Hóa Học, Mol Và Tính Toán Hóa Học, Oxi – Không Khí , Hidro – Nước và Dung Dịch.....',30000,1,'images/hoahoc.jpg','2022-01-13 00:12:55',1),(3,'Thế chiến thứ hai','Chiến tranh thế giới thứ hai (còn được nhắc đến với các tên gọi Đệ nhị thế chiến, Thế chiến II hay Đại chiến thế giới lần thứ hai) là một cuộc chiến tranh thế giới bắt đầu từ khoảng năm 1939 và chấm dứt vào năm 1945....',40000,1,'images/thechien.jpg','2022-01-13 00:12:55',2),(4,'Naruto','Naruto là một bộ truyện tranh Nhật Bản được viết và minh họa bởi Masashi Kishimoto. Nó kể về câu chuyện của Naruto Uzumaki, một ninja trẻ tuổi tìm kiếm sự công nhận từ các đồng nghiệp của mình và ước mơ trở thành Hokage, người lãnh đạo làng của mình.....',20000,1,'images/naruto.jpg','2022-01-13 00:12:55',3),(5,'Đất nước Nhật Bản','Người Nhật Bản mang tinh thần tự lực tự cường, không chùn bước trước những khó khăn thử thách, sẵn sàng đương đầu trước thiên tai như động đất, núi lửa luôn luôn rình rập.  Người Nhật Bản kiên trì, nhẫn nại, không qua loa \"đại khái\", đã làm sẽ làm đến....',35000,1,'images/nhatban.jpg','2022-01-13 00:12:55',4),(6,'Giải toán Einstein','Trong môn toán ở bậc tiểu học các bài toán có lời văn có một vị trí rất quan trọng. Bởi vì: Việc giải toán giúp học sinh củng cố, vận dụng và hiểu sâu sắc thêm tất cả các kiến thức về số học, về đo lường, về hình học đã được học trong môn toán ở tiểu.....',30000,1,'images/toanhoc.jpg','2022-01-13 00:12:55',1),(7,'Trí tuệ nhân tạo','Trong khoa học máy tính, trí tuệ nhân tạo hay AI (tiếng Anh: artificial intelligence), đôi khi được gọi là trí thông minh nhân tạo, là trí thông minh được thể hiện bằng máy móc, trái ngược với trí thông minh tự nhiên của con người.....',40000,1,'images/AI.jpg','2022-01-13 00:12:55',1),(8,'Văn hóa Việt Nam','Văn hoá đọc là một khái niệm có hai nghĩa, một nghĩa rộng và một nghĩa hẹp. Ở nghĩa rộng, đó là ứng xử đọc, giá trị đọc và chuẩn mực đọc của mỗi cá nhân, của cộng đồng xã hội và của các nhà quản lý và cơ quan quản lý nhà nước....',30000,1,'images/vanhoavn.jpg','2022-01-13 00:12:55',4),(67,'Conan Vol 98','Sera Masumi tiếp tục thăm dò Haibara Ai và ở thế đối đầu với Okiya Subaru! Trong khi đó, Conan đã tiến đến gần chân tướng của “em gái ngoài lãnh địa” - Mary…!? Haneda Shukichi bất ngờ gặp án mạng tại buổi học nhóm shogi! Vụ án diễn biến bất ngờ với.....',20000,1,'images/98.jpg','2022-01-16 11:22:18',3),(68,'Conan Vol 99','Chuyện gì đã xảy ra trên cầu Vauxhall ở London…? Bí ẩn bao trùm hai mẹ con Mary và Masumi Sera sẽ được làm sáng tỏ trong chương phá giải vụ án đầu độc tại bữa tiệc của người mẫu! Tìm đến nơi Kazami đang lâm nạn, Toru Amuro tình cờ gặp Conan và nhóm......',20000,1,'images/99.jpg','2022-01-16 11:22:18',3),(69,'Conan Vol 100','Mở đầu câu truyện, cậu học sinh trung học 16 tuổi Shinichi Kudo bị biến thành cậu bé Conan Edogawa. Shinichi trong phần đầu của Thám tử lừng danh Conan được miêu tả là một thám tử học đường. Trong một lần đi chơi công viên \"Miền Nhiệt đới\" với cô bạn.....',50000,1,'images/100.jpg','2022-01-16 11:22:18',3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_tag`
--

DROP TABLE IF EXISTS `product_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_tag` (
  `product_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `product_tag_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_tag`
--

LOCK TABLES `product_tag` WRITE;
/*!40000 ALTER TABLE `product_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1,'2022-01-15 09:17:38',1),(2,'2022-01-16 07:44:14',4),(3,'2022-01-16 08:18:31',4),(4,'2022-01-16 08:35:03',3),(5,'2022-01-16 08:38:59',3),(6,'2022-01-16 09:17:20',3),(7,'2022-01-16 09:17:20',3),(8,'2022-01-16 09:17:20',3),(9,'2022-01-16 09:17:20',3),(10,'2022-01-16 09:17:20',3),(11,'2022-01-16 09:17:20',3),(12,'2022-01-16 09:17:20',3),(13,'2022-01-16 09:17:20',3),(14,'2022-01-16 09:17:20',3),(15,'2022-01-16 09:17:20',3),(16,'2022-01-16 09:17:20',3),(17,'2022-01-16 09:17:20',3),(18,'2022-01-16 09:17:20',3),(19,'2022-01-16 09:17:20',3),(20,'2022-01-16 09:17:20',3),(21,'2022-01-16 09:17:20',3),(22,'2022-01-16 09:17:20',3),(23,'2022-01-16 09:17:20',3),(24,'2022-01-16 09:17:20',3),(25,'2022-01-16 09:43:26',3),(26,'2022-01-16 09:43:26',3),(27,'2022-01-16 09:45:34',3),(28,'2022-01-16 09:46:05',3),(29,'2022-01-16 09:46:53',3),(30,'2022-01-16 09:47:09',3),(31,'2022-01-16 09:47:26',3),(32,'2022-01-16 09:47:43',3),(33,'2022-01-16 09:47:54',3),(34,'2022-01-16 09:48:34',3),(35,'2022-01-16 09:48:49',3),(36,'2022-01-16 09:51:05',3),(37,'2022-01-16 09:51:47',3),(38,'2022-01-16 09:51:47',3),(39,'2022-01-16 09:51:56',3),(40,'2022-01-16 09:52:15',3),(41,'2022-01-16 09:52:50',3),(42,'2022-01-16 09:52:58',3),(43,'2022-01-16 09:53:07',3),(44,'2022-01-16 09:53:33',3),(45,'2022-01-16 09:53:33',3),(46,'2022-01-16 09:55:24',3),(47,'2022-01-16 09:58:42',3),(48,'2022-01-16 09:59:03',3),(49,'2022-01-16 09:59:14',3),(50,'2022-01-16 09:59:14',3),(51,'2022-01-16 09:59:14',3),(52,'2022-01-16 09:59:14',3),(53,'2022-01-16 10:08:32',3),(54,'2022-01-16 10:08:32',3),(55,'2022-01-16 10:08:32',2),(56,'2022-01-16 10:08:32',2),(57,'2022-01-16 10:11:19',2),(58,'2022-01-16 10:12:24',2),(59,'2022-01-16 10:12:24',2),(60,'2022-01-16 10:12:24',2),(61,'2022-01-16 10:12:24',2),(62,'2022-01-16 10:21:38',2),(63,'2022-01-16 10:21:38',2),(64,'2022-01-16 10:21:38',2),(65,'2022-01-16 10:21:38',2),(66,'2022-01-16 10:28:42',2),(67,'2022-01-16 10:28:42',2),(68,'2022-01-16 10:28:42',2),(69,'2022-01-16 10:28:42',2),(70,'2022-01-16 10:28:42',2),(71,'2022-01-16 10:33:11',2),(72,'2022-01-16 10:33:11',2),(73,'2022-01-16 10:33:11',2),(74,'2022-01-16 10:33:11',2),(75,'2022-01-16 10:33:11',2),(76,'2022-01-16 10:33:11',2),(77,'2022-01-16 10:33:11',2),(78,'2022-01-16 10:33:11',2),(79,'2022-01-16 10:33:11',2),(80,'2022-01-16 10:33:11',2),(81,'2022-01-16 10:33:11',2),(82,'2022-01-16 10:33:11',2),(83,'2022-01-16 10:33:11',2),(84,'2022-01-16 11:06:48',2),(85,'2022-01-16 11:06:48',2);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_detail`
--

DROP TABLE IF EXISTS `receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_detail` (
  `receipt_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  PRIMARY KEY (`receipt_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `receipt_detail_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`id`),
  CONSTRAINT `receipt_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_detail`
--

LOCK TABLES `receipt_detail` WRITE;
/*!40000 ALTER TABLE `receipt_detail` DISABLE KEYS */;
INSERT INTO `receipt_detail` VALUES (1,1,1,30000),(1,2,1,30000),(1,3,2,40000),(1,4,1,20000),(1,5,1,35000),(1,6,1,30000),(1,7,1,40000),(1,8,1,30000),(2,2,5,30000),(2,3,1,40000),(2,4,1,20000),(3,1,1,30000),(3,2,1,30000),(3,3,1,40000),(3,4,1,20000),(4,5,8,35000),(4,6,4,30000),(4,7,4,40000),(4,8,1,30000),(5,7,5,40000),(6,1,1,30000),(6,2,1,30000),(6,3,1,40000),(6,4,1,20000),(7,1,1,30000),(7,2,1,30000),(7,3,1,40000),(7,4,1,20000),(8,1,1,30000),(8,2,1,30000),(8,3,1,40000),(8,4,1,20000),(9,1,1,30000),(9,2,1,30000),(9,3,1,40000),(9,4,1,20000),(10,1,1,30000),(10,2,1,30000),(10,3,1,40000),(10,4,1,20000),(11,1,1,30000),(11,2,1,30000),(11,3,1,40000),(11,4,1,20000),(12,1,1,30000),(12,2,1,30000),(12,3,1,40000),(12,4,1,20000),(13,1,1,30000),(13,2,1,30000),(13,3,1,40000),(13,4,1,20000),(14,1,1,30000),(14,2,1,30000),(14,3,1,40000),(14,4,1,20000),(15,1,1,30000),(15,2,1,30000),(15,3,1,40000),(15,4,1,20000),(16,1,1,30000),(16,2,1,30000),(16,3,1,40000),(16,4,1,20000),(17,1,1,30000),(17,2,1,30000),(17,3,1,40000),(17,4,1,20000),(18,1,1,30000),(18,2,1,30000),(18,3,1,40000),(18,4,1,20000),(19,1,1,30000),(19,2,1,30000),(19,3,1,40000),(19,4,1,20000),(20,1,1,30000),(20,2,1,30000),(20,3,1,40000),(20,4,1,20000),(21,1,1,30000),(21,2,1,30000),(21,3,1,40000),(21,4,1,20000),(22,1,1,30000),(22,2,1,30000),(22,3,1,40000),(22,4,1,20000),(23,1,1,30000),(23,2,1,30000),(23,3,1,40000),(23,4,1,20000),(24,1,1,30000),(24,2,1,30000),(24,3,1,40000),(24,4,1,20000),(25,1,1,30000),(25,2,1,30000),(25,3,1,40000),(25,4,1,20000),(26,1,1,30000),(26,2,1,30000),(26,3,1,40000),(26,4,1,20000),(27,1,1,30000),(27,2,1,30000),(27,3,1,40000),(27,4,1,20000),(28,1,1,30000),(28,2,1,30000),(28,3,1,40000),(28,4,1,20000),(29,1,1,30000),(29,2,1,30000),(29,3,1,40000),(29,4,1,20000),(30,1,1,30000),(30,2,1,30000),(30,3,1,40000),(30,4,1,20000),(31,1,1,30000),(31,2,1,30000),(31,3,1,40000),(31,4,1,20000),(32,1,1,30000),(32,2,1,30000),(32,3,1,40000),(32,4,1,20000),(33,1,1,30000),(33,2,1,30000),(33,3,1,40000),(33,4,1,20000),(34,1,1,30000),(34,2,1,30000),(34,3,1,40000),(34,4,1,20000),(35,1,1,30000),(35,2,1,30000),(35,3,1,40000),(35,4,1,20000),(36,1,1,30000),(36,2,1,30000),(36,3,1,40000),(36,4,1,20000),(37,1,1,30000),(37,2,1,30000),(37,3,1,40000),(37,4,1,20000),(38,1,1,30000),(38,2,1,30000),(38,3,1,40000),(38,4,1,20000),(39,1,1,30000),(39,2,1,30000),(39,3,1,40000),(39,4,1,20000),(40,1,1,30000),(40,2,1,30000),(40,3,1,40000),(40,4,1,20000),(41,1,1,30000),(41,2,1,30000),(41,3,1,40000),(41,4,1,20000),(42,1,1,30000),(42,2,1,30000),(42,3,1,40000),(42,4,1,20000),(43,1,1,30000),(43,2,1,30000),(43,3,1,40000),(43,4,1,20000),(44,1,1,30000),(44,2,1,30000),(44,3,1,40000),(44,4,1,20000),(45,1,1,30000),(45,2,1,30000),(45,3,1,40000),(45,4,1,20000),(46,1,1,30000),(46,2,1,30000),(46,3,1,40000),(46,4,1,20000),(47,1,1,30000),(47,2,1,30000),(47,3,1,40000),(47,4,1,20000),(48,1,1,30000),(48,2,1,30000),(48,3,1,40000),(48,4,1,20000),(49,1,1,30000),(49,2,1,30000),(49,3,1,40000),(49,4,1,20000),(50,1,1,30000),(50,2,1,30000),(50,3,1,40000),(50,4,1,20000),(51,1,1,30000),(51,2,1,30000),(51,3,1,40000),(51,4,1,20000),(52,1,1,30000),(52,2,1,30000),(52,3,1,40000),(52,4,1,20000),(53,1,1,30000),(53,2,1,30000),(53,3,1,40000),(53,4,1,20000),(54,1,1,30000),(54,2,1,30000),(54,3,1,40000),(54,4,1,20000),(55,1,1,30000),(55,2,1,30000),(55,3,1,40000),(55,4,1,20000),(56,1,1,30000),(56,2,1,30000),(56,3,1,40000),(56,4,1,20000),(57,1,1,30000),(57,2,1,30000),(57,3,1,40000),(57,4,1,20000),(58,1,1,30000),(58,2,1,30000),(58,3,1,40000),(58,4,1,20000),(59,1,1,30000),(59,2,1,30000),(59,3,1,40000),(59,4,1,20000),(60,1,1,30000),(60,2,1,30000),(60,3,1,40000),(60,4,6,20000),(60,5,1,35000),(60,6,1,30000),(60,7,1,40000),(60,8,1,30000),(61,1,1,30000),(61,2,1,30000),(61,3,1,40000),(61,4,6,20000),(61,5,1,35000),(61,6,1,30000),(61,7,1,40000),(61,8,1,30000),(62,1,1,30000),(62,2,1,30000),(62,3,1,40000),(62,4,6,20000),(62,5,1,35000),(62,6,1,30000),(62,7,1,40000),(62,8,1,30000),(63,1,1,30000),(63,2,1,30000),(63,3,1,40000),(63,4,1,20000),(63,5,1,35000),(63,6,1,30000),(63,7,1,40000),(63,8,1,30000),(64,1,1,30000),(64,2,1,30000),(64,3,1,40000),(64,4,1,20000),(64,5,1,35000),(64,6,1,30000),(64,7,1,40000),(64,8,1,30000),(65,1,1,30000),(65,2,1,30000),(65,3,1,40000),(65,4,1,20000),(65,5,1,35000),(65,6,1,30000),(65,7,1,40000),(65,8,1,30000),(66,1,1,30000),(66,2,1,30000),(66,3,1,40000),(66,4,1,20000),(66,5,1,35000),(66,6,1,30000),(66,7,1,40000),(66,8,1,30000),(67,1,1,30000),(67,2,1,30000),(67,3,1,40000),(67,4,1,20000),(67,5,1,35000),(67,6,1,30000),(67,7,1,40000),(67,8,1,30000),(68,1,1,30000),(68,2,1,30000),(68,3,1,40000),(68,4,1,20000),(69,1,1,30000),(69,2,1,30000),(69,3,1,40000),(69,4,1,20000),(70,1,1,30000),(70,2,1,30000),(70,3,1,40000),(70,4,1,20000),(71,1,1,30000),(71,2,1,30000),(71,3,1,40000),(71,4,1,20000),(72,1,1,30000),(72,2,1,30000),(72,3,1,40000),(72,4,1,20000),(73,1,1,30000),(73,2,1,30000),(73,3,1,40000),(73,4,1,20000),(74,1,1,30000),(74,2,1,30000),(74,3,1,40000),(74,4,1,20000),(75,1,1,30000),(75,2,1,30000),(75,3,1,40000),(75,4,1,20000),(76,1,1,30000),(76,2,1,30000),(76,3,1,40000),(76,4,1,20000),(77,1,1,30000),(77,2,1,30000),(77,3,1,40000),(77,4,1,20000),(78,1,1,30000),(78,2,1,30000),(78,3,1,40000),(78,4,1,20000),(79,1,1,30000),(79,2,1,30000),(79,3,1,40000),(79,4,1,20000),(80,1,1,30000),(80,2,1,30000),(80,3,1,40000),(80,4,1,20000),(81,1,1,30000),(81,2,1,30000),(81,3,1,40000),(81,4,1,20000),(82,1,1,30000),(82,2,1,30000),(82,3,1,40000),(82,4,1,20000),(83,1,1,30000),(83,2,1,30000),(83,3,1,40000),(83,4,1,20000),(84,1,1,30000),(84,2,1,30000),(84,3,1,40000),(84,4,1,20000),(85,1,1,30000),(85,2,1,30000),(85,3,1,40000),(85,4,1,20000);
/*!40000 ALTER TABLE `receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'Best seller'),(2,'New');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `joined_date` datetime DEFAULT NULL,
  `user_role` enum('ADMIN','MANAGER') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Nguyễn Phú An','ngphuan2022','a6b35a9dac39ff1d3f4656c421d2559a','https://res.cloudinary.com/nguyen-phu-an/image/upload/v1642213378/xc3zhzlatf5nznhfwjyw.gif','1951052003an@ou.edu.vn','0941622670',1,'2022-01-15 09:17:38','ADMIN'),(2,'Ngô Trường An','user1','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/nguyen-phu-an/image/upload/v1642226128/wbrzegtde2lldbmqfjwv.gif','','0987654321',1,'2022-01-15 12:53:58','MANAGER'),(3,'Nguyễn Lê Thanh Tuấn','user2','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/nguyen-phu-an/image/upload/v1642226227/g4ryr1m1whjhiid1nmw1.gif','','0989999999',1,'2022-01-15 12:53:58','MANAGER'),(4,'Name','user3','202cb962ac59075b964b07152d234b70','https://res.cloudinary.com/nguyen-phu-an/image/upload/v1642226317/hopkkhmnxbiycg70g1mh.gif','','0912345678',1,'2022-01-15 12:53:58','MANAGER');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-16 11:49:13
