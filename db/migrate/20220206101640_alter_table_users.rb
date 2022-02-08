class AlterTableUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.column :type, :string, null: true
      t.column :index, :integer, null: true
      t.column :telephone_number, :string, null: true

      t.references :college, foreign_key: true
    end

    fill_null_types

    change_column_null(:users, :type, false)
    change_column_null(:users, :academic_degree, true)
    

    add_reference :thesis_defenses, :author, foreign_key: { to_table: :users }
  end

  private

  def fill_null_types
    User.all.each do |user|
      if user.type.nil?
        type = user.email.include?('student') ? 'Student' : 'Employee'
        user.update(type: type)
      end
    end
  end
end
