require "journey"

describe Journey do

  let(:station){double :station}
  let(:entry_station){ Station.new(:name, :zone)}
	let(:exit_station){ Station.new(:name, :zone)}

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
    # it "should store station in the history" do
    #   subject.open_journey(station)
    #   expect(subject.history[0]).to eq(:zone)
    # end

    it "expect open_journey to register station" do
      subject.open_journey(station)
      expect(subject.history[-1]).to eq({:entry_station => station})
    end

    it 'card is in journey' do
      subject.open_journey(entry_station)
      expect(subject).to be_in_journey
    end
  end

  describe '#exit_journey' do

    it 'card is no longer in journey' do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "expect to travel nil" do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(subject.travel).to be_empty
    end

  end

  describe "#fare" do

    it "calculate fare for a journey" do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(subject.fare).to eq(Journey::MIN_FARE)
    end

    it "charge penalty fare when there is no open_journey" do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      subject.exit_journey(exit_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    it "charge penalty fare when person does touch in twice without doing touch_out" do
      subject.open_journey(entry_station)
      subject.open_journey(entry_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

  end


end
