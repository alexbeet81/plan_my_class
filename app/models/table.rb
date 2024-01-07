# == Schema Information
#
# Table name: tables
#
#  id               :bigint           not null, primary key
#  column_position  :string
#  row_position     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  seating_chart_id :bigint           not null
#  student_id       :bigint           not null
#
# Indexes
#
#  index_tables_on_seating_chart_id  (seating_chart_id)
#  index_tables_on_student_id        (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (seating_chart_id => seating_charts.id)
#  fk_rails_...  (student_id => students.id)
#
class Table < ApplicationRecord
  belongs_to :seating_chart
  belongs_to :student, optional: true

  validates :row_position, :column_postion, presence: true
end
