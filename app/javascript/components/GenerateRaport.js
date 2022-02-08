import React from 'react';

const GenerateRaport = () => {
    return (
        <div className="index-content">
            <div className="container">
                    <div href="blog-ici.html" className="w-100">
                        <div className="card">
                            <div className="mb-5 d-flex justify-content-between">
                                <div className="container rounded bg-white mt-5 mb-5">
                                    <div className="row">
                                        <div className="col-md-4 border-right">
                                            <div className="d-flex flex-column align-items-center text-center p-3 py-5">
                                                <img className="rounded-circle mt-5" width="150px" 
                                                    src="https://media.istockphoto.com/vectors/business-report-icon-isolated-on-white-background-vector-id1359860011?b=1&k=20&m=1359860011&s=170667a&w=0&h=o4D_d9byQUfyCHgPKjiTYhLbif1Sl_iaFJprWvL22jA=" />

                                                    <span className="font-weight-bold"></span>
                                                    <span className="text-black-50"></span>
                                                    <span> </span>
                                            </div>
                                        </div>
                                        <div className="col-md-8 border-right">
                                            <div className="p-3 py-5">
                                                <div className="d-flex justify-content-between align-items-center mb-3">
                                                    <h4 className="text-right">Generate raport</h4>
                                                </div>
                                                <form method="post" raports_path do >
                                                    <div className="row mt-2">
                                                        <div className="col-md-6">
                                                            <label className="labels">Faculty</label>
                                                            <input type="text" className='form-control' placeholder='faculty' >
                                                        </div>
                                                        <div className="col-md-6">
                                                            <label className="labels">Field of Study</label>
                                                            <%= f.text_field :field_of_study, className: 'form-control', placeholder: 'field of study' %>
                                                        </div>
                                                    </div>
                                                    <div className="row mt-3">
                                                        <div className="col-md-12">
                                                            <label className="labels">Key words</label>
                                                            <%= f.text_field :key_word, className: 'form-control', placeholder: 'Key words' %>
                                                        </div>
                                                        <div className="row mt-2">
                                                            <div className="col-md-6">
                                                                <label className="labels">Date from:</label>
                                                                <%= f.date_field :date_from, className: 'form-control' %>
                                                            </div>
                                                            <div className="col-md-6">
                                                                <label className="labels">Date to:</label>
                                                                <%= f.date_field :date_to, className: 'form-control' %>
                                                            </div>
                                                        </div>                                                
                                                        <div className="col-md-12">
                                                            <label className="labels">Grade</label><br />
                                                            <%= f.select :grade, 
                                                            {
                                                                "Grade" => [
                                                                    ['Select', nil],
                                                                    ['5', 5.0],
                                                                    ['4', 4.0],
                                                                    ['3', 3.0],
                                                                    ['2', 2.0]
                                                                    ]
                                                            },
                                                            className: 'form-control'  %>
                                                        </div>
                                                        <div className="col-md-12">
                                                            <label className="labels">Supervisor email</label><br />
                                                            <%= f.text_field :supervisor, className: 'form-control', placeholder: 'supervisor email' %>
                                                        </div>
                                                        <div className="col-md-12">
                                                            <label className="labels">Evaluator email</label><br />
                                                            <%= f.text_field :evaluator, className: 'form-control', placeholder: 'evaluator email' %>
                                                        </div>
                                                    </div>
                                                    <div className="mt-5 text-center">
                                                        <%= f.submit 'Generate Raport', className: "btn btn-primary profile-button" %>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    )
}

export default GenerateRaport;