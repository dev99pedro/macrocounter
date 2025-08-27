require_relative 'app/services/calories_ninja_client_api'

client = CaloriesNinjasClient.new('guHq9j7UywoDJ+Hq1cHD0w==VBcqIaYVifJRhKwF')
client.search_food('banana')
