require_relative "station.rb"

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey = []

  end

  def top_up(amount)
  	raise StandardError, "Cannot exceed #{MAX_BALANCE} pounds" if (balance + amount) > MAX_BALANCE
  	@balance += amount
  end

  def touch_in(station)
  	raise StandardError, 'Insufficient funds' if (balance) < MIN_BALANCE
    @entry_station = station
  end

  def in_journey?
  	!!entry_station
  end

  def touch_out(station)
    raise StandardError, 'Error: card not touched in' if entry_station == nil
    @exit_station = station
    save_journey
  	deduct(MIN_FARE)
  end

  private

  def deduct(amount)
  	@balance -= amount
  end

  def save_journey
    @journey << {:entry_station => @entry_station, :exit_station => @exit_station}
    @exit_station  = nil
    @entry_station = nil
  end

end
