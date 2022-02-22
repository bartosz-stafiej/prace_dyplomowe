import axios from 'axios';

export default async function createGraduationWork(input, auth, csrf) {
    await axios.post('/api/v1/graduation_works',
    {...input},
    {
        headers: {
            'Content-Type': 'application/json',
            "Authorization": auth,
            "X-CSRF-Token": csrf,
        }
    })
    .then(res => {
        if (res === 201) return
    })
    .catch(e => {
        console.log(e);
    });
}