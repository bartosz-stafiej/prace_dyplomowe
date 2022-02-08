import axios from 'axios';

const API_URL = 'http://localhost:3000/api/v1';

export async function apiGet(url) {
    return await axios.get(API_URL + url)
        .then(response => {
            if (response.status === 200) {
                return response.data
            }
        })
        .catch(err => {
            throw err;
        })
}

export async function apiPost(url, body) {
    const response = await axios.post(API_URL + url, body)
        .then(response => {
            if(response.status === 200 || response.status === 201) {
                return response.data
            }
        })
        .catch(err => {
            throw err;
        })
}