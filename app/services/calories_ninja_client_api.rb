class CaloriesNinjaClientApi
  require "net/http"
  require "uri"
  require "json"
  require "erb"

  API_URL = "https://api.calorieninjas.com/v1/nutrition"
  # https://api.calorieninjas.com/v1/nutrition?query=100g chicken




  def initialize(api_key)
    @api_key = api_key 
    # essa api key esta recebendo o valor da chave que a Api da Calorie Ninjas passa no site dela
  end

  def search_food(query, unit)
    #query e unit sao dois parametros que estao sendo pegados por :unit e :query no controlador

    encoded_query = ERB::Util.url_encode(unit)

    # transforma o unit(que é a quantidade do alimento) em uma string sem espaços, quebras etc

    uri = URI("#{API_URL}?query=#{encoded_query}g #{query}")
    # basicamente esta retornando isso aqui  https://api.calorieninjas.com/v1/nutrition?query=QuantidadegAlimento


    request = Net::HTTP::Get.new(uri)
    # esta fazendo um Get da uri, que no caso é a url que fizemos ali em cima
    request["X-API-KEY"] = @api_key
    # esta adicionando no headers dessa url o valor que estamos passando por parametro ali na funcao initialize. No caso o valor da chave da Api que o site manda


    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do | http |
      http.request(request)
    end
    # esta iniciando a requisião, falando pro metodo http botar de header o que fizemos ali em cima no request

    json = JSON.parse(response.body)
    # transformando a reposta ali de cima em json
  end
end
