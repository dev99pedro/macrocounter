class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
    @food = Food.new
    @user = current_user
  end



  def create

  

    # validando se os parametros estao presentes, antes de chamar a api
    if params[:query].blank? || params[:unit].blank? || params[:meal_type].blank?
      @food = Food.new
      return render :new
    end

  



    client = CaloriesNinjaClientApi.new("guHq9j7UywoDJ+Hq1cHD0w==VBcqIaYVifJRhKwF")
    # chama a classe CaloriesNinjaClientApi que esta dentro da pasta services. Passa a chave que o site da api te manda como parametro.
    
    foodsearch = client.search_food(params[:query], params[:unit])
    # dentro da classe CalorieNinjaClientApi tem um metodo chamado search_food. Vc esta acionando ele. Ele tem dois parametros que vc esta passando como :query e :unit

    
    items = foodsearch["items"][0]
      if items.blank? || items["name"].blank?
      @food = Food.new

      return render :new
    end
    

    user_id = current_user.id

    # retorna a api com o index 0

    # aqui embaixo retorna o resto dos valores da api
    name = items["name"]
    carbs = items["carbohydrates_total_g"]
    fats = items["fat_total_g"]
    protein = items["protein_g"]
    calories = items["calories"]
    serving = items["serving_size_g"].to_i

      
    
 

    @food= Food.new(foodname: name, carbs: carbs, fats: fats, proteins: protein, calories: calories, user_id: user_id, meal_type: params[:meal_type], serving_size: serving)

    if @food.save
      respond_to do | format | 
        format.html { redirect_to foods_path }
        format.json {render json: @food, status: :created}
      end
    else
      respond_to do | format |
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end


  end


  def new
    @food = Food.new
    @meal_type = params[:meal_type] || "cafe"  # padrão para café se não passareeeeeeeeeeeeeeeeeeeeeee
  end


  def show
    @food = Food.find(params[:id])
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy   
  end




end
