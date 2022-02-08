import React, { useContext, useState } from 'react';

export const AuthContext = React.createContext(null);

let initialUser;

try {
    initialUser = JSON.parse(localStorage.getItem("me"));
} catch(e) {
    throw e;
}

export function AuthProvider(props) {
    const [user, setUser] = useState(initialUser);

    return (
        <AuthContext.Provider value={{user, setUser}}>
            {props.children}
        </AuthContext.Provider>
    );
};

export function useAuth() {
    const context = useContext(AuthContext);
    if(!context) throw new Error('useAuth must be used within a AuthProvider. Wrap a parent componenent in <AuthProvider>')

    return context;
};