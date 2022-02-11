# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it { should have_db_column(:email).of_type(:string).with_options(null: false) }
  it { should have_db_column(:authentication_token).of_type(:string).with_options(null: false) }
  it { should have_db_column(:password_digest).of_type(:string).with_options(null: false) }
  it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:last_name).of_type(:string).with_options(null: false) }
  it { should have_db_column(:type).of_type(:string).with_options(null: false) }
  it { should have_db_column(:role).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:index).of_type(:integer).with_options(null: true) }
  it { should have_db_column(:academic_degree).of_type(:string).with_options(null: true) }
  it { should have_db_column(:telephone_number).of_type(:string).with_options(null: true) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
end
