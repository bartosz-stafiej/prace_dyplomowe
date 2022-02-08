import React from 'react';
import { Route, Routes } from 'react-router-dom';
import GraduationWorks from './GraduationWorks';
import GraduationWork from './GraduationWork';
import Header from './Header';
import Login from './Login';
import useQuery from  '../services/useQuery'
import { AuthProvider } from '../contexts/authContext';

const App = () => {
    const { query, setQuery } = useQuery();

    return (
        <AuthProvider>
            <main>
                <Header setQuery={setQuery} query={query} />
                <Routes>
                    <Route path="/" element={<GraduationWorks query={query} setQuery={setQuery} />} />
                    <Route path="/graduation_works/:id" element={<GraduationWork />} />
                    <Route path="/users/sign_in" element={<Login />} />
                </Routes>
            </main>
        </AuthProvider>
    )
};

export default App;