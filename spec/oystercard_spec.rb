require 'oystercard'

describe Oystercard do

	it 'is initialized with a balance of zero' do
		expect(subject.balance).to eq 0
	end

	describe '#top_up' do
		it { is_expected.to respond_to(:top_up).with(1).argument }

		it 'can top up the balance' do
			expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
		end

		it 'raises error if balance exceeds #{MAX_BALANCE} pounds' do
			subject.top_up(Oystercard::MAX_BALANCE)
			expect{ subject.top_up 1 }.to raise_error 'Cannot exceed #{MAX_BALANCE} pounds'
		end

	end

	describe '#deduct' do
		it { is_expected.to respond_to(:deduct).with(1).argument }

		it 'can deduct balance' do
			subject.top_up(10) 
			expect { subject.deduct 1}.to change{ subject.balance}.by -1
		end
	end

end
