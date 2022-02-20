# frozen_string_literal: true

class RenameTableEmployeesToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :employees, :users
  end
end
