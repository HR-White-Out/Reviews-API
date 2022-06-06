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
 Ensure that Postgresql is install onto your computer

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

GET `/reviews/`

Query Parameters
<table style="width:100%">
  <tr>
    <th>Parameter</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>page</td>
    <td>integer</td>
    <td>Selects the page of results to return. Default 1.</td>
  </tr>
  <tr>
    <td>count</td>
    <td>integer</td>
    <td>Specifies how many results per page to return. Default 5.</td>
  </tr>
  <tr>
    <td>sort</td>
    <td>text</td>
    <td>Changes the sort order of reviews to be based on "newest", "helpful", or "relevant"</td>
  </tr>
  <tr>
    <td>product_id</td>
    <td>integer</td>
    <td>Specifies the product for which to retrieve reviews.</td>
  </tr>
</table>

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

GET `/reviews/meta`

QueryParameters
<table style="width:100%">
  <tr>
    <th>Parameter</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>product_id</td>
    <td>integer</td>
    <td>Required ID of the product for which data should be returned</td>
  </tr>
 
</table>

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

## Add a Review

Adds a review for the given product.

POST `/reviews`

Body Parameters
<table style="width:100%">
  <tr>
    <th>Parameter</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>product_id</td>
    <td>integer</td>
    <td>Required ID of the product to post the review for</td>
  </tr>
  <tr>
    <td>rating</td>
    <td>int</td>
    <td>Integer (1-5) indicating the review rating</td>
  </tr>
   <tr>
    <td>summary</td>
    <td>text</td>
    <td>Summary text of the review</td>
  </tr>
   <tr>
    <td>body</td>
    <td>text</td>
    <td>Continued or full text of the review</td>
  </tr>
   <tr>
    <td>recommend</td>
    <td>bool</td>
    <td>Value indicating if the reviewer recommends the product</td>
  </tr>
   <tr>
    <td>name</td>
    <td>text</td>
    <td>Username for question asker</td>
  </tr>
   <tr>
    <td>email</td>
    <td>text</td>
    <td>Email address for question asker</td>
  </tr>
   <tr>
    <td>photos</td>
    <td>[text]</td>
    <td>Array of text urls that link to images to be shown</td>
  </tr>
   <tr>
    <td>characteristics</td>
    <td>object</td>
    <td>Object of keys representing characteristic_id and values representing the review value for that characteristic. { "14": 5, "15": 5 //...}</td>
  </tr>
</table>

Expected Response:
Status: 201 CREATED 

## Mark Review as Helpful

Updates a review to show it was found helpful.

PUT `/reviews/:review_id/helpful`

Parameters
<table style="width:100%">
  <tr>
    <td>Parameter</td>
    <td>Type</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>reveiw_id</td>
    <td>integer</td>
    <td>Required ID of the review to update</td>
  </tr>
</table>

Expected Response:
Status: 2204 NO CONTENT

## Report Review

Updates a review to show it was reported. Note, this action does not delete the review, but the review will not be returned in the above GET request.

PUT `/reviews/:review_id/report`

Parameters
<table style="width:100%">
  <tr>
    <td>Parameter</td>
    <td>Type</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>reveiw_id</td>
    <td>integer</td>
    <td>Required ID of the review to update</td>
  </tr>
</table>

Expected Response:
Status: 2204 NO CONTENT      
