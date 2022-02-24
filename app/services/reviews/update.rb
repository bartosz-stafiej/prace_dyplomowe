# frozen_string_literal: true

module Reviews
  class Update
    def initialize(data:, review:)
      @data = data
      @review = review
    end

    def call
      transaction do
        review.update(
          data.except(:reviewer_email)
        )

        update_dependency if data[:reviewer_email]

        review
      end
    end

    private

    def update_dependency
      reviewer = Employee.find_by(email: data[:reviewer_email])

      review.update(reviewer: reviewer)
    end

    delegate :transaction, to: :ApplicationRecord, private: true

    attr_reader :data, :review
  end
end
