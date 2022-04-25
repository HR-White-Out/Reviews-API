const express = require('express');
const controllers = require('./controller/controller');
const app = express();
require('dotenv').config();
const { PORT } = process.env;

app.use(express.json());

app.get('/', controllers.getReviews)
app.get('/meta', controllers.getMeta)
app.post('/', controllers.postReview)
app.put('/:review_id/helpful', controllers.putHelpful)
app.put('/:review_id/report', controllers.putReport)

app.listen(
  PORT,
  () => { console.log(`Server running on port ${PORT}!`); },
);