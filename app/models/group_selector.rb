class GroupSelector
	def self.select people
		scores = get_scores people
		first_group = scores.last
		scores.delete first_group
		first_group = first_group[:group]
		to_place = people - first_group
		groups = [first_group]
		while !to_place.empty? do 
			group = scores.find do |group| 
				first_included = to_place.include? group[:group][0] 
				second_included = to_place.include? group[:group][1] 
				first_included && second_included
			end[:group]
			groups << group
			to_place.delete_if {|p| group.include? p }
		end
		groups
	end

	private
		def self.scorers; [ByGenderScorer, ByStartDateScorer]; end

		def self.get_scores people
			combinations = people.combination(2).to_a
			scorers.map do |scorer|
				scores = scorer.score combinations
				scores.sort_by {|s| s[:score]}
			end.flatten
		end
end