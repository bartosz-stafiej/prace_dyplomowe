import axios from 'axios';

export default async function updateGraduationWork(input, auth, csrf, id) {
    await axios.put(`/api/v1/graduation_works/${id}`,
    {...input},
    {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': auth,
            'X-CSRF-Token': csrf,
        }
    })
    .then(res => {
        if(res.status === 200) return res.data;
    })
    .catch(err => {
        console.log(err);
    })
}