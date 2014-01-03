class Human
  include Moveable

  attr_accessor :name

  def initialize(gamestate)
    @gamestate = gamestate
  end
end
