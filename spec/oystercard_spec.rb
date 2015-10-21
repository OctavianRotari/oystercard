require 'oystercard'

describe Oystercard do

	let(:station){ double :station }

	it 'is initialized with a balance of zero' do
		expect(subject.balance).to eq 0
	end

	describe '#top_up' do
		it { is_expected.to respond_to(:top_up).with(1).argument }

		it 'can top up the balance' do
			expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
		end

		it "raises error if balance exceeds #{Oystercard::MAX_BALANCE} pounds" do
			subject.top_up(Oystercard::MAX_BALANCE)
			expect{ subject.top_up 1 }.to raise_error "Cannot exceed #{Oystercard::MAX_BALANCE} pounds"
		end

	end

	describe '#touch_in' do
		it { is_expected.to respond_to(:touch_in)}

		it 'card is in journey' do
			subject.top_up(Oystercard::MIN_BALANCE)
			subject.touch_in(station)
			expect(subject).to be_in_journey
		end

		it "will not touch in if balance is below #{Oystercard::MIN_BALANCE}" do
		expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
		end

		it "expects that the card remembers the entry station" do
			subject.top_up(10)
			subject.touch_in(station)
			expect(subject.entry_station).to eq(station)
		end
	end

	describe '#touch_out' do
		it { is_expected.to respond_to(:touch_out)}

		it 'reduces journey fare' do
			subject.top_up(10)
			subject.touch_in(station)
			expect {subject.touch_out(station)}.to change{subject.balance}.by(-1)
		end

		it 'card is no longer in journey' do
			subject.top_up(Oystercard::MIN_BALANCE)
			subject.touch_in(station)
			subject.touch_out(station)
			expect(subject).not_to be_in_journey
		end

		it 'raises error if card is no longer in journey' do
			subject.top_up(Oystercard::MIN_BALANCE)
			subject.touch_in(station)
			subject.touch_out(station)
			expect {subject.touch_out(station)}.to raise_error 'Error: card not touched in'

		end

		it "expect to set entry_station equal to nil" do
			subject.top_up(Oystercard::MIN_BALANCE)
			subject.touch_in(station)
			subject.touch_out(station)
			expect(subject.entry_station).to eq(nil)
		end

		it "expects that the card remove exit_station when touch_out" do
			subject.top_up(10)
			subject.touch_in(station)
			subject.touch_out(station)
			expect(subject.exit_station).to eq(nil)
		end

	end

	describe '#History' do

		it 'checks if thw journey is empty in the beginning' do
			expect(subject.journey).to eq []
		end

		it "checks if the entry_station and the exit_station was stored in journey" do
			subject.top_up(10)
			subject.touch_in(station)
			subject.touch_out(station)
			expect(subject.journey.length).to eq 1
		end
	end


end
