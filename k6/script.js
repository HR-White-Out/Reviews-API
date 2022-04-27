import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m30s', target: 100 },
    { duration: '20s', target: 0 },
  ],
};

export default () => {
  http.get(`http://localhost:3000/meta?product_id=${Math.floor(Math.random() * 1000000)}`)
}