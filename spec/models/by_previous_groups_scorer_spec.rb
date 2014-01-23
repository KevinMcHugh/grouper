require 'spec_helper' 

describe ByPreviousGroupsScorer do
  describe '.score' do
    context 'with valid arguments' do
      let (:alice) {build(:person)}
      let (:bob) {build(:bob)}
      let (:carol) {build(:carol)}
      let (:dan) {build(:dan)}
      context 'with 2 person groups' do
        let (:group) {build(:group, people: [alice, bob])}
        let (:event) {create(:event, groups: [group])}

        subject {ByPreviousGroupsScorer.score([[alice, bob],[alice, carol], [alice, dan],
            [bob, carol], [bob, dan], [carol, dan]])}
        before(:each) do
          alice.groups = [group]
          bob.groups = [group]
          Event.stub(:last).and_return([event])
        end

        it 'scores to accentuate differences' do
          expect(subject).to match_array [{group: [alice,bob],   score: 0},
          {group: [alice,carol], score: 1},
          {group: [alice,dan],   score: 1},
          {group: [bob,carol],   score: 1},
          {group: [bob, dan],    score: 1},
          {group: [carol, dan],  score: 1}]
        end
      end

      context 'with 4 person groups' do
        let (:e)   {build(:person, name: "e")}
        let (:f)   {build(:bob, {name: "f"})}
        let (:g)   {build(:carol, name: "g")}
        let (:h)   {build(:dan, {name: "h"})}
        let (:group1) {build(:group)}
        let (:group2) {build(:group, people: [e,f,g,h])}
        let (:event) {create(:event, groups: [group1, group2])}

        let (:result) do
          [{group: [alice, bob, carol, dan], score: 0},
          {group: [e, f, g, h], score: 0},
          {group: [alice, f, carol, h], score: 1}]
        end
        before(:each) do
          [alice,bob,carol,dan].map {|p| p.groups = [group1]}
          [e,f,g,h].map {|p| p.groups = [group2]}
          Event.stub(:last).and_return([event])
        end
        subject {ByPreviousGroupsScorer.score [[alice,bob,carol,dan], [e,f,g,h], [alice,f,carol,h]]}
        it 'gives score <0 and > 1' do
          expect(subject).to match_array result
        end
      end
    end
  end
end