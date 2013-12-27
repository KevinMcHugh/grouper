require 'spec_helper' 

describe ByGenderScorer do
  describe '.score' do
    context 'with valid arguments' do
      let (:alice) {build(:person)}
      let (:bob)   {build(:bob)}
      let (:carol) {build(:carol)}
      let (:dan)   {build(:dan)}


      subject {ByGenderScorer.score([[alice, bob],[alice, carol], [alice, dan],
                        [bob, carol], [bob, dan], [carol, dan]])}
      it 'scores to accentuate differences' do
        expect(subject).to match_array [{group: [alice,bob],   score: 1},
                        {group: [alice,carol], score: 0},
                        {group: [alice,dan],   score: 1},
                        {group: [bob,carol],   score: 1},
                        {group: [bob, dan],    score: 1},
                        {group: [carol, dan],  score: 1}]
      end
      end
    end
end