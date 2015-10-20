class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0

  end

  def top_up(amount)
  	raise StandardError, 'Cannot exceed #{MAX_BALANCE} pounds' if (balance + amount) > MAX_BALANCE
  	@balance += amount
  end

end