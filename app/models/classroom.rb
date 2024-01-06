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
class Classroom < ApplicationRecord
  belongs_to :teacher

  validates :name, presence: true
  validates :rows, :columns, presence: true,
                             numericality: { only_integer: true, greater_than: 0 }
end
