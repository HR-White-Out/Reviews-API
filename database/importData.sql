\c reviewsAPI;
COPY reviews(id, rating, summary, body, product_id, date, recommend, hepfulness, reviewer_name, reported, reviewer_email, response)
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
