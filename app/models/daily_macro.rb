class DailyMacro < ApplicationRecord
  validates :calories, numericality: { less_than_or_equal_to: 9000 }, presence: true
  validates :protein, :carbs, :fats, presence: true


  belongs_to :user
end
