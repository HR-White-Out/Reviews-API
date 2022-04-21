-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'reviews'
--
-- ---
CREATE DATABASE reviews;

USE reviews;
DROP TABLE IF EXISTS `ReviewsAPI`;

CREATE TABLE `ReviewsAPI` (
  `review_id` INTEGER(7) NOT NULL DEFAULT Required,
  `rating` INTEGER(1-5) NOT NULL,
  `summary` VARCHAR(60 char) NULL DEFAULT NULL,
  `product_id` INTEGER NOT NULL,
  `body` MEDIUMTEXT(50 to 1000) NOT NULL,
  `date` INTEGER NOT NULL,
  `recommend` bit NOT NULL,
  `hepfulness` INTEGER NULL DEFAULT NULL,
  `reviewer_name` CHAR(up to 60) NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`)
);

-- ---
-- Table 'Photos'
--
-- ---

DROP TABLE IF EXISTS `Photos`;

CREATE TABLE `Photos` (
  `id` INTEGER NOT NULL AUTO_INCREMENT DEFAULT required    ,
  `review_id` INTEGER NOT NULL,
  `url` VARCHAR NOT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'response'
-- Dont know what needs to be in this table yet
-- ---

DROP TABLE IF EXISTS `response`;

CREATE TABLE `response` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `review_id` INTEGER NOT NULL,
  `body` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Dont know what needs to be in this table yet';

-- ---
-- Table 'characteristics'
--
-- ---

DROP TABLE IF EXISTS `characteristics`;

CREATE TABLE `characteristics` (
  `id` INTEGER NOT NULL AUTO_INCREMENT DEFAULT required,
  `lable` VARCHAR NOT NULL DEFAULT 'required',
  `value` DECIMAL NULL DEFAULT NULL,
  `reviews_id` INTEGER NOT NULL DEFAULT required,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE `Photos` ADD FOREIGN KEY (review_id) REFERENCES `reviews` (`review_id`);
ALTER TABLE `response` ADD FOREIGN KEY (review_id) REFERENCES `reviews` (`review_id`);
ALTER TABLE `characteristics` ADD FOREIGN KEY (reviews_id) REFERENCES `reviews` (`review_id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `reviews` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Photos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `response` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `characteristics` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `reviews` (`review_id`,`rating`,`summary`,`product_id`,`body`,`date`,`recommend`,`hepfulness`,`reviewer_name`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `Photos` (`id`,`review_id`,`url`) VALUES
-- ('','','');
-- INSERT INTO `response` (`id`,`review_id`,`body`) VALUES
-- ('','','');
-- INSERT INTO `characteristics` (`id`,`lable`,`value`,`reviews_id`) VALUES
-- ('','','','');