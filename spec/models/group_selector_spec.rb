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
        let(:group1) {Group.new people: [e,f,g,h]}
        let(:group2) {Group.new people: [alice,bob,carol,dan]}
        subject{GroupSelector.select [alice,bob,carol,dan,e,f,g,h]}
        it 'selects the most diverse groups' do
          expect(subject).to match_array [group1, group2]
        end
      end

      context 'and an odd number of people' do
        let(:group1) {Group.new people: [dan,e,f,g]}
        let(:group2) {Group.new people: [alice,bob,carol]}
        let (:result) {[group1,group2]}
        subject{GroupSelector.select [alice,bob,carol,dan,e,f,g]}
        it 'selects the most diverse groups' do
          expect(subject).to match_array [group1, group2]
        end
      end
    end

    context "Rob's weird test" do
      let (:rob) {build(:rob)}
      let (:colin) {build(:colin)}
      let (:george) {build(:george)}
      let (:p1) {build(:p1)}
      let (:p2) {build(:p2)}
      let (:p3) {build(:p3)}
      let (:p4) {build(:p4)}
      let (:group1) {Group.new people: [rob, george, p2, p3]}
      let (:group2) {Group.new people: [colin, p1, p4]}
      subject{GroupSelector.select [rob, colin, george, p1, p2, p3, p4]}
      it "doesn't repeat people" do
        expect(subject).to match_array [group1, group2]
      end
    end

    context 'with previous groups' do
      let(:group1) {build(:group)}
      let(:group2) {build(:group, people: [e,f,g,h])}

      let(:rgroup1) {Group.new people: [alice,bob,g,h]}
      let(:rgroup2) {Group.new people: [carol,dan,e,f]}
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
