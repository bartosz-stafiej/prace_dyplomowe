# frozen_string_literal: true

require 'rails_helper'

describe Employee, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:last_name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:role).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

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
