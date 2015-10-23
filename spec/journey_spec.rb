require "journey"

describe Journey do

  let(:station){double :station}
  let(:entry_station){ double :station, name: "Aldgate", zone: 1 }
	let(:exit_station) { double :station, name: "Whitechappel", zone: 2 }

  describe '#History' do

    it 'checks if thw journey is empty in the beginning' do
      expect(subject.history).to eq []
    end

    it "checks if the entry_station and the exit_station was stored in journey" do
      subject.open_journey(station)
      subject.exit_journey(station)
      expect(subject.history).not_to be_empty
    end

  end

  it { is_expected.to respond_to(:open_journey).with(1).argument}

  describe '#open_journey' do

    it "expect open_journey to register station" do
      subject.open_journey(station)
      expect(subject.history[-1]).to eq({'entry_station' => station})
    end
  end

  describe '#exit_journey' do
    before(:each) do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
    end

    it "expect to travel nil" do
      expect(subject.travel).to be_empty
    end

  end

  describe "#fare" do
    before(:each) do
      subject.open_journey(entry_station)
    end

    it "charge penalty fare when there is no open_journey" do
      subject.exit_journey(exit_station)
      subject.exit_journey(exit_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    it "charge penalty fare when person does touch in twice without doing touch_out" do
      subject.open_journey(entry_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

  end


end
