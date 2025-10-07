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
      fats: Food.sum(:fats),
      carbs: Food.sum(:carbs),
      proteins: Food.sum(:proteins),
    }
    
  end


  def calculate
    last_macro = daily_macros.last
    {
      totalcalories: last_macro.calories - Food.sum(:calories),
      totalfats: last_macro.fats - Food.sum(:fats),
      totalcarbs: last_macro.carbs - Food.sum(:carbs),
      totalprotein: last_macro.protein - Food.sum(:proteins)
    }
  end


  def sum_calories(meal_type = nil)
    scope = Food.all
    scope = scope.where(meal_type: meal_type) if meal_type.present?
    {
      calories: scope.sum(:calories)
    }
  end






end
