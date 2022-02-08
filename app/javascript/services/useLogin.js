import { useState, useEffect } from 'react';
import { apiPost } from './apiService';
import { apiGet } from './apiService'

export default function useLogin(url, requestBody) {
    const [response, setResponse] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        async function init() { 
          try {
            await apiPost(url, requestBody);
            const res = await apiGet('/users/me');
            await setResponse(res);
          } catch(e) {
            setError(e);
          } finally {
            setLoading(false);
          }
        }
        init();
      }, [url]);

    return {
      response,
      error,
      loading
    }
}
