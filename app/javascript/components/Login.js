import React, { useState } from "react";
import { useAuth } from '../contexts/authContext'
import singIn from "../actions/signIn";
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const [input, setInput] = useState({});
    const { csrf } = useAuth();
    const navigate = useNavigate();

    const handleChange = (e) => {
        setInput({...input, [e.target.id]: e.target.value});
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        await singIn(input, csrf);
        await navigate('/');
        location.reload();
    }

    return (
        <main className="login-form">
            <div className="cotainer">
                <div className="row justify-content-center">
                    <div className="col-md-8">
                        <div className="card">
                            <div className="card-header">Login</div>
                            <div className="card-body">
                                <form action="" onSubmit={handleSubmit}>
                                    <div className="form-group row">
                                        <label htmlFor="email" className="col-md-4 col-form-label text-md-right">E-Mail Address</label>
                                        <div className="col-md-6">
                                            <input
                                                type="text"
                                                id="email"
                                                className="form-control"
                                                name="user[email]"
                                                onChange={handleChange}
                                                required
                                                autoFocus
                                            />
                                        </div>
                                    </div>

                                    <div className="form-group row">
                                        <label htmlFor="password" className="col-md-4 col-form-label text-md-right">Password</label>
                                        <div className="col-md-6">
                                            <input
                                                type="password"
                                                id="password"
                                                className="form-control"
                                                name="user[password]"
                                                onChange={handleChange}
                                                required 
                                            />
                                        </div>
                                    </div>


                                    <div className="col-md-6 offset-md-4">
                                        <button type="submit" className="btn btn-primary">
                                            Login
                                        </button>
                                        {/*<%= render "devise/shared/links" %>*/}
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    )
}

export default Login;