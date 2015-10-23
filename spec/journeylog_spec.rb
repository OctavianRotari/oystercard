require 'journeylog'

describe Journeylog do
  let(:station) { double(:station) }
  let(:output) { {'entry_station' => station} }
  it { is_expected.to respond_to(:start_journey).with(1).argument}

  it 'start a new journey with an entry station' do
    subject.start_journey(station)
    expect(subject.journey).to eq output

  end
end
