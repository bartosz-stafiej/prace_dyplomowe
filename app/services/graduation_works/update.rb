# frozen_string_literal: true

module GraduationWorks
  class Update
    def initialize(data:, graduation_work:)
      @data = data
      @graduation_work = graduation_work
    end

    def call
      transaction do
        graduation_work.update(
          data.except(:supervisor_email)
        )

        update_dependency if data[:supervisor_email]

        graduation_work
      end
    end

    private

    def update_dependency
      supervisor = Employee.find_by(email: data[:supervisor_email])

      graduation_work.update(supervisor: supervisor)
    end

    delegate :transaction, to: :ApplicationRecord, private: true

    attr_reader :data, :graduation_work
  end
end
