require_relative 'string'
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
      if walking_player == player
        break if player_walks == "break"
      else
        dealer_walks
      end
    end
    open_cards
    determine_winner
    accrue_winnings
    show_winner
  end

  protected

  def initial_distribution
    player.take_cards(2, cards_deck)
    player.show_data

    dealer.take_cards(2, cards_deck)
    dealer.show_data(true)
  end

  def player_walks
    query = Readline.readline(
      "Пропустить - (s), Добавить карту - (a), Открыть карты - (o): ".in_yellow).chomp
    return "break" if query == 'o'
    self.walking_player = dealer if query == 's'
    if query == 'a' && player.cards.size == 2
      player.take_cards(1, cards_deck)
      player.show_data
      self.walking_player = dealer
    end
  end

  def dealer_walks
    if dealer.cards.count >= 17
      puts "#{dealer.name} пропустил ход.".in_red
      self.walking_player = player
    else
      puts "#{dealer.name} взял одну карту.".in_red
      dealer.take_cards(1, cards_deck)
      dealer.show_data(true)
    end
  end

  def open_cards
    puts "Пора открыть карты.".in_red
    player.show_data
    dealer.show_data
  end

  def determine_winner
    if player.cards.count <= 21 && dealer.cards.count > 21
      winners << player
    elsif player.cards.count > 21 && dealer.cards.count <= 21
      winners << dealer
    elsif player.cards.count > 21 && dealer.cards.count > 21
      winners << player << dealer
    elsif player.cards.count > dealer.cards.count
      winners << player
    elsif player.cards.count < dealer.cards.count
      winners << dealer
    else
      winners << player << dealer
    end
  end

  def accrue_winnings
    winners.each do |winner|
      gain = bank.money_amount / winners.size
      winner.purse.add_money(bank.spend_money(gain))
    end
  end

  def show_winner
    if winners.size == 1
      puts "Победил в игре: #{winners.first.name}".in_magenta
    else
      puts "Ничья!!!".in_magenta
    end
  end
end
