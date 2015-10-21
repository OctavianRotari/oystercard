require 'oystercard'

describe Oystercard do

	let(:station){double:station}
	let(:journey){ double:journey }

	it 'is initialized with a balance of zero' do
		expect(subject.balance).to eq 0
	end

	describe '#top_up' do

		it 'can top up the balance' do
			expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
		end

		it "raises error if balance exceeds #{Oystercard::MAX_BALANCE} pounds" do
			subject.top_up(Oystercard::MAX_BALANCE)
			expect{ subject.top_up 1 }.to raise_error "Cannot exceed #{Oystercard::MAX_BALANCE} pounds"
		end

	end

	describe '#touch_in' do

		it "will not touch in if balance is below #{Oystercard::MIN_BALANCE}" do
		expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
		end

	end

	describe '#touch_out' do

		it 'reduces journey fare' do
			subject.top_up(10)
			subject.touch_in(station)
			expect {subject.touch_out(station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
		end

		it 'reduces journey fare' do
			subject.top_up(10)
			expect {subject.touch_out(station)}.to change{subject.balance}.by(-Oystercard::PENALTY_FARE)
		end

	end

end
