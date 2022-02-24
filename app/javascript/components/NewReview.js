import React, { useState } from 'react';
import { useAuth } from '../contexts/authContext';
import createReview from '../actions/createReview';
import { useNavigate } from 'react-router-dom';
import { useParams } from 'react-router-dom';

const NewReview = () => {
    const { user, csrf } = useAuth();
    const [input, setInput] = useState();
    const { id } = useParams('');
    const navigate = useNavigate();

    function handleChange(e) {
        setInput({...input, [e.target.id]: e.target.value});
    }

    async function handleSubmit(e) {
        e.preventDefault();
        
        await createReview(input, user.tokens.access_token.token, csrf, id);
        navigate('/');
    }

    if (!user) navigate('/');

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
                                            <img className="rounded-circle mt-5" width="150px" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxcbLJB8h01-Ae_J0w4i8MLm-jMNqigGplhA&usqp=CAU" />
                                                <span className="font-weight-bold">email</span>
                                                <span className="text-black-50">{ user.email }</span>
                                                <span> </span>
                                        </div>
                                    </div>
                                    <div className="col-md-8 border-right">
                                        <div className="p-3 py-5">
                                            <div className="d-flex justify-content-between align-items-center mb-3">
                                                <h4 className="text-right">Add new Review</h4>
                                            </div>
                                            <form method="" onSubmit={handleSubmit}>
                                                <div className="row mt-2">
                                                    <div className="col-md-6">
                                                        <label className="labels">Grade</label>
                                                        <select id="grade" onChange={handleChange}>
                                                            <option value="">Select grade</option>
                                                            <option value="5.0">5.0</option>
                                                            <option value="4.5">4.5</option>
                                                            <option value="4.0">4.0</option>
                                                            <option value="3.5">3.5</option>
                                                            <option value="3.0">3.0</option>
                                                            <option value="2.0">2.0</option>
                                                        </select>
                                                    </div>
                                                    <div className="col-md-6">
                                                    </div>
                                                </div>
                                                <div className="row mt-3">
                                                    <div className="col-md-12">
                                                        <label className="labels">Comment</label>
                                                        <textarea
                                                            type="text"
                                                            id="comment"
                                                            className="form-control"
                                                            placeholder="Place here your comment..."
                                                            onChange={handleChange}
                                                        />
                                                    </div>
                                                </div>
                                                <div className="row mt-3">
                                                    <div className="col-md-12">
                                                        <label className="labels">Date of Issue</label>
                                                        <input type="date" id="date_of_issue" className="form-control" onChange={handleChange} />
                                                    </div>
                                                </div>
                                                <div className="row mt-3">
                                                    <div className="col-md-12">
                                                        <label className="labels">Reviewer Email</label>
                                                        <input type="text" id="reviewer_email" className="form-control" onChange={handleChange} />
                                                    </div>
                                                </div>
                                                <div className="mt-5 text-center">
                                                    <button type="submit" className="btn btn-primary profile-button">
                                                        Save Review
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
    )
}

export default NewReview;