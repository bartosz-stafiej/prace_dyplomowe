class DeleteTableStudents < ActiveRecord::Migration[6.1]
  def change
    remove_reference :thesis_defenses, :author
    drop_table :students
  end
end
