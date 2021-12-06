require_relative 'money_error'

class Bank
  attr_accessor :money_amount, :owner

  def initialize(value=0)
    @money_amount = value
  end

  def add_money(value)
    self.money_amount += value
  end

  def spend_money(value)
    if money_amount >= value
      self.money_amount -= value
      value
    else
      raise MoneyError, "#{owner.name}: недостаточно средств!!!"
    end
  end
end
