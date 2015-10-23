
class Journey
  attr_reader :history, :travel, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @history = []
    @fare = 0
    @travel={}
  end

  def reset_fare
    @fare = 0
  end

  def open_journey(station)
    save_journey('entry_station', station)
    fare_touch_in if history.length >= 2
  end

  def exit_journey(station)
    save_journey('exit_station', station)
    fare_touch_out if history.length >= 2
  end

  private

  def save_journey(input, station)
    @history << @travel.merge!(input => station)
    @travel = {}
  end

  def fare_touch_out
    check_hist('exit_station') ? @fare = PENALTY_FARE : @fare = MIN_FARE
  end

  def fare_touch_in
    @fare = PENALTY_FARE if check_hist('entry_station')
  end

  def check_hist(input)
    history[-1].has_key?(input) && history[-2].has_key?(input)
  end

end
