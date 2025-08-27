class DailyMacro < ApplicationRecord
  validates :calories, numericality: { less_than_or_equal_to: 9000 }
  belongs_to :user
end
