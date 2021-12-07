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
    2.times { player.cards.add_card(cards_deck.hand_over_card) }
    player.cards.count_up
    show_data(player)

    2.times { dealer.cards.add_card(cards_deck.hand_over_card) }
    dealer.cards.count_up
    show_data(dealer, true)

    until player.cards.cards.size == 3 && dealer.cards.cards.size == 3
      case walking_player
      when player
        query = Readline.readline(
          "Пропустить - (s), Добавить карту - (a), Открыть карты - (o): ".in_yellow).chomp
        break if query == 'o'
        self.walking_player = dealer if query == 's'
        if query == 'a' && player.cards.cards.size == 2
          1.times { player.cards.add_card(cards_deck.hand_over_card) }
          player.cards.count_up
          show_data(player)
          self.walking_player = dealer
        end
      when dealer
        if dealer.cards.count >= 17
          self.walking_player = player
        else
          1.times { dealer.cards.add_card(cards_deck.hand_over_card) }
          dealer.cards.count_up
          show_data(dealer, true)
        end

      end
    end

    show_data(player)
    show_data(dealer)

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

  def show_data(player, hide=false)
    puts "#{"-" * 5} #{player.name} #{"-" * 5}"
    if hide
      puts "** " * player.cards.cards.size
      puts "Количество очков: **"
    else
      player.cards.show
      puts "Количество очков: #{player.cards.count}"
    end
    puts "Количество денег: #{player.purse.money_amount}"
  end
end
