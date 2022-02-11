# frozen_string_literal: true

class DeviseCreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :telephone_number,   null: false
      t.string :first_name,         null: false
      t.string :last_name,          null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
      t.references :college, foreign_key: true

      t.timestamps null: false
    end

    add_index :students, :email,                unique: true
    add_index :students, :reset_password_token, unique: true
  end
end
