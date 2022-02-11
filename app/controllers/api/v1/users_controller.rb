module Api
    module V1
        class UsersController < BaseController
            def me
                me_blueprint = case current_user.type
                                when 'Student' then StudentBlueprint
                                when 'Employee' then EmployeeBlueprint
                               end
                    

                render json: me_blueprint.render(current_user), status: :ok
            end
        end
    end
end