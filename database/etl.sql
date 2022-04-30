DROP DATABASE IF EXISTS reviewsapi;
CREATE DATABASE reviewsapi;

\c reviewsapi;

-- Drop all tables --
DROP TABLE IF EXISTS characteristics_reviews;
DROP TABLE IF EXISTS characteristics;
DROP TABLE IF EXISTS reviews_photos;
DROP TABLE IF EXISTS reviewdata CASCADE;
DROP TABLE IF EXISTS reviewdata;
DROP TABLE IF EXISTS chars;
--------------------------------------------------------------------------
-- create second table fore characteristics --
CREATE TABLE characteristics (
  id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  name varchar(60) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE characteristics_reviews (
  id INTEGER NOT NULL,
  characteristic_id INTEGER NOT NULL,
  review_id INTEGER NOT NULL,
  value DECIMAL NULL DEFAULT NULL,
  PRIMARY KEY (id)
);
-- cody data from csv files --
\copy characteristics FROM './characteristics.csv' DELIMITER ',' CSV HEADER;
\copy characteristics_reviews FROM './characteristic_reviews.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE chars (
  id SERIAL UNIQUE,
  product_id INTEGER NOT NULL,
  characteristic_id INTEGER NOT NULL,
  name VARCHAR(12) NOT NULL,
  value INTEGER NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE chars DROP id;
ALTER TABLE chars ADD charid BIGSERIAL PRIMARY KEY UNIQUE;
CREATE INDEX charid ON chars (product_id);
-- populate new tables --

INSERT INTO chars (product_id, characteristic_id, name, value)
SELECT characteristics.product_id, characteristics_reviews.characteristic_id, characteristics.name, characteristics_reviews.value
FROM characteristics INNER JOIN characteristics_reviews
ON characteristics.id = characteristics_reviews.characteristic_id
ORDER BY characteristics.product_id;

-- drop tables that I dont need --

DROP TABLE IF EXISTS characteristics_reviews;
DROP TABLE IF EXISTS characteristics;

--- stpes to create reviewdata table ---
--------------------------------------------------------------------
-- create tables data --
CREATE TABLE reviewdata (
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
CREATE TABLE reviews_photos (
  id INTEGER NOT NULL UNIQUE,
  review_id INTEGER NOT NULL,
  url VARCHAR(1024) NOT NULL,
  PRIMARY KEY (id)
);
-- cody data from csv files --
\copy reviewdata FROM './reviews.csv' DELIMITER ',' CSV HEADER;
\copy reviews_photos FROM './reviews_photos.csv' DELIMITER ',' CSV HEADER;

-- no longer need reviews,reviews_photos and photosdata --

ALTER TABLE reviewdata DROP id;
ALTER TABLE reviewdata ADD id BIGSERIAL PRIMARY KEY UNIQUE;

CREATE INDEX id ON reviewdata (product_id);

UPDATE reviewdata SET date = date/1000;
ALTER TABLE reviewdata ALTER date TYPE TIMESTAMP WITHOUT TIME ZONE USING to_timestamp(date) AT TIME ZONE 'UTC';
ALTER TABLE reviewdata ALTER reported SET DEFAULT false;
ALTER TABLE reviewdata ALTER helpfulness SET DEFAULT 0;

ALTER TABLE reviews_photos DROP id;
ALTER TABLE reviews_photos ADD photo_id BIGSERIAL PRIMARY KEY UNIQUE;
CREATE INDEX photo_id ON reviews_photos (review_id);
