-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'reviews'
--
-- ---
DROP DATABASE IF EXISTS reviewsapi;
CREATE DATABASE reviewsapi;

\c reviewsapi;
DROP TABLE IF EXISTS characteristics_reviews;
DROP TABLE IF EXISTS characteristics;
DROP TABLE IF EXISTS reviews_photos;
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id INTEGER NOT NULL UNIQUE,
  product_id INTEGER NOT NULL,
  rating INTEGER NOT NULL,
  date BIGINT NOT NULL,
  summary VARCHAR(200) NULL DEFAULT NULL,
  body VARCHAR(1000) NOT NULL,
  recommend BOOLEAN NOT NULL,
  reported BOOLEAN DEFAULT FALSE,
  reviewer_name varchar(60) NULL DEFAULT NULL,
  reviewer_email varchar(60) NULL DEFAULT NULL,
  response varchar(1000) NULL DEFAULT NULL,
  helpfulness INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ---
-- Table 'reviews_photos'
--
-- ---


CREATE TABLE reviews_photos (
  id INTEGER NOT NULL UNIQUE,
  review_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  PRIMARY KEY (id)
);

-- ---
-- Table 'characteristics'
-- Dont know what needs to be in this table yet
-- ---


CREATE TABLE characteristics (
  id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  name varchar(60) NOT NULL,
  PRIMARY KEY (id)
);

-- ---
-- Table 'characteristics_reviews'
--
-- ---


CREATE TABLE characteristics_reviews (
  id INTEGER NOT NULL,
  characteristic_id INTEGER NOT NULL,
  review_id INTEGER NOT NULL,
  value DECIMAL NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ---
-- Foreign Keys
-- ---

-- CREATE INDEX review_id_idx ON reviews_photos (review_id);
-- CREATE INDEX product_id_idx ON characteristics (product_id);
-- CREATE INDEX review_id_idx ON characteristics_reviews (review_id);

-- ALTER TABLE reviews_photos ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
-- ALTER TABLE characteristics_reviews ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
-- ALTER TABLE characteristics_reviews ADD FOREIGN KEY (characteristic_id) REFERENCES characteristics (id);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE reviews ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE Photos ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE response ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE characteristics ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO reviews (review_id,rating,summary,product_id,body,date,recommend,hepfulness,reviewer_name) VALUES
-- ('','','','','','','','','');
-- INSERT INTO Photos (id,review_id,url) VALUES
-- ('','','');
-- INSERT INTO response (id,review_id,body) VALUES
-- ('','','');
-- INSERT INTO characteristics (id,lable,value,reviews_id) VALUES
-- ('','','','');