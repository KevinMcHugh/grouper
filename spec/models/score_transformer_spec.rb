require 'spec_helper' 

describe ScoreTransformer do
  describe '.transform' do
    let(:group_scoring_mapping) {{['a'] => 1, ['b'] => 2}}
    let(:result) do
      [{group: ['a'], score: 1},{group: ['b'], score: 2}]
    end
    subject{ScoreTransformer.transform group_scoring_mapping}
    it 'transforms properly' do
      expect(subject).to match_array result
    end
  end
  describe '.score_distance' do
    let(:group_scoring_mapping) {{['a'] => 1.5, ['b'] => 1.5}}
    let(:result) do
      {['a'] => 1, ['b'] => 1}
    end
    subject{ScoreTransformer.score_distances group_scoring_mapping}
    it 'adjusts equal distance' do
      expect(subject).to eq result
    end
  end
end