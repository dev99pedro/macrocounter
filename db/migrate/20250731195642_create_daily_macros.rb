class CreateDailyMacros < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_macros do |t|
      t.references :user, foreign_key: true
      t.timestamps
      t.integer :calories
      t.integer :proteins
      t.integer :fats
      t.integer :carbs
    end
  end
end
