import { useState, useEffect } from 'react';
import { apiPost } from './apiService';

export default function usePost(url, requestBody, auth, csrf) {
    const [response, setResponse] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        async function init() { 
          try {
            const res = await apiPost(url, requestBody, auth, csrf);
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
