import axios from 'axios';

export default async function refreshToken(user, csrf) {
    const auth = user.tokens.refresh_token.token;



    await axios.post('/api/v1/refresh_token',
    {},
    {
        headers: {
            "X-CSRF-Token": csrf,
            "Content-Type": "application/json",
            'Authorization': auth,
        }
    })
    .then(res => {
        if (res.status === 200) return res.data;
    })
    .then(json => {
        localStorage.setItem('me', JSON.stringify(json['user']));
    })
    .then(() => location.reload() )
    .catch(e => {
        console.log(e);
    })
}