class ByGenderScorer
	def self.score groups
		group_score_mapping = {}
		groups.each do |group|
			genders = group.map {|p| p.gender}.uniq
			group_score_mapping[group] = genders.length / group.length
		end
		ScoreTransformer.transform group_score_mapping
	end
end