import React, { useState } from 'react';
import useFetch from '../services/useFetch';
import { useAuth } from '../contexts/authContext';
import Spinner from '../components/Spinner';
import updateProfile from '../actions/updateProfile';
import { useNavigate } from 'react-router-dom';

const Profile = () => {
    const [input, setInput] = useState({});
    const { user, csrf } = useAuth();
    const navigate = useNavigate();

    const auth_token = user ? user.tokens.access_token.token : null;
    const {
        data: me,
        loading,
        error
    } = useFetch('/users/me', null, auth_token);

    const handleChange = async (e) => {
        await setInput({...input, [e.target.id]: e.target.value});
    }

    async function handleSubmit(e) {
        e.preventDefault();
        const allowed = ['email', 'first_name', 'last_name', 'academic_degree', 'telephone_number']
        const filtered = Object.entries(input).filter(arr => allowed.includes(arr[0]) && arr[1] !== '');
        const selectedInput = Object.fromEntries(filtered);

        await updateProfile(selectedInput, csrf, auth_token);
        location.reload();
    }

    if (!user) navigate('/');
    if (loading) return <Spinner />
    if(error) throw error;

    return (
        <div className="index-content">
            <div className="container">
                    <div href="blog-ici.html" className="w-100">
                        <div className="card">
                            <div className="mb-5 d-flex justify-content-between">
                                <div className="container rounded bg-white mt-5 mb-5">
                                    <div className="row">
                                        <div className="col-md-4 border-right">
                                            <div className="d-flex flex-column align-items-center text-center p-3 py-5">
                                                <img className="rounded-circle mt-5" width="150px" src="https://icons-for-free.com/iconfiles/png/512/student+icon-1320184412790928936.png" />
                                                    <span className="font-weight-bold">email</span>
                                                    <span className="text-black-50">{ me.email }</span>
                                                    <span> </span>
                                            </div>
                                        </div>
                                        <div className="col-md-8 border-right">
                                            <div className="p-3 py-5">
                                                <div className="d-flex justify-content-between align-items-center mb-3">
                                                    <h4 className="text-right">Profile Settings</h4>
                                                </div>
                                                <form onSubmit={handleSubmit} method="" >
                                                    <div className="row mt-2">
                                                        <div className="col-md-6">
                                                            <label className="labels">Name</label>
                                                            <input 
                                                                type="text"
                                                                id="first_name"
                                                                className="form-control"
                                                                placeholder={me.first_name}
                                                                onChange={handleChange}
                                                            />
                                                        </div>
                                                        <div className="col-md-6">
                                                            <label className="labels">Surname</label>
                                                            <input
                                                                type="text"
                                                                id="last_name"
                                                                className="form-control"
                                                                placeholder={me.last_name}
                                                                onChange={handleChange}
                                                            />
                                                        </div>
                                                    </div>
                                                    <div className="row mt-3">
                                                        <div className="col-md-12">
                                                            <label className="labels">Email</label>
                                                            <input 
                                                                type="text"
                                                                id="email"
                                                                className="form-control"
                                                                placeholder={me.email}
                                                                onChange={handleChange}
                                                            />
                                                        </div>
                                                        {me.type === 'Student' &&
                                                            <>
                                                                <div className="col-md-12">
                                                                    <label className="labels">Telephone Number</label>
                                                                    <input
                                                                        type="text"
                                                                        id="telephone_number"
                                                                        className='form-control'
                                                                        placeholder={me.telephone_number}
                                                                        onChange={handleChange}
                                                                    />
                                                                </div>
                                                                <div className="col-md-12">
                                                                    <label className="labels">Index: </label>
                                                                    <input
                                                                        type="text"
                                                                        id="index"
                                                                        className='form-control'
                                                                        value={me.index}
                                                                        onChange={handleChange}
                                                                        disabled="true"
                                                                    />
                                                                </div>
                                                            </>
                                                        }
                                                        {me.type === 'Employee' &&
                                                            <div className="col-md-12">
                                                                <label className="labels">Academic degree</label>
                                                                <input
                                                                    type="text"
                                                                    id="academic_degree"
                                                                    className="form-control"
                                                                    placeholder={me.academic_degree}
                                                                    onChange={handleChange}
                                                                />
                                                            </div>
                                                        }
                                                    </div>
                                                    <div className="mt-5 text-center">
                                                        <button type="submit" className="btn btn-primary profile-button">
                                                            Save Profile
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    );
}

export default Profile;