require('dotenv').config();
const { Pool } = require('pg');
const PORT = process.env.PORT || 3000;
const { dbUser, dbHost, db, dbPassword } = process.env;

const pool = new Pool({
  user: dbUser,
  host: dbHost,
  database: db,
  password: dbPassword,
  port: '5432'
});

module.exports = {
  // get requests
  getReviews: function getReviews(id, page, count, sort) {
    return new Promise((resolve, reject) => {
      pool.query(`SELECT JSON_BUILD_OBJECT(
        'product_id', cast(${id} AS VARCHAR),
        'page', ${page},
        'count', ${count},
        'results', (SELECT json_agg( JSON_BUILD_OBJECT(
            'review_id', id,
            'rating', rating,
            'summary', summary,
            'recommond', recommend,
            'response', response,
            'body', body,
            'date', date,
            'reviewer_name', reviewer_name,
            'helpfulness', helpfulness
      )) FROM (SELECT id, rating, summary, recommend, response, body, date, reviewer_name, helpfulness FROM reviewdata WHERE product_id = 123 ORDER BY ${sort} DESC LIMIT ${count}) AS reviews)
      )`
      , (error, data) => {
        if (error) {
          reject(error)
        } else {
          resolve(data)
        }
      })
    });
  },
  /*
  SELECT JSON_BUILD_OBJECT(
    'product_id', ${id},
    'page', ${page},
    'count', ${count},
    'results', (SELECT JSON_BUILD_array(
      (SELECT JSON_BUILD_OBJECT(
        'review_id', id,
        'rating', rating,
        'summary', summary,
        'recommond', recommond,
        'response', response,
        'body', body,
        'date', date,
        'reviewer_name', reviewer_name,
        'helpfulness', helpfulness,
        'photos', (SELECT JSON_BUILD_array(
          (SELECT JSON_OBJECT_AGG(
                'id', id,
                'url', url
          )FROM (SELECT id, url FROM reviews_photos WHERE review_id = reviews.id) AS photos)))
    ))
  )
  */
  getMeta: function getMeta(id) {
    return new Promise((resolve, reject) => {
      pool.query(`SELECT JSON_BUILD_OBJECT(
        'product_id', cast(${id} AS VARCHAR),
        'ratings', (SELECT JSON_OBJECT_AGG(rating, rating_data)
          FROM (SELECT rating, count(*) AS rating_data FROM reviewData WHERE product_id = ${id} GROUP BY rating) AS rate),
        'recommended', (SELECT JSON_OBJECT_AGG(recommend, rec_data)
          FROM (SELECT recommend, count(*) AS rec_data FROM reviewData WHERE product_id = ${id} GROUP BY recommend) AS rec),
        'characteristics', (SELECT JSON_OBJECT_AGG(name, JSON_BUILD_OBJECT(
                'id', characteristic_id,
                'value', value
          ))
          FROM (SELECT name, characteristic_id, sum(value)/count(*) AS value
            FROM chars WHERE product_id = ${id} GROUP BY  name, characteristic_id) AS char)
      )`
      , (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      })
    })
  },
  postReview: function postReview() {
    let photos = [];
    if (req.photos !== undefined) {
      for(let i = 0; i < req.photos.length; i += 1) {
        photos.push({ url: req.photos});
      }
    }
    return pool.query(`INSERT INTO reviews_data (product_id, rating, date, summary, body, recommend, reviewer_name, reviewer_email, photos) VALUES (%L, %L, NOW() AT TIME ZONE 'UTC', ${req.product_id}, ${req.rating}, NOW() AT TIME ZONE 'UTC', ${req.summary}, ${req.body}, ${req.recommend}, ${req.name}, ${req.email}, ${photos}) RETURNING id AS review_id;`)
      .then((data) => {
        if (req.characteristics) {
          for (let key in req.characteristics) {
            pool.query(`INSERT INTO characteristics_data (product_id, characteristic_id, review_id, name, value) VALUES (${req.product_id}, ${key}, ${data.rows[0].review_id}, (SELECT name FROM characteristics_data WHERE characteristics_data.characteristic_id = ${key} AND characteristics_data.product_id = ${req.product_id} LIMIT 1), ${req.characteristics[key]})`)
              .catch((err) => console.log(err, 'err posting chars'))
          }
        }
      })
      .catch((err) => console.log(err, 'err posting review'))
  },
  putHelpful: function putHelpful(id) {
    return new Promise((resolve, reject) => {
      pool.query(`UPDATE reviewData SET helpfulness = helpfulness + 1 WHERE id = ${id}`
      , (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      })
    })
  },
  putReport: function putReport(id) {
    return new Promise((resolve, reject) => {
      pool.query(`UPDATE reviewData SET reported = true WHERE id = ${id}`
      , (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      })
    })
  },
};