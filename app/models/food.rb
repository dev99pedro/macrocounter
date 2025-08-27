class Food < ApplicationRecord
  validates :foodname, presence: true
  validates :calories, presence: true
  validates :proteins, presence: true
  validates :fats, presence: true
  validates :carbs, presence: true

  belongs_to :user

  validates :user, presence: true
end
