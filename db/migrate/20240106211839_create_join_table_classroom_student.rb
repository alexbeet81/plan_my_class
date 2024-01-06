class CreateJoinTableClassroomStudent < ActiveRecord::Migration[7.1]
  def change
    create_join_table :classrooms, :students do |t|
      t.index [:classroom_id, :student_id]
      t.index [:student_id, :classroom_id]
    end
  end
end
