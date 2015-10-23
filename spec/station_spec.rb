require 'station'

describe Station do

  it "expects station to hold print out name of a station" do
    station = Station.new(:name, :zone)
    expect(station.name).to eq(:name)
  end

  it "expects station to hold print out zone of a station" do
    station = Station.new(:name, :zone)
    expect(station.zone).to eq :zone
  end

end
