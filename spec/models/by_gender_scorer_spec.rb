require 'spec_helper'

describe ByGenderScorer do
  describe '.score' do
    context 'with valid arguments' do
      let (:alice) {build(:person)}
      let (:bob)   {build(:bob)}
      let (:carol) {build(:carol)}
      let (:dan)   {build(:dan)}
      context 'with 2 person groups' do
        subject {ByGenderScorer.score([[alice, bob],[alice, carol],
          [alice, dan], [bob, carol], [bob, dan], [carol, dan]])}
        it 'scores to accentuate differences' do
          expect(subject).to match_array [{group: [alice,bob],   score: 1},
                          {group: [alice,carol], score: 0},
                          {group: [alice,dan],   score: 1},
                          {group: [bob,carol],   score: 1},
                          {group: [bob, dan],    score: 1},
                          {group: [carol, dan],  score: 1}]
        end
      end
      context 'with 4 person groups' do
        let (:e)   {build(:person, name: "e")}
        let (:g)   {build(:carol, name: "g")}
        let (:diverse_group) {[alice,bob,carol,dan]}
        let (:boring_group) {[alice,carol,e,g]}
        subject {ByGenderScorer.score [diverse_group,boring_group]}
        it 'scores a very diverse group highly' do
          subject.should match_array [{group: diverse_group, score: 1.0},
            {group: boring_group, score: 0.0}]
        end
      end
    end
  end
end