# frozen_string_literal: true

class RecreateUsersTableWithoutDevise < ActiveRecord::Migration[6.1]
  USER_TYPES = %w[Student Employee].freeze

  def up
    remove_index :users, :reset_password_token, unique: true

    change_table :users do |t|
      t.remove :encrypted_password, null: false, default: ''
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at

      t.column :password_digest, :string, null: false
      t.column :authentication_token, :string, null: false

      t.index :authentication_token, unique: true
    end
  end

  def down
    remove_index :users, :authentication_token, unique: true

    change_table :users do |t|
      t.column :encrypted_password, :string, null: false, default: ''
      t.column :reset_password_token, :string
      t.column :reset_password_sent_at, :string
      t.column :remember_created_at, :datetime

      t.remove :password_digest, null: false
      t.remove :authentication_token, null: false
    end

    add_index :users, :reset_password_token, unique: true
  end
end
