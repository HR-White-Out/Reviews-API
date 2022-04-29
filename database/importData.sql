\c reviewsapi;
COPY reviews(id, product_id, rating, date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness)
  FROM '/Users/adarsh/HackReactor/SDC/data/reviews.csv'
  DELIMITER ','
  CSV HEADER;

COPY reviews_photos(id, review_id, url)
  FROM '/Users/adarsh/HackReactor/SDC/data/reviews_photos.csv'
  DELIMITER ','
  CSV HEADER;

COPY characteristics(id, product_id, name)
  FROM '/Users/adarsh/HackReactor/SDC/data/characteristics.csv'
  DELIMITER ','
  CSV HEADER;

COPY characteristics_reviews(id, characteristic_id, review_id, value)
  FROM '/Users/adarsh/HackReactor/SDC/data/characteristic_reviews.csv'
  DELIMITER ','
  CSV HEADER;

-- temp data --
DROP TABLE IF EXISTS photosData;
CREATE TABLE photosData as
SELECT reviews_photos.review_id, JSON_AGG(JSON_BUILD_OBJECT('url', url)) as photos
FROM reviews_photos
GROUP BY reviews_photos.review_id;

-- final tables --
DROP TABLE IF EXISTS reviewData CASCADE;
DROP TABLE IF EXISTS reviewData;
DROP TABLE IF EXISTS chars;

CREATE TABLE reviewData AS
SELECT reviews.*, photosData.photos
FROM reviews
LEFT JOIN photosData ON reviews.id = photosData.review_id
ORDER BY reviews.id;

ALTER TABLE reviewData DROP id;
ALTER TABLE reviewData ADD id BIGSERIAL PRIMARY KEY UNIQUE;

CREATE INDEX id ON reviewData (product_id);

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

-- fix data for date --
UPDATE reviewData SET date = date/1000;
ALTER TABLE reviewData ALTER date TYPE TIMESTAMP WITHOUT TIME ZONE USING to_timestamp(date) AT TIME ZONE 'UTC';

-- add a few things so the data isnt off --
ALTER TABLE reviewData ALTER reported SET DEFAULT false;

ALTER TABLE reviewData ALTER helpfulness SET DEFAULT 0;

DROP TABLE IF EXISTS photosData;
DROP TABLE IF EXISTS characteristics_reviews;
DROP TABLE IF EXISTS characteristics;
DROP TABLE IF EXISTS reviews_photos;
DROP TABLE IF EXISTS reviews;