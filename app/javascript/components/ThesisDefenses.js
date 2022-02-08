import React from 'react';

const ThesisDefenses = ({thesis_defenses}) => {
    return (
        <>
            { thesis_defenses.length > 0 &&
                <span className="activity-done">
                    Thesis defences:
                </span>
            }
            { thesis_defenses.map((td) => {
                return (
                    <li className="d-flex justify-content-between" key={td.id}>
                        <div className="d-flex flex-row align-items-center">
                            <div className="ml-2">
                                <h6 className="mb-0">Author: {td.author.first_name + ' ' + td.author.last_name }</h6>
                                <div className="d-flex flex-row mt-1 text-black-50 date-time">
                                    <div><span className="ml-2">Final Grade: {td.final_grade }</span></div><br />
                                    <div><span className="ml-2">, Evaluator: { td.evaluator?.first_name + ' ' + td.evaluator?.last_name }</span></div><br />
                                    <div><span className="ml-2">, address: {td.defence_address }</span></div><br />
                                    <div className="ml-3"><span className="ml-2">{}</span></div>
                                </div>
                            </div>
                        </div>
                        <div className="d-flex flex-row align-items-center">
                            <div className="d-flex flex-column mr-2">
                                <div className="profile-image">
                                    {/* <% if current_deans_worker? %>
                                        <div className="d-flex flex-column mr-2">
                                            <div className="profile-image">
                                            <%= button_to 'Update', edit_graduation_work_thesis_defense_path(@graduation_work, td), className: 'btn btn-primary mr-5', method: :get %>
                                        </div>
                                        </div>
                                    <% end %> */}
                                </div>
                            </div> 
                        </div>
                    </li>
                )
            })}
        </>
    )
}

export default ThesisDefenses;