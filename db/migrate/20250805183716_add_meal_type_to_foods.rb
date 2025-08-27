class AddMealTypeToFoods < ActiveRecord::Migration[8.0]
  def change
    add_column :foods, :meal_type, :string
  end
end
