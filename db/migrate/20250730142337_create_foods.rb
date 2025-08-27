class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.timestamps
      t.string :foodname
      t.integer :calories
      t.integer :proteins
      t.integer :fats
      t.integer :carbs
      t.string  :meal_type
    end
  end
end
