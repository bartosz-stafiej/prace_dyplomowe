import React from 'react';
import { Route, Routes } from 'react-router-dom';
import GraduationWorks from './GraduationWorks';
import GraduationWork from './GraduationWork';
import Profile from './Profile';
import Header from './Header';
import Login from './Login';
import NewGraduationWork from './NewGraduationWork'
import EditGraduationWork from './EditGraduationWork';
import NewReview from './NewReview';
import EditReview from './EditReview';
import useQuery from  '../services/useQuery'
import { AuthProvider } from '../contexts/authContext';

const App = () => {
    const { query, setQuery } = useQuery();

    return (
        <AuthProvider>
            <main>
                <Header setQuery={setQuery} query={query} />
                <Routes>
                    <Route path="/" 
                        element={<GraduationWorks 
                                    query={query}
                                    setQuery={setQuery}
                                    baseUrl="/graduation_works"
                                />}                
                    />
                    <Route path="/users/me/graduation_works" 
                        element={<GraduationWorks 
                                    query={query} 
                                    setQuery={setQuery} 
                                    baseUrl="/users/me/graduation_works"
                                />} 
                    />
                    <Route path="/graduation_works/:id" element={<GraduationWork />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/users/edit" element={<Profile />} />
                    <Route path="/graduation_works/new" element={<NewGraduationWork />} />
                    <Route path="/graduation_works/:id/edit" element={<EditGraduationWork />} />
                    <Route path="/graduation_works/:id/reviews/new" element={<NewReview />} />
                    <Route path="/graduation_works/:graduation_work_id/reviews/:id/edit" element={<EditReview />} />
                </Routes>
            </main>
        </AuthProvider>
    )
};

export default App;