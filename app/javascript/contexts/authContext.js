import React, { useContext, useState, useEffect } from 'react';
import refreshToken from '../services/refreshToken';

export const AuthContext = React.createContext(null);

let initialUser;

try {
    initialUser = JSON.parse(localStorage.getItem("me")) ?? null;
} catch(e) {
    console.log(e + ": in initialUser authContext");
    initialUser = null;
}

export function AuthProvider(props) {
    const [user, setUser] = useState(initialUser);

    const csrf = document.querySelector('meta[name="csrf-token"]').content;

    useEffect(async () => {
        if (user) {
            const access_token_expires_at = new Date(user.tokens.access_token.expires_at);
            const refresh_token_expires_at = new Date(user.tokens.refresh_token.expires_at);
            const now = new Date();

            if(access_token_expires_at > now) {
                localStorage.setItem("me", JSON.stringify(user)), [user]
            } else if(refresh_token_expires_at > now) {
                await refreshToken(user, csrf);
            } 
            else {
                localStorage.removeItem("me");
            }
        };
    }, [user]);

    return (
        <AuthContext.Provider value={{user, setUser, csrf}}>
            {props.children}
        </AuthContext.Provider>
    );
};

export function useAuth() {
    const context = useContext(AuthContext);
    if(!context) throw new Error('useAuth must be used within a AuthProvider. Wrap a parent componenent in <AuthProvider>')

    return context;
};