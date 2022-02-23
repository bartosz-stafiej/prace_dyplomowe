import axios from 'axios';

export default async function createReview(input, auth, csrf, id) {
    await axios.post(`/api/v1/graduation_works/${id}/reviews`,
    {...input},
    {
        headers: {
            'X-CSRF-Token': csrf,
            'Content-Type': 'application/json',
            'Authorization': auth
        }
    })
    .then(res => {
        if (res.staus === 200) return res.data
    })
    .catch(e => {
        console.log(e);
    })
}