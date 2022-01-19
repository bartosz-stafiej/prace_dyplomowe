# frozen_string_literal: true

require 'rails_helper'

describe StageOfStudy do
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should have_many(:graduation_works)
      .inverse_of(:stage_of_study)
      .dependent(:nullify)
  }
end
