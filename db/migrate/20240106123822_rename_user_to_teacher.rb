class RenameUserToTeacher < ActiveRecord::Migration[7.1]
  def change
    rename_table :users, :teachers
  end
end
