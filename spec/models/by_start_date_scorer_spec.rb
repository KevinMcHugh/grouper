require 'spec_helper' 

describe ByStartDateScorer do
  describe '.score' do
    context 'with valid arguments' do
      let (:alice) {build(:person)}
      let (:bob)   {build(:bob)}
      let (:carol) {build(:carol)}

      subject {ByStartDateScorer.score([[alice, bob],[alice, carol], [bob, carol]])}
      it 'scores to accentuate differences' do
        expect(subject).to match_array [{group: [alice,bob],   score: 1},
                        {group: [alice,carol], score: 0},
                        {group: [bob,carol],   score: 1}]
      end
      end
    end
end