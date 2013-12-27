require 'spec_helper'

describe GroupSelector do
	describe '.select' do
		let (:alice) {build(:person)}
		let (:bob) 	 {build(:bob)}
		let (:carol) {build(:carol)}
		let (:dan) 	 {build(:dan)}
		let (:e) 	 {build(:person, name: "e")}
		let (:f) 	 {build(:bob, {name: "f"})}
		let (:g) 	 {build(:carol, name: "g")}
		let (:h) 	 {build(:dan, {name: "h"})}

		let(:group1) {Group.new people: [alice, bob, carol, dan]}

		context 'with an even number of people' do
			let(:group2) {Group.new people: [e,f,g,h]}
			let (:result) {[group1, group2]}
			subject{GroupSelector.select [alice, bob, carol, dan, e,f,g,h]}
			it 'selects the most diverse groups' do
				expect(subject).to match_array result
			end
		end

		context 'with an odd number of people' do
			let(:group2) {Group.new people: [e,f,g]}
			let (:result) {[group1,group2]}
			subject{GroupSelector.select [alice, bob, carol, dan, e,f,g]}
			it 'selects the most diverse groups' do
				expect(subject).to match_array result
			end
		end
	end
end