require 'rails_helper'

RSpec.describe "Foods", type: :request do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)

     allow_any_instance_of(CaloriesNinjaClientApi).to receive(:search_food)
      .and_return({
        "items" => [ {
          "name" => "Abacaxi",
          "carbohydrates_total_g" => 20,
          "fat_total_g" => 5,
          "protein_g" => 5,
          "calories" => 5,
          "serving_size_g" => 100
        } ]
      })
  end

  it "should return created status" do
    post "/foods", params: {
      query: 'abacaxi',
      unit: '100g',
      meal_type: 'almoço'
    }

    expect(response).to have_http_status(201)

    food = Food.last

    expect(food.foodname).to eq('Abacaxi')
    expect(food.carbs).to eq(20)
    expect(food.fats).to eq(5)
    expect(food.proteins).to eq(5)
    expect(food.calories).to eq(5)
    expect(food.user_id).to eq(user.id)
    expect(food.meal_type).to eq("almoço")
    expect(food.serving_size).to eq("100")
  end


  describe "test the htpp request" do
    it "should return 200 status" do
      get "/foods"
      expect(response).to have_http_status(200)
    end
  end
end
