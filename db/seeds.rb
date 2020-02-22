# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

Ingredient.destroy_all
Cocktail.destroy_all

url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_serialized = open(url).read
ingredient_list = JSON.parse(ingredient_serialized)
ingredient = ingredient_list['drinks']

ingredient.each do |ing|
  Ingredient.create!(name: ing['strIngredient1'])
end

url = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
cocktails_serialized = open(url).read
cocktails = JSON.parse(cocktails_serialized)

cocktails['drinks'].each do |cocktail|
  Cocktail.create(name: cocktail['strDrink'], photo: cocktail['strDrinkThumb'])
end
