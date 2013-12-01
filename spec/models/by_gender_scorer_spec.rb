require 'spec_helper' 

describe ByGenderScorer do
	describe '.score' do
		context 'with valid arguments' do
			let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
			let (:bob) 	 {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
			let (:carol) {Person.new({name: "carol", gender: :woman, start: Date.iso8601("2010-01-01")})}
			let (:dan) 	 {Person.new({name: "dan",   gender: :trans, start: Date.iso8601("2013-01-01")})}

			subject {ByGenderScorer.score [alice], [bob, carol, dan]}
			it 'returns the ' do
				expect(subject).to match_array [{person: bob,   score: 1}, 
												{person: carol, score: 0},
												{person: dan,   score: 1}]
  			end
  		end
  	end
end