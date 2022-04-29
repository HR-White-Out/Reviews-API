import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m30s', target: 1000 },
    { duration: '20s', target: 200 },
  ],
};

export default () => {
  http.get(`http://localhost:3000/?product_id=${Math.floor(Math.random() * 1000000)}`)
}