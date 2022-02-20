import axios from 'axios';
import { API_URL } from '../services/apiService';

export default async function signOut(auth_token, csrf) {
    await axios.delete(API_URL + '/logout',
        {
            headers: {
                "Content-Type": "application/json",
                "Authorization": auth_token,
                "X-CSRF-Token": csrf,
            }
        })
        .then(res => {
            if (res.status === 204) localStorage.removeItem("me");
        })
        .catch((e) => {
            console.log(e);
        });
}