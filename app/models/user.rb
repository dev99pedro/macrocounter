class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods, dependent: :destroy
  has_many :daily_macros

  def sum_macros
    {
      calories: Food.sum(:calories),
      proteins: Food.sum(:proteins),
      fats: Food.sum(:fats),
      carbs: Food.sum(:carbs)
    }
  end
end
