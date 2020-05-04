require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    # array de Recipe objects
    @recipes = []
    @csv_file_path = csv_file_path # recipes.csv

    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def check_recipe(index)
    @recipes[index].check!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      row = Recipe.new(row[0].to_s, row[1].to_s, row[2] == "true", row[3], row[4])
      @recipes << row
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.read.to_s, recipe.prep_time.to_s, recipe.difficulty]
      end
    end
  end
end
