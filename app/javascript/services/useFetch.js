import { useState, useEffect } from 'react';
import { apiGet } from './apiService';

export default function useFetch(url, responseObject, auth='') {
    const [data, setData] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);
    const [itemCount, setItemCount] = useState(null);

    useEffect(() => {
        async function init() { 
          try {
            const json = await apiGet(url, auth);
            responseObject ? await setData(json[responseObject]) : await(setData(json));
            if(json['meta'] && json['meta']['item_count']) setItemCount(json['meta']['item_count'])
          } catch(e) {
            setError(e);
          } finally {
            setLoading(false);
          }
        }
        init();
      }, [url]);

    return {
      data,
      error,
      loading,
      itemCount
    }
}