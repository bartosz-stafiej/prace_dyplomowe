require 'rails_helper'

describe Employee, type: :model do
    it {
        should have_many(:graduation_works)
          .inverse_of(:supervisor)
          .dependent(:nullify)
      }

    it {
        should have_many(:thesis_defenses)
            .inverse_of(:evaluator)
            .dependent(:nullify)
    }

    it {
        should have_many(:reviews)
            .inverse_of(:reviewer)
            .dependent(:nullify)
    }
end