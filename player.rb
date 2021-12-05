class Player
  attr_accessor :name, :purse, :cards

  def initialize(name, purse, cards)
    @name = name
    @purse = purse
    @cards = cards
  end
end
