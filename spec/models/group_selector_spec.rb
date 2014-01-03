require 'spec_helper'

describe GroupSelector do
  describe '.select' do
    let (:alice) {build(:person)}
    let (:bob)   {build(:bob)}
    let (:carol) {build(:carol)}
    let (:dan)   {build(:dan)}
    let (:e)   {build(:person, name: "e")}
    let (:f)   {build(:bob, {name: "f"})}
    let (:g)   {build(:carol, name: "g")}
    let (:h)   {build(:dan, {name: "h"})}

    context 'with no previous groups' do
      context 'and an even number of people' do
        let(:group1) {Group.new people: [alice,dan,f,g]}
        let(:group2) {Group.new people: [bob,carol,e,h]}
        subject{GroupSelector.select [alice,bob,carol,dan,e,f,g,h]}
        it 'selects the most diverse groups' do
          expect(subject).to match_array [group1, group2]
        end
      end

      context 'and an odd number of people' do
        let(:group1) {Group.new people: [alice,bob,g]}
        let(:group2) {Group.new people: [carol,dan,e,f]}
        let (:result) {[group1,group2]}
        subject{GroupSelector.select [alice,bob,carol,dan,e,f,g]}
        it 'selects the most diverse groups' do
          expect(subject).to match_array [group1, group2]
        end
      end
    end

    context 'with previous groups' do
      let(:group1) {build(:group)}
      let(:group2) {build(:group, people: [e,f,g,h])}

      let(:rgroup1) {Group.new people: [alice,carol,f,h]}
      let(:rgroup2) {Group.new people: [bob,dan,e,g]}
      let(:result) {[rgroup1, rgroup2]}
      before(:each) do
        [alice,bob,carol,dan].map {|p| p.groups = [group1]}
        [e,f,g,h].map {|p| p.groups = [group2]}
      end
      subject{GroupSelector.select [alice,bob,carol,dan,e,f,g,h]}
      it 'does not produce the previous group' do
        expect(subject).to match_array result
      end
    end
  end
end