require 'spec_helper'

describe Group do
	let (:event) {Event.new}
	let (:group_a) {Group.new({people: [], event: event})}
	let (:group_b) {Group.new({people: [], event: nil})}

	subject{Group.new({people: [], event: event})}
	describe '#==' do
		context 'when objects are equal' do
			it {should == group_a}
		end

		context 'when objects are not equal' do
			it {should_not == group_b}
		end
	end

	describe '#inspect' do
		let (:alice) {Person.new({name: "alice", gender: :woman, start: Date.iso8601("2009-01-01")})}
		subject{Group.new({people: [alice]}).inspect}
		context 'it returns the peoples names'
		it {should == ['alice']}
	end
end
