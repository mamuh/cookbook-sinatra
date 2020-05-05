require 'rubygems'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'cookbook'
require_relative 'recipe'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/create' do
  new_recipe = Recipe.new(params[:name], params[:description])
  cookbook.add_recipe(new_recipe)
  @recipes = cookbook.all
  redirect '/'
end


get '/recipes/:index' do
  @recipes = cookbook.all
  @recipes.delete_at(params[:index].to_i)
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end
