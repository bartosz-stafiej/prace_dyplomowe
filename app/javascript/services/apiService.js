import axios from 'axios';
import { useAuth } from '../contexts/authContext';

export const API_URL = process.env.REACT_APP_API_BASE_URL;

export async function apiGet(url, auth) {
    return await axios.get(API_URL + url,
        {
            headers: {
                "Content-Type": "application/json",
                'Authorization': auth
            }
        }
        )
        .then(response => {
            if (response.status === 200) {
                return response.data
            }
        })
        .catch(err => {
            throw err;
        })
}

export async function apiPost(url, body, auth) {
    const { csrf } = useAuth();
    await axios.post(API_URL + url,
        {...body},
        {
            headers: { 
                "X-CSRF-Token": csrf,
                "Content-Type": "application/json",
                'Authorization': auth
            }
        })
        .then(response => {
            if(response.status === 200 || response.status === 201) {
                return response.data
            }
        })
        .catch(err => {
            throw err;
        });
}