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
    puts
  end

  def mix(number=30)
    number.times { cards.shuffle! } if cards.size > 0
  end

  def add_card(card)
    cards << card
  end

  def hand_over_card
    cards.shift if cards.size > 0
  end

  def count_up
    self.count = 0

    aces = cards.select { |card| card.name == 'T' }

    case aces.size
    when 2
      aces.first.value = 1
      aces.last.value = 1 if self.count + aces.first.value + aces.last.value > 21
    when 3
      aces.each { |ace| ace.value = 1 }
    end

    cards.each { |card| self.count += card.value }
  end
end
