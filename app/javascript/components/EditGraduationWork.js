import React, { useState } from 'react';
import { useAuth } from '../contexts/authContext';
import useFetchAll from '../services/useFetchAll';
import Spinner from './Spinner';
import { useNavigate, useParams } from 'react-router-dom';
import updateGraduationWork from '../actions/updateGraduationWork';

const NewGraduationWork = () => {
    const { user, csrf } = useAuth();
    const [input, setInput] = useState({});
    const navigate = useNavigate();
    const { id } = useParams('');
    const urls = [
        `/graduation_works/${id}`,
        `/stage_of_studies`
    ]

    const { 
        data,
        error,
        loading,
    } = useFetchAll(urls);

    function handleChange(e) {
        if(e.target.id === 'stage_of_study_id') {
            setInput({...input, [e.target.id]: parseInt(e.target.value)})
        } else {
            setInput({...input, [e.target.id]: e.target.value})
        }
    }

    async function handleSubmit(e) {
        e.preventDefault();

        await updateGraduationWork(input, user.tokens.access_token.token, csrf, id);
        navigate('/');
    }

    if (!user) navigate('/');
    if (loading) return <Spinner />;
    if (error) throw error;

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
                                                    <h4 className="text-right">Edit Graduation Work</h4>
                                                </div>
                                                <form method="" onSubmit={handleSubmit}>
                                                    <div className="row mt-2">
                                                        <div className="col-md-6">
                                                            <label className="labels">Title</label>
                                                            <input type="text" id="title" 
                                                                className="form-control"
                                                                defaultValue={data[0].graduation_work.title}
                                                                onChange={handleChange}
                                                            />
                                                        </div>
                                                        <div className="col-md-6">
                                                            <label className="labels">Topic</label>
                                                            <input type="text" id="topic"
                                                                className="form-control"
                                                                defaultValue={data[0].graduation_work.topic}
                                                                onChange={handleChange}
                                                            />
                                                        </div>
                                                    </div>
                                                    <div className="row mt-3">
                                                        <div className="col-md-12">
                                                            <label className="labels">Date of sumbisson</label>
                                                            <input type="date" id="date_of_submission"
                                                                className="form-control"
                                                                onChange={handleChange}
                                                                defaultValue={
                                                                    data[0].graduation_work.date_of_submission.split(' ')[0]
                                                                }
                                                            />
                                                        </div>
                                                        <div className="col-md-12">
                                                            <label className="labels">Stage of studies</label><br />
                                                            <select 
                                                                className="form-control"
                                                                id="stage_of_study_id"
                                                                defaultValue={
                                                                    data[1].stage_of_studies.find(sos => {
                                                                        return sos.id === data[0].graduation_work.stage_of_study.id
                                                                    }).id
                                                                }
                                                                onChange={handleChange}
                                                            >
                                                                <option value="">Select stage of study</option>
                                                                {
                                                                    data[1].stage_of_studies.map(sot => {
                                                                        return (
                                                                            <option
                                                                                key={sot.id}
                                                                                value={sot.id}
                                                                            >
                                                                                {sot.name}
                                                                            </option>
                                                                        )
                                                                    })
                                                                }
                                                            </select>
                                                        </div>
                                                            <div className="col-md-12">
                                                                <label className="labels">Supervisor email</label><br />
                                                                <input type="text" id="supervisor_email"
                                                                    className="form-control"
                                                                    onChange={handleChange}
                                                                    defaultValue={data[0].graduation_work.supervisor.email}    
                                                                />
                                                            </div>
                                                    </div>
                                                    <div className="mt-5 text-center">
                                                        <button type="submit" className="btn btn-primary profile-button">
                                                            Save Graduation Work
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

export default NewGraduationWork;