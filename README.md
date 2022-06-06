# Reviews-API
by Adarshraj Ravindran

This is a backend API node/express/Postgres application that provides review information to an e-Commerce front end. <br>
## Technologies Used

<div align="center" width="100%">
  <img src="https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB" />
  <img src="https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white" />
  <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" />
  <img src="https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB" />
</div>
<br>
Testing: 
Loader.IO, K6, New Relic 
<br>

## Ensure that Postgresql is install onto your computer

## Installation

```
npm install
```

Start the Postgresql service on your terminal

Rename the `example.env` file to `.env` and configure the variables within.

```
npm start
```

## API Endpoints

## List Reviews

Returns a list of reviews for a particular product. This list does not include any reported reviews.

`GET /reviews/`

QueryParameters
---------------------------------------------------------------------------------------------------------------
| Parameter   | Type    | Description                                                                         |
| page        |	integer |	Selects the page of results to return. Default 1.                                   |
| count 	    | integer |	Specifies how many results per page to return. Default 5.                           |
| sort 	      | text 	  | Changes the sort order of reviews to be based on "newest", "helpful", or "relevant" |
| product_id  | integer | 	Specifies the product for which to retrieve reviews.                              |
---------------------------------------------------------------------------------------------------------------

Expected data output exemple:
```
{
  "product": "2",
  "page": 0,
  "count": 5,
  "results": [
    {
      "review_id": 5,
      "rating": 3,
      "summary": "I'm enjoying wearing these shades",
      "recommend": false,
      "response": null,
      "body": "Comfortable and practical.",
      "date": "2019-04-14T00:00:00.000Z",
      "reviewer_name": "shortandsweeet",
      "helpfulness": 5,
      "photos": [{
          "id": 1,
          "url": "urlplaceholder/review_5_photo_number_1.jpg"
        },
        {
          "id": 2,
          "url": "urlplaceholder/review_5_photo_number_2.jpg"
        },
        // ...
      ]
    },
    {
      "review_id": 3,
      "rating": 4,
      "summary": "I am liking these glasses",
      "recommend": false,
      "response": "Glad you're enjoying the product!",
      "body": "They are very dark. But that's good because I'm in very sunny spots",
      "date": "2019-06-23T00:00:00.000Z",
      "reviewer_name": "bigbrotherbenjamin",
      "helpfulness": 5,
      "photos": [],
    },
    // ...
  ]
}
```

## Get Review Metadata

Returns review metadata for a given product.

`GET /reviews/meta`

QueryParameters
---------------------------------------------------------------------------------------------------------------
| product_id  | integer | 	Required ID of the product for which data should be returned                      |
---------------------------------------------------------------------------------------------------------------

Expected data output exemple:
```
{
  "product_id": "2",
  "ratings": {
    2: 1,
    3: 1,
    4: 2,
    // ...
  },
  "recommended": {
    0: 5
    // ...
  },
  "characteristics": {
    "Size": {
      "id": 14,
      "value": "4.0000"
    },
    "Width": {
      "id": 15,
      "value": "3.5000"
    },
    "Comfort": {
      "id": 16,
      "value": "4.0000"
    },
    // ...
}
```
