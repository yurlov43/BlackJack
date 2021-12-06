class BlackJack
  attr_accessor :player, :dealer, :bank, :cards_deck, :winner

  def initialize(bank, cards_deck, player, dealer)
    @bank = bank
    @cards_deck = cards_deck
    @player = player
    @dealer = dealer
  end

  def start
    puts "#{"-" * 5} #{player.name} #{"-" * 5}"
    2.times { player.cards.add_card(cards_deck.hand_over_card) }
    player.cards.show
    player.cards.count_up
    puts player.cards.count

    puts "#{"-" * 5} #{dealer.name} #{"-" * 5}"
    2.times { dealer.cards.add_card(cards_deck.hand_over_card) }
    puts "** " * 2
    dealer.cards.count_up
    puts "**"
  end
end
