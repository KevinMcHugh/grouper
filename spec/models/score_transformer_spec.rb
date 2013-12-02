require 'spec_helper' 

describe ScoreTransformer do
	let(:group_scoring_mapping) {{['a'] => 1, ['b'] => 2}}
	let(:result) do
		[{group: ['a'], score: 1},{group: ['b'], score: 2}]
	end
	describe '.transform' do
		subject{ScoreTransformer.transform group_scoring_mapping}
		it 'transforms properly' do
			expect(subject).to match_array result
		end
	end
end