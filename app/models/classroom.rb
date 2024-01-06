class Classroom < ApplicationRecord
  belongs_to :teacher

  validates :name, presence: true
  validates :rows, :columns, presence: true,
                             numericality: { only_integer: true, greater_than: 0 }
end
