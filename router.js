const Routers = require('express').Router();
const controllers = require('./controller/controllers');

Routers.get('/', controllers.getReviews)
Routers.get('/meta', controllers.getMeta)
Routers.post('/', controllers.postReview)
Routers.put('/:review_id/helpful', controllers.putHelpful)
Routers.put('/:review_id/report', controllers.putReport)

module.exports = Routers;