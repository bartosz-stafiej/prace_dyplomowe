module Reviews
    class Create
        def initialize(data:, graduation_work:)
            @data = data
            @graduation_work = graduation_work
        end

        def call
            reviewer = Employee.find_by(email: data[:reviewer_email])

            graduation_work.reviews.create(
                **data.except(:reviewer_email),
                reviewer: reviewer
            )
        end

        private

        attr_reader :data, :graduation_work
    end
end