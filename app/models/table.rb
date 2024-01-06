class Table < ApplicationRecord
  belongs_to :seating_chart
  belongs_to :student, optional: true

  validates :row_position, :column_postion, presence: true
end
