require 'spec_helper'

describe Person do
	let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
	let (:bob) 	 {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
	let (:dan) 	 {Person.new({name: "dan",   gender: :trans, start: Date.iso8601("2013-01-01")})}

	describe '#man?' do
		context 'when person is a woman' do
			subject {alice}
			it 'returns false' do
				expect(subject.man?).to be_false
			end
		end
		context 'when person is trans' do
			subject {dan}
			it 'returns false' do
				expect(subject.man?).to be_false
			end
		end
		context 'when person is a man' do
			subject {bob}
			it 'returns true' do
				expect(subject.man?).to be_true
			end
		end
	end

	describe '#woman?' do
		context 'when person is a woman' do
			subject {alice}
			it 'returns true' do
				expect(subject.woman?).to be_true
			end
		end
		context 'when person is trans' do
			subject {dan}
			it 'returns false' do
				expect(subject.woman?).to be_false
			end
		end
		context 'when person is a man' do
			subject {bob}
			it 'returns true' do
				expect(subject.woman?).to be_false
			end
		end
	end
end
