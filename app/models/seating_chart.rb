# == Schema Information
#
# Table name: seating_charts
#
#  id           :bigint           not null, primary key
#  columns      :integer
#  rows         :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  classroom_id :bigint           not null
#
# Indexes
#
#  index_seating_charts_on_classroom_id  (classroom_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_id => classrooms.id)
#
class SeatingChart < ApplicationRecord
  belongs_to :classroom, dependent: :destroy

  # TODO: validate that the seating chart is not larger than the classroom to which it belongs.
  validates :rows, :columns, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :title, presence: true

  validate :check_rows_and_columns

  private

  def check_rows_and_columns
    check_rows && check_columns
  end

  def check_rows
    if rows > classroom.rows
      errors.add(:base, "Seating chart cannot have more rows than classroom.")
      return false
    end

    true
  end

  def check_columns
    if columns > classroom.columns
      errors.add(:base, "Seating chart cannot have more columns than classroom.")
      return false
    end

    true
  end
end