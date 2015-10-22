
class Journey
  attr_reader :history, :travel, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @history = []
    @fare = 0
    @travel={}
  end

  def open_journey(station)
    @travel[:entry_station] = station
    save_journey
    penalty_fare if history.length >= 2
  end

  def exit_journey(station)
    @travel[:exit_station] = station
    save_journey
    calculating_fare if history.length >= 2
  end

  def in_journey?
    true if history[-1].has_key?(:entry_station)
  end

  private

  def save_journey
    @history << @travel
    @travel= {}
  end

  def calculating_fare
    history[-1].has_key?(:exit_station) == true && history[-2].has_key?(:exit_station) == true ? @fare = PENALTY_FARE : @fare = MIN_FARE
  end

  def penalty_fare
    @fare = PENALTY_FARE if history[-1].has_key?(:entry_station) == true && history[-2].has_key?(:entry_station) == true
  end


end
