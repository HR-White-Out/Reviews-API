\c reviewsAPI;
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
