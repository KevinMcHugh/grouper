class GroupSelector
	def self.select people
		scores = get_scores people
		to_place = people
		groups = []
		first_group = scores.last[:group]
		add_to_groups_and_remove_from_to_place first_group, groups, to_place
		place groups, scores, to_place
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

		def self.add_to_groups_and_remove_from_to_place group, groups, to_place
			groups << group
			to_place.delete_if {|p| group.include? p }
		end

		def self.next_group scores, to_place
			scores.find do |group| 
				first_included = to_place.include? group[:group][0] 
				second_included = to_place.include? group[:group][1] 
				first_included && second_included
			end[:group]
		end

		def self.place groups, scores, to_place
			while !to_place.empty? do
				group = next_group scores, to_place
				add_to_groups_and_remove_from_to_place group, groups, to_place
			end
			groups
		end
end