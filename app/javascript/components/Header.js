import React from 'react';
import Logo from 'images/logo.png';
import { Link } from 'react-router-dom';
import { CurrentUserHeader, CurrentScienceWorkerHeader } from './AuthHeaders';
import { useAuth } from '../contexts/authContext';
import signOut from '../actions/signOut';
import { useNavigate } from 'react-router-dom';

const Header = ({query, setQuery}) => {
    const { user, csrf } = useAuth();
    const navigate = useNavigate();

    function handleChange(e) {
        setQuery({...query, page: 1, searchPhrase: e.target.value });
    }

    async function logoutUser() {
        const authToken = user.tokens.access_token.token;
        await signOut(authToken, csrf);
        await navigate('/');
        location.reload();
    }

    return (
        <header className="p-3 bg-dark text-white">
            <div className="container-fluid">
                <div className="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <Link to={'/'} className="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                        <img src={Logo} />
                    </Link>

                    <ul className="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                        {user && 
                            <CurrentUserHeader />
                        }
                        {user && user.type === 'Employee' &&
                            <CurrentScienceWorkerHeader />
                        }
                    </ul>

                    <form className="form-inline" method="get">
                        <input
                            className="form-control"
                            type="text"
                            value={query.searchPhrase}
                            onChange={handleChange}
                            placeholder="Search"
                            aria-label="Search"
                        />
                    </form>


                    {user && 
                        <div className="text-end">
                            <button to='/users/sign_out' className="btn btn-warning" onClick={logoutUser}>
                                Logout
                            </button>
                        </div>
                    }
                    {!user && 
                        <div className="text-end">
                            <Link to='/login' className="btn btn-warning">
                                Login
                            </Link>
                        </div>
                    }
                </div>
            </div>
        </header>
    )
}

export default Header;