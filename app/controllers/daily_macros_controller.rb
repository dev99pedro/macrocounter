class DailyMacrosController < ApplicationController
  skip_before_action :verify_authenticity_token
  # autentificação de token aleatorio
  before_action :authenticate_user!
  # tu ja sabe, autentifica que o usuario esteja logado

  def index
    @daily_macros = DailyMacro.all
    respond_to do | format |
      format.html
      format.json {render json: @daily_macros}
    end
  end

  def create
    @daily_macro = current_user.daily_macros.new(daily_macros_params)
    if @daily_macro.save
      redirect_to foods_path, notice: "criado"      
    else
      render :index
    end 
  end

  def show
    @daily_macro = DailyMacro.find(params[:id])
  end

  private

  def daily_macros_params
    params.require(:daily_macro).permit(:protein, :carbs, :fats, :calories)
  end
end
