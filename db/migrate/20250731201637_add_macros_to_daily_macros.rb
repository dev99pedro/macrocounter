class AddMacrosToDailyMacros < ActiveRecord::Migration[8.0]
  def change
    add_column :daily_macros, :protein, :integer
    add_column :daily_macros, :carbs, :integer
    add_column :daily_macros, :fats, :integer
    add_column :daily_macros, :calories, :integer
  end
end
