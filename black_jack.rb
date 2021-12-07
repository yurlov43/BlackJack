require 'readline'

class BlackJack
  attr_accessor :player, :dealer, :bank, :cards_deck, :walking_player, :winners

  def initialize(bank, cards_deck, player, dealer)
    @bank = bank
    @cards_deck = cards_deck
    @player = player
    @dealer = dealer
    @walking_player = player
    @winners = []
  end

  def start
    initial_distribution

    until player.cards.size == 3 && dealer.cards.size == 3
      case walking_player
      when player
        query = Readline.readline(
          "Пропустить - (s), Добавить карту - (a), Открыть карты - (o): ".in_yellow).chomp
        break if query == 'o'
        self.walking_player = dealer if query == 's'
        if query == 'a' && player.cards.size == 2
          player.take_cards(1, cards_deck)
          player.show_data
          self.walking_player = dealer
        end
      when dealer
        if dealer.cards.count >= 17
          self.walking_player = player
        else
          dealer.take_cards(1, cards_deck)
          dealer.show_data(true)
        end
      end
    end

    player.show_data
    dealer.show_data

    if player.cards.count <= 21 && dealer.cards.count > 21
      self.winners << player
    elsif player.cards.count > 21 && dealer.cards.count <= 21
      self.winners << dealer
    elsif player.cards.count > 21 && dealer.cards.count > 21
      self.winners << player
      self.winners << dealer
    elsif player.cards.count > dealer.cards.count
      self.winners << player
    elsif player.cards.count < dealer.cards.count
      self.winners << dealer
    else
      self.winners << player
      self.winners << dealer
    end

    winners.each do |winner|
      gain = bank.money_amount / winners.size
      winner.purse.add_money(bank.spend_money(gain))
    end

    if winners.size == 1
      puts "Победил в игре: #{winners.first.name}"
    else
      puts "Ничья."
    end
  end

  def initial_distribution
    player.take_cards(2, cards_deck)
    player.show_data

    dealer.take_cards(2, cards_deck)
    dealer.show_data(true)
  end
end
