import React from 'react';
import { Link } from 'react-router-dom';
import NoResults from './errors/NoResults';
import Spinner from './Spinner';
import useFetch from '../services/useFetch';
import Pagination from './Pagination';

export const DEFAULT_PAGINATION_PARAMS = {
    items: 20,
    page: 1,
}

const GraduationWorks = ({query, setQuery}) => {
    const {
        data: graduationWorks,
        error,
        loading,
        itemCount
    } = useFetch('/graduation_works' +
                `?items=${query.items || DEFAULT_PAGINATION_PARAMS.items}` +
                `&page=${query.page || DEFAULT_PAGINATION_PARAMS.page}` +
                `&search_phrase=${query.searchPhrase || ''}`,
                'graduation_works');

    function renderGraduationWork(gd) {
        return (
            <li key={gd.id} className="d-flex justify-content-between">
                <div className="d-flex flex-row align-items-center">
                    <div className="ml-2">
                        <h6 className="mb-0">{gd.title}</h6>
                        <div className="d-flex flex-row mt-1 text-black-50 date-time">
                            <div><span className="ml-2">Topic: {gd.topic}</span></div><br />
                            <div><span className="ml-2">, Date of submission: {gd.date_of_submission}</span></div><br />
                        </div>
                    </div>
                </div>
                <div className="d-flex flex-row align-items-center">
                    {/* <% if current_deans_worker? %>
                        <div className="d-flex flex-column mr-2">
                            <div className="profile-image">
                                <%= button_to 'Update', edit_graduation_work_path(gd), className: 'btn btn-primary mr-5', method: :get %>
                            </div>
                        </div> 
                    <% end %> */}
                    <div className="d-flex flex-column mr-2">
                        <div className="profile-image">
                            <Link to={`/graduation_works/${gd.id}`} className="btn btn-primary">Details</Link>
                        </div>
                    </div>
                </div>
            </li>
        )
    }

    if (error) throw error;
    if (loading) return <Spinner />
    if (graduationWorks.length === 0) return <NoResults query={query}/>;

    return (
        <div className="container mt-5">
            <div className="row">
                <div className="col-md-12">
                    <div className="d-flex justify-content-between align-items-center activity">
                        <div>
                            <span className="activity-done">
                                {/* <% if params[:me_scope] %>
                                Yours
                                <% end %> */}
                                Graduations Work
                            </span>
                        </div>
                        {/* <% if current_deans_worker? %>
                            <a href='/students/me/graduation_works/new' style="text-decoration:none;">
                                Add graduation work
                            </a>
                        <% end %> */}
                        <Pagination setQuery={setQuery} query={query} itemCount={itemCount}/>
                    </div>
                    <div className="mt-3">
                        <ul className="list list-inline">
                            {graduationWorks.map((gd) => renderGraduationWork(gd))}
                        </ul>
                    </div>
                    <div className="d-flex justify-content-between align-items-center activity">
                        <div>
                            <span className="activity-done"></span>
                        </div>
                        <Pagination setQuery={setQuery} query={query} itemCount={itemCount}/>
                    </div>
                </div>
            </div>
        </div>
    )
};

export default GraduationWorks;