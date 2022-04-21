const mongoose = require('mongoose');

const reviews = mongoose.Schema({
  id: int,
  rating: int,
  summary: int,
  body: char,
  date: int,
  recommended: boolien,
  helpgulness: int,
  response: [
    {
      id: int,
      body: char,
    }
  ],
  username: char,
  photos: [
    {
      id: int,
      url: char,
    }
  ],
  characteristics: [{
    lable: char,
    value: int,
  }]
});
