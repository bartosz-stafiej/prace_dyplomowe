import axios from 'axios';
import { API_URL } from '../services/apiService';

export default async function singIn(input, csrf) {
    await axios.post(API_URL + '/login',
        {...input},
        {
         headers: {
            "X-CSRF-Token": csrf,
            "Content-Type": "application/json"
        }
    })
    .then(res => {
        const json = res.data['user'];
        const expires_at = new Date();
        expires_at.setSeconds(expires_at.getSeconds() + json.tokens.access_token.expires_in);
        json.tokens.access_token.expires_at = expires_at;

        return json;
    }).then(json => {
        const expires_at = new Date();
        expires_at.setSeconds(expires_at.getSeconds() + json.tokens.refresh_token.expires_in);
        json.tokens.refresh_token.expires_at = expires_at;

        return json;
    }).then(json => {
        localStorage.setItem("me", JSON.stringify(json));
    })
    .catch((e) => {
        console.log(e);
    });
}