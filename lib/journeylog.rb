class Journeylog
  attr_reader :journey
  def initialize
    @journey = {}
  end
    # @journeyujourney = journey
    # @my_other_journey = journey * 2
  def start_journey(station)
    @journey['entry_station'] = station
  end


end
