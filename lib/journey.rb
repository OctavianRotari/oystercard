
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
    @travel[:entry_station] = station
    save_journey
    fare_touch_in if history.length >= 2
  end

  def exit_journey(station)
    @travel[:exit_station] = station
    save_journey
    fare_touch_out if history.length >= 2
  end

  def in_journey?
    true if history[-1].has_key?(:entry_station)
  end

  private

  def save_journey
    @history << @travel
    @travel = {}
  end

  def fare_touch_out
    history[-1].has_key?(:exit_station) == true && history[-2].has_key?(:exit_station) == true ?
    @fare = PENALTY_FARE : @fare = MIN_FARE
  end

  def fare_touch_in
    @fare = PENALTY_FARE if
    history[-1].has_key?(:entry_station) == true && history[-2].has_key?(:entry_station) == true
  end


end
