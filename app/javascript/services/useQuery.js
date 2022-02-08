import { useState } from "react";

export const DEFAULT_PAGINATION_PARAMS = {
    items: 20,
    page: 1,
}

export default function useQuery() {
    const [query, setQuery] = useState({});

    if (!query.page) setQuery({...query, ...DEFAULT_PAGINATION_PARAMS});
    
    return { query, setQuery }
}