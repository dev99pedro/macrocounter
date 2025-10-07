class Food < ApplicationRecord
  validates :foodname, presence: true
  validates :calories, presence: true
  validates :proteins, presence: true
  validates :fats, presence: true
  validates :carbs, presence: true

  

  
  belongs_to :user
  validates :user, presence: true

  after_destroy_commit do
  broadcast_remove_to "removefood", target: "food_#{id}"
  
  broadcast_replace_to "updatecalories",
  target: "food_#{self.meal_type}",
  partial: "shared/calories_update",
  locals: { meal: self.meal_type, user: self.user } 
  end
  # esse aqui só é chamado, quando algo é destruido do banco de dados after_destroy_commit 
  # pra isso funcionar precisa ter <%= turbo_stream_from "updatecalories" e <%= turbo_stream_from "removefood" %> na view de onde tu quer chamar %>  
  # broadcast_remove_to "removefood", target: "food_#{id}" ta pegando todo elemento com food_#{id} e removendo
  # broadcast_replace_to "updatecalories" ta pegando food_#{self.meal_type}(USAMOS SELF PORQUE AQUI NO MODELO PRECISA USAR SELF QUANDO QUER SELCIONAR ALGO)
  

end
