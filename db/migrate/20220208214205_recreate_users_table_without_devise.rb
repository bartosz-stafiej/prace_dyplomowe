class RecreateUsersTableWithoutDevise < ActiveRecord::Migration[6.1]
  USER_TYPES = %w[Student Employee]

  def change
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
end
