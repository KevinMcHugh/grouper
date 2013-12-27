class ByPreviousGroupsScorer
	require 'pp'
	def self.score groups
		group_score_mappings = {}
		groups.each do |people|
			score = people.map do |person|
				previously_in_groups = person.groups.map {|group| group.people}.flatten.uniq
				score = (people - [person]).map do |other_person|
					# pp person
					# pp previously_in_groups
					# puts '!'
					included = previously_in_groups.include? other_person
					included ? 0 : 1
				end.reduce :+
			end.reduce :+
			score = score / people.length
			group_score_mappings[people] = score
		end
		ScoreTransformer.transform group_score_mappings
	end
end