class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :read

  def initialize(name, description, read = false, prep_time = nil, difficulty = nil)
    @name = name
    @description = description
    @read = read
    @prep_time = prep_time
    @difficulty = difficulty
  end

  def check!
    @read = true
  end
end
