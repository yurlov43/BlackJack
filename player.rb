require 'readline'

class Player
  attr_accessor :name, :purse, :cards

  def initialize(name, purse, cards)
    @name = name
    @purse = purse
    @cards = cards
  end

  def take_cards(number, cards_deck)
    number.times { cards.add_card(cards_deck.hand_over_card) }
    cards.count_up
  end

  def show_data(hide=false)
    puts "#{"-" * 7} #{name} #{"-" * 7}"
    if hide
      puts "** " * cards.size
      puts "Количество очков: **"
    else
      cards.show
      puts "Количество очков: #{cards.count}"
    end
    puts "Количество денег: #{purse.money_amount}"
  end
end
