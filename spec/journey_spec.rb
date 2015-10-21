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
      expect(subject.history.length).to eq 1
    end

  end

  it { is_expected.to respond_to(:open_journey).with(1).argument}

  describe '#open_journey' do
    # it "should store station in the history" do
    #   subject.open_journey(station)
    #   expect(subject.history[0]).to eq(:zone)
    # end

    it "expect open_journey to register entry_station" do
      subject.open_journey(station)
      expect(subject.entry_station).to eq(station)
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

    it "expect to set entry_station equal to nil" do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(subject.entry_station).to eq(nil)
    end

    it "expects that the card remove exit_station when touch_out" do
      subject.open_journey(entry_station)
      subject.exit_journey(exit_station)
      expect(subject.exit_station).to eq(nil)
    end

  end

end
