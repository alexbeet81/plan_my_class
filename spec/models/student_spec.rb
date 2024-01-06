# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "associations" do
    it "can belong to many classrooms" do
      student = create(:student)
      classrooms = create_list(:classroom, 2)
      student.classrooms << classrooms

      expect(student.classrooms.count).to eq(2)
    end
  end
end
