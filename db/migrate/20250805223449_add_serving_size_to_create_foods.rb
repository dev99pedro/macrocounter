class AddServingSizeToCreateFoods < ActiveRecord::Migration[8.0]
  def change
    add_column :foods, :serving_size, :string
  end
end
