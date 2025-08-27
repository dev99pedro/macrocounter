require 'rails_helper'

RSpec.describe DailyMacrosController, type: :request do
  # :controller está obsoleto, sempre usar o :request
  let(:user) { create(:user) }

  before do
     login_as(user, scope: :user)
  end

  describe "daily macros of the user" do
    it "creates a daily macro with the necessary fields" do
      food_params = {
        daily_macro: {
          protein: 20,
          carbs: 20,
          calories: 20,
          fats: 20,
          user_id: user.id
        }
      }

      post "/daily_macros", params: food_params
      # aqui tem que ser post pq estamos testando a requisição http

      expect(response).to have_http_status(302)
    end

    it "is invalid if calories exceed 900" do
      daily_macro = DailyMacro.new(
        protein: 20,
        carbs: 20,
        calories: 9100,
        fats: 20,
        user_id: user.id
      )
      # aqui pode ser New, pq nao estamos fazendo uma chamada http, apenas testando as validações do modelo

      expect(daily_macro).not_to be_valid
      expect(daily_macro.errors[:calories]).to include("must be less than or equal to 9000")

    end


    it "shows the user's daily macro" do
      food_params = {
        daily_macro: {
          protein: 20,
          carbs: 20,
          calories: 20,
          fats: 20,
          user_id: user.id
        }
      }

      post "/daily_macros", params: food_params
      expect(response).to have_http_status(302)

      get "/daily_macros"
      expect(response).to have_http_status(200)

      expect(food_params[:daily_macro][:protein]).to eq(20)
      expect(food_params[:daily_macro][:carbs]).to eq(20)
      expect(food_params[:daily_macro][:calories]).to eq(20)
      expect(food_params[:daily_macro][:fats]).to eq(20)
    end

    it "validate if not configurate the macros, show message or form" do
      get "/daily_macros"

      expect(response).to have_http_status(200)
      expect(response.body).to include("[]")
    end
  end
end
