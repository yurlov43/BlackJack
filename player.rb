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
    puts "#{"-" * 6} #{name} #{"-" * 6}"
    if hide
      puts "** " * cards.size
      puts "Количество очков: **"
    else
      cards.show
      puts "Количество очков: #{cards.count}"
    end
    puts "Количество денег: #{purse.money_amount}"
  end

  def move

    # После этого ход переходит пользователю. У пользователя есть на выбор 3 варианта:
    #
    # - Пропустить. В этом случае, ход переходит к дилеру
    #
    # - Добавить карту. (только если у пользователя на руках 2 карты).
    #   В этом случае игроку добавляется еще одна случайная карта, сумма очков пересчитывается, ход переходит дилеру.
    #   Может быть добавлена только одна карта.
    #
    # - Открыть карты. Открываются карты дилера и игрока, игрок видит сумму очков дилера, идет подсчет результатов игры
  end
end
