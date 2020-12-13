# ************************************************************
# Sequel Ace SQL dump
# Version 2121
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.5.6-MariaDB)
# Database: gotoeat
# Generation Time: 2020-12-13 02:28:23 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table details
# ------------------------------------------------------------

CREATE TABLE `details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `review_count` int(11) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `image_url` varchar(2047) CHARACTER SET latin1 DEFAULT NULL,
  `homepage_url` varchar(2047) CHARACTER SET latin1 DEFAULT NULL,
  `phone_number` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `resevation_phone_number` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `tabelog_url` varchar(2047) CHARACTER SET latin1 DEFAULT NULL,
  `genre1` varchar(100) DEFAULT NULL,
  `genre2` varchar(100) DEFAULT NULL,
  `genre3` varchar(100) DEFAULT NULL,
  `rating_score` float DEFAULT NULL,
  `budget__price_lunch` varchar(100) DEFAULT NULL,
  `budget__price_dinner` varchar(100) DEFAULT NULL,
  `station` varchar(1000) DEFAULT NULL,
  `address` varchar(2047) DEFAULT NULL,
  `business_hours` varchar(2047) DEFAULT NULL,
  `feature` varchar(2047) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table pages
# ------------------------------------------------------------

CREATE TABLE `pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `crawl_status` int(11) DEFAULT 0,
  `parse_status` int(11) DEFAULT 0,
  `name` varchar(63) DEFAULT NULL,
  `restaurant_url` varchar(2047) CHARACTER SET latin1 DEFAULT NULL,
  `html` longtext DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `rating_score` float DEFAULT NULL,
  `review_count` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `NAME` (`name`),
  KEY `PARSE_STATUS` (`parse_status`),
  KEY `RESTAURANT_URL` (`restaurant_url`(767))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
