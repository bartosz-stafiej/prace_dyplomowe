# frozen_string_literal: true

require 'rails_helper'

describe GraduationWork, type: :model do
  it { should have_db_column(:title).of_type(:string).with_options(null: true) }
  it { should have_db_column(:topic).of_type(:string).with_options(null: false) }
  it { should have_db_column(:date_of_submission).of_type(:datetime).with_options(null: false) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:stage_of_study)
      .inverse_of(:graduation_works)
      .required
  }

  it {
    should belong_to(:supervisor)
      .class_name(:Employee)
      .inverse_of(:graduation_works)
      .required
  }

  it {
    should have_many(:thesis_defenses)
      .inverse_of(:graduation_work)
      .dependent(:delete_all)
  }

  it {
    should have_many(:key_words)
      .inverse_of(:graduation_work)
      .dependent(:nullify)
  }

  it {
    should have_many(:reviews)
      .inverse_of(:graduation_work)
      .dependent(:delete_all)
  }
end
