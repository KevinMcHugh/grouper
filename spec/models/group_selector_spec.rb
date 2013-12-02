require 'spec_helper'

describe GroupSelector do
	describe '.select' do
		let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2010-01-01")})}
		let (:bob) 	 {Person.new({name: "bob",   gender: :man,   start: Date.iso8601("2013-01-01")})}
		let (:carol) {Person.new({name: "carol", gender: :woman, start: Date.iso8601("2010-01-01")})}
		let (:dan) 	 {Person.new({name: "dan",   gender: :trans, start: Date.iso8601("2013-01-01")})}
		
		let (:result) {[[alice, bob],[carol, dan]]}
		subject{GroupSelector.select [alice, bob, carol, dan]}
		it 'selects the most diverse groups' do
			expect(subject).to match_array result
		end
	end
end