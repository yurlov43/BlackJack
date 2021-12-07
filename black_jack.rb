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
    puts "#{"-" * 5} #{player.name} #{"-" * 5}"
    2.times { player.cards.add_card(cards_deck.hand_over_card) }
    player.cards.show
    player.cards.count_up
    puts "Количество очков: #{player.cards.count}"
    puts "Количество денег: #{player.purse.money_amount}"

    puts "#{"-" * 5} #{dealer.name} #{"-" * 5}"
    2.times { dealer.cards.add_card(cards_deck.hand_over_card) }
    puts "** " * dealer.cards.cards.size
    dealer.cards.count_up
    puts "Количество очков: **"
    puts "Количество денег: #{dealer.purse.money_amount}"

    until player.cards.cards.size == 3 && dealer.cards.cards.size == 3
      case walking_player
      when player
        query = Readline.readline(
          "Пропустить - (s), Добавить карту - (a), Открыть карты - (o): ".in_yellow).chomp
        break if query == 'o'
        self.walking_player = dealer if query == 's'
        if query == 'a' && player.cards.cards.size == 2
          puts "#{"-" * 5} #{player.name} #{"-" * 5}"
          1.times { player.cards.add_card(cards_deck.hand_over_card) }
          player.cards.show
          player.cards.count_up
          puts "Количество очков: #{player.cards.count}"
          puts "Количество денег: #{player.purse.money_amount}"
          self.walking_player = dealer
        end
      when dealer
        if dealer.cards.count >= 17
          self.walking_player = player
        else
          puts "#{"-" * 5} #{dealer.name} #{"-" * 5}"
          1.times { dealer.cards.add_card(cards_deck.hand_over_card) }
          puts "** " * dealer.cards.cards.size
          dealer.cards.count_up
          puts "Количество очков: **"
          puts "Количество денег: #{dealer.purse.money_amount}"
        end

      end
    end

    puts "#{"-" * 5} #{player.name} #{"-" * 5}"
    player.cards.show
    puts "Количество очков: #{player.cards.count}"
    puts "Количество денег: #{player.purse.money_amount}"

    puts "#{"-" * 5} #{dealer.name} #{"-" * 5}"
    dealer.cards.show
    puts "Количество очков: #{dealer.cards.count}"
    puts "Количество денег: #{dealer.purse.money_amount}"

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
end
