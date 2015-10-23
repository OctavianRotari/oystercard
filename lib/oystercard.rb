require_relative "station.rb"
require_relative "journeylog.rb"

class Oystercard

  attr_reader :balance, :journey

  MAX = 90
  MIN = 1

  def initialize( journey = Journey.new )
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
  	raise StandardError, "Cannot exceed #{MAX} pounds" if (balance + amount) > MAX
  	@balance += amount
  end

  def touch_in(station)
  	raise StandardError, 'Insufficient funds' if (balance) < MIN
    @journey.open_journey(station)
    deduct
  end

  def touch_out(station)
    @journey.exit_journey(station)
    deduct
  end

  private

  def deduct
    @balance -= journey.fare
    @journey.reset_fare
  end

end
