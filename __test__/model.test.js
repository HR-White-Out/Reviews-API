const db = require('../models/models');

test('DB returns review object with the right keys', () => {
  return db.getReviews(20).then((result) => {
    expect(Object.keys(result.rows[0])).toEqual([
      'review_id', 'rating', 'summary',
      'recommend', 'response', 'body',
    'date', 'reviewer_name']);
  })
});
// need to add photos