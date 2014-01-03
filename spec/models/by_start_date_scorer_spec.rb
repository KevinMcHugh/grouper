require 'spec_helper' 

describe ByStartDateScorer do
  describe '.score' do
    let (:alice) {build(:person)}
    let (:bob)   {build(:bob)}
    let (:carol) {build(:carol)}
    let (:dan) {build(:dan)}
    let (:e) {build(:person, name: 'e')}
    let (:f) {build(:bob, name: 'f', start: "2008-01-01")}

    context 'with 2 person groups' do
      subject {ByStartDateScorer.score([[alice, bob],[alice, carol], [bob, carol]])}
      it 'scores to accentuate differences' do
        expect(subject).to match_array [{group: [alice,bob],   score: 1},
                        {group: [alice,carol], score: 0},
                        {group: [bob,carol],   score: 1}]
      end
    end
    context 'with 4 person groups' do
      subject {ByStartDateScorer.score([[alice,bob,carol,f], [alice,carol,dan,e],
                                        [alice,bob,carol,dan]])}
      it 'scores to accentuate differences' do
        expect(subject).to match_array [{group: [alice,bob,carol,f], score: 1},
                      {group: [alice,carol,dan,e], score: 0},
                      {group: [alice,bob,carol,dan], score: 0.7496580027359782}]
      end
    end
  end
end