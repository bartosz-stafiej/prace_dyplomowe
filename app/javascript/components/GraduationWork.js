import React from 'react';
import { useParams } from 'react-router-dom';
import PageNotFound from './errors/PageNotFound';
import Spinner from './Spinner';
import useFetch from '../services/useFetch';
import Reviews from './Reviews';
import ThesisDefenses from './ThesisDefenses'

const GraduationWork = () => {
    const { id } = useParams('');

    const { 
        data: graduationWork,
        error,
        loading,
    } = useFetch(`/graduation_works/${id}`, 'graduation_work');

    if(error) throw error;
    if(loading) return <Spinner />
    if(!graduationWork) return <PageNotFound />

    return (
        <div className="index-content">
            <div className="container">
                <div className="w-100">
                    <div className="card">
                        <div className="mb-5 d-flex justify-content-between">
                            <div className="w-50">
                                <div key={id}>
                                    <h4>Topic:</h4>
                                    <p>{graduationWork.topic}</p>
                                    <h4>Title:</h4>
                                    <p>{graduationWork.title}</p>
                                    <br />
                                    <h4>Date of submission:</h4>
                                    <p>{graduationWork.date_of_submission}</p>
                                    <br />
                                    <h4>Final Grade:</h4>
                                        {graduationWork.thesis_defenses.map((defence) => {
                                            return (
                                            <p>
                                                {'Autor: ' + defence.author.first_name + ' ' + defence.author.last_name + ',' }<br />
                                                {'Grade: ' + defence.final_grade }
                                            </p>
                                            )
                                        })}
                                </div>
                            </div>
                            <div className="w-50">
                                <h4>Address of defence:</h4>
                                {graduationWork.thesis_defenses.map((defence) => {
                                    return(
                                        <>
                                            <p>{defence.defence_address}</p>
                                            <h4>Authors:</h4>
                                            <p>{defence.author.first_name + ' ' + defence.author.last_name}</p>
                                        </>
                                    )
                                })}
                                <h4>Supervisor:</h4>
                                <p>{graduationWork.supervisor.academic_degree + ' ' + graduationWork.supervisor.first_name + ' ' + graduationWork.supervisor.last_name}</p>
                            </div>
                        </div>
                    </div>
                    <div className="mt-3">
                        <ul className="list list-inline">
                            <div className="d-flex justify-content-between">
                                <div className="container">
                                    {/* <% if current_employee && @graduation_work.supervisor_id == current_employee.id && !Review.exists?(graduation_work_id: @graduation_work.id, reviewer_id: current_employee.id) %>
                                        <%= link_to 'Add review', new_graduation_work_review_path(@graduation_work), className: 'nav-link px-2 text-dark' %>
                                    <% end %> */}
                                </div>
                                <div className="container">
                                    {/* <% if current_deans_worker? %>
                                        <%= link_to 'Add thesis defence', new_graduation_work_thesis_defense_path(@graduation_work), className: 'nav-link px-2 text-dark' %>
                                    <% end %> */}
                                </div>
                            </div>
                            <Reviews reviews={graduationWork.reviews}/>
                            <br />
                            <ThesisDefenses thesis_defenses={graduationWork.thesis_defenses} />
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default GraduationWork;