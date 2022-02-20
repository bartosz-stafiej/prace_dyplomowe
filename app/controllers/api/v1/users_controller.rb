# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def me
        render json: me_blueprint.render(current_user), status: :ok
      end

      def update
        contract = Users::UpdateContract.new
        validation_result = validate!(contract)

        current_user.update(validation_result.to_h)

        render json: me_blueprint.render(current_user), status: :ok
      end

      private

      def me_blueprint
        @me_blueprint ||= case current_user.type
                          when 'Student' then StudentBlueprint
                          when 'Employee' then EmployeeBlueprint
                          end
      end
    end
  end
end
