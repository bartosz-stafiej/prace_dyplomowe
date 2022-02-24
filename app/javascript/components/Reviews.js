import React from "react";
import { Link, useParams } from 'react-router-dom';

const Reviews = ({reviews, user}) => {
    const { id } = useParams();

    return (
        <>
            {reviews.length > 0 &&
                <span className="activity-done">
                    Reviews:
                </span>
            }
            {reviews.map((review) => {
                return (
                    <li className="d-flex justify-content-between" key={review.id}>
                        <div className="d-flex flex-row align-items-center">
                            <div className="ml-2">
                                <h6 className="mb-0">Author: {review.reviewer?.first_name + ' ' + review.reviewer?.last_name}</h6>
                                <div className="d-flex flex-row mt-1 text-black-50 date-time">
                                    <div><span className="ml-2">Grade: { review.grade }</span></div><br />
                                    <div><span className="ml-2">, Comment: { review.comment }</span></div><br />
                                    <div className="ml-3"><span className="ml-2">{ }</span></div>
                                </div>
                            </div>
                        </div>
                        <div className="d-flex flex-row align-items-center">
                            <div className="d-flex flex-column mr-2">
                                <div className="profile-image">
                                    { user && user.type === 'Employee' &&
                                        <div className="d-flex flex-column mr-2">
                                            <div className="profile-image">
                                                <Link 
                                                    to={`/graduation_works/${id}/reviews/${review.id}/edit`}
                                                    className="btn btn-primary mr-5">
                                                    Update
                                                </Link>
                                            </div>
                                        </div>
                                    }
                                </div>
                            </div>
                        </div>
                    </li>
                )
            })}
        </>
    )
}


export default Reviews;