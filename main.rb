require_relative 'money_error'
require_relative 'black_jack'
require_relative 'cards_deck'
require_relative 'player'
require_relative 'string'
require_relative 'bank'
require_relative 'card'
require 'readline'

bank = Bank.new()
user_purse = Bank.new(100)
dealer_purse = Bank.new(100)

user_cards = CardsDeck.new()
dealer_cards = CardsDeck.new()

user_name = Readline.readline("Введите своё имя: ".in_yellow).chomp
user = Player.new(user_name, user_purse, user_cards)
user_purse.owner = user

dealer_name = "Dealer"
dealer = Player.new(dealer_name, dealer_purse, dealer_cards)
dealer_purse.owner = dealer

loop do
  begin
    bank.add_money(user.purse.spend_money(10))
    bank.add_money(dealer.purse.spend_money(10))
  rescue MoneyError => error
    puts "#{error.message}".in_red
    break
  end

  cards_deck = CardsDeck.new()
  cards_deck.fill
  cards_deck.mix

  black_jack = BlackJack.new(bank, cards_deck, user, dealer)
  black_jack.start()

  query = Readline.readline("Начать новую игру? (q-выход): ".in_yellow).chomp
  break if query == 'q'
end