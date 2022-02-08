import React from 'react';

const Pagination = ({ query, setQuery, itemCount }) => {
    return (
        <nav aria-label="Page navigation example">
            <ul className="pagination">
                <li className="page-item">
                { query.page > 1 &&
                <a 
                    className="page-link"
                    onClick={() => { setQuery({...query, page: query.page - 1}) }}
                    aria-label="Previous"
                >
                    <span aria-hidden="true">&laquo;</span>
                    <span className="sr-only">Previous</span>
                </a>
                }
                </li>
                <li className="page-item"><div className="page-link">...</div></li>
                <li className="page-item"><div className="page-link">{query.page || 1}</div></li>
                <li className="page-item"><div className="page-link">...</div></li>
                <li className="page-item">
                { query.page < (itemCount / query.items) &&
                <a 
                    className="page-link"
                    onClick={() => { setQuery({...query, page: query.page + 1}) }}
                    aria-label="Next"
                >
                    <span aria-hidden="true">&raquo;</span>
                    <span className="sr-only">Next</span>
                </a>
                }
                </li>
            </ul>
        </nav>
    )
}

export default Pagination;