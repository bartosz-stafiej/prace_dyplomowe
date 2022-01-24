# frozen_string_literal: true

class AddRoleToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :role, :integer, null: false, default: 1
  end
end
