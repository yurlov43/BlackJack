class BlackJack
  attr_accessor :player, :dealer, :bank, :cards_deck, :winner

  def initialize(player, dealer, bank, cards_deck)
    @player = player
    @dealer = dealer
    @cards = cards_deck
    @bank = bank
  end
end
