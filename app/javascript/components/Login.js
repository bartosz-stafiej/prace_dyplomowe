import React from "react";
import useLogin from '../services/useLogin';
import { useAuth } from '../contexts/authContext'
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const { setUser } = useAuth();
    const navigate = useNavigate();

    function handleSubmit(event) {
        const res = useLogin('/users/sign_in', event.target.value);
        setUser(res);
        debugger;
        navigate('/graduation_works');
    }

    return (
        <main className="login-form">
            <div className="cotainer">
                <div className="row justify-content-center">
                    <div className="col-md-8">
                        <div className="card">
                            <div className="card-header">Login</div>
                            <div className="card-body">
                                <form action="" method="post" onSubmit={handleSubmit}>
                                    <div className="form-group row">
                                        <label htmlFor="email" className="col-md-4 col-form-label text-md-right">E-Mail Address</label>
                                        <div className="col-md-6">
                                            <input type="text" id="email" className="form-control" name="user[email]" required autoFocus />
                                        </div>
                                    </div>

                                    <div className="form-group row">
                                        <label htmlFor="password" className="col-md-4 col-form-label text-md-right">Password</label>
                                        <div className="col-md-6">
                                            <input type="password" id="password" className="form-control"  name="user[password]" required />
                                        </div>
                                    </div>


                                    <div className="col-md-6 offset-md-4">
                                        <button type="submit" className="btn btn-primary" >
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