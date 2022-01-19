# frozen_string_literal: true

require 'rails_helper'

describe Student, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
  it { should have_db_column(:telephone_number).of_type(:string).with_options(null: false) }
  it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:last_name).of_type(:string).with_options(null: false) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:college)
      .inverse_of(:students)
      .optional
  }

  it {
    should have_many(:thesis_defenses)
      .inverse_of(:author)
      .dependent(:nullify)
  }
end
