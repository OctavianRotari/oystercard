require 'oystercard'

describe Oystercard do

	it 'is initialized with a balance of zero' do
		expect(subject.balance).to eq 0
	end

end
