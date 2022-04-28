const db = require('../models/models');

test('DB returns review object with the right keys', () => {
  return db.getReviews(1, 1, 5, 'helpfulness').then((result) => {
    console.log(Object.keys(result.rows[0]))
    expect(Object.keys(result.rows[0])).toEqual([
      'product_id', 'rating', 'date', 'summary', 'body',
      'recommend', 'reported', 'reviewer_name', 'reviewer_email', 'response', 'helpfulness', 'photos', 'id',]);
  })
});
// need to add photos