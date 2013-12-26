require 'spec_helper'

describe GroupSelector do
	describe '.select' do
		let (:alice) {build(:person)}
		let (:bob) 	 {build(:person, {name: "bob", gender: :man, start: "2013-01-01"})}
		let (:carol) {build(:person, name: "carol")}
		let (:dan) 	 {build(:person, {name: "dan", gender: :trans, start: "2013-01-01"})}
		let (:e) 	 {build(:person, name: "e")}
		let (:f) 	 {build(:person, {name: "f", gender: :man, start: "2013-01-01"})}
		let (:g) 	 {build(:person, name: "g")}
		let (:h) 	 {build(:person, {name: "h", gender: :trans, start: "2013-01-01"})}


		context 'with an even number of people' do
			let(:group1) {Group.new people: [alice, bob, carol, dan]}
			let(:group2) {Group.new people: [e,f,g,h]}
			let (:result) {[group1, group2]}
			subject{GroupSelector.select [alice, bob, carol, dan, e,f,g,h]}
			it 'selects the most diverse groups' do
				expect(subject).to match_array result
			end
		end

		context 'with an odd number of people' do
			let(:group1) {Group.new people: [dan, e,f,g]}
			let(:group2) {Group.new people: [alice, bob, carol]}
			let (:result) {[group1,group2]}
			subject{GroupSelector.select [alice, bob, carol, dan, e,f,g]}
			it 'selects the most diverse groups' do
				expect(subject).to match_array result
			end
		end
	end
end