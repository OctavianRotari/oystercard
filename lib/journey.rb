
class Journey
  attr_reader :history, :entry_station, :exit_station, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @history = []
    @entry_station = nil
    @exit_station  = nil
    @fare = 0
  end

  def open_journey(station)
    @entry_station = station
  end

  def exit_journey(station)
    @exit_station = station
    save_journey
  end

  def in_journey?
    !!entry_station
  end

  private

  def save_journey
    @history << {:entry_station => @entry_station, :exit_station => @exit_station}
    calculating_fare
    @exit_station  = nil
    @entry_station = nil
  end

  def calculating_fare
    @exit_station != nil && @entry_station == nil ? @fare = PENALTY_FARE : @fare = MIN_FARE
  end

end
