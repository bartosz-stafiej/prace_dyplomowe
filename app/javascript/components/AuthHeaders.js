import React from 'react';
import { Link } from 'react-router-dom';

export const CurrentUserHeader = () => {
    return ( 
        // here goes current user check
        <>
            <li>
                <Link to='/users/edit' className='nav-link px-2 text-white' >
                    My profile
                </Link>
            </li>
            <li>
                <Link to={'/users/me/graduation_works'} className='nav-link px-2 text-white'>
                    My Graduation Works
                </Link>
            </li>
        </>
    )
}

export const CurrentScienceWorkerHeader = () => {
    return ( 
        // here goes current science worker check
        <>
            <li>
                <Link to='/students/me/graduation_works/new' className='nav-link px-2 text-white' >
                    Add Graduation Work
                </Link>
            </li>
            <li>
                <Link to='/raports/new' className='nav-link px-2 text-white'>
                    Generate raport
                </Link>
            </li>
        </>
    )
}