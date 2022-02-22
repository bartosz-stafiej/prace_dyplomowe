# frozen_string_literal: true

module GraduationWorks
  class Create
    def initialize(data:)
      @data = data
    end

    def call
      create_graduation_work(data)
    end

    private

    def create_graduation_work(data)
      supervisor = Employee.find_by(email: data[:supervisor_email])

      GraduationWork.create!(
        **data.except(:supervisor_email),
        supervisor: supervisor
      )
    end

    attr_reader :data
  end
end
