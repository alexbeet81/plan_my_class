# == Schema Information
#
# Table name: classrooms
#
#  id         :bigint           not null, primary key
#  columns    :integer
#  name       :string
#  rows       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint           not null
#
# Indexes
#
#  index_classrooms_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => teachers.id)
#
require 'rails_helper'

RSpec.describe Classroom, type: :model do
  let(:teacher) { create(:teacher) } # This makes 'teacher' available in the examples.

  it 'is valid with valid attributes' do
    classroom = Classroom.new(name: 'Math 101', rows: 5, columns: 5, teacher: teacher)
    expect(classroom).to be_valid
  end

  it 'is not valid without a name' do
    classroom = Classroom.new(rows: 5, columns: 5, teacher: teacher)
    expect(classroom).not_to be_valid
  end

  it 'is not valid without rows' do
    classroom = Classroom.new(name: 'Math 101', columns: 5, teacher: teacher)
    expect(classroom).not_to be_valid
  end

  it 'is not valid without columns' do
    classroom = Classroom.new(name: 'Math 101', rows: 5, teacher: teacher)
    expect(classroom).not_to be_valid
  end

  describe "associations" do
    it "can have many students" do
      classroom = create(:classroom)
      students = create_list(:student, 3)
      classroom.students << students

      expect(classroom.students.count).to eq(3)
    end
  end
end