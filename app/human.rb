class Human
  attr_reader :name

  def initialize(gamestate)
    @gamestate = gamestate
  end

  def set_name(name)
    @name = name
  end
end
