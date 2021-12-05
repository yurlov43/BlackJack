require_relative 'card'
require_relative 'string'

class CardsDeck
  attr_accessor :cards, :count

  SUITS = {
    :spade => "\u{2660} ".in_black,
    :club => "\u{2663} ".in_black,
    :heart => "\u{2665} ".in_red,
    :diamond => "\u{2666} ".in_red
  }

  NAMES_VALUES = {
    "2" => 2, "3" => 3, "4" => 4, "5" => 5,
    "6" => 6, "7" => 7, "8" => 8, "9" => 9,
    "10" => 10, "B" => 10, "D" => 10, "K" => 10,
    "T" => 11
  }

  def initialize
    @cards = []
    @count = 0
  end

  def fill
    NAMES_VALUES.each do |name, value|
      SUITS.each_value { |suit| add_card(Card.new(name, suit, value)) }
    end
  end

  def show
    cards.each { |card| print "#{card.name}#{card.suit} " }
    nil
  end

  def mix(number=30)
    number.times { cards.shuffle! } if cards.size > 0
  end

  def add_card(card)
    cards << card
    self.count += card.value
  end

  def hand_over_card
    if cards.size > 0
      self.count -= cards.first.value
      cards.shift
    end
  end

  def count_up
    cards.each { |card| self.count += card.value } if cards.size > 0
  end
end
