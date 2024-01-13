# == Schema Information
#
# Table name: classrooms
#
#  id                       :bigint           not null, primary key
#  columns                  :integer
#  name                     :string
#  rows                     :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  current_seating_chart_id :bigint
#  teacher_id               :bigint           not null
#
# Indexes
#
#  index_classrooms_on_current_seating_chart_id  (current_seating_chart_id)
#  index_classrooms_on_teacher_id                (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (current_seating_chart_id => seating_charts.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class Classroom < ApplicationRecord
  belongs_to :teacher
  has_and_belongs_to_many :students
  has_many :seating_charts, dependent: :destroy
  belongs_to :current_seating_chart, class_name: 'SeatingChart', foreign_key: 'current_seating_chart_id', optional: true


  validates :name, presence: true
  validates :rows, :columns, presence: true,
                             numericality: { only_integer: true, greater_than: 0 }
end
