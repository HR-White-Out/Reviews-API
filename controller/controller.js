const { Pool } = require('pg');
const mod = require('../models/models');
const PORT = process.env.PORT || 3000;
require('dotenv').config();

const pool = new Pool({
  user: process.env.dbUser,
  host: process.env.dbHost,
  database: process.env.db,
  port: '6000'
});

module.exports = {
  getReviews: function getReviews(req, res) {
    let { product_id = 1, page = 1, count = 5, sort = 'relevant' } = req.query;
    if (sort === 'relevant') {
      sort = 'helpfulness DESC, date'
    }
    mod.getReviews(product_id, page, count, sort)
      .then((data) => {
        let result = {
          product: product_id,
          page,
          count,
          results: data.rows
        };
        res.send(result);
      })
      .catch((error) => console.log(error));
  },
  getMeta: function getMeta(req, res) {
    mod.getMeta(req.query.product_id)
    .then((data) => {
      let result = data.rows[0].json_build_object;
      result.product_id = req.query.product_id;
      res.send(result);
    })
    .catch((error) => console.log(error));
  },
  postReview: function postReview(req, res) {
    mod.postReview(req.body)
    .then(() => res.status(201).send())
    .catch((error) => console.log(error));

  },
  putHelpful: function putHelpful(req, res) {
    mod.putHelpful(req.params.review_id)
    .then(() => res.status(204).send())
    .catch((error) => console.log(error));
  },
  putReport: function putReport(req, res) {
    mod.putReport(req.params.review_id)
    .then(() => res.status(204).send())
    .catch((error) => console.log(error));
  }

}