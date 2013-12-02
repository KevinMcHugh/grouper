require 'spec_helper' 

describe ByGenderScorer do
	describe '.score' do
		context 'with valid arguments' do
			let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
			let (:bob) 	 {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
			let (:carol) {Person.new({name: "carol", gender: :woman, start: Date.iso8601("2010-01-01")})}
			let (:dan) 	 {Person.new({name: "dan",   gender: :trans, start: Date.iso8601("2013-01-01")})}

			subject {ByGenderScorer.score([[alice, bob],[alice, carol], [alice, dan],
											  [bob, carol], [bob, dan], [carol, dan]])}
			it 'scores to accentuate differences' do
				expect(subject).to match_array [{group: [alice,bob],   score: 1},
												{group: [alice,carol], score: 0},
												{group: [alice,dan],   score: 1},
												{group: [bob,carol],   score: 1},
												{group: [bob, dan],    score: 1},
												{group: [carol, dan],  score: 1}]
			end
  		end
  	end
end