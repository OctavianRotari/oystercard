require_relative "station.rb"
require_relative "journey.rb"

class Oystercard

  attr_reader :balance, :journey

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
  	raise StandardError, "Cannot exceed #{MAX_BALANCE} pounds" if (balance + amount) > MAX_BALANCE
  	@balance += amount
  end

  def touch_in(station)
  	raise StandardError, 'Insufficient funds' if (balance) < MIN_BALANCE
    @journey.open_journey(station)
  end

  def touch_out(station)
    raise StandardError, 'Error: card not touched in' if @journey.entry_station == nil
    @journey.exit_journey(station)
  	deduct(MIN_FARE)
  end

  private

  def deduct(amount)
  	@balance -= amount
  end

end
