import axios from 'axios';

export default async function updateReview(input, auth, csrf, graduation_work_id, id) {
    await axios.put(`/api/v1/graduation_works/${graduation_work_id}/reviews/${id}`,
    {...input},
        {
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrf,
            'Authorization': auth,
        }
    })
    .then(res => {
        if(res.status === 200) return res.data
    })
    .catch(err => {
        console.log(err);
    });
}