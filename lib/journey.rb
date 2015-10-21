
class Journey
  attr_reader :history, :entry_station, :exit_station

  def initialize
    @history = []
    @entry_station = nil
    @exit_station = nil
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
    @exit_station  = nil
    @entry_station = nil
  end

end
