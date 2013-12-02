require 'spec_helper' 

describe ByStartDateScorer do
	describe '.score' do
		context 'with valid arguments' do
			let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
			let (:bob) 	 {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
			let (:carol) {Person.new({name: "carol", gender: :woman, start: Date.iso8601("2010-01-01")})}

			subject {ByStartDateScorer.score([[alice, bob],[alice, carol], [bob, carol]])}
			it 'scores to accentuate differences' do
				expect(subject).to match_array [{group: [alice,bob],   score: 1},
												{group: [alice,carol], score: 0},
												{group: [bob,carol],   score: 1}]
			end
  		end
  	end
end