class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
    @food = Food.new
  end

  def create
    client = CaloriesNinjaClientApi.new("guHq9j7UywoDJ+Hq1cHD0w==VBcqIaYVifJRhKwF")
    # chama a classe CaloriesNinjaClientApi que esta dentro da pasta services. Passa a chave que o site da api te manda como parametro.

    foodsearch = client.search_food(params[:query], params[:unit])
    # dentro da classe CalorieNinjaClientApi tem um metodo chamado search_food. Vc esta acionando ele. Ele tem dois parametros que vc esta passando como :query e :unit

    user_id = current_user.id

    items = foodsearch["items"][0]
    # retorna a api com o index 0

    # aqui embaixo retorna o resto dos valores da api
    name = items["name"]
    carbs = items["carbohydrates_total_g"]
    fats = items["fat_total_g"]
    protein = items["protein_g"]
    calories = items["calories"]
    serving = items["serving_size_g"]

    @food= Food.new(foodname: name, carbs: carbs, fats: fats, proteins: protein, calories: calories, user_id: user_id, meal_type: params[:meal_type], serving_size: serving)

    if @food.save
       render json: @food, status: :created
      # redirect_to @food, notice: "Comida salva com sucesso"
    else

     render :new, alert: "Erro ao salvar"
    end
  end


  def new
    @food = current_user.foods.order(created_at: :desc)
    # pega os dados de food que foi criado pelo usuario, e coloca em ordem crescente(no caso primeiro os ultimos que foram chamados)
    
    @meal_type = params[:meal_type] || "cafe"  # padrão para café se não passar
  end
end
