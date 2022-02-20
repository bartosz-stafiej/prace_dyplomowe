import axios from 'axios';

export default async function updateProfile(input, csrf, auth_token) {
    await axios.put('/api/v1/users',
    {...input},
    {
        headers: {
            "X-CSRF-Token": csrf,
            "Content-Type": "application/json",
            'Authorization': auth_token
        }
    })
    .then(res => {
        if (res.status === 200) return res.data;
    })
    .catch(e => {
        console.log(e);
    })
}