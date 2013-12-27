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

        subject {ByPreviousGroupsScorer.score([[alice, bob],[alice, carol], [alice, dan],
            [bob, carol], [bob, dan], [carol, dan]])}
        before(:each) do
          alice.groups = [group]
          bob.groups = [group]
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
        subject {ByPreviousGroupsScorer.score [alice,bob,carol,dan,e,f,g,h].combination(4)}
        it 'gives score <0 and > 1' do
          subject.each do |score_mapping|
            score_mapping[:score].should be >= 0
            score_mapping[:score].should be <= 1
          end
        end
      end
    end
  end
end